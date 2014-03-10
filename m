From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH v2 0/5] ceph: fixes for nfs export
Date: Mon, 10 Mar 2014 11:18:17 +0800
Message-ID: <531D2EF9.5040300@intel.com>
References: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1403070657430.24219@cobra.newdream.net> <531A5DBD.3040007@intel.com> <alpine.DEB.2.00.1403091841040.24219@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38514 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbaCJDST (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 9 Mar 2014 23:18:19 -0400
In-Reply-To: <alpine.DEB.2.00.1403091841040.24219@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/10/2014 09:43 AM, Sage Weil wrote:
> On Sat, 8 Mar 2014, Yan, Zheng wrote:
>> how about the below patch and corresponding mds change in
>> https://github.com/ceph/ceph/commit/617ce6761edd7264893f3638c33fd229c71751a0
> 
> I like this better, thanks!
> 
> One question, though: in the LOOKUPNAME case, the client will already have 
> a cap on both the parent and child inode, right?  (IIUC, it will have done 
> a LOOKUPINO on the fh/child, then LOOKUPPARENT to get a cap for the 
> parent inode, and then a LOOKUPNAME to validate the name.
> 
> Is the reason you still do MDCache::open_ino() because we can't assume 
> that the parent and child are on the same MDS?

For the LOOKUPNAME case, MDCache::open_ino() is not needed. I'm lazy to write
separate function for LOOKUPNAME.

Regards
Yan, Zheng

> 
> Thanks!
> sage
> 
> 
>>
>> Regards
>> Yan, Zheng
>>
>> ---
>> >From 0fa1971741b1d3c236ee6fa3a7feb5a74fbd7f2f Mon Sep 17 00:00:00 2001
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>> Date: Thu, 6 Mar 2014 16:40:32 +0800
>> Subject: [PATCH 1/3] ceph: add get_name() NFS export callback
>>
>> Use the newly introduced LOOKUPNAME MDS request to connect child
>> inode to its parent directory.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/export.c             | 40 ++++++++++++++++++++++++++++++++++
>>  fs/ceph/inode.c              | 51 +++++++++++++++++++++++++++++++++++++++++++-
>>  fs/ceph/strings.c            |  1 +
>>  include/linux/ceph/ceph_fs.h |  1 +
>>  4 files changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
>> index 6e611e7..bf36e7f 100644
>> --- a/fs/ceph/export.c
>> +++ b/fs/ceph/export.c
>> @@ -195,9 +195,49 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
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
>> +	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPNAME,
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
>> +
>> +	mutex_unlock(&parent->d_inode->i_mutex);
>> +
>> +	if (!err) {
>> +		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
>> +		memcpy(name, rinfo->dname, rinfo->dname_len);
>> +		name[rinfo->dname_len] = 0;
>> +		dout("get_name %p ino %llx.%llx name %s\n",
>> +		     child, ceph_vinop(child->d_inode), name);
>> +	} else {
>> +		dout("get_name %p ino %llx.%llx err %d\n",
>> +		     child, ceph_vinop(child->d_inode), err);
>> +	}
>> +
>> +	ceph_mdsc_put_request(req);
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
>> index 8bf2384..91d6c9d 100644
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
>> +		if (dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME) {
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
>> diff --git a/fs/ceph/strings.c b/fs/ceph/strings.c
>> index 4440f447..51cc23e 100644
>> --- a/fs/ceph/strings.c
>> +++ b/fs/ceph/strings.c
>> @@ -54,6 +54,7 @@ const char *ceph_mds_op_name(int op)
>>  	case CEPH_MDS_OP_LOOKUPHASH:  return "lookuphash";
>>  	case CEPH_MDS_OP_LOOKUPPARENT:  return "lookupparent";
>>  	case CEPH_MDS_OP_LOOKUPINO:  return "lookupino";
>> +	case CEPH_MDS_OP_LOOKUPNAME:  return "lookupname";
>>  	case CEPH_MDS_OP_GETATTR:  return "getattr";
>>  	case CEPH_MDS_OP_SETXATTR: return "setxattr";
>>  	case CEPH_MDS_OP_SETATTR: return "setattr";
>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
>> index 25bfb0e..35f345f 100644
>> --- a/include/linux/ceph/ceph_fs.h
>> +++ b/include/linux/ceph/ceph_fs.h
>> @@ -332,6 +332,7 @@ enum {
>>  	CEPH_MDS_OP_LOOKUPHASH = 0x00102,
>>  	CEPH_MDS_OP_LOOKUPPARENT = 0x00103,
>>  	CEPH_MDS_OP_LOOKUPINO  = 0x00104,
>> +	CEPH_MDS_OP_LOOKUPNAME = 0x00105,
>>  
>>  	CEPH_MDS_OP_SETXATTR   = 0x01105,
>>  	CEPH_MDS_OP_RMXATTR    = 0x01106,
>> -- 
>> 1.8.5.3
>>
>>

