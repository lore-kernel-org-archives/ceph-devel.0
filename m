From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] ceph: trim deleted inode
Date: Tue, 23 Jul 2013 13:33:49 +0800
Message-ID: <51EE15BD.7020505@intel.com>
References: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1307221838490.6532@cobra.newdream.net> <51EDE414.9060203@intel.com> <alpine.DEB.2.00.1307222223050.10870@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060402090501070809090107"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61596 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab3GWFdv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Jul 2013 01:33:51 -0400
In-Reply-To: <alpine.DEB.2.00.1307222223050.10870@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060402090501070809090107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/23/2013 01:25 PM, Sage Weil wrote:
> On Tue, 23 Jul 2013, Yan, Zheng wrote:
>> On 07/23/2013 09:41 AM, Sage Weil wrote:
>>> On Sun, 21 Jul 2013, Yan, Zheng wrote:
>>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>>
>>>> The MDS uses caps message to notify clients about deleted inode.
>>>> when receiving a such message, invalidate any alias of the inode.
>>>> This makes the kernel release the inode ASAP.
>>>>
>>>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>>>> ---
>>>>  fs/ceph/caps.c | 31 ++++++++++++++++++++++++++++++-
>>>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>>> index 25442b4..b446fdd 100644
>>>> --- a/fs/ceph/caps.c
>>>> +++ b/fs/ceph/caps.c
>>>> @@ -2334,6 +2334,28 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
>>>>  }
>>>>  
>>>>  /*
>>>> + * Invalidate unlinked inode's aliases, so we can drop the inode
>>>> + * from the cache ASAP.
>>>> + */
>>>> +static void invalidate_aliases(struct inode *inode)
>>>> +{
>>>> +	struct dentry *dn;
>>>> +
>>>> +	dout("invalidate_aliases inode %p\n", inode);
>>>> +	d_prune_aliases(inode);
>>>> +	while ((dn = d_find_alias(inode))) {
>>>> +		d_delete(dn);
>>>> +		dput(dn);
>>>
>>> I don't think this loop is safe.  d_delete() won't unlink the inode if 
>>> there are other refs to the dentry, which would make this get stuck in a 
>>> loop.  Maybe simple checking if we get the same dentry back from 
>>> d_find_alias() as the previous call?
>>>
>>
>> For non-dir inode, d_find_alias() only return connected dentry. After calling
>> d_delete, the dentry become disconnected. so the loop is safe.
> 
> Oh, right.  Totally misread that.
> 
>>>> +		/*
>>>> +		 * for dir inode, d_find_alias() can return
>>>> +		 * disconnected dentry
>>>> +		 */
>>>> +		if (S_ISDIR(inode->i_mode))
>>>> +			break;
>>>> +	}
>>>
>>> If we handle the more general case, I'm not sure we need any special case 
>>> here for the directory... although I confess I'm not sure why disconnected 
>>> dentries should be treated specially at all.
>>>
>>
>> For dir inode, d_find_alias() may disconnected dentry, that's why the special case
>> is needed. how about below code.
> 
> Right.  I think either variation is okay.  I'll pull in the original for 
> now, unless you prefer the below.  Sorry for the runaround!
> 
> sage
> 

please apply the attached version, thanks.

Yan, Zheng


--------------060402090501070809090107
Content-Type: text/x-patch;
 name="0001-ceph-trim-deleted-inode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ceph-trim-deleted-inode.patch"

From 04e85337b3384e7be52a0aefb6ae63491986be7d Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Sun, 21 Jul 2013 10:07:51 +0800
Subject: [PATCH] ceph: trim deleted inode

The MDS uses caps message to notify clients about deleted inode.
when receiving a such message, invalidate any alias of the inode.
This makes the kernel release the inode ASAP.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 25442b4..430121a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2334,6 +2334,38 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 }
 
 /*
+ * Invalidate unlinked inode's aliases, so we can drop the inode ASAP.
+ */
+static void invalidate_aliases(struct inode *inode)
+{
+	struct dentry *dn, *prev = NULL;
+
+	dout("invalidate_aliases inode %p\n", inode);
+	d_prune_aliases(inode);
+	/*
+	 * For non-directory inode, d_find_alias() only returns
+	 * connected dentry. After calling d_delete(), the dentry
+	 * become disconnected.
+	 *
+	 * For directory inode, d_find_alias() only can return
+	 * disconnected dentry. But directory inode should have
+	 * one alias at most.
+	 */
+	while ((dn = d_find_alias(inode))) {
+		if (dn == prev) {
+			dput(dn);
+			break;
+		}
+		d_delete(dn);
+		if (prev)
+			dput(prev);
+		prev = dn;
+	}
+	if (prev)
+		dput(prev);
+}
+
+/*
  * Handle a cap GRANT message from the MDS.  (Note that a GRANT may
  * actually be a revocation if it specifies a smaller cap set.)
  *
@@ -2363,6 +2395,7 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	int writeback = 0;
 	int revoked_rdcache = 0;
 	int queue_invalidate = 0;
+	int deleted_inode = 0;
 
 	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
 	     inode, cap, mds, seq, ceph_cap_string(newcaps));
@@ -2407,8 +2440,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		     from_kgid(&init_user_ns, inode->i_gid));
 	}
 
-	if ((issued & CEPH_CAP_LINK_EXCL) == 0)
+	if ((issued & CEPH_CAP_LINK_EXCL) == 0) {
 		set_nlink(inode, le32_to_cpu(grant->nlink));
+		if (inode->i_nlink == 0 &&
+		    (newcaps & (CEPH_CAP_LINK_SHARED | CEPH_CAP_LINK_EXCL)))
+			deleted_inode = 1;
+	}
 
 	if ((issued & CEPH_CAP_XATTR_EXCL) == 0 && grant->xattr_len) {
 		int len = le32_to_cpu(grant->xattr_len);
@@ -2517,6 +2554,8 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		ceph_queue_writeback(inode);
 	if (queue_invalidate)
 		ceph_queue_invalidate(inode);
+	if (deleted_inode)
+		invalidate_aliases(inode);
 	if (wake)
 		wake_up_all(&ci->i_cap_wq);
 
-- 
1.8.1.4


--------------060402090501070809090107--
