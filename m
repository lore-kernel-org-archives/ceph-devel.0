From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: NFS of Gluster and Ceph
Date: Thu, 10 Mar 2011 23:45:39 +0800
Message-ID: <AANLkTikVgP_n0cEEa4AHsL6zYbxjZaGvFuozB4XqV222@mail.gmail.com>
References: <AANLkTikxqzhANs3tHufbuNjOxh+CQhxqE6pG2nL=DVTH@mail.gmail.com>
	<121F588803854AE4A0B0E95E001F1D63@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37415 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1CJPpl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 10:45:41 -0500
Received: by bwz15 with SMTP id 15so1908263bwz.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 07:45:39 -0800 (PST)
In-Reply-To: <121F588803854AE4A0B0E95E001F1D63@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Gregory,
Here are my conditions:
1. I use in-kernel client(my OS is Fedora 14)
2. Replication level is 1, so there are 2 identical files(the original
and the copy).
3. The network card on each server and the switch are 1Gb/s.

You said you'd expect mush faster results on the buffered write test,
maybe approaching the network interface limits.
I think you may misunderstand what I mean.
I used the in-kernel client to mount Ceph(mount -t ceph 192.168.1.11:/
/mnt/ceph) .
I re-exported NFS on the client using "exportfs client:/mnt/ceph -o
fsid=1234,rw,no_squash_root"
Besides, I used another server to connect to the client by NFS
protocol and did the write test using dd command(with buffer).
And I got  Ceph=46.6MB/s while Gluster=39.3MB/s, the speed looked similar.
So this confuses me. Because I think even if Ceph is re-exported by
NFS protocol, it should be a lot faster than Gluster.
Did I do something wrong or was it really influenced by the speed of
the switch or the router?
Thanks in advance!

Sylar Shen

2011/3/10 Gregory Farnum <gregory.farnum@dreamhost.com>:
> Sylar:
> Did you run this using Ceph's FUSE or in-kernel client? If this is on cfuse, the results don't surprise me -- it's not very well optimized!
> If this is using the kernel client, I'd expect much faster results on the buffered write test -- I think speeds approaching the network interface limits are more typical.
> What level of replication are you using, and what does your network look like? Is it possible that a switch or router is limiting your total throughput?
>
> On the dsync run, those results look about right -- you could probably get higher bandwidths by using a larger block size but synchronous IO is just slow over all network filesystems.
>
> On a different note, you might want to try with a larger test set -- 100,000 8KB blocks is only 781MB, which should fit in RAM with room to spare. :)
> -Greg
> On Wednesday, March 9, 2011 at 5:32 PM, Sylar Shen wrote:
> Hi,
>> I know that Ceph can re-export nfs protocol.
>> So I want to compare the speed differences between Ceph and Gluster.
>> I use Linux command "dd" to make a write test. Here is the command I used.
>> "dd if=/dev/zero of=/mnt/test1.dbf bs=8k count=100000"
>> The hardware conditions are the same.
>> I set Gluster as 20 servers and Ceph as 1 MDS, 19 OSDes and 1 MON(MDS
>> and Mon are on the same server).
>> I have one physical server as a client.
>> The results are as follows:
>> 1. with oflag=dsync
>> Gluster=166KB/s
>> Ceph=174KB/s
>> 2. without oflag=dsync
>> Gluster=39.3MB/s
>> Ceph=46.6MB/s
>>
>> This confuses me. Because I thought Ceph should be a lot faster than Gluster.
>> But it seems not according the results.
>> Could someone tell me if I did something wrong or the result is OK?
>> Thanks in advance!
>> --
>> Best Regards,
>> Sylar Shen
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
>



-- 
Best Regards,
Sylar Shen
