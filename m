From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Re: GCEPH error
Date: Wed, 6 Jul 2011 18:03:40 +0200
Message-ID: <CAJ_6VAepa1DW02YmbC3dRdDhe-ACQL7C5sps2CdXpqr8m3j0og@mail.gmail.com>
References: <CAJ_6VAeC4z0GWmkw6JVWN1dG9yEmYOX7788_=KAgM08wukKMEA@mail.gmail.com>
	<CAJ_6VAeQgHjW++yjQGuyXfK2vKvRWOLZxao=S956nM9mjV5kcg@mail.gmail.com>
	<CA+qbEUMT+WYwcq6AO6yNxhoQPxL1yEN1jU61L1JmfYdGz2KKsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56962 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab1GFQDl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2011 12:03:41 -0400
Received: by gwaa18 with SMTP id a18so35990gwa.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jul 2011 09:03:40 -0700 (PDT)
In-Reply-To: <CA+qbEUMT+WYwcq6AO6yNxhoQPxL1yEN1jU61L1JmfYdGz2KKsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

Hello Colin,

Yep, I got this advice from Tommi as well and I installed librsvg2-2 +
libgtk2.0-dev
(this one install as well LOTS of dependencies) but it's still the
same errors. My distrib is Ubuntu server 11.04.

Wilfrid

2011/7/6 Colin McCabe <cmccabe@alumni.cmu.edu>:
> On Tue, Jul 5, 2011 at 1:44 PM, Wilfrid Allembrand
> <wilfrid.allembrand@gmail.com> wrote:
>> Hello,
>>
>> So I updated packages + the kernel (now running 3.0.0-0300rc6-generi=
c)
>> but I continue to have the same error. Any idea ?
>>
>> Regards,
>> Wilfrid
>
> You need to install the package that provides SVG support in your
> distribution. We probably need to add this as a dependency in automak=
e
> / .deb / .rpm somehow.
>
> cheers,
> Colin
>
>
>>
>> 2011/7/4 Wilfrid Allembrand <wilfrid.allembrand@gmail.com>:
>>> Hello,
>>>
>>> When trying to launch gceph (gceph -v : ceph version 0.30
>>> (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)), I get the folow=
ing
>>> errors and I'm unable to get the GUI.
>>> Im using ubuntu server 11.04. Do I need to install specific depende=
ncies ?
>>>
>>>
>>> 2011-07-04 16:52:38.953237 7f228404c960 Problem making graphic from
>>> /usr/share/ceph_tool/gui_resources//blacklist.svg; error code: 3:
>>> Couldn't recognize the image file format for file
>>> '/usr/share/ceph_tool/gui_resources//blacklist.svg'
>>> 2011-07-04 16:52:38.953361 7f228404c960 There was a problem with
>>> initializing the GUI.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkWindow'. Hint: this error is commonly caused by failing to call=
 a
>>> library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkImage'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkWindow'. Hint: this error is commonly caused by failing to call=
 a
>>> library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkImage'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkWindow'. Hint: this error is commonly caused by failing to call=
 a
>>> library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkWindow'. Hint: this error is commonly caused by failing to call=
 a
>>> library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkWindow'. Hint: this error is commonly caused by failing to call=
 a
>>> library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkImage'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>> failing to call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>> failing to call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>> failing to call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>> failing to call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->chi=
ld
>>> =3D=3D child' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>> failing to call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkFrame'. Hint: this error is commonly caused by failing to call =
a
>>> library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GtkCellView'. Hint: this error is commonly caused by failing to ca=
ll
>>> a library init() function.
>>>
>>> (gceph:30555): Gtk-CRITICAL **: IA__gtk_widget_unparent: assertion
>>> `GTK_IS_WIDGET (widget)' failed
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to c=
all
>>> a library init() function.
>>>
>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_table=
 !=3D
>>> 0' failed
>>>
>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing to
>>> call a library init() function.
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
