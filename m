From: Sage Weil <sage@newdream.net>
Subject: Re: Unstable clock
Date: Tue, 17 Oct 2017 13:57:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710171356580.26711@piezo.us.to>
References: <085064b4-2e21-4e54-cdd8-dd8a4560aa92@suse.de> <alpine.DEB.2.11.1710171325500.26702@piezo.us.to> <9079f6c0-e37e-74c7-4fcb-4f5fd55cf482@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:55543 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdJQN5h (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Oct 2017 09:57:37 -0400
In-Reply-To: <9079f6c0-e37e-74c7-4fcb-4f5fd55cf482@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mohamad Gebai <mgebai@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>, Florian Haas <florian@hastexo.com>

On Tue, 17 Oct 2017, Mohamad Gebai wrote:
> On 10/17/2017 09:27 AM, Sage Weil wrote:
> > On Tue, 17 Oct 2017, Mohamad Gebai wrote:
> >
> >> It would be good to know if there are any, and maybe prepare for them?
> > Adam added a new set of clock primitives that include a monotonic clock 
> > option that should be used in all cases where we're measuring the passage 
> > of time instead of the wall clock time.  There is a longstanding trello 
> > card to go through and change the latency calculations to use the 
> > monotonic clock.  There are probably dozens of places where an ill-timed 
> > clock jump is liable to trigger some random assert.  It's just a matter of 
> > going through and auditing calls to the legacy ceph_clock_now() method.
> >
> 
> Thanks Sage. I assume that's the card you're referring to:
> https://trello.com/c/SAtGPq0N/65-use-time-span-monotonic-for-durations
> 
> I can take of that one if no one else has started working on it.

That would be wonderful!  I'm pretty sure nobody else is looking at it so 
you win today.  :)

sage
