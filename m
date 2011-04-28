From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: libceph API
Date: Thu, 28 Apr 2011 10:02:15 -0700
Message-ID: <BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
	<BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
	<BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
	<BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
	<20110427192827.GA6405@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51941 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab1D1RCQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 13:02:16 -0400
Received: by fxm17 with SMTP id 17so1951700fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 10:02:15 -0700 (PDT)
In-Reply-To: <20110427192827.GA6405@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Brian Chrisman <brchrisman@gmail.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Wed, Apr 27, 2011 at 12:28 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Wed, Apr 27, 2011 at 11:49:11AM -0700, Brian Chrisman wrote:
>> ceph_mount_t is forward declared as a struct in libceph.h.
>> When referencing that within libceph.h, gcc barfs:
>> client/libceph.h:32: error: expected =91)=92 before =91*=92 token
>>
>> Is libceph.h intended to be used in C-programs, and if so, am I usin=
g
>> it incorrectly?
>> ceph_mount_t is defined as a class in libceph.cc, and I'm unclear on
>> how that would be translated into a struct for C-programs linking to
>> libceph.
>
> We talked about this on IRC, replying here for others & historical
> records.
>
> The problem is this:
>
> struct ceph_mount_t;
>
> int ceph_create(ceph_mount_t **cmount, const char * const id);
>
> There is no ceph_mount_t. Changing the prototype to
>
> int ceph_create(struct ceph_mount_t **cmount, const char * const id);
>
> should get things going nicely (as long as you fix up the
> implementation also).

Yeah, the struct keyword needs to be added for the benefit of C
clients. Sorry for any confusion.

regards,
Colin


>
>
>
> (And in case someone is thinking about suggesting a typedef, I'm with
> the other Finn on this one:
> http://lkml.indiana.edu/hypermail/linux/kernel/0206.1/0402.html
> )
>
> --
> :(){ :|:&};:
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
