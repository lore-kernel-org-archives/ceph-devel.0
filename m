From: Ben England <bengland@redhat.com>
Subject: Re: CephFs performance data
Date: Wed, 3 Aug 2016 15:33:51 -0400 (EDT)
Message-ID: <906232803.11790446.1470252831523.JavaMail.zimbra@redhat.com>
References: <BL2PR02MB211528CE823D5728C3A474ACF4060@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:45453 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182AbcHCTdy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2016 15:33:54 -0400
In-Reply-To: <BL2PR02MB211528CE823D5728C3A474ACF4060@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Somnath, here are the Cephfs slides from this morning. 

https://s3.amazonaws.com/ben.england/Cephfs+performance+results+June+2016.pdf

Let me know if you have trouble reading them.

As for sequential 4-KB I/O performance, I believe kernel Cephfs client is aggregating reads and writes - otherwise you are quite right that the IOPS level could not be sustained.  This is common practice in other distributed filesystems as well, such as NFS and Gluster.  For RANDOM I/O, coalescing of I/O requests is far less likely.   I have some performance data on these runs that should be useful in confirming the result, will try to look that up for you.

I'm looking forward to hearing other people's results with Cephfs as well.

-ben


----- Original Message -----
> From: "Somnath Roy" <Somnath.Roy@sandisk.com>
> To: "Ben England (bengland@redhat.com)" <bengland@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, August 3, 2016 12:23:21 PM
> Subject: CephFs performance data
> 
> Ben,
> Thanks for the first cut data on CephFS , it was really helpful.
> Do you mind to send out the slides ?
> Also, continuing the discussion on 4K SW throughput is ~1GB/S , if you are
> running test with direct IO, client Linux system can't coalesce the writes
> and I didn't see much coalescing at the OSD servers as well. Unless CephFS
> has some coalescing logic it will be good if we can find out how we are
> getting this bigger throughput for 4K. Let me know if I am missing
> something..
> 
> Thanks & Regards
> Somnath
