From: Tommi Virtanen <tv@inktank.com>
Subject: Re: distributed cluster
Date: Tue, 29 May 2012 09:44:19 -0700
Message-ID: <CADvuQREnjHmnjOKimy2+FCrJ0yc2zGh6v4gtUtovX=jVDazRsQ@mail.gmail.com>
References: <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35540 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab2E2Qok (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 12:44:40 -0400
Received: by pbbrp8 with SMTP id rp8so6185677pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:44:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205281117360.358@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@update.uu.se>
Cc: ceph-devel@vger.kernel.org

On Mon, May 28, 2012 at 4:28 AM, Jerker Nyberg <jerker@update.uu.se> wrote:
> This may not really be a subject ceph-devel mailinglist but rather a
> potential ceph-users? I hope it is ok to write here.

It's absolutely ok to talk on this mailing list about using Ceph. We
may create a separate ceph-users later on, but right now this list is
where the conversation should go.

> Let us assume we have a couple of sites distributed over a metro network
> with at least gigabit interconnect. The demands for storage capacity and
> speed at our sites are increasing together with the demands for reasonably
> stable storage. May Ceph be a port of a solution?

Ceph was designed to work within a single data center. If parts of the
cluster reside in remote locations, you essentially suffer the worst
combination of their latency and bandwidth limits. A write that gets
replicated to three different data centers is not complete until the
data has been transferred to all three, and an acknowledgement has
been received.

For example: with data replicated over data centers A, B, C, connected
at 1Gb/s, the fastest all of A will ever handle writes is 0.5Gb/s --
it'll need to replicate everything to B and C, over that single pipe.

I am aware of a few people building multi-dc Ceph clusters. Some have
shared their network latency, bandwidth and availability numbers with
me (confidentially), and at first glance their wide-area network
performs better than many single-dc networks. They are far above a 1
gigabit interconnect.

I would really recommend you embark on a project like this only if you
are able to understand the Ceph replication model, and do the math for
yourself and figure out what your expected service levels for Ceph
operations would be. (Naturally, Inktank Professional Services will
help you in your endeavors, though their first response should be
"that's not a recommended setup".)

> One idea is to set up Ceph distributed over this metro network. A public
> service network is announced at all sites, anycasted from the storage
> SMB/NFS/RGW(?)-to-Ceph gateway. (for stateless connections). Statefull
> connections (iSCSI?) has to contact the individual storage gateways and
> redundancy is handled at the application level (dual path). Ceph kernel
> clients contact the storage servers directly.

The Ceph Distributed File System is not considered production ready yet.
