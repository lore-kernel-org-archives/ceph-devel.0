From: Eric Sandeen <esandeen@redhat.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 15 Feb 2016 10:21:05 -0600
Message-ID: <56C1FAF1.3030805@redhat.com>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
 <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
 <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
 <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
 <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com> <20151208044640.GL1983@devil.localdomain>
 <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
Reply-To: sandeen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42828 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbcBOQVI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Feb 2016 11:21:08 -0500
In-Reply-To: <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier <david.casier@aevoo.fr>, Dave Chinner <dchinner@redhat.com>
Cc: Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>

On 2/15/16 9:18 AM, David Casier wrote:
> Hi Dave,
> 1TB is very wide for SSD.
> Exemple with only 10GiB :
> https://www.aevoo.fr/2016/02/14/ceph-ext4-optimisation-for-filestore/

It wouldn't be too hard to modify the inode32 restriction to a lower
threshold, I think, if it would really be useful.

On the other hand, 10GiB seems awfully small.  What are realistic
sizes for this usecase?

-Eric

 
> 2015-12-08 5:46 GMT+01:00 Dave Chinner <dchinner@redhat.com>:
>> On Fri, Dec 04, 2015 at 03:12:25PM -0500, Ric Wheeler wrote:
>>> On 12/01/2015 05:02 PM, Sage Weil wrote:
>>>> Hi David,
>>>>
>>>> On Tue, 1 Dec 2015, David Casier wrote:
>>>>> Hi Sage,
>>>>> With a standard disk (4 to 6 TB), and a small flash drive, it's easy
>>>>> to create an ext4 FS with metadata on flash
>>>>>
>>>>> Example with sdg1 on flash and sdb on hdd :
>>>>>
>>>>> size_of() {
>>>>>   blockdev --getsize $1
>>>>> }
>>>>>
>>>>> mkdmsetup() {
>>>>>   _ssd=/dev/$1
>>>>>   _hdd=/dev/$2
>>>>>   _size_of_ssd=$(size_of $_ssd)
>>>>>   echo """0 $_size_of_ssd linear $_ssd 0
>>>>>   $_size_of_ssd $(size_of $_hdd) linear $_hdd 0" | dmsetup create dm-${1}-${2}
>>>>> }
>>
>> So this is just a linear concatenation that relies on ext4 putting
>> all it's metadata at the front of the filesystem?
>>
>>>>>
>>>>> mkdmsetup sdg1 sdb
>>>>>
>>>>> mkfs.ext4 -O ^has_journal,flex_bg,^uninit_bg,^sparse_super,sparse_super2,^extra_isize,^dir_nlink,^resize_inode
>>>>> -E packed_meta_blocks=1,lazy_itable_init=0 -G 32768 -I 128 -i
>>>>> $((1024*512)) /dev/mapper/dm-sdg1-sdb
>>>>>
>>>>> With that, all meta_blocks are on the SSD
>>
>> IIRC, it's the "packed_meta_blocks=1" that does this.
>>
>> THis is something that is pretty trivial to do with XFS, too,
>> by use of the inode32 allocation mechanism. That reserves the
>> first TB of space for inodes and other metadata allocations,
>> so if you span the first TB with SSDs, you get almost all the
>> metadata on the SSDs, and all the data in the higher AGs. With the
>> undocumented log location mkfs option, you can also put hte log at
>> the start og AG 0 which means that would sit on the SSD, too,
>> without needing an external log device.
>>
>> SGI even had a mount option hack to limit this allocator behaviour
>> to a block limit lower than 1TB so they could limit the metadata AG
>> regions to, say, the first 200GB.
>>
>>>> This is coincidentally what I've been working on today.  So far I've just
>>>> added the ability to put the rocksdb WAL on a second device, but it's
>>>> super easy to push rocksdb data there as well (and have it spill over onto
>>>> the larger, slower device if it fills up).  Or to put the rocksdb WAL on a
>>>> third device (e.g., expensive NVMe or NVRAM).
>>
>> I have old bits and pieces from 7-8 years ago that would allow some
>> application control of allocation policy to allow things like this
>> to be done, but I left SGI before it was anything mor ethan just a
>> proof of concept....
>>
>>>> See this ticket for the ceph-disk tooling that's needed:
>>>>
>>>>     http://tracker.ceph.com/issues/13942
>>>>
>>>> I expect this will be more flexible and perform better than the ext4
>>>> metadata option, but we'll need to test on your hardware to confirm!
>>>>
>>>> sage
>>>
>>> I think that XFS "realtime" subvolumes are the thing that does this
>>> -  the second volume contains only the data (no metadata).
>>>
>>> Seem to recall that it is popular historically with video
>>> appliances, etc but it is not commonly used.
>>
>> Because it's a single threaded allocator. It's not suited to highly
>> concurrent applications, just applications that require large
>> extents allocated in a deterministic manner.
>>
>> Cheers,
>>
>> Dave.
>> --
>> Dave Chinner
>> dchinner@redhat.com
> 
> 
> 
