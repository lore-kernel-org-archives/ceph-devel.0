From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: bandwidth with Ceph - v0.59 (Bobtail)
Date: Fri, 25 Apr 2014 16:36:35 -0500
Message-ID: <535AD563.9010504@inktank.com>
References: <2C899773-4518-4704-86B3-F27B035F7E13@cs.utah.edu> <CAPYLRzgT0MRrdmPPaRii6h5nXoueJsKtfoMsKK3Og8Fc1-2bjw@mail.gmail.com> <89EC8837-F1DF-4B41-86CD-334BEA4226A2@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:52131 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaDYVgb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Apr 2014 17:36:31 -0400
Received: by mail-ig0-f170.google.com with SMTP id uq10so2743441igb.1
        for <ceph-devel@vger.kernel.org>; Fri, 25 Apr 2014 14:36:31 -0700 (PDT)
In-Reply-To: <89EC8837-F1DF-4B41-86CD-334BEA4226A2@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing <xinglin@cs.utah.edu>, Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

For what it's worth, I've been able to achieve up to around 120MB/s with 
btrfs before things fragment.

Mark

On 04/25/2014 03:59 PM, Xing wrote:
> Hi Gregory,
>
> Thanks very much for your quick reply. When I started to look into Ceph, Bobtail was the latest stable release and that was why I picked that version and started to make a few modifications. I have not ported my changes to 0.79 yet. The plan is if v-0.79 can provide a higher disk bandwidth efficiency, I will switch to 0.79. Unfortunately, that does not seem to be the case.
>
> The futex trace was done with version 0.79, not 0.59. I did a profile in 0.59 too. There are some improvements, such as the introduction of fd cache. But lots of futex calls are still there in v-0.79. I also measured the maximum bandwidth from each disk we can get in Version 0.79. It does not improve significantly: we can still only get 90~100 MB/s from each disk.
>
> Thanks,
> Xing
>
>
> On Apr 25, 2014, at 2:42 PM, Gregory Farnum <greg@inktank.com> wrote:
>
>> Bobtail is really too old to draw any meaningful conclusions from; why
>> did you choose it?
>>
>> That's not to say that performance on current code will be better
>> (though it very much might be), but the internal architecture has
>> changed in some ways that will be particularly important for the futex
>> profiling you did, and are probably important for these throughput
>> results as well.
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> On Fri, Apr 25, 2014 at 1:38 PM, Xing <xinglin@cs.utah.edu> wrote:
>>> Hi,
>>>
>>> I also did a few other experiments, trying to get what the maximum bandwidth we can get from each data disk. The output is not encouraging: for disks that can provide 150 MB/s block-level sequential read bandwidths, we can only get about 90MB/s from each disk. Something that is particular interesting is that the replica size also affects the bandwidth we could get from the cluster. It seems that there is no such observation/conversations in the Ceph community and I think it may be helpful to share my findings.
>>>
>>> The experiment was run with two d820 machines in Emulab at University of Utah. One is used as the data node and the other is used as the client. They are connected by a 10 GB/s Ethernet. The data node has 7 disks, one for OS and the rest 6 for OSDs. For the rest 6 disks, we use one for journal and the other for data. Thus in total we have 3 OSDs. The network bandwidth is sufficient to support reading from 3 disks in full bandwidth.
>>>
>>> I varied the read-ahead size for the rbd block device (exp1), osd op threads for each osd (exp2), varied the replica size (exp3), and object size (exp4). The most interesting is varying the replica size. As I varied replica size from 1, to 2 and to 3, the aggregated bandwidth dropped from 267 MB/s to 211 and 180. The reason for the drop I believe is as we increase the number of replicas, we store more data into each OSD. then when we need to read it back, we have to read from a larger range (more seeks). The fundamental problem is likely because we are doing replication synchronously, and thus layout object files in a raid 10 - near format, rather than the far format. For the difference between the near format and far format for raid 10, you could have a look at the link provided below
 .
>>>
>>> http://lxr.free-electrons.com/source/Documentation/device-mapper/dm-raid.txt
>>>
>>> For results about other experiments, you could download my slides at the link provided below.
>>> http://www.cs.utah.edu/~xinglin/slides/ceph-bandiwdth-exp.pptx
>>>
>>>
>>> I do not know why Ceph only gets about 60% of the disk bandwidth. To do a comparison, I ran tar to read every rbd object files to create a tarball and see how much bandwidth I can get from this workload. Interestingly, the tar workload actually gets a higher bandwidth (80% of block level bandwidth), even though it is accessing the disk more randomly (tar reads each object file in a dir sequentially while the object files were created in a different order.). For more detail, please goto my blog to have a read.
>>> http://xinglin-system.blogspot.com/2014/04/ceph-lab-note-1-disk-read-bandwidth-in.html
>>>
>>> Here are a few questions.
>>> 1. What are the maximum bandwidth people can get from each disk? I found Jiangang from Intel also reported 57% efficiency for disk bandwidth. He suggested one reason: interference among so many sequential read workloads. I agree but when I tried to run with one single workload, I still do not get a higher efficiency.
>>> 2. If the efficiency is about 60%, what are the reasons that cause this? Could it be because of the locks (futex as I mentioned in my previous email) or anything else?
>>>
>>> Thanks very much for any feedback.
>>>
>>> Thanks,
>>> Xing
>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

