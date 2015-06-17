From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RE: xattrs vs. omap with radosgw
Date: Wed, 17 Jun 2015 01:32:35 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF01FDC834@SHSMSX104.ccr.corp.intel.com>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
 <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11821 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231AbbFQBcj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 21:32:39 -0400
In-Reply-To: <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

=46WIW, there was some discussion in OpenStack Swift and their performa=
nce tests showed 255 is not the best in recent XFS. They decided to use=
 large xattr boundary size(65535).

https://gist.github.com/smerritt/5e7e650abaa20599ff34


-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Sage Weil
Sent: Wednesday, June 17, 2015 3:43 AM
To: GuangYang
Cc: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
Subject: Re: xattrs vs. omap with radosgw

On Tue, 16 Jun 2015, GuangYang wrote:
> Hi Cephers,
> While looking at disk utilization on OSD, I noticed the disk was cons=
tantly busy with large number of small writes, further investigation sh=
owed that, as radosgw uses xattrs to store metadata (e.g. etag, content=
-type, etc.), which made the xattrs get from local to extents, which in=
curred extra I/O.
>=20
> I would like to check if anybody has experience with offloading the m=
etadata to omap:
> =A0 1> Offload everything to omap? If this is the case, should we mak=
e the inode size as 512 (instead of 2k)?
> =A0 2> Partial offload the metadata to omap, e.g. only offloading the=
 rgw specified metadata to omap.
>=20
> Any sharing is deeply appreciated. Thanks!

Hi Guang,

Is this hammer or firefly?

With hammer the size of object_info_t crossed the 255 byte boundary, wh=
ich is the max xattr value that XFS can inline.  We've since merged som=
ething that stripes over several small xattrs so that we can keep thing=
s inline, but it hasn't been backported to hammer yet.  See c6cdb4081e3=
66f471b372102905a1192910ab2da.  Perhaps this is what you're seeing?

I think we're still better off with larger XFS inodes and inline xattrs=
 if it means we avoid leveldb at all for most objects.

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
