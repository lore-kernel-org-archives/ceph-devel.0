From: GuangYang <yguang11@outlook.com>
Subject: RE: xattrs vs. omap with radosgw
Date: Tue, 16 Jun 2015 20:48:54 +0000
Message-ID: <BLU175-W260DE8E197D05B0951BEBDDFA70@phx.gbl>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>,<alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc2s26.hotmail.com ([65.55.111.101]:54015 "EHLO
	BLU004-OMC2S26.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060AbbFPUsz convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 16:48:55 -0400
In-Reply-To: <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Thanks Sage for the quick response.

It is on Firefly v0.80.4.

While trying to put with *rados* directly, the xattrs can be inline. Th=
e problem comes to light when using radosgw, since we have a bunch of m=
etadata to keep via xattrs, including:
=A0 =A0rgw.idtag =A0: 15 bytes
=A0 =A0rgw.manifest : =A0381 bytes
=A0 =A0rgw.acl : 121 bytes
=A0 =A0rgw.etag : 33 bytes

Given the background, it looks like the problem is that the=A0rgw.manif=
est is too large so that XFS make it extents. If I understand correctly=
, if we port the change to Firefly, we should be able to inline the ino=
de since the accumulated size is still less than 2K (please correct me =
if I am wrong here).

Thanks,
Guang


----------------------------------------
> Date: Tue, 16 Jun 2015 12:43:08 -0700
> From: sage@newdream.net
> To: yguang11@outlook.com
> CC: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
> Subject: Re: xattrs vs. omap with radosgw
>
> On Tue, 16 Jun 2015, GuangYang wrote:
>> Hi Cephers,
>> While looking at disk utilization on OSD, I noticed the disk was con=
stantly busy with large number of small writes, further investigation s=
howed that, as radosgw uses xattrs to store metadata (e.g. etag, conten=
t-type, etc.), which made the xattrs get from local to extents, which i=
ncurred extra I/O.
>>
>> I would like to check if anybody has experience with offloading the =
metadata to omap:
>> 1> Offload everything to omap? If this is the case, should we make t=
he inode size as 512 (instead of 2k)?
>> 2> Partial offload the metadata to omap, e.g. only offloading the rg=
w specified metadata to omap.
>>
>> Any sharing is deeply appreciated. Thanks!
>
> Hi Guang,
>
> Is this hammer or firefly?
>
> With hammer the size of object_info_t crossed the 255 byte boundary, =
which
> is the max xattr value that XFS can inline. We've since merged someth=
ing
> that stripes over several small xattrs so that we can keep things inl=
ine,
> but it hasn't been backported to hammer yet. See
> c6cdb4081e366f471b372102905a1192910ab2da. Perhaps this is what you're
> seeing?
>
> I think we're still better off with larger XFS inodes and inline xatt=
rs if
> it means we avoid leveldb at all for most objects.
>
> sage
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
