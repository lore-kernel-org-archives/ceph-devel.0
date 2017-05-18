From: Sage Weil <sage@newdream.net>
Subject: Re: What should we do if ceph feature bit is all used?
Date: Thu, 18 May 2017 13:39:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705181338010.4016@piezo.novalocal>
References: <CALZt5jyPyb8d0maz06LTguhC=++tzdKKY7fJ6DQHLkOS5amzDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42974 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755868AbdERNjI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 09:39:08 -0400
In-Reply-To: <CALZt5jyPyb8d0maz06LTguhC=++tzdKKY7fJ6DQHLkOS5amzDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, onebeiniunai@163.com

On Thu, 18 May 2017, Ning Yao wrote:
> Hi, Sage and all Cepher
> 
> I find that CEPH_FEATURE bit uses uint64_t and only 64 bits can be
> used totally. However, it will be exhausted soon.  What should we do
> then? Thanks

We are recycling feature bits.  If you look at ceph_features.h in master, 
there are macros that make it explicit when a feature is deprecated and 
when it can be resused.  Once luminous is out we'll have another 10+ bits 
available.

Right now the only ones we can't reuse are the ones that affect client 
behavior; those we have to be more careful deprecating in order to 
preserve support for old clients.

sage
