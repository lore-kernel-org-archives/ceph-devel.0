From: kefu chai <tchaikov@gmail.com>
Subject: Re: WIP for C++11 Time Support
Date: Fri, 28 Aug 2015 01:13:35 +0800
Message-ID: <CAJE9aOOELZk9yipBcavEUFS+bamTA3m+ONJ67ub8uDUzgKPs0A@mail.gmail.com>
References: <55D37498.8060504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33231 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbH0RNg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Aug 2015 13:13:36 -0400
Received: by qkch123 with SMTP id h123so14091553qkc.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2015 10:13:35 -0700 (PDT)
In-Reply-To: <55D37498.8060504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Ceph Developers <ceph-devel@vger.kernel.org>

On Wed, Aug 19, 2015 at 2:08 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
> I've pushed a branch, wip-cxx11time for inspection. It includes basic
> support for std::chrono (including clocks linked to specific POSIX CLOCK_*
> identifiers) and a new timer class that doesn't require Context*.
>
> As was suggested to me, I updated one subsystem to use std::chrono as an
> example, in this case OSDC.
>
> Please review/critique.

Adam, the commits look great! i just posted some comments on them.

looking forward to the time literals in config_opt.h!

-- 
Regards
Kefu Chai
