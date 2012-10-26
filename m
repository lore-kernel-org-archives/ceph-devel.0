From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/4] rbd: verify rbd image order value
Date: Fri, 26 Oct 2012 17:06:01 -0500
Message-ID: <508B0949.7000906@inktank.com>
References: <5085791C.9010205@inktank.com> <5085798C.8010605@inktank.com> <50882D25.8010706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38641 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966617Ab2JZWGF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:06:05 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2550800iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:06:04 -0700 (PDT)
In-Reply-To: <50882D25.8010706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/24/2012 01:02 PM, Josh Durgin wrote:
> Might want to add some output so we can tell which error
> is being hit.

This is true for all of the cases that fail, not just those
I'm adding here.

I'll implement this suggestion separately too, probably next
week.

					-Alex

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
> On 10/22/2012 09:51 AM, Alex Elder wrote:
>> This adds a verification that an rbd image's object order is
>> within the upper and lower bounds supported by this implementation.
>>
>> It must be at least 9 (SECTOR_SHIFT), because the Linux bio system
>> assumes that minimum granularity.
>>
>> It also must be less than 32 (at the moment anyway) because there
>> exist spots in the code that store the size of a "segment" (object
>> backing an rbd image) in a signed int variable, which can be 32 bits
>> including the sign.  We should be able to relax this limit once
>> we've verified the code uses 64-bit types where needed.
>>
>> Note that the CLI tool already limits the order to the range 12-25.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index d032883..4734446 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -533,6 +533,16 @@ static bool rbd_dev_ondisk_valid(struct
>> rbd_image_header_ondisk *ondisk)
>>       if (memcmp(&ondisk->text, RBD_HEADER_TEXT, sizeof
>> (RBD_HEADER_TEXT)))
>>           return false;
>>
>> +    /* The bio layer requires at least sector-sized I/O */
>> +
>> +    if (ondisk->options.order < SECTOR_SHIFT)
>> +        return false;
>> +
>> +    /* If we use u64 in a few spots we may be able to loosen this */
>> +
>> +    if (ondisk->options.order > 8 * sizeof (int) - 1)
>> +        return false;
>> +
>>       /*
>>        * The size of a snapshot header has to fit in a size_t, and
>>        * that limits the number of snapshots.
>>
> 

