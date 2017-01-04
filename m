From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Status of static analysis
Date: Wed, 4 Jan 2017 10:44:40 +1000
Message-ID: <20170104004440.GA6375@rskikr.localdomain>
References: <20161219024554.GA6396@rskikr.localdomain>
 <CAJ4mKGbge38C_EqefK1Mm7Tn6CadC2iy_MBF1FHWJtw1Rc3A0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35571 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760122AbdADAos (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 19:44:48 -0500
Received: by mail-pf0-f177.google.com with SMTP id i88so78839117pfk.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 16:44:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbge38C_EqefK1Mm7Tn6CadC2iy_MBF1FHWJtw1Rc3A0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On Wed, Jan 4, 2017 at 10:30 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Sun, Dec 18, 2016 at 6:45 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>> As you would have noticed in recent weeks we have returned to  running a
>> Coverity test over the source tree on a weekly basis. In addition, I have been
>> running Clang Static Analyzer and Cppcheck scans. Until we can find a better
>> home for these and include at least one of them in our CI processes I will be
>> hosting them at http://people.redhat.com/bhubbard/
>
> So...is there some way for people to feed back into that as we
> evaluate stuff? For instance I looked at one of the use-after-free
> reports[1] and it's incorrect and I think there's a way to tell
> Coverity so, but I've no idea how.
> -Greg
>
> [1]: http://people.redhat.com/bhubbard/scan-build.16-12-30/report-46bfed.html#EndPath

Hi Greg,

That report is from Clang Static Analyzer (not Coverity) and I am happy to
coordinate feedback as best I can for now.

There is a FAQ here, http://clang-analyzer.llvm.org/faq.html

>>
>> --
>> Cheers,
>> Brad
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
