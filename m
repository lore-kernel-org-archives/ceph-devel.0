From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Messenger V2: multiple bind support
Date: Thu, 2 Nov 2017 14:57:41 -0700
Message-ID: <CAJ4mKGafaDvu6qT_EnHSnKcHaXD7bEDUg2Hr9FuQfjoygU5nXg@mail.gmail.com>
References: <1508855817.10018.25.camel@suse.com> <add34139-4ed6-fcca-fdac-a05f58aff433@suse.de>
 <CAJ4mKGaQ2EDENqqNpDUH6XG2THGk-XnJ+oR4yu14pF7h+F6r1g@mail.gmail.com> <alpine.DEB.2.11.1711020238570.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:49218 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbdKBV5n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Nov 2017 17:57:43 -0400
Received: by mail-io0-f172.google.com with SMTP id n137so2230948iod.6
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 14:57:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1711020238570.23234@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Joao Eduardo Luis <joao@suse.de>, Ricardo Dias <rdias@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 1, 2017 at 7:43 PM Sage Weil <sage@newdream.net> wrote:
>
> On Wed, 1 Nov 2017, Gregory Farnum wrote:
> > On Wed, Oct 25, 2017 at 7:43 AM Joao Eduardo Luis <joao@suse.de> wrote:
> > >
> > > On 10/24/2017 03:36 PM, Ricardo Dias wrote:
> > > > Hi list,
> > > >
> > > > I was wondering if it makes sense to support multiple binds with a
> > > > single messenger instance.
> > > >
> > > > The use case I have in mind is when there are multiple public/cluster
> > > > networks specified in ceph.conf and we want to listen for connections
> > > > in one interface of each network. With the support for multiple binds,
> > > > we could use a single messenger instance to listen to all interfaces.
> > > >
> > > > Do you think it is worth to implement such support or is the above use
> > > > case easily handled by having multiple messenger instances?
> > >
> > > I would think multiple binds would make sense, but how would this affect
> > > setting the policies? Would we be sharing a single policy across
> > > multiple binds, or would we be allowed different policies for different
> > > binds?
> > >
> > > Regardless, and not knowing the code, wouldn't this make sense for
> > > multiplexing multiple daemons on a single messenger? Making the
> > > messenger sort of a blackbox, that everyone could just use seamlessly
> > > without having to figure too many things out?
> > >
> > > E.g., instead of multiplexing several osds on a messenger for the public
> > > network, and then the same set of osds on a messenger for the cluster
> > > network, we could simply have one messenger (bound to public and
> > > cluster) and have just that one messenger for all the osds.
> > >
> > > Anyway, from an abstraction point-of-view it makes sense to me; no idea
> > > how feasible that would be though.
> >
> > There's sort of two pieces here, right?
> > 1) From the Dispatcher perspective, we want a single "Messenger" that
> > it talks to. (At least, I'm pretty sure. Unless we need to be making
> > routing decisions using internal data? I really hope that never comes
> > up.) That could be set up by having multiple Messenger implementations
> > behind a "UnifyingMessenger" abstraction layer with pretty minimal
> > changes.
> >
> > 2) From an implementation perspective, which data structures do we end
> > up needing to share in order to have a daemon listening on multiple
> > ports?
> >
> > So, from the SimpleMessenger perspective, I don't think we get much
> > out of trying to build multi-bind into it. We'd basically get to
> > eliminate the duplicated DIspatchQueue, which is not very interesting.
> > (Modulo some flow control stuff, perhaps.) From an AsyncMessenger
> > implementation perspective, that calculus might shift since we're
> > running on a thread pool, but I'm not deeply familiar with the code
> > internals.
>
> I'm afraid that the problem that's going to come up is the peer_addr
> hash_map<> for stateful_peer connections (osd to osd, etc.).  This is down
> in the messenger layer and is the main piece of shared state left (most
> everything else works with Connection refs).  I'm worried that we'll want
> or need to pull that up out of the messenger into the consumer (e.g., a
> hash_map<int,ConnectionRef> osd_peers in OSDService) and refactor the
> connection race handling a bit.  I think that will ultimately solve some
> bugs and will simplify the Messenger greatly, but it's a painful refactor.


You just mean here when we're selecting the correct network to use for
OSD<->OSD communications? Hmm, I'm tempted to say we could do
something pretty simple by setting a priority for the different
addresses, but you're right, there are some issues with reconnect
especially in cases where one network stops working.

>
>
> > But I'm curious what brings this up. I thought you were working on the
> > v2 protocol — does something in that somehow hinge on the server-side
> > implementation of multiple networks?
>
> The v2 protocol will run on another port and we want to answer on the old
> port+protocol for old clients too.


This is a rather narrower case than the above though, right? Because
we don't need to worry about cross-messenger reconnects (the client
will be old and use the old messenger/port, or new and use the new
one) so we can put in a very simple shim.
-Greg
