From: Wido den Hollander <wido@42on.com>
Subject: Re: inode64 mount option for XFS
Date: Mon, 03 Nov 2014 15:32:51 +0100
Message-ID: <54579213.5070900@42on.com>
References: <545774FA.2070102@42on.com> <alpine.DEB.2.00.1411030619220.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:37538 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbaKCOc7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Nov 2014 09:32:59 -0500
In-Reply-To: <alpine.DEB.2.00.1411030619220.15135@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/03/2014 03:20 PM, Sage Weil wrote:
> On Mon, 3 Nov 2014, Wido den Hollander wrote:
>> Hi,
>>
>> While look at init-ceph and ceph-disk I noticed a discrepancy between them.
>>
>> init-ceph mounts XFS filesystems with rw,noatime,inode64, but
>> ceph-disk(-active) with rw,noatime
>>
>> As inode64 gives the best performance, shouldn't ceph-disk do the same?
> 
> I noticed this a while back but didn't finish fixing it.. can you take a 
> look at wip-xfs-inode64 and see if it looks right?
>  

Looks good to me. Simple fix, but that should do it.

>> Any implications if we add inode64 on running deployments?
> 
> I don't think so!  Note that on new kernels I think inode64 is now the 
> default, so this is really about performance on older systems (precise, 
> rhel6, probably).
> 

Yes, I noticed that later on. But it gives consistency. Ubuntu precise
and RHEL 6 will be around for quite some time, so it would be better to
enable it for those systems as well.

Wido

> sage
> 
>>
>> -- 
>> Wido den Hollander
>> 42on B.V.
>> Ceph trainer and consultant
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
