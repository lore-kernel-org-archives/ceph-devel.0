From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: multi-line comments
Date: Thu, 17 Aug 2017 10:25:30 -0700
Message-ID: <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35695 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbdHQRZb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 13:25:31 -0400
Received: by mail-it0-f43.google.com with SMTP id 76so34011246ith.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 10:25:31 -0700 (PDT)
In-Reply-To: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, amitkuma@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 17, 2017 at 4:22 AM, kefu chai <tchaikov@gmail.com> wrote:
> hi Amit,
>
> i found that you started to encourage developers to use "/* */" for
> multiple-lined comment while reviewing pull requests. IIUC, it's more
> of a gray area, and sort of a personal preferences. so i don't
> understand why we need to go this way. and i believe, in modern C++
> practice, "//" is more common[0], and works better for developers. in
> the sense that, it's more readable, conforms to C++ standards, and
> works just fine with editors/tools.
>

Similarly, do we have a rule or guidance about contractions anywhere?

I can see how that might be desirable for non-native english speakers,
but it's not a rule of any kind that I'm aware of. Do we want it to
be? (...perhaps I should add the ceph-china list to this CC).
-Greg
