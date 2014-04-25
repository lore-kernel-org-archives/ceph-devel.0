From: Xing <xinglin@cs.utah.edu>
Subject: bandwidth with Ceph - v0.59 (Bobtail)
Date: Fri, 25 Apr 2014 14:38:43 -0600
Message-ID: <2C899773-4518-4704-86B3-F27B035F7E13@cs.utah.edu>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:32831 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbaDYUiq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Apr 2014 16:38:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com
Cc: Xing <xinglin@cs.utah.edu>

Hi,

I also did a few other experiments, trying to get what the maximum bandwidth we can get from each data disk. The output is not encouraging: for disks that can provide 150 MB/s block-level sequential read bandwidths, we can only get about 90MB/s from each disk. Something that is particular interesting is that the replica size also affects the bandwidth we could get from the cluster. It seems that there is no such observation/conversations in the Ceph community and I think it may be helpful to share my findings.  

The experiment was run with two d820 machines in Emulab at University of Utah. One is used as the data node and the other is used as the client. They are connected by a 10 GB/s Ethernet. The data node has 7 disks, one for OS and the rest 6 for OSDs. For the rest 6 disks, we use one for journal and the other for data. Thus in total we have 3 OSDs. The network bandwidth is sufficient to support reading from 3 disks in full bandwidth. 

I varied the read-ahead size for the rbd block device (exp1), osd op threads for each osd (exp2), varied the replica size (exp3), and object size (exp4). The most interesting is varying the replica size. As I varied replica size from 1, to 2 and to 3, the aggregated bandwidth dropped from 267 MB/s to 211 and 180. The reason for the drop I believe is as we increase the number of replicas, we store more data into each OSD. then when we need to read it back, we have to read from a larger range (more seeks). The fundamental problem is likely because we are doing replication synchronously, and thus layout object files in a raid 10 - near format, rather than the far format. For the difference between the near format and far format for raid 10, you could have a look at the link provided below. 

http://lxr.free-electrons.com/source/Documentation/device-mapper/dm-raid.txt

For results about other experiments, you could download my slides at the link provided below. 
http://www.cs.utah.edu/~xinglin/slides/ceph-bandiwdth-exp.pptx


I do not know why Ceph only gets about 60% of the disk bandwidth. To do a comparison, I ran tar to read every rbd object files to create a tarball and see how much bandwidth I can get from this workload. Interestingly, the tar workload actually gets a higher bandwidth (80% of block level bandwidth), even though it is accessing the disk more randomly (tar reads each object file in a dir sequentially while the object files were created in a different order.). For more detail, please goto my blog to have a read. 
http://xinglin-system.blogspot.com/2014/04/ceph-lab-note-1-disk-read-bandwidth-in.html

Here are a few questions. 
1. What are the maximum bandwidth people can get from each disk? I found Jiangang from Intel also reported 57% efficiency for disk bandwidth. He suggested one reason: interference among so many sequential read workloads. I agree but when I tried to run with one single workload, I still do not get a higher efficiency. 
2. If the efficiency is about 60%, what are the reasons that cause this? Could it be because of the locks (futex as I mentioned in my previous email) or anything else? 

Thanks very much for any feedback. 

Thanks,
Xing




