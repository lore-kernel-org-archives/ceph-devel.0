From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Transforming a bufferlist iterator into new bufferlist
Date: Mon, 27 Aug 2012 13:23:25 -0700
Message-ID: <CAPrxi58o57cWU4W0918ErPPow6q2Gg_niAWZGO8jiB6UMtMaWw@mail.gmail.com>
References: <CAPrxi590uJZWYpcWb-uhNucH57_AcSEepbGi-0M9o5zQPf=ZvQ@mail.gmail.com>
	<alpine.DEB.2.00.1208271300200.29719@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61069 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754598Ab2H0UX1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 16:23:27 -0400
Received: by lagy9 with SMTP id y9so2808689lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 13:23:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208271300200.29719@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Perfect, thanks.

On Mon, Aug 27, 2012 at 1:01 PM, Sage Weil <sage@inktank.com> wrote:
>
> and then
>
> bufferlist b;
> ::decode(b, it);
>
> will get it back.
>
> sage
