From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: libceph API
Date: Thu, 28 Apr 2011 10:36:05 -0700
Message-ID: <BANLkTinJpnMj0ryhFF1ucVjkPs5NeZ1taQ@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
	<BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
	<BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
	<BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
	<20110427192827.GA6405@dreamer>
	<BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
	<Pine.LNX.4.64.1104281022200.1187@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40010 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab1D1RgH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 13:36:07 -0400
Received: by fxm17 with SMTP id 17so1970765fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 10:36:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104281022200.1187@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 10:23 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 28 Apr 2011, Colin McCabe wrote:
>> On Wed, Apr 27, 2011 at 12:28 PM, Tommi Virtanen
>> <tommi.virtanen@dreamhost.com> wrote:
>> > On Wed, Apr 27, 2011 at 11:49:11AM -0700, Brian Chrisman wrote:
>> >> ceph_mount_t is forward declared as a struct in libceph.h.
>> >> When referencing that within libceph.h, gcc barfs:
>> >> client/libceph.h:32: error: expected ?)? before ?*? token
>> >>
>> >> Is libceph.h intended to be used in C-programs, and if so, am I u=
sing
>> >> it incorrectly?
>> >> ceph_mount_t is defined as a class in libceph.cc, and I'm unclear=
 on
>> >> how that would be translated into a struct for C-programs linking=
 to
>> >> libceph.
>> >
>> > We talked about this on IRC, replying here for others & historical
>> > records.
>> >
>> > The problem is this:
>> >
>> > struct ceph_mount_t;
>> >
>> > int ceph_create(ceph_mount_t **cmount, const char * const id);
>> >
>> > There is no ceph_mount_t. Changing the prototype to
>> >
>> > int ceph_create(struct ceph_mount_t **cmount, const char * const i=
d);
>> >
>> > should get things going nicely (as long as you fix up the
>> > implementation also).
>>
>> Yeah, the struct keyword needs to be added for the benefit of C
>> clients. Sorry for any confusion.
>
> I pushed a patch to master that adds this. =A0It's now
>
> =A0 =A0 =A0 =A0struct ceph_mount_t;
>
> which is sort of annoying: the _t suffix really shouldn't be there. =A0=
But
> if it's just ceph_mount it conflicts with int ceph_mount()... =A0:/
>
> sage
>
>

Well, actually, in C and C++, variables can have the same name as
types. In other words, the namespaces are separate. Taking advantage
of this isn't necessarily a good idea, though... parsing in C++ is
pretty ambiguous already.

As far as the _t suffix goes, it's used a lot in the Ceph library
bindings. For example, librados has rados_t, rados_ioctx_t,
rados_list_ctx_t, and rados_snap_t. librbd has rbd_snap_t and
rbd_image_t. So although we don't generally use the _t internally, the
library bindings are generally a _t party (so to speak.)

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
