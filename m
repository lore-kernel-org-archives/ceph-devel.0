From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Accelerating crush with SIMD
Date: Sun, 28 Aug 2016 21:28:25 -0700
Message-ID: <CAJ4mKGbpnUFqXpVLVpbWrzGXHjJA17ec-evUUutBKVo9iJndBw@mail.gmail.com>
References: <57C3269E.7010102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35943 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbcH2E2j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 00:28:39 -0400
Received: by mail-ua0-f169.google.com with SMTP id m60so186489580uam.3
        for <ceph-devel@vger.kernel.org>; Sun, 28 Aug 2016 21:28:27 -0700 (PDT)
In-Reply-To: <57C3269E.7010102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Aug 28, 2016 at 10:59 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Could we significantly accelerate crush with SIMD instructions ? I don't remember the idea being discussed but maybe I missed it.

I think it was attempted, but using a lookup table method turned out
to be much faster. Sage did some prototyping and then some folks from
Intel did a lot of heavy optimization; I'd be surprised if anybody
managed to speed up the CRUSH calculations much at this point (at
least, without changing the fundamental math involved).

Sorry I can't be more detailed; the actual CRUSH implementation is
something I've largely left alone. I imagine the optimization points
become pretty clear running git blame or something though. ;)
-Greg
