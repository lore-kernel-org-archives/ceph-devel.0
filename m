From: John Spray <jspray@redhat.com>
Subject: Re: multi-line comments
Date: Fri, 18 Aug 2017 12:35:35 +0100
Message-ID: <CALe9h7dN3ogwj80hYXAP2AyKpv8CGc_HK5a=ye+OsTjeqqeRDQ@mail.gmail.com>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
 <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35308 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdHRLf4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Aug 2017 07:35:56 -0400
Received: by mail-oi0-f52.google.com with SMTP id e124so93819306oig.2
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 04:35:56 -0700 (PDT)
In-Reply-To: <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Amit Kumar <amitkuma@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 17, 2017 at 6:25 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Thu, Aug 17, 2017 at 4:22 AM, kefu chai <tchaikov@gmail.com> wrote:
>> hi Amit,
>>
>> i found that you started to encourage developers to use "/* */" for
>> multiple-lined comment while reviewing pull requests. IIUC, it's more
>> of a gray area, and sort of a personal preferences. so i don't
>> understand why we need to go this way. and i believe, in modern C++
>> practice, "//" is more common[0], and works better for developers. in
>> the sense that, it's more readable, conforms to C++ standards, and
>> works just fine with editors/tools.
>>
>
> Similarly, do we have a rule or guidance about contractions anywhere?
>
> I can see how that might be desirable for non-native english speakers,
> but it's not a rule of any kind that I'm aware of. Do we want it to
> be? (...perhaps I should add the ceph-china list to this CC).

Based on the discussion on https://github.com/ceph/ceph/pull/16705,
there doesn't seem to be much support for removing contractions.

I sympathise with John W's original intent on that PR to make it
easier to sync up upstream docs with commercial products that might
have an IBM-ish style, but I don't think it makes sense to make the
change without making it a rule, and I think it's not something that's
desirable as a rule.

I would welcome a style guide for our upstream docs though, so that we
could have a place to refer to for any rules we do want to have.

John

1. As I write that, I realise it's weird that in English we sometimes
use in- to mean opposite and sometimes not!  What a language...


> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
