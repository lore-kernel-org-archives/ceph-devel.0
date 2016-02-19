From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Fwd: Fwd: [newstore (again)] how disable double write WAL
Date: Fri, 19 Feb 2016 22:28:52 +1100
Message-ID: <CA+z5Dsz_2z42tRtmSf3pSxSNModxmW60C6POUJDOMP9ZnwAgZg@mail.gmail.com>
References: <alpine.DEB.2.00.1511241240150.25734@cobra.newdream.net>
 <CA+gn+znHyioZhOvuidN1pvMgRMOMvjbjcues_+uayYVadetz=A@mail.gmail.com>
 <CA+gn+z=5+gu=3R3ssLq-kQBjB6DFYeb9JteXV5Y7in89b8cmKA@mail.gmail.com>
 <alpine.DEB.2.00.1512011357340.19170@cobra.newdream.net> <5661F3A9.8070703@redhat.com>
 <20151208044640.GL1983@devil.localdomain> <CA+gn+znGzF+J=qAk+511qdfPJV4xYB+4F5k8KMLWh0+JtryLeA@mail.gmail.com>
 <20160216033538.GB2005@devil.localdomain> <CA+gn+z=dGTeLo71h=z=AvoLM-RRq_-RfbJwFamyfxK93bvk+Hw@mail.gmail.com>
 <CA+gn+zmCx_Pu6oEUT31SfKRF1A9Pzi1aWTPbXJY7dOgQqCqARQ@mail.gmail.com> <20160219052637.GF2005@devil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33285 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427186AbcBSL3M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Feb 2016 06:29:12 -0500
Received: by mail-ob0-f175.google.com with SMTP id jq7so104635342obb.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 Feb 2016 03:29:11 -0800 (PST)
In-Reply-To: <20160219052637.GF2005@devil.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Chinner <dchinner@redhat.com>
Cc: David Casier <david.casier@aevoo.fr>, Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, Brian Foster <bfoster@redhat.com>, Eric Sandeen <esandeen@redhat.com>, =?UTF-8?Q?Beno=C3=AEt_LORIOT?= <benoit.loriot@aevoo.fr>

Interesting observations Dave. Given XFS is Ceph's current production
standard it makes me wonder why the default filestore configs split
leaf directories at only 320 objects. We've seen first hand that it
doesn't take long before this starts hurting performance in a big way.

Cheers,

On 19 February 2016 at 16:26, Dave Chinner <dchinner@redhat.com> wrote:
> On Tue, Feb 16, 2016 at 09:39:28AM +0100, David Casier wrote:
>>         "With this model, filestore rearrange the tree very
>>         frequently : + 40 I/O every 32 objects link/unlink."
>> It is the consequence of parameters :
>> filestore_merge_threshold = 2
>> filestore_split_multiple = 1
>>
>> Not of ext4 customization.
>
> It's a function of the directory structure you are using to work
> around the scalability deficiencies of the ext4 directory structure.
> i.e. the root cause is that you are working around an ext4 problem.
>
>> The large amount of objects in FileStore require indirect access and
>> more IOPS for every directory.
>>
>> If root of inode B+tree is a simple block, we have the same problem with XFS
>
> Only if you use the same 32-entries per directory constraint. Get
> rid of that constraint, start thinking about storing tens of
> thousands of files per directory instead. i.e. let the directory
> structure handle IO optimisation as the number of entries grow, not
> impose artificial limits that prevent them from working efficiently.
>
> Put simply, XFS is more efficient in terms of the average physical
> IO per random inode lookup with shallow, wide directory structures
> than it will be with a narrow, deep setup that is optimised to work
> around the shortcomings of ext3/ext4.
>
> When you use deep directory structures to inde millions of files,
> you have to assume that any random lookup will require directory
> inode IO. When you use wide, shallow directories you can almost
> guarantee that the directory inodes will remain cached in memory
> because the are so frequently traversed. hence we never need to do
> IO for directory inodes in a wide, shallow config, and so that IO
> can be ignored.
>
> So let's assume, for ease of maths, we have 40 byte dirent
> structures (~24 byte file names). That means a single 4k directory
> block can index aproximately 60-70 entries. More than this, and XFs
> switches to a more scalable multi-block ("leaf", then "node") format.
>
> When XFs moves to a multi-block structure, the first block of the
> directory is converted to a name hash btree that allows finding any
> directory entry in one further IO.  The hash index is made up of 8
> byte entries, so for a 4k block it can index 500 entries in a single
> IO.  IOWs, a random, cold cache lookup across 500 directory entries
> can be done in 2 IOs.
>
> Now lets add a second level to that hash btree - we have 500 hash
> index leaf blocks that can be reached in 2 IOs, so now we can reach
> 25,000 entries in 3 IOs. And in 4 IOs we can reach 2.5 million
> entries.
>
> It should be noted that the length of the directory entries doesn't
> affect this lookup scalability because the index is based on 4 byte
> name hashes. Hence it has the same scalability characterisitics
> regardless of the name lengths; it is only affect by changes in
> directory block size.
>
> If we consider your current "1 IO per directory" config using a 32
> entry structure, it's 1024 entries in 2 IOs, 32768 in 3 IOs and with
> 4 IOs it's 1 million entries. This is assuming we can fit 32 entries
> in the inode core, which we shoul dbe able to do for the nodes of
> the tree, but the leaves with the file entries are probably going to
> have full object names and so are likely to be in block format. I've
> ignored this and assume the leaf directories pointing to the objects
> are also inline.
>
> IOWs, by the time we get to needing 4 IOs to reach the file store
> leaf directories (i.e. > ~30,000 files in the object store), a
> single XFS directory is going to have the same or better IO efficiency
> than your configuration fixed confiugration.
>
> And we can make XFS even better - with an 8k directory block size, 2
> IOs reach 1000 entries, 3 IOs reach a million entries, and 4 IOs
> reach a billion entries.
>
> So, in summary, the number of entries that can be indexed in a
> given number of IOs:
>
> IO count                1       2       3       4
> 32 entry wide           32      1k      32k     1m
> 4k dir block            70      500     25k     2.5m
> 8k dir block            150     1k      1m      1000m
>
> And the number of directories required for a given number of
> files if we limit XFS directories to 3 internal IOs:
>
> file count              1k      10k     100k    1m      10m     100m
> 32 entry wide           32      320     3200    32k     320k    3.2g
> 4k dir block            1       1       5       50      500     5k
> 8k dir block            1       1       1       1       11      101
>
> So, as you can see, once you make the directory structure shallow
> and wide, you can reach many more entries in the same number of IOs
> and there is much lower inode/dentry cache footprint when you do so.
> IOWs, on XFS you design the heirachy to provide the necessary
> lookup/modification concurrency as IO scalibility as file counts
> rise is already efficeintly handled by the filesystem's directory
> structure.
>
> Doing this means the file store does not need to rebalance every 32
> create/unlink operations. Nor do you need to be concerned about
> maintaining a working set of directory inodes in cache under memory
> pressure - there directory entries become the hotest items in the
> cache and so will never get reclaimed.
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> dchinner@redhat.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
