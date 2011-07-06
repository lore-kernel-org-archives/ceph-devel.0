From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: GCEPH error
Date: Wed, 6 Jul 2011 09:17:51 -0700
Message-ID: <CA+qbEUOXT5Vaa_0_F=xeCrsTVvbq3ArpwZtxfiyu3jK9LXdMZg@mail.gmail.com>
References: <CAJ_6VAeC4z0GWmkw6JVWN1dG9yEmYOX7788_=KAgM08wukKMEA@mail.gmail.com>
	<CAJ_6VAeQgHjW++yjQGuyXfK2vKvRWOLZxao=S956nM9mjV5kcg@mail.gmail.com>
	<CA+qbEUMT+WYwcq6AO6yNxhoQPxL1yEN1jU61L1JmfYdGz2KKsg@mail.gmail.com>
	<CAJ_6VAepa1DW02YmbC3dRdDhe-ACQL7C5sps2CdXpqr8m3j0og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:61166 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab1GFQRw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2011 12:17:52 -0400
Received: by fxd18 with SMTP id 18so238012fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jul 2011 09:17:51 -0700 (PDT)
In-Reply-To: <CAJ_6VAepa1DW02YmbC3dRdDhe-ACQL7C5sps2CdXpqr8m3j0og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 6, 2011 at 9:03 AM, Wilfrid Allembrand
<wilfrid.allembrand@gmail.com> wrote:
> Hello Colin,
>
> Yep, I got this advice from Tommi as well and I installed librsvg2-2 =
+
> libgtk2.0-dev
> (this one install as well LOTS of dependencies) but it's still the
> same errors. My distrib is Ubuntu server 11.04.
>
> Wilfrid

I did some quick googling and it looks like some other people have the
same problem. One person said installing cairo-lcd fixed it for them,
which tends to make me think that there is another package that needs
to be installed besides the ones you mentioned to make this work.

It might be helpful to see what people have to say about this on an
Ubuntu mailing list.

C.


>
> 2011/7/6 Colin McCabe <cmccabe@alumni.cmu.edu>:
>> On Tue, Jul 5, 2011 at 1:44 PM, Wilfrid Allembrand
>> <wilfrid.allembrand@gmail.com> wrote:
>>> Hello,
>>>
>>> So I updated packages + the kernel (now running 3.0.0-0300rc6-gener=
ic)
>>> but I continue to have the same error. Any idea ?
>>>
>>> Regards,
>>> Wilfrid
>>
>> You need to install the package that provides SVG support in your
>> distribution. We probably need to add this as a dependency in automa=
ke
>> / .deb / .rpm somehow.
>>
>> cheers,
>> Colin
>>
>>
>>>
>>> 2011/7/4 Wilfrid Allembrand <wilfrid.allembrand@gmail.com>:
>>>> Hello,
>>>>
>>>> When trying to launch gceph (gceph -v : ceph version 0.30
>>>> (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9)), I get the folo=
wing
>>>> errors and I'm unable to get the GUI.
>>>> Im using ubuntu server 11.04. Do I need to install specific depend=
encies ?
>>>>
>>>>
>>>> 2011-07-04 16:52:38.953237 7f228404c960 Problem making graphic fro=
m
>>>> /usr/share/ceph_tool/gui_resources//blacklist.svg; error code: 3:
>>>> Couldn't recognize the image file format for file
>>>> '/usr/share/ceph_tool/gui_resources//blacklist.svg'
>>>> 2011-07-04 16:52:38.953361 7f228404c960 There was a problem with
>>>> initializing the GUI.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkWindow'. Hint: this error is commonly caused by failing to cal=
l a
>>>> library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkImage'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkWindow'. Hint: this error is commonly caused by failing to cal=
l a
>>>> library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkImage'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkWindow'. Hint: this error is commonly caused by failing to cal=
l a
>>>> library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkWindow'. Hint: this error is commonly caused by failing to cal=
l a
>>>> library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkWindow'. Hint: this error is commonly caused by failing to cal=
l a
>>>> library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkMenu'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkImage'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkAccelLabel'. Hint: this error is commonly caused by failing to
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>>> failing to call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>>> failing to call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>>> failing to call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>>> failing to call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkLabel'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: gtk_bin_remove: assertion `bin->ch=
ild
>>>> =3D=3D child' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkScrolledWindow'. Hint: this error is commonly caused by
>>>> failing to call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkFrame'. Hint: this error is commonly caused by failing to call=
 a
>>>> library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GtkCellView'. Hint: this error is commonly caused by failing to c=
all
>>>> a library init() function.
>>>>
>>>> (gceph:30555): Gtk-CRITICAL **: IA__gtk_widget_unparent: assertion
>>>> `GTK_IS_WIDGET (widget)' failed
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkHBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'GdkScreenX11'. Hint: this error is commonly caused by failing to =
call
>>>> a library init() function.
>>>>
>>>> (gceph:30555): glibmm-CRITICAL **: Glib::ObjectBase*
>>>> Glib::wrap_create_new_wrapper(GObject*): assertion `wrap_func_tabl=
e !=3D
>>>> 0' failed
>>>>
>>>> (gceph:30555): glibmm-WARNING **: Failed to wrap object of type
>>>> 'gtkmm__GtkVBox'. Hint: this error is commonly caused by failing t=
o
>>>> call a library init() function.
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
