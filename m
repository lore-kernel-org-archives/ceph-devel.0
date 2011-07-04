From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: GCEPH error
Date: Mon, 4 Jul 2011 16:56:30 +0200
Message-ID: <CAJ_6VAeC4z0GWmkw6JVWN1dG9yEmYOX7788_=KAgM08wukKMEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49787 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab1GDO4b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 10:56:31 -0400
Received: by gwaa18 with SMTP id a18so2009095gwa.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2011 07:56:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

When trying to launch gceph (gceph -v : ceph version 0.30
(commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)), I get the folowing
errors and I'm unable to get the GUI.
Im using ubuntu server 11.04. Do I need to install specific dependencies ?


2011-07-04 16:52:38.953237 7f228404c960 Problem making graphic from
/usr/share/ceph_tool/gui_resources//blacklist.svg; error code: 3:
Couldn't recognize the image file format for file
'/usr/share/ceph_tool/gui_resources//blacklist.svg'
2011-07-04 16:52:38.953361 7f228404c960 There was a problem with
initializing the GUI.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkWindow'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkImage'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkAccelLabel'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkWindow'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkImage'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkAccelLabel'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkWindow'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkWindow'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkAccelLabel'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkAccelLabel'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkWindow'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkImage'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkAccelLabel'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
failing to call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
failing to call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
failing to call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
failing to call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkLabel'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->child
== child' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
failing to call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkFrame'. Hint: this error is commonly caused by failing to call a
library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GtkCellView'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): Gtk-CRITICAL **: IA__gtk_widget_unparent: assertion
`GTK_IS_WIDGET (widget)' failed

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
call a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'GdkScreenX11'. Hint: this error is commonly caused by failing to call
a library init() function.

(gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table !=
0' failed

(gceph:30555): glibmm-WARNING **: Failed to wrap object of type
'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
call a library init() function.
