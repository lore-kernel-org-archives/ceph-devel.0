From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Switching on mds_bal_frag by default
Date: Fri, 5 Aug 2016 13:36:49 -0400
Message-ID: <CA+2bHPYoMxeYdEz4Zef5Vp8yOs3CpJAYvbGVa_B1fWi2X5DC0Q@mail.gmail.com>
References: <CALe9h7fbSiDEf_AYKyOuDDwtDq_4-T1Dq4p0kieyAmZoMyHu8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34836 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759358AbcHERhU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 13:37:20 -0400
Received: by mail-qk0-f176.google.com with SMTP id x185so76785157qkc.2
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 10:37:20 -0700 (PDT)
In-Reply-To: <CALe9h7fbSiDEf_AYKyOuDDwtDq_4-T1Dq4p0kieyAmZoMyHu8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Aug 5, 2016 at 6:52 AM, John Spray <jspray@redhat.com> wrote:
> Patrick: can you try enabling fragmentation in the multimds tests so
> that we have an idea if it's going to make them blow up before we
> switch it on in master?
>
> The multimds suites currently don't have the yaml fragments that
> switch it on, and they'll probably be particularly vulnerable to any
> issues it might throw up.

Yup, I'm working on getting the two suites more in sync so we're
consistently testing configurations. I'll do some runs later today on
a ceph-qa-suite branch.

-- 
Patrick Donnelly
