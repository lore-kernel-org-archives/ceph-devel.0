From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v2 0/5] ceph: fixes for nfs export
Date: Sun, 9 Mar 2014 21:25:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403092122140.24219@cobra.newdream.net>
References: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1403070657430.24219@cobra.newdream.net> <531A5DBD.3040007@intel.com> <alpine.DEB.2.00.1403091845570.24219@cobra.newdream.net> <531D301C.9020301@intel.com>
 <alpine.DEB.2.00.1403092108370.24219@cobra.newdream.net> <531D3D5F.1060509@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48368 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaCJEZM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Mar 2014 00:25:12 -0400
In-Reply-To: <531D3D5F.1060509@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 10 Mar 2014, Yan, Zheng wrote:
> On 03/10/2014 12:12 PM, Sage Weil wrote:
> > On Mon, 10 Mar 2014, Yan, Zheng wrote:
> >> On 03/10/2014 09:49 AM, Sage Weil wrote:
> >>> On Sat, 8 Mar 2014, Yan, Zheng wrote:
> >>>> how about the below patch and corresponding mds change in
> >>>> https://github.com/ceph/ceph/commit/617ce6761edd7264893f3638c33fd229c71751a0
> >>>>
> >>>> Regards
> >>>> Yan, Zheng
> >>>>
> >>>> ---
> >>>> >From 0fa1971741b1d3c236ee6fa3a7feb5a74fbd7f2f Mon Sep 17 00:00:00 2001
> >>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>>> Date: Thu, 6 Mar 2014 16:40:32 +0800
> >>>> Subject: [PATCH 1/3] ceph: add get_name() NFS export callback
> >>>>
> >>>> Use the newly introduced LOOKUPNAME MDS request to connect child
> >>>> inode to its parent directory.
> >>>>
> >>>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> >>>> ---
> >>>>  fs/ceph/export.c             | 40 ++++++++++++++++++++++++++++++++++
> >>>>  fs/ceph/inode.c              | 51 +++++++++++++++++++++++++++++++++++++++++++-
> >>>>  fs/ceph/strings.c            |  1 +
> >>>>  include/linux/ceph/ceph_fs.h |  1 +
> >>>>  4 files changed, 92 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> >>>> index 6e611e7..bf36e7f 100644
> >>>> --- a/fs/ceph/export.c
> >>>> +++ b/fs/ceph/export.c
> >>>> @@ -195,9 +195,49 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
> >>>>  	return dentry;
> >>>>  }
> >>>>  
> >>>> +static int ceph_get_name(struct dentry *parent, char *name,
> >>>> +			 struct dentry *child)
> >>>> +{
> >>>> +	struct ceph_mds_client *mdsc;
> >>>> +	struct ceph_mds_request *req;
> >>>> +	int err;
> >>>> +
> >>>> +	mdsc = ceph_inode_to_client(child->d_inode)->mdsc;
> >>>> +	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPNAME,
> >>>> +				       USE_ANY_MDS);
> >>>> +	if (IS_ERR(req))
> >>>> +		return PTR_ERR(req);
> >>>> +
> >>>> +	mutex_lock(&parent->d_inode->i_mutex);
> >>>> +
> >>>> +	req->r_inode = child->d_inode;
> >>>> +	ihold(child->d_inode);
> >>>> +	req->r_ino2 = ceph_vino(parent->d_inode);
> >>>> +	req->r_locked_dir = parent->d_inode;
> >>>> +	req->r_num_caps = 1;
> >>>> +	err = ceph_mdsc_do_request(mdsc, NULL, req);
> >>>> +
> >>>> +	mutex_unlock(&parent->d_inode->i_mutex);
> >>>> +
> >>>> +	if (!err) {
> >>>> +		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
> >>>> +		memcpy(name, rinfo->dname, rinfo->dname_len);
> >>>> +		name[rinfo->dname_len] = 0;
> >>>> +		dout("get_name %p ino %llx.%llx name %s\n",
> >>>> +		     child, ceph_vinop(child->d_inode), name);
> >>>
> >>> One other oddity here: the MDS is returning a bunch of metadata about the 
> >>> dentry, including (in most cases) a lease.  The client is ignoring all of 
> >>> that and only needs the name itself to feed back into exportfs.  I believe 
> >>> at this point that is fine: the client can forget leases at any time and 
> >>> will respond to MDS revocations accordingly.
> >>>
> >>> It would probably require a bit of a kludge on the MDS side to make the 
> >>> reply_request() respond with the dentry name but prevent a lease from 
> >>> being issued.  Might be worth it though?  Maybe a generic "no lease" flag 
> >>> that even regular LOOKUP could use (if for some reason the client didn't 
> >>> want a lease)?
> >>>
> >>> This needn't hold up the other patches, but I'm curious what you think 
> >>> about it.
> >>>
> >>
> >> the nfsd does a dentry lookup after it has got the name. the lease can avoid
> >> sending another 'lookup' request to the MDS.
> > 
> > For that to work, I think we need to preallocate the dentry and set 
> > req->r_dentry.  The ceph_fill_trace() code, in fact, looks like it will 
> > BUG out if it gets a reply with a dentry but the request r_dentry isn't 
> > set (we should probably fix that too).
> > 
> > In any case, that seems tricky because we don't know the name ahead of 
> > time, so it would need to have its own code path on reply to allocate the 
> > dentry of the proper name.  Given that this is only used in rare NFS 
> > re-export corner cases, my inclination is to not bother optimizing?
> > 
> > sage
> > 
> > 
> >>
> >> Regards
> >> Yan, Zheng
> >>
> >>>
> >>>
> >>>> +	} else {
> >>>> +		dout("get_name %p ino %llx.%llx err %d\n",
> >>>> +		     child, ceph_vinop(child->d_inode), err);
> >>>> +	}
> >>>> +
> >>>> +	ceph_mdsc_put_request(req);
> >>>> +	return err;
> >>>> +}
> >>>> +
> >>>>  const struct export_operations ceph_export_ops = {
> >>>>  	.encode_fh = ceph_encode_fh,
> >>>>  	.fh_to_dentry = ceph_fh_to_dentry,
> >>>>  	.fh_to_parent = ceph_fh_to_parent,
> >>>>  	.get_parent = ceph_get_parent,
> >>>> +	.get_name = ceph_get_name,
> >>>>  };
> >>>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> >>>> index 8bf2384..91d6c9d 100644
> >>>> --- a/fs/ceph/inode.c
> >>>> +++ b/fs/ceph/inode.c
> >>>> @@ -1044,10 +1044,59 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
> >>>>  					 session, req->r_request_started, -1,
> >>>>  					 &req->r_caps_reservation);
> >>>>  			if (err < 0)
> >>>> -				return err;
> >>>> +				goto done;
> >>>>  		} else {
> >>>>  			WARN_ON_ONCE(1);
> >>>>  		}
> >>>> +
> >>>> +		if (dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME) {
> >>>> +			struct qstr dname;
> >>>> +			struct dentry *dn, *parent;
> >>>> +
> >>>> +			BUG_ON(!rinfo->head->is_target);
> >>>> +			BUG_ON(req->r_dentry);
> >>>> +
> >>>> +			parent = d_find_any_alias(dir);
> >>>> +			BUG_ON(!parent);
> >>>> +
> >>>> +			dname.name = rinfo->dname;
> >>>> +			dname.len = rinfo->dname_len;
> >>>> +			dname.hash = full_name_hash(dname.name, dname.len);
> >>>> +			vino.ino = le64_to_cpu(rinfo->targeti.in->ino);
> >>>> +			vino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
> >>>> +retry_lookup:
> >>>> +			dn = d_lookup(parent, &dname);
> >>>> +			dout("d_lookup on parent=%p name=%.*s got %p\n",
> >>>> +			     parent, dname.len, dname.name, dn);
> >>>> +
> >>>> +			if (!dn) {
> >>>> +				dn = d_alloc(parent, &dname);
> >>>> +				dout("d_alloc %p '%.*s' = %p\n", parent,
> >>>> +				     dname.len, dname.name, dn);
> >>>> +				if (dn == NULL) {
> >>>> +					dput(parent);
> >>>> +					err = -ENOMEM;
> >>>> +					goto done;
> >>>> +				}
> >>>> +				err = ceph_init_dentry(dn);
> >>>> +				if (err < 0) {
> >>>> +					dput(dn);
> >>>> +					dput(parent);
> >>>> +					goto done;
> >>>> +				}
> >>>> +			} else if (dn->d_inode &&
> >>>> +				   (ceph_ino(dn->d_inode) != vino.ino ||
> >>>> +				    ceph_snap(dn->d_inode) != vino.snap)) {
> >>>> +				dout(" dn %p points to wrong inode %p\n",
> >>>> +				     dn, dn->d_inode);
> >>>> +				d_delete(dn);
> >>>> +				dput(dn);
> >>>> +				goto retry_lookup;
> >>>> +			}
> >>>> +
> >>>> +			req->r_dentry = dn;
> 
> req->r_dentry is set here. is there anything I'm missing?

Oh!  Nope, I didn't read the whole patch, sorry!  This looks right.

Reviewed-by: Sage Weil <sage@inktank.com>

sage


> 
> Regards
> Yan, Zheng 
> 
> >>>> +			dput(parent);
> >>>> +		}
> >>>>  	}
> >>>>  
> >>>>  	if (rinfo->head->is_target) {
> >>>> diff --git a/fs/ceph/strings.c b/fs/ceph/strings.c
> >>>> index 4440f447..51cc23e 100644
> >>>> --- a/fs/ceph/strings.c
> >>>> +++ b/fs/ceph/strings.c
> >>>> @@ -54,6 +54,7 @@ const char *ceph_mds_op_name(int op)
> >>>>  	case CEPH_MDS_OP_LOOKUPHASH:  return "lookuphash";
> >>>>  	case CEPH_MDS_OP_LOOKUPPARENT:  return "lookupparent";
> >>>>  	case CEPH_MDS_OP_LOOKUPINO:  return "lookupino";
> >>>> +	case CEPH_MDS_OP_LOOKUPNAME:  return "lookupname";
> >>>>  	case CEPH_MDS_OP_GETATTR:  return "getattr";
> >>>>  	case CEPH_MDS_OP_SETXATTR: return "setxattr";
> >>>>  	case CEPH_MDS_OP_SETATTR: return "setattr";
> >>>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> >>>> index 25bfb0e..35f345f 100644
> >>>> --- a/include/linux/ceph/ceph_fs.h
> >>>> +++ b/include/linux/ceph/ceph_fs.h
> >>>> @@ -332,6 +332,7 @@ enum {
> >>>>  	CEPH_MDS_OP_LOOKUPHASH = 0x00102,
> >>>>  	CEPH_MDS_OP_LOOKUPPARENT = 0x00103,
> >>>>  	CEPH_MDS_OP_LOOKUPINO  = 0x00104,
> >>>> +	CEPH_MDS_OP_LOOKUPNAME = 0x00105,
> >>>>  
> >>>>  	CEPH_MDS_OP_SETXATTR   = 0x01105,
> >>>>  	CEPH_MDS_OP_RMXATTR    = 0x01106,
> >>>> -- 
> >>>> 1.8.5.3
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>>
> >>
> >>
> 
> 
