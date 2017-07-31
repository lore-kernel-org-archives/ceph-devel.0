From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: What's the difference between pg incomplete and pg inconsistent ?
Date: Mon, 31 Jul 2017 09:29:51 -0700
Message-ID: <CAJ4mKGYeAU0DUyJTo1OQq0R0hM0r9QYiMcovbn2VimUNU=H7uQ@mail.gmail.com>
References: <CAN=xyVUcJUiTG8UnOS_bPiw1MProWROCNc4hKAqwEctFn5DgFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:37529 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbdGaQ3w (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jul 2017 12:29:52 -0400
Received: by mail-io0-f170.google.com with SMTP id c74so113139074iod.4
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jul 2017 09:29:52 -0700 (PDT)
In-Reply-To: <CAN=xyVUcJUiTG8UnOS_bPiw1MProWROCNc4hKAqwEctFn5DgFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, "Ma, Jianpeng" <jianpeng.ma@intel.com>, Kefu Chai <tchaikov@gmail.com>

On Mon, Jul 31, 2017 at 2:39 AM, qi Shi <m13913886148@gmail.com> wrote:
> 1, What causes pg incomplete ?
> Is it because pg failed to select the authoritative log?
>
> 2, What causes pg inconsistent ?
> When pg status is inconsistent, why don't peering but inconsistent ?
>
> 3, What's the difference between pg incomplete and pg inconsistent ?
>
> Can you analyze it from pg state machine?

An incomplete PG is missing part of the log or modified objects it
needs in order to go active. An inconsistent PG has detected via
scrubbing that some of its objects differ when they should be the
same. So an inconsistent PG is active because it has all the data it
should, some of that data just doesn't make sense. An incomplete PG
does not.
(Also, if you're running a sufficiently old version of Ceph, a PG
might be incomplete because there aren't enough live replicas — in
current code that is called "undersized", though.)
-Greg
