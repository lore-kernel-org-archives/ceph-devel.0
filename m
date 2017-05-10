From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: boost::future and continuations
Date: Wed, 10 May 2017 01:36:17 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1705100134240.23902@ancalagon.suse.de>
References: <457eab81-262e-c7f1-44e2-916dbfa3b4cb@redhat.com> <CAJ4mKGbzvYp6+RupbyA=L=kAMUuykFrAy+DBEafAiV+fcWz6AQ@mail.gmail.com> <alpine.DEB.2.11.1705091640470.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48025 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751081AbdEJIgT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 May 2017 04:36:19 -0400
In-Reply-To: <alpine.DEB.2.11.1705091640470.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, 9 May 2017, Sage Weil wrote:

> Yeah, +100 if it's on a standards track.  Is the implic unwrapping
> something that is planned and/or coming soon?

The Concurrency TS extends std::future in several interesting directions. 
There's an implementation of it that's the foundation of the HPX library.

http://stellar.cct.lsu.edu/projects/hpx/

http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4107.html

Hope that helps,

-Jesse
