From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 15 Jun 2012 11:50:01 -0700
Message-ID: <4FDB83D9.6010209@inktank.com>
References: <21601270.dfB0BsVfyn@pc10> <25761303.PmWYZprmzc@pc10> <Pine.LNX.4.64.1206110920150.10557@cobra.newdream.net> <1815615.qFFlAnfNF8@pc10> <CADdPHGu0s=rjqRZiFn4K8+fVFc4JG0bOpd3r-HStk1S3nM69BQ@mail.gmail.com> <4FDB56F5.3060407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48143 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab2FOSuG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 14:50:06 -0400
Received: by pbbrp8 with SMTP id rp8so5636937pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 11:50:05 -0700 (PDT)
In-Reply-To: <4FDB56F5.3060407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Guido Winkelmann <guido-ceph@thisisnotatest.de>, Sage Weil <sage@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, ceph-devel@vger.kernel.org

Since Guido was seeing this problem on btrfs as well, I'm going to try
tracking down more precisely where it was introduced.

Josh

On 06/15/2012 08:38 AM, Josh Durgin wrote:
> Short version: you should set 'filestore fiemap = false' for your osds.
>
> I was able to reproduce the crash with all the debugging I needed
> yesterday via test_librbd_fsx, and the problem looks like a bug in
> fiemap. Even though we call fsync before each fiemap call, we were
> getting different results (one bad result, which resulted in the
> corruption, and the correct result later, with no writes to the file
> in between).
>
> This was on XFS kernel 3.3.1, so I'll be sending a report to the xfs
> list with the log when I get to the office. I don't know which
> other versions are affected yet.
>
> In the meantime, you should turn fiemap usage off on the osd by setting
> 'filestore fiemap = false' in your ceph.conf [osd] section. I think
> we should make that the default in 0.48 as well.
>
> Josh
>
> On 06/15/2012 05:14 AM, Stefan Majer wrote:
>> Hi,
>>
>> We had today a catastrophic fs corruption in one of our virtual
>> machines, after fsck ~100MB was inside lost+found :-(
>> So is think we hit the same bug (ceph-0.45.2, sparse rbd images)
>>
>> Is there any progress on this topic, or any hint how to help on this
>> would be helpful.
>>
>> Greetings
>> Stefan Majer
>>
>> On Tue, Jun 12, 2012 at 2:31 PM, Guido Winkelmann
>> <guido-ceph@thisisnotatest.de> wrote:
>>> Am Montag, 11. Juni 2012, 09:30:42 schrieb Sage Weil:
>>>> If you can reproduce it with 'debug filestore = 20' too, that will be
>>>> better, as it will tell us what the FIEMAP ioctl is returning.
>>>
>>> I ran another testrun with 'debug filestore = 20'.
>>>
>>>> Also, if
>>>> you can attach/post the contents of the object itself (rados -p rbd get
>>>> rb.0.1.0000000002a0 /tmp/foo) we can make sure the object has the right
>>>> data (and the sparse-read operation that librbd is doing is the
>>>> culprit).
>>>
>>> I tried that, with the block name that the steps further below gave me:
>>>
>>> rados -p rbd get rb.0.13.00000000045a block
>>>
>>> When I looked into the block, it looked like a bunch of temp files
>>> from the
>>> portage system with padding in between, although it should be random
>>> data... I
>>> think I got the wrong block after all...
>>>
>>> Here's what I did:
>>> Run the iotester again:
>>> testserver-rbd11 iotester # date ; ./iotester /var/iotest ; date
>>> Tue Jun 12 13:51:58 CEST 2012
>>> Wrote 100 MiB of data in 2004 milliseconds
>>> [snip lots of irrelevant lines]
>>> Wrote 100 MiB of data in 2537 milliseconds
>>> Read 100 MiB of data in 3794 milliseconds
>>> Read 100 MiB of data in 10150 milliseconds
>>> Digest wrong for file
>>> "/var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e"
>>> Tue Jun 12 13:55:00 CEST 2012
>>>
>>> Run the fiemap tool on that file:
>>>
>>> testserver-rbd11 ~ # ./fiemap
>>> /var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e
>>> File /var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e has 1 extents:
>>> # Logical Physical Length Flags
>>> 0: 0000000000000000 0000000116900000 0000000000100000 0001
>>>
>>>> As for the log:
>>>>
>>>> First, map the offset to an rbd block. For example, taking the
>>>> 'Physical'
>>>> value of 00000000a8200000 from above:
>>>>
>>>> $ printf "%012x\n" $((0x00000000a8200000 / (4096*1024) ))
>>>> 0000000002a0
>>>
>>> That gave me
>>>
>>> $ printf "%012x\n" $((0x0000000116900000 / (4096*1024) ))
>>> 00000000045a
>>>
>>>> Then figure out what the object name prefix is:
>>>>
>>>> $ rbd info<imagename> | grep prefix
>>>> block_name_prefix: rb.0.1
>>>
>>> Result: block_name_prefix: rb.0.13
>>>
>>>> Then add the block number, 0000000002a0 to that, e.g.
>>>> rb.0.1.0000000002a0.
>>>
>>> Result: rb.0.13.00000000045a
>>>
>>>> Then map that back to an osd with
>>>>
>>>> $ ceph osd map rbd rb.0.1.0000000002a0
>>>> osdmap e19 pool 'rbd' (2) object 'rb.0.1.0000000002a0' -> pg 2.a2e06f65
>>>> (2.5) -> up [0,2] acting [0,2]
>>>
>>> That gives me
>>> [root@storage1 ~]# ceph osd map rbd rb.0.13.00000000045a 2> /dev/null
>>> osdmap e101 pool 'rbd' (2) object 'rb.0.13.00000000045a' -> pg
>>> 2.80b039fb
>>> (2.7b) -> up [2,1] acting [2,1]
>>>
>>>> You'll see the osd ids listed in brackets after 'active'. We want the
>>>> first one, 0 in my example. The log from that OSD is what we need.
>>>
>>> Okay, i'm attaching the compressed log for osd.2 and the compressed
>>> block to
>>> the issue report in the redmine.
>>>
>>> Guido
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

