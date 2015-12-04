From: Eric Sandeen <esandeen@redhat.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Fri, 4 Dec 2015 14:20:14 -0600
Message-ID: <5661F57E.80709@redhat.com>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
 <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
 <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
 <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
 <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com>
Reply-To: sandeen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56450 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756123AbbLDUUR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Dec 2015 15:20:17 -0500
In-Reply-To: <5661F3A9.8070703@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, David Casier <david.casier@aevoo.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Dave Chinner <dchinner@redhat.com>, Brian Foster <bfoster@redhat.com>

On 12/4/15 2:12 PM, Ric Wheeler wrote:
> On 12/01/2015 05:02 PM, Sage Weil wrote:
>> Hi David,
>>
>> On Tue, 1 Dec 2015, David Casier wrote:
>>> Hi Sage,
>>> With a standard disk (4 to 6 TB), and a small flash drive, it's easy
>>> to create an ext4 FS with metadata on flash
>>>
>>> Example with sdg1 on flash and sdb on hdd :
>>>
>>> size_of() {
>>>    blockdev --getsize $1
>>> }
>>>
>>> mkdmsetup() {
>>>    _ssd=/dev/$1
>>>    _hdd=/dev/$2
>>>    _size_of_ssd=$(size_of $_ssd)
>>>    echo """0 $_size_of_ssd linear $_ssd 0
>>>    $_size_of_ssd $(size_of $_hdd) linear $_hdd 0" | dmsetup create dm-${1}-${2}
>>> }
>>>
>>> mkdmsetup sdg1 sdb
>>>
>>> mkfs.ext4 -O ^has_journal,flex_bg,^uninit_bg,^sparse_super,sparse_super2,^extra_isize,^dir_nlink,^resize_inode
>>> -E packed_meta_blocks=1,lazy_itable_init=0 -G 32768 -I 128 -i
>>> $((1024*512)) /dev/mapper/dm-sdg1-sdb
>>>
>>> With that, all meta_blocks are on the SSD
>>>
>>> If omap are on SSD, there are almost no metadata on HDD
>>>
>>> Consequence : performance Ceph (with hack on filestore without journal
>>> and directIO) are almost same that performance of the HDD.
>>>
>>> With cache-tier, it's very cool !
>> Cool!  I know XFS lets you do that with the journal, but I'm not sure if
>> you can push the fs metadata onto a different device too.. I'm guessing
>> not?
>>
>>> That is why we are working on a hybrid approach HDD / Flash on ARM or Intel
>>>
>>> With newstore, it's much more difficult to control the I/O profil.
>>> Because rocksDB embedded its own intelligence
>> This is coincidentally what I've been working on today.  So far I've just
>> added the ability to put the rocksdb WAL on a second device, but it's
>> super easy to push rocksdb data there as well (and have it spill over onto
>> the larger, slower device if it fills up).  Or to put the rocksdb WAL on a
>> third device (e.g., expensive NVMe or NVRAM).
>>
>> See this ticket for the ceph-disk tooling that's needed:
>>
>>     http://tracker.ceph.com/issues/13942
>>
>> I expect this will be more flexible and perform better than the ext4
>> metadata option, but we'll need to test on your hardware to confirm!
>>
>> sage
> 
> I think that XFS "realtime" subvolumes are the thing that does this -  the second volume contains only the data (no metadata).
> 
> Seem to recall that it is popular historically with video appliances, etc but it is not commonly used.
> 
> Some of the XFS crew cc'ed above would have more information on this,

The realtime subvolume puts all data on a separate volume, and uses a different
allocator; it is more for streaming type applications, in general.  And it's
not enabled in RHEL - and not heavily tested at this point, I think.

-Eric
