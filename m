From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH REPOST 2/4] rbd: add warning messages for missing arguments
Date: Fri, 04 Jan 2013 09:24:20 -0600
Message-ID: <50E6F424.2090104@inktank.com>
References: <50E5D7A9.6040101@inktank.com> <50E5D7FB.9040906@inktank.com> <50E62C10.1010608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47813 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab3ADPcd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 10:32:33 -0500
Received: by mail-ie0-f170.google.com with SMTP id k10so19906953iea.15
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 07:32:32 -0800 (PST)
In-Reply-To: <50E62C10.1010608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 07:10 PM, Dan Mick wrote:
> Do you want to include in the message some kind of indication which
> operation/function is involved?  (this is definitely better, but even
> better might be to add "rbd add" or "rbd_add_parse_args" to the msgs)

Sure.  This comment really applies to the previous patch.  I'm
sure I thought of doing that and I'm not sure any more why I did
not.  Maybe worried about lines getting too long?  Or maybe
I bumped into varargs problems?  I don't know.

I'll rename the rbd_warn() function _rbd_warn(), and will add a new
first argument which is the function name.  Then I'll define a new
macro rbd_warn() that just calls _rbd_warn(), inserting __func__ as
a first argument.

					-Alex

> On 01/03/2013 11:11 AM, Alex Elder wrote:
>> Tell the user (via dmesg) what was wrong with the arguments provided
>> via /sys/bus/rbd/add.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 635b81d..31da8c5 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -3244,8 +3244,10 @@ static int rbd_add_parse_args(const char *buf,
>>       /* The first four tokens are required */
>>
>>       len = next_token(&buf);
>> -    if (!len)
>> -        return -EINVAL;    /* Missing monitor address(es) */
>> +    if (!len) {
>> +        rbd_warn(NULL, "no monitor address(es) provided");
>> +        return -EINVAL;
>> +    }
>>       mon_addrs = buf;
>>       mon_addrs_size = len + 1;
>>       buf += len;
>> @@ -3254,8 +3256,10 @@ static int rbd_add_parse_args(const char *buf,
>>       options = dup_token(&buf, NULL);
>>       if (!options)
>>           return -ENOMEM;
>> -    if (!*options)
>> -        goto out_err;    /* Missing options */
>> +    if (!*options) {
>> +        rbd_warn(NULL, "no options provided");
>> +        goto out_err;
>> +    }
>>
>>       spec = rbd_spec_alloc();
>>       if (!spec)
>> @@ -3264,14 +3268,18 @@ static int rbd_add_parse_args(const char *buf,
>>       spec->pool_name = dup_token(&buf, NULL);
>>       if (!spec->pool_name)
>>           goto out_mem;
>> -    if (!*spec->pool_name)
>> -        goto out_err;    /* Missing pool name */
>> +    if (!*spec->pool_name) {
>> +        rbd_warn(NULL, "no pool name provided");
>> +        goto out_err;
>> +    }
>>
>>       spec->image_name = dup_token(&buf, NULL);
>>       if (!spec->image_name)
>>           goto out_mem;
>> -    if (!*spec->image_name)
>> -        goto out_err;    /* Missing image name */
>> +    if (!*spec->image_name) {
>> +        rbd_warn(NULL, "no image name provided");
>> +        goto out_err;
>> +    }
>>
>>       /*
>>        * Snapshot name is optional; default is to use "-"
>>

