From: Sage Weil <sage@inktank.com>
Subject: Re: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 08:57:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210310856420.10356@cobra.newdream.net>
References: <3c3b5485-acc1-4955-8890-32f6399d117f@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58387 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758056Ab2JaP5H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 11:57:07 -0400
In-Reply-To: <3c3b5485-acc1-4955-8890-32f6399d117f@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:
> Hello,
> 
> I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,cache=none), randread, with 4K block size on a small size of 1G (so it can be handle by the buffer cache on ceph cluster)
> 
> 
> fio --filename=/dev/vdb -rw=randread --bs=4K --size=1000M --iodepth=40  --group_reporting --name=file1 --ioengine=libaio --direct=1
> 
> 
> I can't get more than 5000 iops.

Have you tried increasing the iodepth?

sage

> 
> 
> RBD cluster is :
> ---------------
> 3 nodes,with each node : 
> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon 
> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ
> rbd 0.53
> 
> ceph.conf
> 
>         journal dio = false
>         filestore fiemap = false
>         filestore flusher = false
>         osd op threads = 24
>         osd disk threads = 24
>         filestore op threads = 6
> 
> kvm host is : 4 x 12 cores opteron
> ------------
> 
> 
> During the bench:
> 
> on ceph nodes:
> - cpu  is around 10% used
> - iostat show no disks activity on osds. (so I think that the 1G file is handle in the linux buffer)
> 
> 
> on kvm host:
> 
> -cpu is around 20% used
> 
> 
> I really don't see where is the bottleneck....
> 
> Any Ideas, hints ?
> 
> 
> Regards,
> 
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
