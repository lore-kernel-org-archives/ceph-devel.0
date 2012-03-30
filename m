From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 3/5] ceph: make use of ceph file layout helpers
Date: Fri, 30 Mar 2012 14:55:45 -0500
Message-ID: <4F760FC1.5010906@dreamhost.com>
References: <4F5E7DA5.4040802@dreamhost.com> <4F5E7F6C.1040904@dreamhost.com> <Pine.LNX.4.64.1203152257080.13626@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35599 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759348Ab2C3Tzj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Mar 2012 15:55:39 -0400
In-Reply-To: <Pine.LNX.4.64.1203152257080.13626@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/16/2012 12:59 AM, Sage Weil wrote:
> On Mon, 12 Mar 2012, Alex Elder wrote:
>> There are helpers defined in "include/linux/ceph/osdmap.h" for
>> accessing the fields of an on-disk ceph file layout structure.
>> Use them--consistently--throughout the code.
>>
>> Also define CEPH_FILE_LAYOUT_PG_PREFERRED_NONE, to represent
>> symbolically the explicit "no preferred PG" value.
>>
>> Make a few casts explicit too (to make it more obvious it's
>> occuring).  This produces some long lines, but they go away in an
>> upcoming patch.
>>
>> Signed-off-by: Alex Elder<elder@dreamhost.com>

A few comments below.  I'm about to re-post this series.

. . .

>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>> index 75960b1..bfd5b93 100644
>> --- a/fs/ceph/xattr.c
>> +++ b/fs/ceph/xattr.c
>> @@ -115,11 +115,12 @@ static size_t ceph_vxattrcb_file_layout(struct
>> ceph_inode_info *ci, char *val,
>>
>>   	ret = snprintf(val, size,
>>   		"chunk_bytes=%lld\nstripe_count=%lld\nobject_size=%lld\n",
>> -		(unsigned long long)ceph_file_layout_su(&ci->i_layout),
>> +		(unsigned long
>> long)ceph_file_layout_stripe_unit(&ci->i_layout),
>>   		(unsigned long
>> long)ceph_file_layout_stripe_count(&ci->i_layout),
>>   		(unsigned long
>> long)ceph_file_layout_object_size(&ci->i_layout));
>>
>> -	if (ceph_file_layout_pg_preferred(&ci->i_layout)>= 0) {
>> +	if (ceph_file_layout_pg_preferred(&ci->i_layout) !=
>> +			CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
>
> The function returns cpu order, #define is little endian

I will fix this--throughout.  I'm going to define the constant
in CPU order instead (and fix the one place that depended on it
being in little endian order).

>>   		val += ret;
>>   		size -= ret;
>>   		ret += snprintf(val, size, "preferred_osd=%lld\n",
>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
>> index 2645704..cf86032 100644
>> --- a/include/linux/ceph/ceph_fs.h
>> +++ b/include/linux/ceph/ceph_fs.h

. . .

>> @@ -1011,23 +1011,24 @@ int ceph_calc_object_layout(struct ceph_object_layout
>> *ol,
>>   	if (!pool)
>>   		return -EIO;
>>   	ps = ceph_str_hash(pool->v.object_hash, oid, strlen(oid));
>> -	if (preferred>= 0) {
>> +
>> +	if (preferred == CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
>
> Here, too.  I'd just stick with>= ...

No, I intentionally defined this constant to have a specific
meaning, and I don't want any sense that it is greater than
or less than something--just distinguished from all other
valid preferred PG values.

>
>> +		num = le32_to_cpu(pool->v.pg_num);
>> +		num_mask = pool->pg_num_mask;
>> +	} else {
>>   		ps += preferred;
>>   		num = le32_to_cpu(pool->v.lpg_num);
>>   		num_mask = pool->lpg_num_mask;
>> -	} else {

. . .
