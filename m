From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph RBD performance - random writes
Date: Wed, 08 Aug 2012 16:58:57 -0500
Message-ID: <5022E121.4070004@inktank.com>
References: <5021F6D1.7000004@catalyst.net.nz> <5022B3F4.5050109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39065 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2HHV7B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 17:59:01 -0400
Received: by yhmm54 with SMTP id m54so1348486yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Aug 2012 14:59:00 -0700 (PDT)
In-Reply-To: <5022B3F4.5050109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, ceph-devel@vger.kernel.org

On 8/8/12 1:46 PM, Josh Durgin wrote:
> On 08/07/2012 10:19 PM, Mark Kirkwood wrote:
>> I've been looking at using Ceph RBD as a block store for database use.
>> As part of this I'm looking a how (particularly random) IO of smallish
>> (4K, 8K) block sizes performs.
>>
>> I've setup Ceph with a single osd and mon spread over two SSD (Intel
>> 520) - 2G journal on one and the osd data on the other (xfs filesystem).
>> The Intel's are pretty fast, and (despite being shackled by a crappy
>> Nvidia SATA controller) fly for random IO.
>>
>> However I am not seeing that reflected in the RBD case. I have the
>> device mounted on the local machine where the osd and mon are running
>> (so network performance should not be a factor here).
>>
>> Here is what I did:
>>
>> Create a rbd device of 10G and mount on /mnt/vol0:
>>
>> $ rbd create --size 10240 vol0
>> $ rbd map vol0
>> $ mkfx.xfs /dev/rbd0
>> $ rbd mount /dev/rdb0 /mnt/vol0
>>
>> Make a file:
>>
>> $ dd if=/dev/zero of=/mnt/vol0/dump/file bs=4k count=300000 conv=fsync
>> 1228800000 bytes (1.2 GB) copied, 13.4361 s, 91.5 MB/s
>>
>> Performance ok if file size < journal (2G).
>>
>> $ dd if=/dev/zero of=/mnt/vol0/dump/file bs=4096k count=200 conv=fsync
>> 838860800 bytes (839 MB) copied, 9.47086 s, 88.6 MB/s
>>
>> Not so good if file size > journal.
>>
>> $ dd if=/dev/zero of=/mnt/vol0/dump/file bs=4096k count=1000 conv=fsync
>> 4194304000 bytes (4.2 GB) copied, 279.891 s, 15.0 MB/s
>>
>> Random writes (see attached file) sync'ed with sync_file_range are ok if
>> block size big:
>>
>> $ ./writetest /mnt/vol0/dump/file 4194304 0 1
>> random writes: 292 of: 4194304 bytes elapsed: 9.8397s io rate: 30/s
>> (118.70 MB/s)
>>
>> $ ./writetest /mnt/vol0/dump/file 1048576 0 1
>> random writes: 1171 of: 1048576 bytes elapsed: 10.6042s io rate: 110/s
>> (110.43 MB/s)
>>
>> $ ./writetest /mnt/vol0/dump/file 131072 0 1
>> random writes: 9375 of: 131072 bytes elapsed: 15.8075s io rate: 593/s
>> (74.13 MB/s)
>>
>>
>> However smallish block size is suicide (trigger suicide assert after a
>> while), I see 100 IOPS or less on actual devices, all 100% util:
>>
>> $ ./writetest /mnt/vol0/dump/file 8192 0 1
>>
>> I am running into http://tracker.newdream.net/issues/2784 here I think.
>
> This can be a sign of a bug in the underlying filesystem or hardware -
> maybe your controller? That assert is hit when a single operation to
> the filesystem beneath the osd takes longer than 180 seconds (by
> default).
>
>> Note that the actual SSD are very fast for this when accessed directly:
>>
>> $ ./writetest /data1/ceph/1/file 8192 0 1
>> random writes: 1000000 of: 8192 bytes elapsed: 125.7907s io rate: 7950/s
>> (62.11 MB/s)
>>
>>
>> Thanks for your patience in reading so far - some actual questions now
>> :-)
>>
>> 1/ Why is the appending write from dd when the size of file > journal so
>> slow, despite reasonably capable storage devices?
>
> It's possible you need to use more threads to have more operations in
> flight in to the filestore (the main storage for the osd). Try
> something like this in your ceph configuration for the osds:
>
>      osd op threads = 24
>      osd disk threads = 24
>      filestore op threads = 6
>      filestore queue max ops = 24
>
> (from http://www.spinics.net/lists/ceph-devel/msg07128.html)
>

It's probably worth giving a try, but I haven't had much luck improving 
small IO performance with more threads/queued ops.

>> 2/ Is the sudden dramatic drop in random write performance a
>> manifestation of the "small requests  are slow" issue? or is this
>> something else?
>
> It's probably that. Sam's actively looking into it, and once he has
> something it will be interesting to see how well it works on your
> hardware.

For what it's worth, with mostly default settings I was seeing about 
8MB/s to dell branded samsung SSDs with 4k IOs using rados bench.  That 
was with 256 concurrent client requests.  This is definitely something 
we are working hard on tracking down.

>
> Josh
>
>> Thanks
>>
>> Mark
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


