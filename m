From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 2/4] ceph: fix ceph_fh_to_parent()
Date: Thu, 06 Mar 2014 13:15:30 +0800
Message-ID: <53180472.5010201@intel.com>
References: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com> <1393687411-2457-2-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1403050914430.17314@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23586 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbaCFFPd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Mar 2014 00:15:33 -0500
In-Reply-To: <alpine.DEB.2.00.1403050914430.17314@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/06/2014 01:17 AM, Sage Weil wrote:
> On Sat, 1 Mar 2014, Yan, Zheng wrote:
>> ceph_fh_to_parent() finds the inode that corresponds to the 'ino' field
>> of struct ceph_nfs_confh. This is wrong, it should find the inode that
>> corresponds to the 'parent_ino' field.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> 
> It's been a while since I've looked at this, but I'm a bit confused.
> 
> If we have a get_parent() operation that will reliably get the parent 
> directory for an inode, why do we want/need the ceph_nfs_confh?  If we 
> *do* have that struct and look up the parent_ino, we have no guarantee 
> that it is still the parent if there has been an intervening rename.  
> Would it be better to always use ceph_nfs_fh, and rely on LOOKUPPARENT 
> instead?
> 

fh_to_parent() is used when reconnecting non-directory inode. (get_parent()
is used when reconnecting directory inode). The problem of using LOOKUPPARENT
is that the inode may have multiple links. if the primary link of the inode is
in stray directory, LOOKUPPARENT return -ESTALE. 

> Thanks-
> sage
> 
> 
>> ---
>>  fs/ceph/export.c | 38 +++++---------------------------------
>>  1 file changed, 5 insertions(+), 33 deletions(-)
>>
>> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
>> index 905d7f2..017af26 100644
>> --- a/fs/ceph/export.c
>> +++ b/fs/ceph/export.c
>> @@ -122,49 +122,21 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
>>  }
>>  
>>  /*
>> - * get parent, if possible.
>> - *
>> - * FIXME: we could do better by querying the mds to discover the
>> - * parent.
>> + * convert regular fh to parent
>>   */
>>  static struct dentry *ceph_fh_to_parent(struct super_block *sb,
>> -					 struct fid *fid,
>> +					struct fid *fid,
>>  					int fh_len, int fh_type)
>>  {
>>  	struct ceph_nfs_confh *cfh = (void *)fid->raw;
>> -	struct ceph_vino vino;
>> -	struct inode *inode;
>> -	struct dentry *dentry;
>> -	int err;
>>  
>> -	if (fh_type == 1)
>> +	if (fh_type != FILEID_INO32_GEN_PARENT)
>>  		return ERR_PTR(-ESTALE);
>>  	if (fh_len < sizeof(*cfh) / 4)
>>  		return ERR_PTR(-ESTALE);
>>  
>> -	pr_debug("fh_to_parent %llx/%d\n", cfh->parent_ino,
>> -		 cfh->parent_name_hash);
>> -
>> -	vino.ino = cfh->ino;
>> -	vino.snap = CEPH_NOSNAP;
>> -	inode = ceph_find_inode(sb, vino);
>> -	if (!inode)
>> -		return ERR_PTR(-ESTALE);
>> -
>> -	dentry = d_obtain_alias(inode);
>> -	if (IS_ERR(dentry)) {
>> -		pr_err("fh_to_parent %llx -- inode %p but ENOMEM\n",
>> -		       cfh->ino, inode);
>> -		iput(inode);
>> -		return dentry;
>> -	}
>> -	err = ceph_init_dentry(dentry);
>> -	if (err < 0) {
>> -		iput(inode);
>> -		return ERR_PTR(err);
>> -	}
>> -	dout("fh_to_parent %llx %p dentry %p\n", cfh->ino, inode, dentry);
>> -	return dentry;
>> +	pr_debug("fh_to_parent %llx\n", cfh->parent_ino);
>> +	return __fh_to_dentry(sb, cfh->parent_ino);
>>  }
>>  
>>  const struct export_operations ceph_export_ops = {
>> -- 
>> 1.8.5.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

