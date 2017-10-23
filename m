From: Ricardo Dias <rdias@suse.com>
Subject: Re: Why does messenger sends the address of himself and of the
 connecting peer
Date: Mon, 23 Oct 2017 09:47:36 +0100
Message-ID: <1508748456.10018.15.camel@suse.com>
References: <1508513118.10018.8.camel@suse.com>
         <alpine.DEB.2.11.1710201536440.26711@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:58123 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJWIr6 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 23 Oct 2017 04:47:58 -0400
In-Reply-To: <alpine.DEB.2.11.1710201536440.26711@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 2017-10-20 at 15:40 +0000, Sage Weil wrote:
> On Fri, 20 Oct 2017, Ricardo Dias wrote:
> > In the current messenger protocol, upon accepting a new connection,
> the
> > messenger sends it's address and the connecting peer address along
> with
> > the banner string. Why does the connecting peer need these
> addresses?
> > Moreover, the connecting peer uses the connecting peer address
> (sent
> > from the server) to set as it's own address.
> > 
> > What happens if the network is rewriting addresses  because of NAT,
> or
> > whatever other strange reasons?
> 
> There are two cases:
> 
> 1) client -> server connections.  These always are initiated in one 
> directly.  The self address thing is included there partly so that
> the 
> client can discover what its effective (public) address is.  In the
> case 
> of the OSD, the initial osd -> mon connection allows the osd to learn
> what 
> it's public IP address will be (we advertise our address as the one 
> that is used to connect to the mon).
> 
> 2) server <-> server connections, e.g., mon<->mon, osd<->osd, mds<-
> >mds.  
> Here, connections can be opened in either direction.  I believe here
> it is 
> just used as a sanity check.
> 
> > I also saw that the code that encodes these addresses have a
> comment
> > saying "// legacy". Should we remove these addresses from the new
> V2
> > protocol, or do we still need them?
> 
> I think we'll still need them, since new clients will still need to 
> connect to old servers, and new servers will need to allow old
> clients to 
> connect.

The Messenger will still support the V1 protocol, so if a new client
needs to talk with an old server it will instantiate a V1 messenger.
Therefore, I think we can drop this from the V2 protocol, right?

> 
> HTH?
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
Ricardo Dias
Senior Software Engineer - Storage Team
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284
(AG Nürnberg)
