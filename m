From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: [PATCH] Fix compile error when using nss libs:
Date: Fri, 22 Jul 2011 15:35:00 -0600
Message-ID: <CALFpzo6K6va2AANqOR1YXB8mj5-FbL9qyYY8FiBdx-pmeKXxAQ@mail.gmail.com>
References: <1311356967-1797-1-git-send-email-shadowsor@gmail.com>
	<CALFpzo4Nc3y1zps9tct5BMjHa2kYSEQyPpK=66XSRtLK7WqzBA@mail.gmail.com>
	<Pine.LNX.4.64.1107221324050.25773@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53840 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab1GVVfE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 17:35:04 -0400
Received: by wyg8 with SMTP id 8so1751999wyg.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jul 2011 14:35:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107221324050.25773@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Yeah, sorry. This was a CentOS 6 system, didn't seem to have any
immediate provider of libcrypto++, so just skipped to nss.  I figured
that not many people are probably using the nss path, so I'm not sure
if this is just untested or something wonky on the compiler... at any
rate an extra semicolon shouldn't break others :-)

On Fri, Jul 22, 2011 at 2:25 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 22 Jul 2011, Marcus Sorensen wrote:
>> auth/Crypto.cc:218: error: expected primary-expression before ?}? to=
ken
>> auth/Crypto.cc:218: error: expected ?;? before ?}? token
>>
>> Perhaps something more is missing here but this gets things going...
>> apparently not used much?
>
> Looks right. =A0Maybe only some compiler versions bork on that? =A0We
> also usually build with crypto++ when we can (libnss sucks a
> several ways).
>
> Can I add your signed-off-by?
>
> Thanks-
> sage
>
>
>> ---
>> =A0src/auth/Crypto.cc | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/auth/Crypto.cc b/src/auth/Crypto.cc
>> index 7251d09..ad256bb 100644
>> --- a/src/auth/Crypto.cc
>> +++ b/src/auth/Crypto.cc
>> @@ -215,6 +215,7 @@ static void nss_aes_operation(CK_ATTRIBUTE_TYPE
>> op, const bufferptr& secret,
>> =A0err_slot:
>> =A0 PK11_FreeSlot(slot);
>> =A0err:
>> + =A0;
>> =A0}
>>
>> =A0#else
>> --
>> 1.7.4.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
