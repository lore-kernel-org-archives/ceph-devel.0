From: Mark Nelson <mnelson@redhat.com>
Subject: Re: xattrs vs. omap with radosgw
Date: Tue, 16 Jun 2015 15:51:44 -0500
Message-ID: <55808C60.8000706@redhat.com>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>,<alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net> <BLU175-W260DE8E197D05B0951BEBDDFA70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757193AbbFPUvs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 16:51:48 -0400
In-Reply-To: <BLU175-W260DE8E197D05B0951BEBDDFA70@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>



On 06/16/2015 03:48 PM, GuangYang wrote:
> Thanks Sage for the quick response.
>
> It is on Firefly v0.80.4.
>
> While trying to put with *rados* directly, the xattrs can be inline. The problem comes to light when using radosgw, since we have a bunch of metadata to keep via xattrs, including:
>     rgw.idtag  : 15 bytes
>     rgw.manifest :  381 bytes

Ah, that manifest will push us over the limit afaik resulting in every 
inode getting a new extent.

>     rgw.acl : 121 bytes
>     rgw.etag : 33 bytes
>
> Given the background, it looks like the problem is that the rgw.manifest is too large so that XFS make it extents. If I understand correctly, if we port the change to Firefly, we should be able to inline the inode since the accumulated size is still less than 2K (please correct me if I am wrong here).

I think you are correct so long as the patch breaks that manifest down 
into 254 byte or smaller chunks.

>
> Thanks,
> Guang
>
>
> ----------------------------------------
>> Date: Tue, 16 Jun 2015 12:43:08 -0700
>> From: sage@newdream.net
>> To: yguang11@outlook.com
>> CC: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
>> Subject: Re: xattrs vs. omap with radosgw
>>
>> On Tue, 16 Jun 2015, GuangYang wrote:
>>> Hi Cephers,
>>> While looking at disk utilization on OSD, I noticed the disk was constantly busy with large number of small writes, further investigation showed that, as radosgw uses xattrs to store metadata (e.g. etag, content-type, etc.), which made the xattrs get from local to extents, which incurred extra I/O.
>>>
>>> I would like to check if anybody has experience with offloading the metadata to omap:
>>> 1> Offload everything to omap? If this is the case, should we make the inode size as 512 (instead of 2k)?
>>> 2> Partial offload the metadata to omap, e.g. only offloading the rgw specified metadata to omap.
>>>
>>> Any sharing is deeply appreciated. Thanks!
>>
>> Hi Guang,
>>
>> Is this hammer or firefly?
>>
>> With hammer the size of object_info_t crossed the 255 byte boundary, which
>> is the max xattr value that XFS can inline. We've since merged something
>> that stripes over several small xattrs so that we can keep things inline,
>> but it hasn't been backported to hammer yet. See
>> c6cdb4081e366f471b372102905a1192910ab2da. Perhaps this is what you're
>> seeing?
>>
>> I think we're still better off with larger XFS inodes and inline xattrs if
>> it means we avoid leveldb at all for most objects.
>>
>> sage
>   		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
