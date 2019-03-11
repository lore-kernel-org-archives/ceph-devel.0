From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH 2/2] ceph: quota: fix quota subdir mounts
Date: Mon, 11 Mar 2019 11:43:07 +0000
Message-ID: <87h8c9fxh0.fsf@suse.com>
References: <20190308162757.9260-1-lhenriques@suse.com>
        <20190308162757.9260-3-lhenriques@suse.com>
        <CAAM7YAnDvg0y8qkdGjO-EEdC6s5dMeHHF-PgeAxPqN_LPSSrEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAnDvg0y8qkdGjO-EEdC6s5dMeHHF-PgeAxPqN_LPSSrEA@mail.gmail.com>
        (Zheng Yan's message of "Mon, 11 Mar 2019 11:12:19 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Sat, Mar 9, 2019 at 12:30 AM Luis Henriques <lhenriques@suse.com> wrote:
>>
>> The CephFS kernel client does not enforce quotas set in a directory that isn't
>> visible from the mount point.  For example, given the path '/dir1/dir2', if quotas
>> are set in 'dir1' and the filesystem is mounted with
>>
>>   mount -t ceph <server>:<port>:/dir1/ /mnt
>>
>> then the client won't be able to access 'dir1' inode, even if 'dir2' belongs to
>> a quota realm that points to it.
>>
>> This patch fixes this issue by simply doing an MDS LOOKUPINO operation for
>> unknown inodes.  Any inode reference obtained this way will be added to a list
>> in ceph_mds_client, and will only be released when the filesystem is umounted.
>>
>> Link: https://tracker.ceph.com/issues/38482
>> Reported-by: Hendrik Peyerl <hpeyerl@plusline.net>
>> Signed-off-by: Luis Henriques <lhenriques@suse.com>
>> ---
>>  fs/ceph/mds_client.c | 14 +++++++
>>  fs/ceph/mds_client.h |  2 +
>>  fs/ceph/quota.c      | 91 +++++++++++++++++++++++++++++++++++++++-----
>>  fs/ceph/super.h      |  2 +
>>  4 files changed, 99 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 163fc74bf221..72c5ce5e4209 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -3656,6 +3656,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>>         mdsc->max_sessions = 0;
>>         mdsc->stopping = 0;
>>         atomic64_set(&mdsc->quotarealms_count, 0);
>> +       INIT_LIST_HEAD(&mdsc->quotarealms_inodes_list);
>> +       spin_lock_init(&mdsc->quotarealms_inodes_lock);
>>         mdsc->last_snap_seq = 0;
>>         init_rwsem(&mdsc->snap_rwsem);
>>         mdsc->snap_realms = RB_ROOT;
>> @@ -3726,9 +3728,21 @@ static void wait_requests(struct ceph_mds_client *mdsc)
>>   */
>>  void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
>>  {
>> +       struct ceph_inode_info *ci;
>> +
>>         dout("pre_umount\n");
>>         mdsc->stopping = 1;
>>
>> +       spin_lock(&mdsc->quotarealms_inodes_lock);
>> +       while(!list_empty(&mdsc->quotarealms_inodes_list)) {
>> +               ci = list_first_entry(&mdsc->quotarealms_inodes_list,
>> +                                     struct ceph_inode_info,
>> +                                     i_quotarealms_inode_item);
>> +               list_del(&ci->i_quotarealms_inode_item);
>> +               iput(&ci->vfs_inode);
>
> iput while holding spinlock is not good

Yep, that's definitely not a good idea.  And maybe this loop could even
race with a lookup currently in progress and a new inode could be added
to the list after the cleanup.  I didn't verified this race could really
occur, because an easy fix is to simply move this loop into
ceph_mdsc_destroy() where we don't really need the spinlock anymore.

<snip>

>> +restart:
>>         down_read(&mdsc->snap_rwsem);
>> -       old_realm = get_quota_realm(mdsc, old);
>> -       new_realm = get_quota_realm(mdsc, new);
>> +       old_realm = get_quota_realm(mdsc, old, true);
>> +       /* This needs to be atomic, so we need to hold snap_rwsem */
>
> I don't understand this comment. get_quota_realm() unlock snap_rwsem
> no matter the 'retry' parameter is true or not/

Right, maybe the parameter name and the comment are a bit misleading.

get_quota_realm may need to do an inode lookup and then retry to get the
quota realm.  If this lookup is required, it has to drop the rwsem.

However, in ceph_quota_is_same_realm we need to lookup 2 quota realms
"atomically", i.e. with the rwsem held.  If get_quota_realm needs to
drop it, it will do the MDS inode lookup anyway but instead of retrying
to get the quota realm it will return -EAGAIN (because 'retry' will be
'false').  This allows for ceph_quota_is_same_realm to restart the
operation itself, and retry to get both quota realms without
get_quota_realm dropping the rwsem.

Does it make sense?  I agree the design isn't great :-/
I tried to describe this behavior in get_quota_realm comment, but it's
probably not good enough.

>> +       new_realm = get_quota_realm(mdsc, new, false);
>> +       if (PTR_ERR(new_realm) == -EAGAIN) {
>> +               up_read(&mdsc->snap_rwsem);
>> +               if (old_realm)
>> +                       ceph_put_snap_realm(mdsc, old_realm);
>> +               goto restart;
>> +       }
>>         is_same = (old_realm == new_realm);
>>         up_read(&mdsc->snap_rwsem);
>>
>> @@ -166,6 +230,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>>                 return false;
>>
>>         down_read(&mdsc->snap_rwsem);
>> +restart:
>>         realm = ceph_inode(inode)->i_snap_realm;
>>         if (realm)
>>                 ceph_get_snap_realm(mdsc, realm);
>> @@ -176,9 +241,15 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>>                 spin_lock(&realm->inodes_with_caps_lock);
>>                 in = realm->inode ? igrab(realm->inode) : NULL;
>>                 spin_unlock(&realm->inodes_with_caps_lock);
>> -               if (!in)
>> -                       break;
>> -
>> +               if (!in) {
>
> maybe we should  distinguish ‘realm->inode is null' from 'igrab fails'

Sure, that makes sense.

Cheers,
-- 
Luis


>
>> +                       up_read(&mdsc->snap_rwsem);
>> +                       in = lookup_quotarealm_inode(mdsc, inode->i_sb, realm);
>> +                       down_read(&mdsc->snap_rwsem);
>> +                       if (IS_ERR(in))
>> +                               break;
>> +                       ceph_put_snap_realm(mdsc, realm);
>> +                       goto restart;
>> +               }
>>                 ci = ceph_inode(in);
>>                 spin_lock(&ci->i_ceph_lock);
>>                 if (op == QUOTA_CHECK_MAX_FILES_OP) {
>> @@ -314,7 +385,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>>         bool is_updated = false;
>>
>>         down_read(&mdsc->snap_rwsem);
>> -       realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root));
>> +       realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
>>         up_read(&mdsc->snap_rwsem);
>>         if (!realm)
>>                 return false;
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index ce51e98b08ec..cc7766aeb73b 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -375,6 +375,8 @@ struct ceph_inode_info {
>>         struct list_head i_snap_realm_item;
>>         struct list_head i_snap_flush_item;
>>
>> +       struct list_head i_quotarealms_inode_item;
>> +
>>         struct work_struct i_wb_work;  /* writeback work */
>>         struct work_struct i_pg_inv_work;  /* page invalidation work */
>>
>
