From: Sage Weil <sweil@redhat.com>
Subject: Re: msgr2 protocol
Date: Thu, 2 Jun 2016 14:24:04 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58434 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932392AbcFBSXl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Jun 2016 14:23:41 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 009F84464C
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jun 2016 18:23:41 +0000 (UTC)
In-Reply-To: <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 2 Jun 2016, Gregory Farnum wrote:
> On Thu, May 26, 2016 at 11:17 AM, Sage Weil <sweil@redhat.com> wrote:
> > I wrote up a basic proposal for the new msgr2 protocol:
> >
> >         http://pad.ceph.com/p/msgr2
> >
> > It is pretty similar to the current protocol, with a few key changes:
> >
> > 1. The initial banner has a version number for protocl features supported
> > and required.  This will allow optional behavior later.  The current
> > protocol doesn't allow this (the banner string is fixed and has to match
> > verbatim).
> >
> > 2. The auth handshake is a low-level msgr exchange now.  This more or less
> > matches the MAuth and MAuthReply exchange with the mon.  Also, the
> > authenticator/ticket presentation for established clients can be sent here
> > as part of this exchange, instead of as part of the msg_connect and
> > msg_connect_reply exchnage.
> >
> > 3. The identification of peers during connect is moved to the TAG_IDENT
> > stage.  This way it could happen after authentication and/or encryption,
> > if we like.  (Not sure it matters.)
> 
> Hmm, reading this through I'm actually confused about how we do
> authentication before we identify ourselves.

Keep in mind that this TAG_IDENT is the entity type and features--not our 
cephx auth EntityName (client.foo, osd.123, etc.)--that identity is 
established (securely) as part of the auth handshake.

> Going back to the fast reconnects again (in which we allow a client to
> submit all the reconnect data at once and submit a message without
> waiting for a response from the server), we'd need to be able to
> re-use the previous session key during the authentication phase but
> for that to make any sense it would need to have supplied the
> identifying cookie.

I think the fast reconnect would only be possible if the first connection 
got far enough to discover the server cookie from it's TAG_IDENT.  So the 
2 pieces of info we need are the session key established during auth 
handshake *and* the server cookie from the ident.  If, after that point, 
we disconnect, we can fast reconnect using that info + our last seq etc.

I'm not totally certain this will actually be a win, though.  For example, 
say we send

 msg5 + msg6 + msg7 + msg8 + msg9 + msg10

and have seen an ack through msg6.  That means on reconnect we either have 
to wait for a round trip to get the last_ack and find out whether the 
server got 7-10, or blindly resend 7-10 even though they might be dups.  
Whether it's a win will depend on the message sizes vs connection latency.

My inclination is still to leave the door open for fast reconnect, but 
ignore it in the initial implementation for simplicity...

sage


> Were you thinking that with cephx, it would use the cluster key to
> generate a "blind" session key, saying it's allowed to talk, and then
> use that session key to do identification and share the cephx bundle?
> -Greg
> 
> 
> >
> > 4. Signatures are a separate message now that follows the previous
> > message.  If a message doesn't have a signature that follows, it is
> > dropped.  Once authenticated we can sign all the other handshake exchanges
> > (TAG_IDENT, etc.) as well as the messages themselves.
> >
> > 5. The reconnect behavior for stateful connections is a separate
> > exchange. This keeps the stateless connections free of clutter.
> >
> > 6. A few changes in the auth_none and cephx integratoin will be needed.
> > For example, all the current stubs assume that authentication happens over
> > MAuth message and authorization happens in an authorizer blob in
> > ceph_msg_connect.  Now both are part of TAG_AUTH_REQUEST, so we'll need to
> > multiplex the cephx message blobs. Also, because the IDENT exchanges
> > happens later, we may need to pass additional info in the auth handshake
> > messages (like the peer type, or whatever else is needed).
> >
> > 7. Lots of messages can go either way, and I tried ot avoid a strict
> > request/response model so that things could be pipelined, and we'd spend a
> > minimal amount of time waiting for a response from the other end.  For
> > example,
> >
> > C:
> >  initiates connection
> > S:
> >  accepts connection
> >  -> banner
> >  -> TAG_AUTH_METHODS
> > C:
> >  -> banner
> >  -> TAG_AUTH_SET_METHOD
> >  -> TAG_AUTH_AUTH_REQUEST
> > S:
> >  -> TAG_AUTH_REPLY
> > C:
> >  -> TAG_ENCRYPT_BEGIN
> >  -> TAG_IDENT
> >  -> TAG_SIGNATURE
> > S:
> >  -> TAG_ENCRYPT_BEGIN
> >  -> TAG_IDENT
> >  -> TAG_SIGNATURE
> > C:
> >  -> TAG_START
> >  -> TAG_SIGNATURE
> >  -> TAG_MSG
> >  -> TAG_SIGNATURE
> >     ...
> > S:
> >  -> TAG_MSG
> >  -> TAG_SIGNATURE
> >     ...
> >
> > Comments, please!  The exhange is a bit less structured as far as who
> > sends what message, with the idea that we could pipeline a lot of it, but
> > it may end up being too ambiguous.  Let me know what you think...
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
