From: Eric Sandeen <sandeen@redhat.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 22 Feb 2016 09:56:59 -0600
Message-ID: <56CB2FCB.8080105@redhat.com>
References: <9D046674-EA8B-4CB5-B049-3CF665D4ED64@aevoo.fr>
 <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
 <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
 <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
 <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net>
 <5661F3A9.8070703@redhat.com> <20151208044640.GL1983@devil.localdomain>
 <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
 <20160216033538.GB2005@devil.localdomain> <56C74B91.9080508@redhat.com>
 <CA+gn+znGy7VnfkZ+vz65s-j+hpTafQ731-T_tx6gYZrRk3h1Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034AbcBVP5C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Feb 2016 10:57:02 -0500
In-Reply-To: <CA+gn+znGy7VnfkZ+vz65s-j+hpTafQ731-T_tx6gYZrRk3h1Yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier <david.casier@aevoo.fr>
Cc: Dave Chinner <dchinner@redhat.com>, Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>

On 2/21/16 4:56 AM, David Casier wrote:
> I made a simple test with XFS
> 
> dm-sdf6-sdg1 :
> -------------------------------------------------------------------------------------------
> ||  sdf6 : SSD part ||           sdg1 : HDD (4TB)                         ||
> -------------------------------------------------------------------------------------------

If this is in response to my concern about not working on small
filesystems, the above is sufficiently large that inode32
won't be ignored.

> [root@aotest ~]# mkfs.xfs -f -i maxpct=0.2 /dev/mapper/dm-sdf6-sdg1

Hm, why set maxpct?  This does affect how the inode32 allocator
works, but I'm wondering if that's why you set it.  How did you arrive
at 0.2%?  Just want to be sure you understand what you're tuning.

Thanks,
-Eric

> [root@aotest ~]# mount -o inode32 /dev/mapper/dm-sdf6-sdg1 /mnt
> 
> 8 directory with 16, 32, ..., 128 sub-directory and 16, 32, ..., 128
> files (82 bytes)
> 1 xattr per dir and 3 xattr per file (user.cephosd...)
> 
> 3 800 000 files and directory
> 16 GiB was written on SSD
> 
> ------------------------------------------------------
> ||                 find | wc -l                   ||
> ------------------------------------------------------
> || Objects per dir || % IOPS on SSD ||
> ------------------------------------------------------
> ||           16         ||            99           ||
> ||           32         ||           100          ||
> ||           48         ||            93           ||
> ||           64         ||            88           ||
> ||           80         ||            88           ||
> ||           96         ||            86           ||
> ||          112        ||            87           ||
> ||          128        ||            88           ||
> -----------------------------------------------------
> 
> ------------------------------------------------------
> ||           find -exec getfattr '{}' \;         ||
> ------------------------------------------------------
> || Objects per dir || % IOPS on SSD ||
> ------------------------------------------------------
> ||           16         ||            96           ||
> ||           32         ||            97           ||
> ||           48         ||            96           ||
> ||           64         ||            95           ||
> ||           80         ||            94           ||
> ||           96         ||            93           ||
> ||          112        ||            94           ||
> ||          128        ||            95           ||
> -----------------------------------------------------
> 
> It is true that filestore is not designed to make Big Data and the
> cache must work inode / xattr
> 
> I hope to see quiclky Bluestore in production :)
> 
> 2016-02-19 18:06 GMT+01:00 Eric Sandeen <esandeen@redhat.com>:
>>
>>
>> On 2/15/16 9:35 PM, Dave Chinner wrote:
>>> On Mon, Feb 15, 2016 at 04:18:28PM +0100, David Casier wrote:
>>>> Hi Dave,
>>>> 1TB is very wide for SSD.
>>>
>>> It fills from the bottom, so you don't need 1TB to make it work
>>> in a similar manner to the ext4 hack being described.
>>
>> I'm not sure it will work for smaller filesystems, though - we essentially
>> ignore the inode32 mount option for sufficiently small filesystems.
>>
>> i.e. if inode numbers > 32 bits can't exist, we don't change the allocator,
>> at least not until the filesystem (possibly) gets grown later.
>>
>> So for inode32 to impact behavior, it needs to be on a filesystem
>> of sufficient size (at least 1 or 2T, depending on block size, inode
>> size, etc). Otherwise it will have no effect today.
>>
>> Dave, I wonder if we need another mount option to essentially mean
>> "invoke the inode32 allocator regardless of filesystem size?"
>>
>> -Eric
>>
>>>> Exemple with only 10GiB :
>>>> https://www.aevoo.fr/2016/02/14/ceph-ext4-optimisation-for-filestore/
>>>
>>> It's a nice toy, but it's not something that is going scale reliably
>>> for production.  That caveat at the end:
>>>
>>>       "With this model, filestore rearrange the tree very
>>>       frequently : + 40 I/O every 32 objects link/unlink."
>>>
>>> Indicates how bad the IO patterns will be when modifying the
>>> directory structure, and says to me that it's not a useful
>>> optimisation at all when you might be creating several thousand
>>> files/s on a filesystem. That will end up IO bound, SSD or not.
>>>
>>> Cheers,
>>>
>>> Dave.
>>>
> 
> 
> 

