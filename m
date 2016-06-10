From: Sage Weil <sage@newdream.net>
Subject: Re: msgr2 protocol
Date: Fri, 10 Jun 2016 06:11:01 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606100544560.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com> <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com> <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com> <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com> <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com> <CACJqLya8rdipTW9hAikgyyDAWTFeTuqOizvDQSY88L_QnzeKFQ@mail.gmail.com>
 <CAEG8a3KKtw122rY1kt3DMw_9y87ivK7FO1h0LbhoWn05mUD8Tg@mail.gmail.com> <20160610083145.GD23426@degu.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33447 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbcFJKKk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 06:10:40 -0400
In-Reply-To: <20160610083145.GD23426@degu.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Junwang Zhao <zhjwpku@gmail.com>, Haomai Wang <haomai@xsky.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 10 Jun 2016, Marcus Watts wrote:
> Sorry for the delay reviewing this; got a bit snowed with some
> rush hammer things.
> 
> So my comments here are of msgr2
> as of 20160610.
> 
> 1. 
> banner phase.
> bitmask- should allow for >64 bits (even though we should avoid that)

The protocol specifies hex digits, so there is no explicit size 
restriction.

> 2.
> session handshake & message exchange
> w/ confounder >= block_size, cbc-cts -- there's no need to send pad bytes.
> 	[ cts, ciphertext stealing, is a simple modification of cbc to
> 	not send some bytes which turn out to to be unnecessary; does
> 	not hurt security, see
> 		https://en.wikipedia.org/wiki/Ciphertext_stealing	]
>
> 3.
> authentication, "tag_auth_reply".
> method specific payload need not *resend* feature bits, needs
> merely to sign them.

True.  The modular auth implementation needs to have a well-defined 
representation of the thing it is signing.  Since it should be independent 
of the wire protocol, we just need to make sure the thing it is 
either signing or resending and signing is well defined.

> 4.
> authentication
> S/c/ auth_methods, set_method, etc.
> really hope these don't each need to be separate roundtrips.
> perhaps something like,
> sequence:
> 	C->S, S->C:
> 		num_methods,{type,tag,paylen,payload}[num_methods]
> 			where
> 				tag: byte: enum{ continue, accept, info, reject}
> 		at most one method can say "accept", and that message
> 		concludes the auth negotiation for that side (if the other
> 		end doesn't agree, it can reject the connection.)
> 		if a method needs internal state/sequence data, it
> 		must be part of the payload for that method.
> 	each side must send one of these with "accept" before
> 	it can send anything else; all messages sent after "accept"
> 	must be encrypted &etc. (so in that sense equiv to
> 	your TAG_ENCRYPT_BEGIN).
> 	an "info" method can be sent w/ any exchange, can
> 	communicate add'l info that might be useful in that phase or later.
> 	"info" needs to be signed somehow by any successful auth sequence (how?).
> 	reject should include error message, code(?).  is not signed.
> 	positively terminates that method, but not the auth sequence
> 	(another method might succeed).  Neither side should use
> 	that method thereafter, & attempts to do so should be treated
> 	as a fatal connection error by the other side.
> 	If no method indicates "continue" or "accept", that is a
> 	connection fatal error.
> 
> 	one method type can be the "fast reconnect".

If I'm understanding correctly, you're worried about the client 
speculatively trying a few different auth modes in parallel?  I'm not 
worried about optimizing that situation--the site config may accept 
multiple methods server-side but the clients themselves should just be 
configured to prefer the method the site admin prefers.

With the current spec, you can do something like:

C: connect
C: banner
C: set method
C: auth + present existing ticket
C: <wait>

S: accept
S: banner
S: <accept client's method, see ticket>
S: auth + reply
S: <wait>

C: <see server replies>
C: <start sending messages>

Earlier I thought the client had to wait for the server auth reply before 
it could send messages, but it turns out it doesn't with cephx: the 
session key is fixed for a given ticket.  So the confounder(s) are 
critical.  I suppose the client could optimistically continue with the 
exchange without hearing anything from the server, but the fallback path 
if the client's choice of auth method isn't accepted would be more 
complicated. Perhaps we only do that if the client only has 1 configured 
option that it is allowed to use.

> 5.
> message flow handshake.
> I think this can be folded into the authentication
> flow I outlined previously.  Definitly should not be
> N back & forth's.

With the single configured auth method on the client, we'd have

C: connect
C: banner
C: set method
C: auth + present existing ticket
C: tag_ident
C: <wait>

S: accept
S: banner
S: <accept client's method, see ticket>
S: auth + reply
S: <see client ident>
S: ident reply

C: start
C: <messages ...>

That's only one round trip/wait.  I don't think we can get around the 
ident exchange and feature exchange because the message encoding depends 
on it.

> 6.
> so the stuff winds up secured by the authentication sequence needs to include:
> 	auth sequence

The auth and auth reply payloads are just passed to the auth plugin; they 
need to be self-securing.

> 	initial features

This needs to be added :(.  I'm thinking we should just call it cephy 
instead of cephx since we'll be changing the internal auth payloads to 
include this.

> 	final sequence number

What's this?

> 	that side's identity.

Already there.


My big question in the above PR is whether it is sufficient to have a 
confounder in the initial auth exchange and not on each frame/message.
We had per message after our bluejeans discussion but I don't see why 
having just one confounder during the auth exchange to randomize the 
initial state of the exchange isn't sufficient.

Thanks!
sage



> 
> 7.
> > From: Junwang Zhao <zhjwpku@gmail.com>
> > My understanding is that before the protocol msgr2 begins, each party
> > already has it's own secrete key, and it's public key has been known by
> > it's peer, and they have alreay shared the session key that will be used
> > by encryption/decryption.
> > 
> > The secrete key will be used by signature, and the public key will be
> > used to identify.
> 
> 2 main forms of encryption:
> 	symmetric:	single secret key known to both ends: used for
> 			both encryption & decrytion.
> 	public key:	2 keys: public & private.  public key can be shared,
> 			private key is knonw to only one end.
> 			a variety of algorithms including public key encryption,
> 			signing with the private key, or generating shared
> 			secrets.  In many cases the public key/private keys
> 			only used to derive or protect a secret key that is
> 			then used with ordinary symmetric encryption.
> 
> Ceph currently onhly does symmetric encryption.  So there are no public keys.
> (cephx.  See,
> 	http://docs.ceph.com/docs/jewel/dev/cephx_protocol/	)
> 
> We'd like to do interesting things with public keys in the future.
> So we want a sufficiently flexible algorithm that we can plug
> such use in without redoing everything.
> 
> 					-Marcus Watts
> 
> 
