From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: libceph API
Date: Thu, 28 Apr 2011 11:16:50 -0700
Message-ID: <BANLkTikVT0oSB2kcdXrZN58d_BybLY97BA@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
	<BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
	<BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
	<BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
	<20110427192827.GA6405@dreamer>
	<BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
	<Pine.LNX.4.64.1104281022200.1187@cobra.newdream.net>
	<BANLkTinJpnMj0ryhFF1ucVjkPs5NeZ1taQ@mail.gmail.com>
	<Pine.LNX.4.64.1104281047060.1187@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43917 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103Ab1D1SQw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 14:16:52 -0400
Received: by fxm17 with SMTP id 17so1993774fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 11:16:50 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104281047060.1187@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 10:47 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 28 Apr 2011, Colin McCabe wrote:
>> > I pushed a patch to master that adds this. =A0It's now
>> >
>> > =A0 =A0 =A0 =A0struct ceph_mount_t;
>> >
>> > which is sort of annoying: the _t suffix really shouldn't be there=
=2E =A0But
>> > if it's just ceph_mount it conflicts with int ceph_mount()... =A0:=
/
>> >
>> > sage
>> >
>> >
>>
>> Well, actually, in C and C++, variables can have the same name as
>> types. In other words, the namespaces are separate. Taking advantage
>> of this isn't necessarily a good idea, though... parsing in C++ is
>> pretty ambiguous already.
>
> In this case it's the function ceph_mount(). =A0I'll make it
> struct ceph_mount_info and typdef ceph_mount_info_t I guess!
>
> sage
>

We don't actually need a typedef for this. In C++, you can declare
"Foo f;" in any context that you could declare "struct Foo f;"

=46or the part of our code that is C, I think we've been trying to keep
to the kernel style guides, which contain a (well-justified) rant
against overuse of typedef. I think TV commented on this too :)

What do you guys think of changing struct ceph_mount_t to struct
ceph_mount_info_t?

sincerely,
Colin.


>
>>
>> As far as the _t suffix goes, it's used a lot in the Ceph library
>> bindings. For example, librados has rados_t, rados_ioctx_t,
>> rados_list_ctx_t, and rados_snap_t. librbd has rbd_snap_t and
>> rbd_image_t. So although we don't generally use the _t internally, t=
he
>> library bindings are generally a _t party (so to speak.)
>>
>> cheers,
>> Colin
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
