From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] ceph: add get_name() NFS export callback
Date: Fri, 07 Mar 2014 06:19:17 +0800
Message-ID: <5318F465.3030504@intel.com>
References: <1394111946-13754-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1403060832170.316@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:38105 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbaCFWTo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Mar 2014 17:19:44 -0500
In-Reply-To: <alpine.DEB.2.00.1403060832170.316@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/07/2014 12:45 AM, Sage Weil wrote:
> On Thu, 6 Mar 2014, Yan, Zheng wrote:
>> Set WANT_DENTRY flag for the LOOKUPINO MDS request. The flag makes
>> MDS reply contain dentry trace.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/export.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/ceph/inode.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 95 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
>> index 4ec1fd5..3c84b49 100644
>> --- a/fs/ceph/export.c
>> +++ b/fs/ceph/export.c
>> @@ -183,9 +183,54 @@ static struct dentry *ceph_get_parent(struct dentry *child)
>>  	return dentry;
>>  }
>>  
>> +static int ceph_get_name(struct dentry *parent, char *name,
>> +			 struct dentry *child)
>> +{
>> +	struct ceph_mds_client *mdsc;
>> +	struct ceph_mds_request *req;
>> +	int err;
>> +
>> +	mdsc = ceph_inode_to_client(child->d_inode)->mdsc;
>> +	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPINO,
>> +				       USE_ANY_MDS);
>> +	if (IS_ERR(req))
>> +		return PTR_ERR(req);
>> +
>> +	mutex_lock(&parent->d_inode->i_mutex);
>> +
>> +	req->r_inode = child->d_inode;
>> +	ihold(child->d_inode);
>> +	req->r_ino2 = ceph_vino(parent->d_inode);
>> +	req->r_locked_dir = parent->d_inode;
>> +	req->r_num_caps = 1;
>> +	err = ceph_mdsc_do_request(mdsc, NULL, req);
> 
> This one also worries me.  If the r_locked_dir isn't the current parent 
> anymore, then below in ceph_fill_trace we will be doing a d_alloc etc in 
> the wrong directory... at least with the current version of LOOKUPINO.  Is 
> there an MDS patch that is verifying ino2 is correct?  Otherwise, we might 
> be creating a dentry and setting up a lease etc in a different directory  
> than what the MDS has.

see https://github.com/ceph/ceph/pull/1385. It checks the inos.

> 
> Sigh... the nfsd's behavior when trying to reconnect things is clearly 
> confusing to me.  Even reading through 
> Documentation/filesystems/nfs/Exporting it isn't obvious what nfsd is 
> actually doing with these methods, or what happens if the filesystem isn't 
> in the state it expects it to be.
> 
> Anyway, it sounds like as long as we prevent ceph_fill_inode from putting 
> a dentry in the wrong directory then this is good!
> 
> sage
> 
>> +
>> +	mutex_unlock(&parent->d_inode->i_mutex);
>> +
>> +	if (!err) {
>> +		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
>> +		if (rinfo->head->is_dentry) {
>> +			memcpy(name, rinfo->dname, rinfo->dname_len);
>> +			name[rinfo->dname_len] = 0;
>> +		} else {
>> +			err = -EOPNOTSUPP;
>> +		}
>> +	}
>> +	ceph_mdsc_put_request(req);
>> +
>> +	if (!err)
>> +		dout("get_name child %p ino %llx.%llx name %s\n",
>> +		     child, ceph_vinop(child->d_inode), name);
>> +	else
>> +		dout("get_name child %p ino %llx.%llx err %d\n",
>> +		     child, ceph_vinop(child->d_inode), err);
>> +	return err;
>> +}
>> +
>>  const struct export_operations ceph_export_ops = {
>>  	.encode_fh = ceph_encode_fh,
>>  	.fh_to_dentry = ceph_fh_to_dentry,
>>  	.fh_to_parent = ceph_fh_to_parent,
>>  	.get_parent = ceph_get_parent,
>> +	.get_name = ceph_get_name,
>>  };
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 8bf2384..ff3ee3e 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -1044,10 +1044,59 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
>>  					 session, req->r_request_started, -1,
>>  					 &req->r_caps_reservation);
>>  			if (err < 0)
>> -				return err;
>> +				goto done;
>>  		} else {
>>  			WARN_ON_ONCE(1);
>>  		}
>> +
>> +		if (dir && req->r_op == CEPH_MDS_OP_LOOKUPINO) {
>> +			struct qstr dname;
>> +			struct dentry *dn, *parent;
>> +
>> +			BUG_ON(!rinfo->head->is_target);
>> +			BUG_ON(req->r_dentry);
>> +
>> +			parent = d_find_any_alias(dir);
>> +			BUG_ON(!parent);
>> +
>> +			dname.name = rinfo->dname;
>> +			dname.len = rinfo->dname_len;
>> +			dname.hash = full_name_hash(dname.name, dname.len);
>> +			vino.ino = le64_to_cpu(rinfo->targeti.in->ino);
>> +			vino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
>> +retry_lookup:
>> +			dn = d_lookup(parent, &dname);
>> +			dout("d_lookup on parent=%p name=%.*s got %p\n",
>> +			     parent, dname.len, dname.name, dn);
>> +
>> +			if (!dn) {
>> +				dn = d_alloc(parent, &dname);
>> +				dout("d_alloc %p '%.*s' = %p\n", parent,
>> +				     dname.len, dname.name, dn);
>> +				if (dn == NULL) {
>> +					dput(parent);
>> +					err = -ENOMEM;
>> +					goto done;
>> +				}
>> +				err = ceph_init_dentry(dn);
>> +				if (err < 0) {
>> +					dput(dn);
>> +					dput(parent);
>> +					goto done;
>> +				}
>> +			} else if (dn->d_inode &&
>> +				   (ceph_ino(dn->d_inode) != vino.ino ||
>> +				    ceph_snap(dn->d_inode) != vino.snap)) {
>> +				dout(" dn %p points to wrong inode %p\n",
>> +				     dn, dn->d_inode);
>> +				d_delete(dn);
>> +				dput(dn);
>> +				goto retry_lookup;
>> +			}
>> +
>> +			req->r_dentry = dn;
>> +			dput(parent);
>> +		}
>>  	}
>>  
>>  	if (rinfo->head->is_target) {
>> -- 
>> 1.8.5.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

