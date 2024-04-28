/*
    Hacking on code from wmctrl and windowlist

        https://github.com/Conservatory/wmctrl
        https://github.com/tuurep/windowlist

    to make some simple window actions on key shortcuts

    Bind to a key:
        cycle-sameclass [--forward]
        cycle-sameclass --backward

    Switch focus to the next/previous window that has
    the same class as the active window
*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xatom.h>
#include <X11/Xlib.h>

#define MAX_PROPERTY_VALUE_LEN 4096

char* get_property(Display* d, Window w, Atom xa_prop_type, char* prop_name, unsigned long* size) {
    unsigned long ret_nitems, ret_bytes_after, tmp_size;
    unsigned char* ret_prop;
    int ret_format;
    char* ret;

    Atom xa_prop_name = XInternAtom(d, prop_name, False);
    Atom xa_ret_type;

    /*
        MAX_PROPERTY_VALUE_LEN / 4 explanation (XGetWindowProperty manpage):

        long_length = Specifies the length in 32-bit multiples of the
                      data to be retrieved.

        NOTE:  see
        http://mail.gnome.org/archives/wm-spec-list/2003-March/msg00067.html
        In particular:

        When the X window system was ported to 64-bit architectures, a
        rather peculiar design decision was made. 32-bit quantities such
        as Window IDs, atoms, etc, were kept as longs in the client side
        APIs, even when long was changed to 64 bits.
    */
    if (XGetWindowProperty(d, w, xa_prop_name, 0, MAX_PROPERTY_VALUE_LEN / 4, False,
                           xa_prop_type, &xa_ret_type, &ret_format, &ret_nitems,
                           &ret_bytes_after, &ret_prop) != Success) {
        return NULL;
    }

    if (xa_ret_type != xa_prop_type) {
        XFree(ret_prop);
        return NULL;
    }

    // null terminate the result to make string handling easier

    tmp_size = (ret_format / 8) * ret_nitems;
    // Correct 64 Architecture implementation of 32 bit data
    if(ret_format==32) tmp_size *= sizeof(long)/4;
    ret = malloc(tmp_size + 1);
    memcpy(ret, ret_prop, tmp_size);
    ret[tmp_size] = '\0';

    if (size) {
        *size = tmp_size;
    }

    XFree(ret_prop);
    return ret;
}

Window get_active_window(Display* d) {
    char* prop;
    unsigned long size;
    Window ret = (Window) 0;

    Window root = DefaultRootWindow(d);
    prop = get_property(d, root, XA_WINDOW, "_NET_ACTIVE_WINDOW", &size);
    if (prop) {
        ret = *((Window*) prop);
        free(prop);
    }

    return(ret);
}

char* get_window_class(Display* d, Window w) {

    unsigned long size;
    char* wm_class = get_property(d, w, XA_STRING, "WM_CLASS", &size);

    if (!wm_class) {
        return NULL;
    }

    char* class = calloc(size, sizeof(char));

    /*
       WM_CLASS contains two consecutive null-terminated strings:
       <Instance>\0<Class>\0
       We want the second one, so point after the first null-terminator.

       More explanation on this pretty unintuitive window property:
       https://unix.stackexchange.com/questions/494169/wm-class-vs-wm-instance
    */
    char* pointer_to_class = strchr(wm_class, '\0') + 1;
    strcpy(class, pointer_to_class);

    free(wm_class);
    return class;
}

Window* get_client_list(Display* d, unsigned long* size) {
    Window* client_list = NULL;

    Window root = DefaultRootWindow(d);
    client_list = (Window*) get_property(d, root, XA_WINDOW, "_NET_CLIENT_LIST", size);

    return client_list;
}

int client_msg(Display* d, Window w, char* msg) {
    XEvent e;
    long mask = SubstructureRedirectMask | SubstructureNotifyMask;

    e.xclient.type = ClientMessage;
    e.xclient.serial = 0;
    e.xclient.send_event = True;
    e.xclient.message_type = XInternAtom(d, msg, False);
    e.xclient.window = w;
    e.xclient.format = 32;

    if (XSendEvent(d, DefaultRootWindow(d), False, mask, &e)) {
        return EXIT_SUCCESS;
    } else {
        fprintf(stderr, "Cannot send %s event.\n", msg);
        return EXIT_FAILURE;
    }
}

void activate_window(Display* d, Window w) {
    client_msg(d, w, "_NET_ACTIVE_WINDOW");
    XMapRaised(d, w);
}

int main(int argc, char* argv[]) {
    Display* d = XOpenDisplay(NULL);

    Window active_window = get_active_window(d);
    char* active_window_class = get_window_class(d, active_window);

    unsigned long size;
    Window* windows = get_client_list(d, &size);

    int n = size / sizeof(Window);

    Window next = 0;
    bool past_active_window = false;

    for (int i = 0; i < n; i++) {
        Window current_window = windows[i];

        if (argc > 1 && !strcmp(argv[1], "--backward")) {
            current_window = windows[n-i-1];
        }

        if (current_window == active_window) {
            past_active_window = true;
            continue;
        }

        char* current_window_class = get_window_class(d, current_window);
        
        if (!strcmp(current_window_class, active_window_class)) {
            if (!past_active_window && next == 0) {
                // Remember this window in case wrap is necessary
                next = current_window;
    
            }
            if (past_active_window) {
                // Next window found with no wrap necessary
                next = current_window;
                free(current_window_class);
                break;
            }
        }
        free(current_window_class);
    }

    free(windows);
    free(active_window_class);

    if (next != 0) {
        activate_window(d, next);
    }

    XCloseDisplay(d);
}
