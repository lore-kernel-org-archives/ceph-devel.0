From: Sage Weil <sage@newdream.net>
Subject: Re: xattrs vs. omap with radosgw
Date: Tue, 16 Jun 2015 12:43:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1646703641-1434483788=:15556"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50522 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbbFPTnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 15:43:09 -0400
In-Reply-To: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1646703641-1434483788=:15556
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2015, GuangYang wrote:
> Hi Cephers,
> While looking at disk utilization on OSD, I noticed the disk was consta=
ntly busy with large number of small writes, further investigation showed=
 that, as radosgw uses xattrs to store metadata (e.g. etag, content-type,=
 etc.), which made the xattrs get from local to extents, which incurred e=
xtra I/O.
>=20
> I would like to check if anybody has experience with offloading the met=
adata to omap:
> =A0 1> Offload everything to omap? If this is the case, should we make =
the inode size as 512 (instead of 2k)?
> =A0 2> Partial offload the metadata to omap, e.g. only offloading the r=
gw specified metadata to omap.
>=20
> Any sharing is deeply appreciated. Thanks!

Hi Guang,

Is this hammer or firefly?

With hammer the size of object_info_t crossed the 255 byte boundary, whic=
h=20
is the max xattr value that XFS can inline.  We've since merged something=
=20
that stripes over several small xattrs so that we can keep things inline,=
=20
but it hasn't been backported to hammer yet.  See
c6cdb4081e366f471b372102905a1192910ab2da.  Perhaps this is what you're=20
seeing?

I think we're still better off with larger XFS inodes and inline xattrs i=
f=20
it means we avoid leveldb at all for most objects.

sage

--557981400-1646703641-1434483788=:15556--
