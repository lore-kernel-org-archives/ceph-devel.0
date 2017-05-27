From: kefu chai <tchaikov@gmail.com>
Subject: Re: Missing -lpython2.7 when linking ceph-dencoder
Date: Sun, 28 May 2017 01:03:29 +0800
Message-ID: <CAJE9aOO1O_Gke2qp4wo==oZu=jfzuX28_4ZYp-Q+ZV1Gv6XcQQ@mail.gmail.com>
References: <8117b0fd-3c3d-c56b-490c-41772fdd2478@digiware.nl>
 <b9ae6bc8-1d1b-87e9-bfdb-96586e42bbfc@digiware.nl> <edad80ad-82ed-78c0-338c-a39315656d17@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36297 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdE0RDb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 27 May 2017 13:03:31 -0400
Received: by mail-ua0-f179.google.com with SMTP id j17so19307452uag.3
        for <ceph-devel@vger.kernel.org>; Sat, 27 May 2017 10:03:30 -0700 (PDT)
In-Reply-To: <edad80ad-82ed-78c0-338c-a39315656d17@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 26, 2017 at 11:32 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 26-5-2017 16:37, Willem Jan Withagen wrote:
>> On 26-5-2017 16:12, Willem Jan Withagen wrote:
>>> Hi Kefu,
>>>
>>> This change has happend relatively early in my vacation because all the
>>> build that are left sort of hang on this. ceph-dencoder just misses out
>>> on a large number of Py object that it can not link. And that again
>>> comes from linking boost_python.

Willem, could you pastebin the error message somewhere, so i can take
a look at it?

>>>
>>> Now I remember we had this problem when we reworked the
>>> find_package(python) stuff.
>>> Any suggestions other than starting to bisect this?
>>
>> Right,
>>
>> It is the other way around....
>> Boost linking just always includes boost_python which in turn misses
>> -lpython to be successful.
>> So now the question is, why am I getting boost_python there?
>
> The standard include Boost code in Cmake returns all available libraries.
> So for now I'm manually removing
>         /usr/local/lib/libboost_python.so
> from the Boost_LIBRARIES.
>
> Now REMOVE_ITEM does not use regual expressions, so it is hardcoded.
> Which looks sort of clumsy.
>
> I'll submit a PR for this.
>
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
