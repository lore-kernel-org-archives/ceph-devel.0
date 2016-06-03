From: Sage Weil <sweil@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 3 Jun 2016 09:11:04 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606030904430.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com> <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com>
 <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbcFCNKl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Jun 2016 09:10:41 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA7DA486A5
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jun 2016 13:10:40 +0000 (UTC)
In-Reply-To: <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 2 Jun 2016, Gregory Farnum wrote:
> On Thu, Jun 2, 2016 at 11:24 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Thu, 2 Jun 2016, Gregory Farnum wrote:
> >> On Thu, May 26, 2016 at 11:17 AM, Sage Weil <sweil@redhat.com> wrote:
> >> > I wrote up a basic proposal for the new msgr2 protocol:
> >> >
> >> >         http://pad.ceph.com/p/msgr2
> >> >
> >> > It is pretty similar to the current protocol, with a few key changes:
> >> >
> >> > 1. The initial banner has a version number for protocl features supported
> >> > and required.  This will allow optional behavior later.  The current
> >> > protocol doesn't allow this (the banner string is fixed and has to match
> >> > verbatim).
> >> >
> >> > 2. The auth handshake is a low-level msgr exchange now.  This more or less
> >> > matches the MAuth and MAuthReply exchange with the mon.  Also, the
> >> > authenticator/ticket presentation for established clients can be sent here
> >> > as part of this exchange, instead of as part of the msg_connect and
> >> > msg_connect_reply exchnage.
> >> >
> >> > 3. The identification of peers during connect is moved to the TAG_IDENT
> >> > stage.  This way it could happen after authentication and/or encryption,
> >> > if we like.  (Not sure it matters.)
> >>
> >> Hmm, reading this through I'm actually confused about how we do
> >> authentication before we identify ourselves.
> >
> > Keep in mind that this TAG_IDENT is the entity type and features--not our
> > cephx auth EntityName (client.foo, osd.123, etc.)--that identity is
> > established (securely) as part of the auth handshake.
> >
> >> Going back to the fast reconnects again (in which we allow a client to
> >> submit all the reconnect data at once and submit a message without
> >> waiting for a response from the server), we'd need to be able to
> >> re-use the previous session key during the authentication phase but
> >> for that to make any sense it would need to have supplied the
> >> identifying cookie.
> >
> > I think the fast reconnect would only be possible if the first connection
> > got far enough to discover the server cookie from it's TAG_IDENT.  So the
> > 2 pieces of info we need are the session key established during auth
> > handshake *and* the server cookie from the ident.  If, after that point,
> > we disconnect, we can fast reconnect using that info + our last seq etc.
> 
> Yes, I agree. But that means the server needs to be able to identify
> the shared secret key being used to sign stuff. Do we not switch over
> from the cluster key to the session key until after auth is done and
> we move to TAG_IDENT?
> That might mean we want to re-sign all the stuff used for
> decision-making in the AUTH phase with our session key as well, hrm.
> Or maybe that doesn't add anything since if somebody has access to the
> session key they can necessarily have seen our session key, so never
> mind.

I would expect the fast reconnect to do something like

 cookie, {cookie, last seq i got, next seq i will send, nonce}^previous_session_key

and the server reply to do something like

 {nonce+1, last seq i got}^previous_session_key

The server would look up the previous cookie, use that session key to 
decrypt the block, verify it looks okay, and use the rest of the info to 
initialize the session.  Probably with some confounder or something.  As 
long as the cookie is plaintext, and the rest can be validated against the 
previous session key, I think we would have enough?

> > I'm not totally certain this will actually be a win, though.  For example,
> > say we send
> >
> >  msg5 + msg6 + msg7 + msg8 + msg9 + msg10
> >
> > and have seen an ack through msg6.  That means on reconnect we either have
> > to wait for a round trip to get the last_ack and find out whether the
> > server got 7-10, or blindly resend 7-10 even though they might be dups.
> > Whether it's a win will depend on the message sizes vs connection latency.
> >
> > My inclination is still to leave the door open for fast reconnect, but
> > ignore it in the initial implementation for simplicity...
> 
> Yeah, if we actually get interrupted without acks it's not so helpful.
> I'm thinking more the case where the OSD is needing to politely tear
> down tcp sessions/sockets earlier than it would like to than that the
> network is frequently failing on us.

Oh yeah, that's a good point.  It's probably worth it then!

sage
