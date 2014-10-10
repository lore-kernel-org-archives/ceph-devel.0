From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 15:17:25 -0700
Message-ID: <CA+Hcz5_xuNtgRrk_VPS+Cx76pROyZyTPEOEfs=D11dOTL=rTVA@mail.gmail.com>
References: <5437A6C0.3000005@dachary.org>
	<alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net>
	<5438134E.7050009@dachary.org>
	<alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net>
	<CA+Hcz5_gwQdZ15EyJBfzxU05bDp0Pbdcgfqtv_=N5Q9Zm62FdQ@mail.gmail.com>
	<5438307C.4060701@dachary.org>
	<CA+Hcz58UV8-eEbbV8uJrg5xaS+DCdueZAmRDwdtuVQTzfSPgSw@mail.gmail.com>
	<5438558C.7060304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:50286 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaJJWRZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 18:17:25 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so2309071qaq.10
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 15:17:25 -0700 (PDT)
In-Reply-To: <5438558C.7060304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 10, 2014 at 2:54 PM, Loic Dachary <loic@dachary.org> wrote:
> I would be surprised if it could easily be setup for cross compilation. Although it would be nice to have an ARMv8 I don't need it right now. Do you ?

Potentially. I'll poke around a bit and see. Maybe we can run 32-bit
builds on ARMv8. I'm not in a huge rush, and can always build from
source on those boxes, as cross-compiling might be a major headache :)
