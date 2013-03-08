From: "Yan, Zheng " <yanzheng@21cn.com>
Subject: Re: [PATCH 1/2] ceph: increase i_release_count when clear I_COMPLETE flag
Date: Fri, 8 Mar 2013 09:04:50 +0800
Message-ID: <CAAM7YAmkNh4CQPZvH6xm9tL7tZL+yqY=VRm1Vw7XL2_xzzKt5A@mail.gmail.com>
References: <1362656170-4337-1-git-send-email-zheng.z.yan@intel.com>
	<F994D6BB71B642259997BA453CFB0288@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:45291 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3CHBEx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 20:04:53 -0500
Received: by mail-la0-f45.google.com with SMTP id er20so1154958lab.4
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 17:04:51 -0800 (PST)
In-Reply-To: <F994D6BB71B642259997BA453CFB0288@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org, sage@inktank.com

On Fri, Mar 8, 2013 at 5:03 AM, Greg Farnum <greg@inktank.com> wrote:
> I'm pulling this in for now to make sure this clears out that ENOENT =
bug we hit =97 but shouldn't we be fixing ceph_i_clear() to always bump=
 the i_release_count? It doesn't seem like it would ever be correct wit=
hout it, and these are the only two callers.

yes, it's better to put it in ceph_i_clear(). will update patches once
they pass the test.

Regards
Yan, Zheng

>
> The second one looks good to us and we'll test it but of course that =
can't go upstream through our tree.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
> On Thursday, March 7, 2013 at 3:36 AM, Yan, Zheng wrote:
>
>> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.=
com)>
>>
>> If some dentries were pruned or FILE_SHARED cap was revoked while
>> readdir is in progress. make sure ceph_readdir() does not mark the
>> directory as complete.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan=
@intel.com)>
>> ---
>> fs/ceph/caps.c | 1 +
>> fs/ceph/dir.c | 13 +++++++++++--
>> 2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 76634f4..35cebf3 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -500,6 +500,7 @@ static void __check_cap_issue(struct ceph_inode_=
info *ci, struct ceph_cap *cap,
>> if (S_ISDIR(ci->vfs_inode.i_mode)) {
>> dout(" marking %p NOT complete\n", &ci->vfs_inode);
>> ci->i_ceph_flags &=3D ~CEPH_I_COMPLETE;
>> + ci->i_release_count++;
>> }
>> }
>> }
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 76821be..068304c 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -909,7 +909,11 @@ static int ceph_rename(struct inode *old_dir, s=
truct dentry *old_dentry,
>> */
>>
>> /* d_move screws up d_subdirs order */
>> - ceph_i_clear(new_dir, CEPH_I_COMPLETE);
>> + struct ceph_inode_info *ci =3D ceph_inode(new_dir);
>> + spin_lock(&ci->i_ceph_lock);
>> + ci->i_ceph_flags &=3D ~CEPH_I_COMPLETE;
>> + ci->i_release_count++;
>> + spin_unlock(&ci->i_ceph_lock);
>>
>> d_move(old_dentry, new_dentry);
>>
>> @@ -1073,6 +1077,7 @@ static int ceph_snapdir_d_revalidate(struct de=
ntry *dentry,
>> */
>> static void ceph_d_prune(struct dentry *dentry)
>> {
>> + struct ceph_inode_info *ci;
>> dout("ceph_d_prune %p\n", dentry);
>>
>> /* do we have a valid parent? */
>> @@ -1087,7 +1092,11 @@ static void ceph_d_prune(struct dentry *dentr=
y)
>> * we hold d_lock, so d_parent is stable, and d_fsdata is never
>> * cleared until d_release
>> */
>> - ceph_i_clear(dentry->d_parent->d_inode, CEPH_I_COMPLETE);
>> + ci =3D ceph_inode(dentry->d_parent->d_inode);
>> + spin_lock(&ci->i_ceph_lock);
>> + ci->i_ceph_flags &=3D ~CEPH_I_COMPLETE;
>> + ci->i_release_count++;
>> + spin_unlock(&ci->i_ceph_lock);
>> }
>>
>> /*
>> --
>> 1.7.11.7
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
