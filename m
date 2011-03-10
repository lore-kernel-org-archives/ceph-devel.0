From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: NFS of Gluster and Ceph
Date: Wed, 9 Mar 2011 17:59:34 -0800
Message-ID: <121F588803854AE4A0B0E95E001F1D63@gmail.com>
References: <AANLkTikxqzhANs3tHufbuNjOxh+CQhxqE6pG2nL=DVTH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36362 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab1CJB7i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2011 20:59:38 -0500
Received: by yxs7 with SMTP id 7so468261yxs.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2011 17:59:37 -0800 (PST)
In-Reply-To: <AANLkTikxqzhANs3tHufbuNjOxh+CQhxqE6pG2nL=DVTH@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sylar:
Did you run this using Ceph's FUSE or in-kernel client? If this is on cfuse, the results don't surprise me -- it's not very well optimized!
If this is using the kernel client, I'd expect much faster results on the buffered write test -- I think speeds approaching the network interface limits are more typical.
What level of replication are you using, and what does your network look like? Is it possible that a switch or router is limiting your total throughput?

On the dsync run, those results look about right -- you could probably get higher bandwidths by using a larger block size but synchronous IO is just slow over all network filesystems.

On a different note, you might want to try with a larger test set -- 100,000 8KB blocks is only 781MB, which should fit in RAM with room to spare. :)
-Greg
On Wednesday, March 9, 2011 at 5:32 PM, Sylar Shen wrote:
Hi,
> I know that Ceph can re-export nfs protocol.
> So I want to compare the speed differences between Ceph and Gluster.
> I use Linux command "dd" to make a write test. Here is the command I used.
> "dd if=/dev/zero of=/mnt/test1.dbf bs=8k count=100000"
> The hardware conditions are the same.
> I set Gluster as 20 servers and Ceph as 1 MDS, 19 OSDes and 1 MON(MDS
> and Mon are on the same server).
> I have one physical server as a client.
> The results are as follows:
> 1. with oflag=dsync
> Gluster=166KB/s
> Ceph=174KB/s
> 2. without oflag=dsync
> Gluster=39.3MB/s
> Ceph=46.6MB/s
> 
> This confuses me. Because I thought Ceph should be a lot faster than Gluster.
> But it seems not according the results.
> Could someone tell me if I did something wrong or the result is OK?
> Thanks in advance!
> -- 
> Best Regards,
> Sylar Shen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

