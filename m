From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 6/6] ceph: make ceph_setxattr() and ceph_removexattr()
 more alike
Date: Fri, 02 Mar 2012 20:17:56 -0800
Message-ID: <4F519B74.9020708@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com> <4F4D99D3.8070501@dreamhost.com> <Pine.LNX.4.64.1203021134230.6413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53789 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab2CCER5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 23:17:57 -0500
In-Reply-To: <Pine.LNX.4.64.1203021134230.6413@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/02/2012 11:35 AM, Sage Weil wrote:
> On Tue, 28 Feb 2012, Alex Elder wrote:
>
>> This patch just rearranges a few bits of code to make more
>> portions of ceph_setxattr() and ceph_removexattr() identical.
>>
>> Signed-off-by: Alex Elder<elder@dreamhost.com>
>> ---

. . .

>> @@ -803,6 +803,7 @@ int ceph_setxattr(struct dentry *dentry, const char *name,
>>   	spin_lock(&ci->i_ceph_lock);
>>   retry:
>
> This:
>
>>   	issued = __ceph_caps_issued(ci, NULL);
>> +	dout("setxattr %p issued %s\n", inode, ceph_cap_string(issued));
>>   	if (!(issued&  CEPH_CAP_XATTR_EXCL))
>>   		goto do_sync;
>
> needs to go after this:
>
>>   	__build_xattrs(inode);
>
> All of the __build_xattrs() calls should go before the cap check, because
> they drop i_ceph_lock.
>
> Can probably do that in a new patch, since it was broken for some of these
> before.

I've created this to (try to) document your observation:
     http://tracker.newdream.net/issues/2129

I am committing this patch as-is for now.

					-Alex

> Otherwise, this series looks good!
>
> Reviewed-by: Sage Weil<sage@newdream.net>
>
>> @@ -811,7 +812,7 @@ retry:
>>
>>   	if (!ci->i_xattrs.prealloc_blob ||
>>   	    required_blob_size>  ci->i_xattrs.prealloc_blob->alloc_len) {
>> -		struct ceph_buffer *blob = NULL;
>> +		struct ceph_buffer *blob;
>>
>>   		spin_unlock(&ci->i_ceph_lock);
>>   		dout(" preaallocating new blob size=%d\n",
>> required_blob_size);
>> @@ -825,12 +826,13 @@ retry:
>>   		goto retry;
>>   	}
>>
>> -	dout("setxattr %p issued %s\n", inode, ceph_cap_string(issued));
>>   	err = __set_xattr(ci, newname, name_len, newval,
>>   			  val_len, 1, 1, 1,&xattr);
>> +
>>   	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
>>   	ci->i_xattrs.dirty = true;
>>   	inode->i_ctime = CURRENT_TIME;
>> +
>>   	spin_unlock(&ci->i_ceph_lock);
>>   	if (dirty)
>>   		__mark_inode_dirty(inode, dirty);
>> @@ -892,18 +894,17 @@ int ceph_removexattr(struct dentry *dentry, const char
>> *name)
>>   		return -EOPNOTSUPP;
>>
>>   	spin_lock(&ci->i_ceph_lock);
>> -	__build_xattrs(inode);
>>   	issued = __ceph_caps_issued(ci, NULL);
>>   	dout("removexattr %p issued %s\n", inode, ceph_cap_string(issued));
>> -
>>   	if (!(issued&  CEPH_CAP_XATTR_EXCL))
>>   		goto do_sync;
>> +	__build_xattrs(inode);
>>
>>   	err = __remove_xattr_by_name(ceph_inode(inode), name);
>> +
>>   	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
>>   	ci->i_xattrs.dirty = true;
>>   	inode->i_ctime = CURRENT_TIME;
>> -
>>   	spin_unlock(&ci->i_ceph_lock);
>>   	if (dirty)
>>   		__mark_inode_dirty(inode, dirty);
>> --
>> 1.7.5.4
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

