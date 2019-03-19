From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
Date: Tue, 19 Mar 2019 16:42:24 +0000
Message-ID: <8736nin7db.fsf@suse.com>
References: <20190312142019.30936-1-lhenriques@suse.com>
        <20190312142019.30936-3-lhenriques@suse.com>
        <CAAM7YAkksn_w6Nsm0D7HVGh59ysAJyHptXQ886xD9DAVGhxNEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAkksn_w6Nsm0D7HVGh59ysAJyHptXQ886xD9DAVGhxNEQ@mail.gmail.com>
        (Zheng Yan's message of "Mon, 18 Mar 2019 21:06:28 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Tue, Mar 12, 2019 at 10:22 PM Luis Henriques <lhenriques@suse.com> wrote:
...
>> +static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
>> +                                            struct super_block *sb,
>> +                                            struct ceph_snap_realm *realm)
>> +{
>> +       struct inode *in;
>> +
>> +       in = ceph_lookup_inode(sb, realm->ino);
>> +       if (IS_ERR(in)) {
>> +               pr_warn("Can't lookup inode %llx (err: %ld)\n",
>> +                       realm->ino, PTR_ERR(in));
>> +               return in;
>> +       }
>> +
>> +       spin_lock(&mdsc->quotarealms_inodes_lock);
>> +       list_add(&ceph_inode(in)->i_quotarealms_inode_item,
>> +                &mdsc->quotarealms_inodes_list);
>> +       spin_unlock(&mdsc->quotarealms_inodes_lock);
>> +
> Multiple threads can call this function for the same inode at the same
> time. need to handle this. Besides, client needs to record lookupino
> error. Otherwise, client may repeatedly send useless request.

Good point.  So, the only way I see to fix this is to drop the
mdsc->quotarealms_inodes_list and instead use an ordered list/tree of
structs that would either point to the corresponding ceph inode or to
NULL if there was an error in the lookup:

	struct ceph_realm_inode {
                u64 ino;
		struct ceph_inode_info *ci;
		spinlock_t lock;
		unsigned long timeout;
	}

The 'timeout' field would be used to try to do the lookup again if the
error occurred long time ago.

The code would then create a new struct for the realm->ino (if one is
not found in the mdsc list), lock it and do the lookupino; if there's a
struct already on the list, it either means there's a lookupino in
progress or there was an error in the last lookup.

This sounds overly complicated so I may be missing the obvious simple
fix.  Any ideas?

>> +       spin_lock(&realm->inodes_with_caps_lock);
>> +       realm->inode = in;
>
> reply of lookup_ino should alreadly set realm->inode

Yes, of course.  This was silly.

Cheers,
-- 
Luis
