From: Sage Weil <sage@newdream.net>
Subject: Re: Why does messenger sends the address of himself and of the
 connecting peer
Date: Mon, 23 Oct 2017 12:14:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710231214160.16763@piezo.us.to>
References: <1508513118.10018.8.camel@suse.com>         <alpine.DEB.2.11.1710201536440.26711@piezo.us.to> <1508748456.10018.15.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:57202 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJWMOb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 08:14:31 -0400
In-Reply-To: <1508748456.10018.15.camel@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 23 Oct 2017, Ricardo Dias wrote:
> On Fri, 2017-10-20 at 15:40 +0000, Sage Weil wrote:
> > On Fri, 20 Oct 2017, Ricardo Dias wrote:
> > > In the current messenger protocol, upon accepting a new connection,
> > the
> > > messenger sends it's address and the connecting peer address along
> > with
> > > the banner string. Why does the connecting peer need these
> > addresses?
> > > Moreover, the connecting peer uses the connecting peer address
> > (sent
> > > from the server) to set as it's own address.
> > > 
> > > What happens if the network is rewriting addresses  because of NAT,
> > or
> > > whatever other strange reasons?
> > 
> > There are two cases:
> > 
> > 1) client -> server connections.  These always are initiated in one 
> > directly.  The self address thing is included there partly so that
> > the 
> > client can discover what its effective (public) address is.  In the
> > case 
> > of the OSD, the initial osd -> mon connection allows the osd to learn
> > what 
> > it's public IP address will be (we advertise our address as the one 
> > that is used to connect to the mon).
> > 
> > 2) server <-> server connections, e.g., mon<->mon, osd<->osd, mds<-
> > >mds.  
> > Here, connections can be opened in either direction.  I believe here
> > it is 
> > just used as a sanity check.
> > 
> > > I also saw that the code that encodes these addresses have a
> > comment
> > > saying "// legacy". Should we remove these addresses from the new
> > V2
> > > protocol, or do we still need them?
> > 
> > I think we'll still need them, since new clients will still need to 
> > connect to old servers, and new servers will need to allow old
> > clients to 
> > connect.
> 
> The Messenger will still support the V1 protocol, so if a new client
> needs to talk with an old server it will instantiate a V1 messenger.
> Therefore, I think we can drop this from the V2 protocol, right?

Oh, right.. yes!

sage
