From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: RGW: Refusing FastCGI request with empty CONTENT_LENGTH ? Why
 ?
Date: Tue, 02 Apr 2013 10:29:17 -0500
Message-ID: <515AF94D.4030708@inktank.com>
References: <CAF6-1L4GdD8w=3y-0fnVHLA1RPAoKmr-EwST9_pteD_i8opkPw@mail.gmail.com> <CAF6-1L6y81uVN29ZJyjxOHv5r=cQXqoYdSV22AGHY1U9Xgu57g@mail.gmail.com> <CAF6-1L5L1s4hdvrFLAiF7Z0ByJ0JcDASwrvM4AexPfmgvCg0=w@mail.gmail.com> <alpine.DEB.2.00.1304020827210.4476@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:53211 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761283Ab3DBP3T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 11:29:19 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so549016ieb.1
        for <ceph-devel@vger.kernel.org>; Tue, 02 Apr 2013 08:29:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304020827210.4476@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, ceph-devel@vger.kernel.org

This one afaik:

https://github.com/carsonoid/ceph/commit/96896eb092c3b4e0760e56d5228ef0d604951a12

Mark

On 04/02/2013 10:27 AM, Sage Weil wrote:
> On Tue, 2 Apr 2013, Sylvain Munaut wrote:
>> Hi,
>>
>> Replying to myself
>>
>>> So that means if there is a CONTENT_LENGTH field in the environment
>>> but it's empty, then the request is just refused.
>>
>> This is fixed in master but wasn't backported to the bobtail branch,
>> which is how I missed it ...
>
> Which commit?  We can probably backport it..
>
> s
>
>> Sorry for the noise.
>>
>> Cheers,
>>
>>      Sylvain
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

