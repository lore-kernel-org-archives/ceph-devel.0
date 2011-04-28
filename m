From: Sage Weil <sage@newdream.net>
Subject: Re: libceph API
Date: Thu, 28 Apr 2011 10:47:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104281047060.1187@cobra.newdream.net>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
 <Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
 <BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
 <BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
 <BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com> <20110427192827.GA6405@dreamer>
 <BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
 <Pine.LNX.4.64.1104281022200.1187@cobra.newdream.net>
 <BANLkTinJpnMj0ryhFF1ucVjkPs5NeZ1taQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1540422984-1304012859=:1187"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54449 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab1D1RrV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 13:47:21 -0400
In-Reply-To: <BANLkTinJpnMj0ryhFF1ucVjkPs5NeZ1taQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1540422984-1304012859=:1187
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 28 Apr 2011, Colin McCabe wrote:
> > I pushed a patch to master that adds this. =A0It's now
> >
> > =A0 =A0 =A0 =A0struct ceph_mount_t;
> >
> > which is sort of annoying: the _t suffix really shouldn't be there. =A0=
But
> > if it's just ceph_mount it conflicts with int ceph_mount()... =A0:/
> >
> > sage
> >
> >
>=20
> Well, actually, in C and C++, variables can have the same name as
> types. In other words, the namespaces are separate. Taking advantage
> of this isn't necessarily a good idea, though... parsing in C++ is
> pretty ambiguous already.

In this case it's the function ceph_mount().  I'll make it=20
struct ceph_mount_info and typdef ceph_mount_info_t I guess!

sage


>=20
> As far as the _t suffix goes, it's used a lot in the Ceph library
> bindings. For example, librados has rados_t, rados_ioctx_t,
> rados_list_ctx_t, and rados_snap_t. librbd has rbd_snap_t and
> rbd_image_t. So although we don't generally use the _t internally, the
> library bindings are generally a _t party (so to speak.)
>=20
> cheers,
> Colin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1540422984-1304012859=:1187--
