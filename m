From: Amit <amitkuma@redhat.com>
Subject: Re: multi-line comments
Date: Fri, 18 Aug 2017 17:23:18 +0530
Message-ID: <5996d531.c26f630a.ad731.d0e9@mx.google.com>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
 <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
 <CALe9h7dN3ogwj80hYXAP2AyKpv8CGc_HK5a=ye+OsTjeqqeRDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33229 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdHRLxX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Aug 2017 07:53:23 -0400
Received: by mail-pg0-f43.google.com with SMTP id t3so35029874pgt.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 04:53:23 -0700 (PDT)
In-Reply-To: <CALe9h7dN3ogwj80hYXAP2AyKpv8CGc_HK5a=ye+OsTjeqqeRDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Amit Kumar <amitkuma@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Guys,

Thanks for writing in..

Why I prefer /* */

1. I believe multiline text comment is one entity - which you want to
logically keep together. Line breaks in such a comment are nothing more
than places to wrap text, so breaking it up into many "separate"
comments makes no sense to me though. Therefore, I construct a single
comment block around the whole thing - using /* */.

2. For commenting out code, each line is its own logical unit, so using
consecutive "//"s is ok - sometimes. This is especially true if
individual lines could be commented back "in" for some reason, but not
all of them. Though if you want to comment out a whole block code where
it will never make sense to partially comment it in/out, you may still
prefer to use /* */ - again to group everything together logically and
visually.

3. /* */ called Block comments hence comment blocks should be enclosed
within these. Descriptive blocks can be used in function Header, file
headers etc.

4. Even standard documentation tool (doxygen) generated multiline
comments as /* */ instead of //

Though line comments are OK too, But why not to use block comments which
are meant for same purpose....

Though NOTED ..

Thanks

On 08/18/2017 05:05 PM, John Spray wrote:
> On Thu, Aug 17, 2017 at 6:25 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Thu, Aug 17, 2017 at 4:22 AM, kefu chai <tchaikov@gmail.com> wrote:
>>> hi Amit,
>>>
>>> i found that you started to encourage developers to use "/* */" for
>>> multiple-lined comment while reviewing pull requests. IIUC, it's more
>>> of a gray area, and sort of a personal preferences. so i don't
>>> understand why we need to go this way. and i believe, in modern C++
>>> practice, "//" is more common[0], and works better for developers. in
>>> the sense that, it's more readable, conforms to C++ standards, and
>>> works just fine with editors/tools.
>>>
>> Similarly, do we have a rule or guidance about contractions anywhere?
>>
>> I can see how that might be desirable for non-native english speakers,
>> but it's not a rule of any kind that I'm aware of. Do we want it to
>> be? (...perhaps I should add the ceph-china list to this CC).
> Based on the discussion on https://github.com/ceph/ceph/pull/16705,
> there doesn't seem to be much support for removing contractions.
>
> I sympathise with John W's original intent on that PR to make it
> easier to sync up upstream docs with commercial products that might
> have an IBM-ish style, but I don't think it makes sense to make the
> change without making it a rule, and I think it's not something that's
> desirable as a rule.
>
> I would welcome a style guide for our upstream docs though, so that we
> could have a place to refer to for any rules we do want to have.
>
> John
>
> 1. As I write that, I realise it's weird that in English we sometimes
> use in- to mean opposite and sometimes not!  What a language...
>
>
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thanks
Amit Kumar
!!If you stumble, get back up. 
What happened yesterday, no longer matters.
Today is another day to move closer to your GOAL!!

