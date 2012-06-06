From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/3] libceph: fix overflow in osdmap_decode()
Date: Wed, 06 Jun 2012 14:14:59 -0500
Message-ID: <4FCFAC33.6020003@inktank.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com> <1335682765-1643-2-git-send-email-xi.wang@gmail.com> <4FCF84A4.4040005@dreamhost.com> <16A6B85A-9BD1-4242-95CD-5ACFC43956F4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:48467 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab2FFTOy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 15:14:54 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so5623604ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 12:14:54 -0700 (PDT)
In-Reply-To: <16A6B85A-9BD1-4242-95CD-5ACFC43956F4@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 06/06/2012 12:56 PM, Xi Wang wrote:
> On Jun 6, 2012, at 12:26 PM, Alex Elder wrote:
>>
>> Just above here we see:
>>        /* pg_temp */
>>        ceph_decode_32_safe(p, end, len, bad);
>>        for (i = 0; i < len; i++) {
>>
>> We haven't validated "len" here either.  Looking at it I'm not sure
>> we can do much, but I think we do know a few things should be true:
>> - (len & (sizeof (u32) - 1)) == 0
>> - len <= (UINT_MAX / (sizeof (struct ceph_pg) + sizeof (u32)))
>>    and further, if it's invalid to have a value for pg->len of
>>    zero, then we can instead assert:
>> - len <= (UINT_MAX / (sizeof (struct ceph_pg) + 2 * sizeof (u32)))
>>
>> I don't know if it's that important do do a check like this though.
> 
> I don't see any overflow issue here.  Are you worried about the loop
> running for a while given a large n?  How about this check?

Not an overflow check, but a validity check nevertheless.

> 	/* pg_temp */
> 	ceph_decode_32_safe(p, end, len, bad);
> +	if (len > UINT_MAX / (sizeof(u32) + sizeof(u64)))
> +		goto bad;

That part is sufficient, though I'd prefer sizeof (ceph_pg) both
here and in the line that follows, rather than sizeof (u64).

> +	ceph_decode_need(p, end, len * (sizeof(u32) + sizeof(u64)), bad);

This isn't necessary--I was not looking for overflow, just for
some sanity checking on the value that came in from the wire.

It probably won't matter because in time if the value is too large
then one of the checks inside the loop might bail out.  But catching
it as early as possible is always better.

I'm not too concerned about it.  I may get around to implement
fixes like this myself, but would probably do it comprehensively
if I do.

					-Alex
