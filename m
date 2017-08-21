From: John Spray <jspray@redhat.com>
Subject: Re: multi-line comments
Date: Mon, 21 Aug 2017 10:49:07 +0100
Message-ID: <CALe9h7coEqdxprPQqyyFmp_N9Nt-418QU=TJiVTpackiQDx3HQ@mail.gmail.com>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
 <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
 <CALe9h7dN3ogwj80hYXAP2AyKpv8CGc_HK5a=ye+OsTjeqqeRDQ@mail.gmail.com> <CAC-Np1w9taokXhoqskA-j=AEZevMhLJJFj-vn7FDy_s1kASB+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33547 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbdHUJt2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Aug 2017 05:49:28 -0400
Received: by mail-oi0-f46.google.com with SMTP id f11so149683854oic.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Aug 2017 02:49:28 -0700 (PDT)
In-Reply-To: <CAC-Np1w9taokXhoqskA-j=AEZevMhLJJFj-vn7FDy_s1kASB+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, kefu chai <tchaikov@gmail.com>, Amit Kumar <amitkuma@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 18, 2017 at 10:18 PM, Alfredo Deza <adeza@redhat.com> wrote:
> On Fri, Aug 18, 2017 at 7:35 AM, John Spray <jspray@redhat.com> wrote:
>> On Thu, Aug 17, 2017 at 6:25 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Thu, Aug 17, 2017 at 4:22 AM, kefu chai <tchaikov@gmail.com> wrote:
>>>> hi Amit,
>>>>
>>>> i found that you started to encourage developers to use "/* */" for
>>>> multiple-lined comment while reviewing pull requests. IIUC, it's more
>>>> of a gray area, and sort of a personal preferences. so i don't
>>>> understand why we need to go this way. and i believe, in modern C++
>>>> practice, "//" is more common[0], and works better for developers. in
>>>> the sense that, it's more readable, conforms to C++ standards, and
>>>> works just fine with editors/tools.
>>>>
>>>
>>> Similarly, do we have a rule or guidance about contractions anywhere?
>>>
>>> I can see how that might be desirable for non-native english speakers,
>>> but it's not a rule of any kind that I'm aware of. Do we want it to
>>> be? (...perhaps I should add the ceph-china list to this CC).
>>
>> Based on the discussion on https://github.com/ceph/ceph/pull/16705,
>> there doesn't seem to be much support for removing contractions.
>>
>> I sympathise with John W's original intent on that PR to make it
>> easier to sync up upstream docs with commercial products that might
>> have an IBM-ish style, but I don't think it makes sense to make the
>> change without making it a rule, and I think it's not something that's
>> desirable as a rule.
>>
>> I would welcome a style guide for our upstream docs though, so that we
>> could have a place to refer to for any rules we do want to have.
>
> We do have a documentation style guide:
>
>     https://github.com/ceph/ceph/blob/master/doc/start/documenting-ceph.rst#documentation-style-guide
>
> Most of the suggestions/rules there aren't really followed :(
> Hopefully with the new fixes that went in, that will change and
> prevent us from going astray again.

I think that's more of a style guide for the documentation .rst source
code, I was thinking of a style guide for the content itself.

John

>>
>> John
>>
>> 1. As I write that, I realise it's weird that in English we sometimes
>> use in- to mean opposite and sometimes not!  What a language...
>>
>>
>>> -Greg
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
