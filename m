From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD journal draft design
Date: Thu, 4 Jun 2015 11:08:08 -0400 (EDT)
Message-ID: <1628237419.11058538.1433430488520.JavaMail.zimbra@redhat.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com> <1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com> <CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com> <1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com> <CAC6JEv_M5jKk+FSDZja15Rmyf3W2x5-yeg9LRukKCHLnYq-j+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:60865 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbbFDPIK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jun 2015 11:08:10 -0400
In-Reply-To: <CAC6JEv_M5jKk+FSDZja15Rmyf3W2x5-yeg9LRukKCHLnYq-j+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> >> >A successful append will indicate whether or not the journal is now full
> >> >(larger than the max object size), indicating to the client that a new
> >> >journal object should be used.  If the journal is too large, an error
> >> >code
> >> >responce would alert the client that it needs to write to the current
> >> >active journal object.  In practice, the only time the journaler should
> >> >expect to see such a response would be in the case where multiple clients
> >> >are using the same journal and the active object update notification has
> >> >yet to be received.
> >>
> >> I'm confused. How does this work with the splay count thing you
> >> mentioned above? Can you define <splay count>?
> >
> > Similar to the stripe width.
> 
> Okay, that sort of makes sense but I don't see how you could legally
> be writing to different "sets" so why not just make it an explicit
> striping thing and move all journal entries for that "set" at once?
> 
> ...Actually, doesn't *not* forcing a coordinated move from one object
> set to another mean that you don't actually have an ordering guarantee 
> across tags if you replay the journal objects in order?

The ordering between tags was meant to be a soft ordering guarantee (since any number of delays could throw off the actual order as delivered from the OS).  In the case of a VM using multiple RBD images sharing the same journal, this provides an ordering guarantee per device but not between devices.

This is no worse than the case of each RBD image using its own journal instead of sharing a journal and the behavior doesn't seem too different from a non-RBD case when submitting requests to two different physical devices (e.g. a SSD device and a NAS device will commit data at different latencies). Without the forced coordinated move, the potential gap in request orders between two devices would increase by the latency of the notify message roundtrip time, but it prevents the need for potentially resending journal entries to a new journal object.
