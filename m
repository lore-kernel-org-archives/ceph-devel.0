From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 2/2] ceph: quota: fix quota subdir mounts
Date: Thu, 07 Mar 2019 11:02:09 +0000
Message-ID: <87mum79ccu.fsf@suse.com>
References: <20190301175752.17808-1-lhenriques@suse.com>
        <20190301175752.17808-3-lhenriques@suse.com>
        <CAAM7YAmPSoEaJ6tXUtp+f56SV-Tqr6VKP4RquV0FA+LYkR8Rxg@mail.gmail.com>
        <87va0vamog.fsf@suse.com>
        <CAAM7YAmapiFwj=sY+vCUyOU1mPZE2sk4_ZYPYAk06iPDd_utzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAmapiFwj=sY+vCUyOU1mPZE2sk4_ZYPYAk06iPDd_utzQ@mail.gmail.com>
        (Zheng Yan's message of "Thu, 7 Mar 2019 15:29:24 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Thu, Mar 7, 2019 at 2:21 AM Luis Henriques <lhenriques@suse.com> wrote:
>>
>> "Yan, Zheng" <ukernel@gmail.com> writes:
>>
>> > On Sat, Mar 2, 2019 at 3:13 AM Luis Henriques <lhenriques@suse.com> wrote:
>> >>
>> >> The CephFS kernel client doesn't enforce quotas that are set in a
>> >> directory that isn't visible in the mount point.  For example, given the
>> >> path '/dir1/dir2', if quotas are set in 'dir1' and the mount is done in with
>> >>
>> >>   mount -t ceph <server>:<port>:/dir1/ /mnt
>> >>
>> >> then the client can't access the 'dir1' inode from the quota realm dir2
>> >> belongs to.
>> >>
>> >> This patch fixes this by simply doing an MDS LOOKUPINO Op and grabbing a
>> >> reference to it (so that it doesn't disappear again).  This also requires an
>> >> extra field in ceph_snap_realm so that we know we have to release that
>> >> reference when destroying the realm.
>> >>
>> >
>> > This may cause circle reference if somehow an inode owned by snaprealm
>> > get moved into mount subdir (other clients do rename).  how about
>> > holding these inodes in mds_client?
>>
>> Ok, before proceeded any further I wanted to make sure that what you
>> were suggesting was something like the patch below.  It simply keeps a
>> list of inodes in ceph_mds_client until the filesystem is umounted,
>> iput()ing them at that point.
>>
> yes,
>
>> I'm sure I'm missing another place where the reference should be
>> dropped, but I couldn't figure it out yet.  It can't be
>> ceph_destroy_inode; drop_inode_snap_realm is a possibility, but what if
>> the inode becomes visible in the meantime?  Well, I'll continue thinking
>> about it.
>
> why do you think we need to clean up the references at other place.
> what problem you encountered.

I'm not really seeing any issue, at least not at the moment.  I believe
that we could just be holding refs to inodes that may not exist anymore
in the cluster.  For example, in client 1:

 mkdir -p /mnt/a/b
 setfattr -n ceph.quota.max_files -v 5 /mnt/a

In client 2 we mount:

 mount <addr>:/a/b /mnt

This client will access the realm and inode for 'a' (adding that inode
to the ceph_mds_client list), because it has quotas.  If client 1 then
deletes 'a', client 2 will continue to have a reference to that inode in
that list.  That's why I thought we should be able to clean up that refs
list in some other place, although that's probably a big deal, since we
won't be able to a lot with this mount anyway.

Cheers,
-- 
Luis
