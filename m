From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: libceph API
Date: Wed, 27 Apr 2011 12:28:27 -0700
Message-ID: <20110427192827.GA6405@dreamer>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
 <Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
 <BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
 <BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
 <BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35947 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab1D0T20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 15:28:26 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Wed, Apr 27, 2011 at 11:49:11AM -0700, Brian Chrisman wrote:
> ceph_mount_t is forward declared as a struct in libceph.h.
> When referencing that within libceph.h, gcc barfs:
> client/libceph.h:32: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98*=E2=80=99 token
>=20
> Is libceph.h intended to be used in C-programs, and if so, am I using
> it incorrectly?
> ceph_mount_t is defined as a class in libceph.cc, and I'm unclear on
> how that would be translated into a struct for C-programs linking to
> libceph.

We talked about this on IRC, replying here for others & historical
records.

The problem is this:

struct ceph_mount_t;

int ceph_create(ceph_mount_t **cmount, const char * const id);

There is no ceph_mount_t. Changing the prototype to

int ceph_create(struct ceph_mount_t **cmount, const char * const id);

should get things going nicely (as long as you fix up the
implementation also).



(And in case someone is thinking about suggesting a typedef, I'm with
the other Finn on this one:
http://lkml.indiana.edu/hypermail/linux/kernel/0206.1/0402.html
)

--=20
:(){ :|:&};:
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
