From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Re: why cache tier creates an empty object for a non-existent object?
Date: Thu, 3 Mar 2016 11:37:09 +0800
Message-ID: <CAGkCoN+Jnc-iWTe_H_n+5u4+vaOa7A7V7LgMM2B6PhuexcKJpg@mail.gmail.com>
References: <CAGkCoN+V=-g20fDZ2P5=eQvgWk5BBVJ0GaUkQPG2cX8nW5jRNQ@mail.gmail.com>
 <CALe9h7dNA7XDwWw=1=8wkRBRt7A74HMHiHkABD_NHw7JCHEJzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38851 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcCCDhu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 22:37:50 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so14685469wml.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 19:37:50 -0800 (PST)
In-Reply-To: <CALe9h7dNA7XDwWw=1=8wkRBRt7A74HMHiHkABD_NHw7JCHEJzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com


On Wed, Mar 2, 2016 at 6:32 PM, John Spray <jspray@redhat.com> wrote:
> On Wed, Mar 2, 2016 at 9:05 AM, Zhi Zhang <zhang.david2011@gmail.com> wrote:
>> Hi Guys,
>>
>> Recently I am trying cache tier and if I try to stat a non-existent
>> object in both cache tier pool and base pool, I find cache tier will
>> not just return -ENOENT, but also create an empty object with setting
>> its flag as FLAG_WHITEOUT in cache tier pool.
>>
>> Although it indicates this object is not existed logically, why cache
>> tier will try to create it rather than only returning -ENOENT?
>
> I would imagine the logic is to cache the fact that the object doesn't
> exist, so that if the client repeatedly tries to fetch the
> non-existent object, it doesn't have to keep querying the backing pool
> to check.
>

thanks, you are right.

> John
>
>> Thanks.
>>
>> Regards,
>> Zhi Zhang (David)
>> Contact: zhang.david2011@gmail.com
>>               zhangz.david@outlook.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
