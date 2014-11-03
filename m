From: Wido den Hollander <wido@42on.com>
Subject: Re: inode64 mount option for XFS
Date: Mon, 03 Nov 2014 13:38:25 +0100
Message-ID: <54577741.2080608@42on.com>
References: <545774FA.2070102@42on.com> <54577638.7060900@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:37388 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbaKCMi3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Nov 2014 07:38:29 -0500
In-Reply-To: <54577638.7060900@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel <ceph-devel@vger.kernel.org>

On 11/03/2014 01:34 PM, Stefan Priebe - Profihost AG wrote:
> 
> Am 03.11.2014 um 13:28 schrieb Wido den Hollander:
>> Hi,
>>
>> While look at init-ceph and ceph-disk I noticed a discrepancy between them.
>>
>> init-ceph mounts XFS filesystems with rw,noatime,inode64, but
>> ceph-disk(-active) with rw,noatime
>>
>> As inode64 gives the best performance, shouldn't ceph-disk do the same?
>>
>> Any implications if we add inode64 on running deployments?
> 
> Isn't inode64 XFS default anyway?
> 

The XFS website suggests it isn't:
http://xfs.org/index.php/XFS_FAQ#Q:_What_is_the_inode64_mount_option_for.3F

"By default, with 32bit inodes, XFS places inodes only in the first 1TB
of a disk."

However, if you look at bit further:
http://xfs.org/index.php/XFS_status_update_for_2012

"Linux 3.7 will be a fairly boring release as far as XFS is concerned,
the biggest user visible changes are an intelligent implementation of
the lseek SEEK_HOLE/SEEK_DATA calls, and finally the switch to use the
inode64 allocator by default. "

So it seems you are partially right. It depends on the kernel you are
running if it is enabled by default.

Wido

> Stefan
> 
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
