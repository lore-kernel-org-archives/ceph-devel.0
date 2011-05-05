From: Sage Weil <sage@newdream.net>
Subject: Re: question about ceph messaging protocol
Date: Thu, 5 May 2011 12:29:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105051219440.26811@cobra.newdream.net>
References: <BANLkTi=L=6s2FCYgXdSnS4b7UTkFrdLWZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59253 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1EET3B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 15:29:01 -0400
In-Reply-To: <BANLkTi=L=6s2FCYgXdSnS4b7UTkFrdLWZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Henry,

On Wed, 4 May 2011, Henry C Chang wrote:
> Hi,
> 
> I have a question about ceph's messaging protocol:
> 
> According to the documentation
> (http://ceph.newdream.net/wiki/Messaging_protocol), the acceptor
> replies with the RETRY tag when it thinks this connecting attempt is
> an old one or the initiator did not get the READY message. So, the
> acceptor sends its own connect_seq to the initiator and waits for it
> to retry.

That wiki page is sadly out of date.  Notably it talks about RETRY when 
the code actually has RETRY_GLOBAL and RETRY_SESSION.  But it's the same 
basic idea: if the attempt has a LOWER seq than the existing session, we 
send a RETRY.

> However, when the initiator re-connects with the acceptor's
> connect_seq (WITHOUT +1), the acceptor will think this is a connection
> race because (peer_connect_seq == existing.connect_seq). Is this the
> desired behavior or just I misunderstood the protocol?

If it's the _same_ seq, then both ends compare the addresses to determine 
which socket wins.  The loser sends WAIT.  It sounds like in your case, 
yes, it'll reconnect with the same seq, and it will look like a 
connection race... because it is.  If the acceptor has an open connection 
with the same seq, the initiator should have it too, and not be 
connecting.

It may be we didn't anticipate a situation where your acceptor has the 
connection but it is idle/closed and doesn't notice.  Maybe sending a 
keepalive in this situation is what is needed?

How are you hitting this situation?

sage

