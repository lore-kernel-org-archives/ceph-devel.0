From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 08/11] ceph: remove exported caps when handling cap import
 message
Date: Tue, 21 Jan 2014 14:49:08 +0800
Message-ID: <52DE1864.8040802@intel.com>
References: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com> <1390277745-20142-8-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1401202120450.28801@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18894 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbaAUGtJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jan 2014 01:49:09 -0500
In-Reply-To: <alpine.DEB.2.00.1401202120450.28801@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 01/21/2014 01:22 PM, Sage Weil wrote:
> On Tue, 21 Jan 2014, Yan, Zheng wrote:
>> Version 3 cap import message includes the ID of the exported
>> caps. It allow us to remove the exported caps if we still haven't
>> received the corresponding cap export message.
>>
>> We remove the exported caps because they are stale, keeping them
>> can compromise consistence.
> 
> Was there any testing with this with the new client and old mds?  It 
> obviously will suffer from this bug, but ideally it should handle a basic 
> non-racy migration..

I did run test with old mds. The only behavior change for old mds is that
exporting caps are not remenbered. If client receives cap export message,
then receives cap import message, there is a period of time corresponding
inode has no cap. Inode with no cap is not good, but I don't think it causes
any big issue.

Regards
Yan, Zheng


> 
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/caps.c               | 73 ++++++++++++++++++++++++++++----------------
>>  include/linux/ceph/ceph_fs.h | 11 ++++++-
>>  2 files changed, 56 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index d65ff33..44373dc 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -611,6 +611,7 @@ retry:
>>  		if (ci->i_auth_cap == NULL ||
>>  		    ceph_seq_cmp(ci->i_auth_cap->mseq, mseq) < 0)
>>  			ci->i_auth_cap = cap;
>> +		ci->i_cap_exporting_issued = 0;
>>  	} else if (ci->i_auth_cap == cap) {
>>  		ci->i_auth_cap = NULL;
>>  		spin_lock(&mdsc->cap_dirty_lock);
>> @@ -2823,10 +2824,12 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>>   */
>>  static void handle_cap_import(struct ceph_mds_client *mdsc,
>>  			      struct inode *inode, struct ceph_mds_caps *im,
>> +			      struct ceph_mds_cap_peer *ph,
>>  			      struct ceph_mds_session *session,
>>  			      void *snaptrace, int snaptrace_len)
>>  {
>>  	struct ceph_inode_info *ci = ceph_inode(inode);
>> +	struct ceph_cap *cap;
>>  	int mds = session->s_mds;
>>  	unsigned issued = le32_to_cpu(im->caps);
>>  	unsigned wanted = le32_to_cpu(im->wanted);
>> @@ -2834,28 +2837,38 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
>>  	unsigned mseq = le32_to_cpu(im->migrate_seq);
>>  	u64 realmino = le64_to_cpu(im->realm);
>>  	u64 cap_id = le64_to_cpu(im->cap_id);
>> +	u64 p_cap_id;
>> +	int peer;
>>  
>> -	if (ci->i_cap_exporting_mds >= 0 &&
>> -	    ceph_seq_cmp(ci->i_cap_exporting_mseq, mseq) < 0) {
>> -		dout("handle_cap_import inode %p ci %p mds%d mseq %d"
>> -		     " - cleared exporting from mds%d\n",
>> -		     inode, ci, mds, mseq,
>> -		     ci->i_cap_exporting_mds);
>> -		ci->i_cap_exporting_issued = 0;
>> -		ci->i_cap_exporting_mseq = 0;
>> -		ci->i_cap_exporting_mds = -1;
>> +	if (ph) {
>> +		p_cap_id = le64_to_cpu(ph->cap_id);
>> +		peer = le32_to_cpu(ph->mds);
>> +	} else {
>> +		p_cap_id = 0;
>> +		peer = -1;
>> +	}
>>  
>> -		spin_lock(&mdsc->cap_dirty_lock);
>> -		if (!list_empty(&ci->i_dirty_item)) {
>> -			dout(" moving %p back to cap_dirty\n", inode);
>> -			list_move(&ci->i_dirty_item, &mdsc->cap_dirty);
>> +	dout("handle_cap_import inode %p ci %p mds%d mseq %d peer %d\n",
>> +	     inode, ci, mds, mseq, peer);
>> +
>> +	spin_lock(&ci->i_ceph_lock);
>> +	cap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
>> +	if (cap && cap->cap_id == p_cap_id) {
>> +		dout(" remove export cap %p mds%d flags %d\n",
>> +		     cap, peer, ph->flags);
>> +		if (ph->flags & CEPH_CAP_FLAG_AUTH) {
>> +			WARN_ON(cap->seq != le32_to_cpu(ph->seq));
>> +			WARN_ON(cap->mseq != le32_to_cpu(ph->mseq));
>>  		}
>> -		spin_unlock(&mdsc->cap_dirty_lock);
>> -	} else {
>> -		dout("handle_cap_import inode %p ci %p mds%d mseq %d\n",
>> -		     inode, ci, mds, mseq);
>> +		ci->i_cap_exporting_issued = cap->issued;
>> +		__ceph_remove_cap(cap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
>>  	}
>>  
>> +	/* make sure we re-request max_size, if necessary */
>> +	ci->i_wanted_max_size = 0;
>> +	ci->i_requested_max_size = 0;
>> +	spin_unlock(&ci->i_ceph_lock);
>> +
>>  	down_write(&mdsc->snap_rwsem);
>>  	ceph_update_snap_trace(mdsc, snaptrace, snaptrace+snaptrace_len,
>>  			       false);
>> @@ -2866,11 +2879,6 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
>>  	kick_flushing_inode_caps(mdsc, session, inode);
>>  	up_read(&mdsc->snap_rwsem);
>>  
>> -	/* make sure we re-request max_size, if necessary */
>> -	spin_lock(&ci->i_ceph_lock);
>> -	ci->i_wanted_max_size = 0;  /* reset */
>> -	ci->i_requested_max_size = 0;
>> -	spin_unlock(&ci->i_ceph_lock);
>>  }
>>  
>>  /*
>> @@ -2888,6 +2896,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>>  	struct ceph_inode_info *ci;
>>  	struct ceph_cap *cap;
>>  	struct ceph_mds_caps *h;
>> +	struct ceph_mds_cap_peer *peer = NULL;
>>  	int mds = session->s_mds;
>>  	int op;
>>  	u32 seq, mseq;
>> @@ -2898,12 +2907,14 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>>  	void *snaptrace;
>>  	size_t snaptrace_len;
>>  	void *flock;
>> +	void *end;
>>  	u32 flock_len;
>>  	int open_target_sessions = 0;
>>  
>>  	dout("handle_caps from mds%d\n", mds);
>>  
>>  	/* decode */
>> +	end = msg->front.iov_base + msg->front.iov_len;
>>  	tid = le64_to_cpu(msg->hdr.tid);
>>  	if (msg->front.iov_len < sizeof(*h))
>>  		goto bad;
>> @@ -2921,17 +2932,25 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>>  	snaptrace_len = le32_to_cpu(h->snap_trace_len);
>>  
>>  	if (le16_to_cpu(msg->hdr.version) >= 2) {
>> -		void *p, *end;
>> -
>> -		p = snaptrace + snaptrace_len;
>> -		end = msg->front.iov_base + msg->front.iov_len;
>> +		void *p = snaptrace + snaptrace_len;
>>  		ceph_decode_32_safe(&p, end, flock_len, bad);
>> +		if (p + flock_len > end)
>> +			goto bad;
>>  		flock = p;
>>  	} else {
>>  		flock = NULL;
>>  		flock_len = 0;
>>  	}
>>  
>> +	if (le16_to_cpu(msg->hdr.version) >= 3) {
>> +		if (op == CEPH_CAP_OP_IMPORT) {
>> +			void *p = flock + flock_len;
>> +			if (p + sizeof(*peer) > end)
>> +				goto bad;
>> +			peer = p;
>> +		}
>> +	}
>> +
>>  	mutex_lock(&session->s_mutex);
>>  	session->s_seq++;
>>  	dout(" mds%d seq %lld cap seq %u\n", session->s_mds, session->s_seq,
>> @@ -2968,7 +2987,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>>  		goto done;
>>  
>>  	case CEPH_CAP_OP_IMPORT:
>> -		handle_cap_import(mdsc, inode, h, session,
>> +		handle_cap_import(mdsc, inode, h, peer, session,
>>  				  snaptrace, snaptrace_len);
>>  	}
>>  
>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
>> index 26bb587..0a37b98 100644
>> --- a/include/linux/ceph/ceph_fs.h
>> +++ b/include/linux/ceph/ceph_fs.h
>> @@ -459,7 +459,8 @@ struct ceph_mds_reply_cap {
>>  	__u8 flags;                    /* CEPH_CAP_FLAG_* */
>>  } __attribute__ ((packed));
>>  
>> -#define CEPH_CAP_FLAG_AUTH  1          /* cap is issued by auth mds */
>> +#define CEPH_CAP_FLAG_AUTH	(1 << 0)  /* cap is issued by auth mds */
>> +#define CEPH_CAP_FLAG_RELEASE	(1 << 1)  /* release the cap */
>>  
>>  /* inode record, for bundling with mds reply */
>>  struct ceph_mds_reply_inode {
>> @@ -660,6 +661,14 @@ struct ceph_mds_caps {
>>  	__le32 time_warp_seq;
>>  } __attribute__ ((packed));
>>  
>> +struct ceph_mds_cap_peer {
>> +	__le64 cap_id;
>> +	__le32 seq;
>> +	__le32 mseq;
>> +	__le32 mds;
>> +	__u8   flags;
>> +} __attribute__ ((packed));
>> +
>>  /* cap release msg head */
>>  struct ceph_mds_cap_release {
>>  	__le32 num;                /* number of cap_items that follow */
>> -- 
>> 1.8.4.2
>>
>>

