From: John Spray <jspray@redhat.com>
Subject: Re: multi-line comments
Date: Thu, 17 Aug 2017 12:42:05 +0100
Message-ID: <CALe9h7cT=MnWE4jtEuzeF1K9V=tJtQra+weJg_EXKvDXP43+Wg@mail.gmail.com>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34710 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbdHQLm0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 07:42:26 -0400
Received: by mail-oi0-f46.google.com with SMTP id x3so63455814oia.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 04:42:26 -0700 (PDT)
In-Reply-To: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, amitkuma@redhat.com

On Thu, Aug 17, 2017 at 12:22 PM, kefu chai <tchaikov@gmail.com> wrote:
> hi Amit,
>
> i found that you started to encourage developers to use "/* */" for
> multiple-lined comment while reviewing pull requests. IIUC, it's more
> of a gray area, and sort of a personal preferences. so i don't
> understand why we need to go this way. and i believe, in modern C++
> practice, "//" is more common[0], and works better for developers. in
> the sense that, it's more readable, conforms to C++ standards, and
> works just fine with editors/tools.

Yep.  Both are completely acceptable.

John

>
> ---
> [0] https://google.github.io/styleguide/cppguide.html#Comment_Style
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
