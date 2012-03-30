From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 5/5] ceph: fix up the types of the file layout helpers
Date: Fri, 30 Mar 2012 14:55:59 -0500
Message-ID: <4F760FCF.2090604@dreamhost.com>
References: <4F5E7DA5.4040802@dreamhost.com> <4F5E7F71.5050605@dreamhost.com> <Pine.LNX.4.64.1203152307310.13626@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35614 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761355Ab2C3Tzw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Mar 2012 15:55:52 -0400
In-Reply-To: <Pine.LNX.4.64.1203152307310.13626@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/16/2012 01:10 AM, Sage Weil wrote:
> On Mon, 12 Mar 2012, Alex Elder wrote:
>
>> The helper macros for accessing file layout fields of an on-disk
>> ceph file layout structure cast their results to type (__s32).  This
>> is a bit strange, since (with one exception--fl_pg_preferred):
>>      - there is no need for negative values; and
>>      - all users of these macros are assigning their result to
>>        64-bit variables.
>> So just make these macros return a 64-bit unsigned type.
>>
>> The exception is the preferred placement group, which remains a
>> signed 32-bit value.  A placement group id encodes the preferred
>> primary OSD in a 16-bit value, and there's no sense at this point
>> getting too far away from that.
>>
>> Signed-off-by: Alex Elder<elder@dreamhost.com>

. . .

>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 26c30e7..bc2d807 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c

. . .

>> @@ -1028,29 +1028,30 @@ int ceph_calc_object_layout(struct ceph_object_layout

. . .

>> -	ps = ceph_str_hash(pool->v.object_hash, oid, strlen(oid));
>>
>> -	if (preferred == CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
>> -		num = le32_to_cpu(pool->v.pg_num);
>> -		num_mask = pool->pg_num_mask;
>> -	} else {
>> +	ps = ceph_str_hash(pool->v.object_hash, oid, strlen(oid));
>> +	if (preferred != CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
>> +		BUG_ON(preferred<  0);
>>   		ps += preferred;
>> -		num = le32_to_cpu(pool->v.lpg_num);
>> -		num_mask = pool->lpg_num_mask;
>>   	}
>>
>> +	num = le32_to_cpu(pool->v.lpg_num);
>> +	num_mask = pool->lpg_num_mask;
>
> Unless i'm misreading this diff, you're switching to always using lpg_num
> and lpg_num_mask instead of pg_num and pg_num_mask.  That "l" prefix means
> "localized," for a different set of localized PGs used when htere is a
> preferred OSD.  We need to keep these assignments in the if and else
> blocks...

No, you read it right and I got it wrong.  I misread the code
and thought they were operating with the same fields.  I'll fix
it.

					-Alex

>> +
>>   	pgid.ps = cpu_to_le16(ps);
>> -	pgid.preferred = cpu_to_le16(preferred);
>> +	pgid.preferred = cpu_to_le16((s16) preferred);
>>   	pgid.pool = fl->fl_pg_pool;
>>   	if (preferred == CEPH_FILE_LAYOUT_PG_PREFERRED_NONE)
>>   		dout("calc_object_layout '%s' pgid %d.%x\n", oid, poolid, ps);

. . .

