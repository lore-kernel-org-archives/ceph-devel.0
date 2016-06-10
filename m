From: Marcus Watts <mwatts@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 10 Jun 2016 04:31:45 -0400
Message-ID: <20160610083145.GD23426@degu.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
 <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
 <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com>
 <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
 <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
 <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>
 <CACJqLya8rdipTW9hAikgyyDAWTFeTuqOizvDQSY88L_QnzeKFQ@mail.gmail.com>
 <CAEG8a3KKtw122rY1kt3DMw_9y87ivK7FO1h0LbhoWn05mUD8Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34020 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbcFJIbt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 04:31:49 -0400
Content-Disposition: inline
In-Reply-To: <CAEG8a3KKtw122rY1kt3DMw_9y87ivK7FO1h0LbhoWn05mUD8Tg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junwang Zhao <zhjwpku@gmail.com>
Cc: Haomai Wang <haomai@xsky.com>, Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sorry for the delay reviewing this; got a bit snowed with some
rush hammer things.

So my comments here are of msgr2
as of 20160610.

1. 
banner phase.
bitmask- should allow for >64 bits (even though we should avoid that)

2.
session handshake & message exchange
w/ confounder >= block_size, cbc-cts -- there's no need to send pad bytes.
	[ cts, ciphertext stealing, is a simple modification of cbc to
	not send some bytes which turn out to to be unnecessary; does
	not hurt security, see
		https://en.wikipedia.org/wiki/Ciphertext_stealing	]

3.
authentication, "tag_auth_reply".
method specific payload need not *resend* feature bits, needs
merely to sign them.

4.
authentication
S/c/ auth_methods, set_method, etc.
really hope these don't each need to be separate roundtrips.
perhaps something like,
sequence:
	C->S, S->C:
		num_methods,{type,tag,paylen,payload}[num_methods]
			where
				tag: byte: enum{ continue, accept, info, reject}
		at most one method can say "accept", and that message
		concludes the auth negotiation for that side (if the other
		end doesn't agree, it can reject the connection.)
		if a method needs internal state/sequence data, it
		must be part of the payload for that method.
	each side must send one of these with "accept" before
	it can send anything else; all messages sent after "accept"
	must be encrypted &etc. (so in that sense equiv to
	your TAG_ENCRYPT_BEGIN).
	an "info" method can be sent w/ any exchange, can
	communicate add'l info that might be useful in that phase or later.
	"info" needs to be signed somehow by any successful auth sequence (how?).
	reject should include error message, code(?).  is not signed.
	positively terminates that method, but not the auth sequence
	(another method might succeed).  Neither side should use
	that method thereafter, & attempts to do so should be treated
	as a fatal connection error by the other side.
	If no method indicates "continue" or "accept", that is a
	connection fatal error.

	one method type can be the "fast reconnect".

5.
message flow handshake.
I think this can be folded into the authentication
flow I outlined previously.  Definitly should not be
N back & forth's.

6.
so the stuff winds up secured by the authentication sequence needs to include:
	auth sequence
	initial features
	final sequence number
	that side's identity.

7.
> From: Junwang Zhao <zhjwpku@gmail.com>
> My understanding is that before the protocol msgr2 begins, each party
> already has it's own secrete key, and it's public key has been known by
> it's peer, and they have alreay shared the session key that will be used
> by encryption/decryption.
> 
> The secrete key will be used by signature, and the public key will be
> used to identify.

2 main forms of encryption:
	symmetric:	single secret key known to both ends: used for
			both encryption & decrytion.
	public key:	2 keys: public & private.  public key can be shared,
			private key is knonw to only one end.
			a variety of algorithms including public key encryption,
			signing with the private key, or generating shared
			secrets.  In many cases the public key/private keys
			only used to derive or protect a secret key that is
			then used with ordinary symmetric encryption.

Ceph currently onhly does symmetric encryption.  So there are no public keys.
(cephx.  See,
	http://docs.ceph.com/docs/jewel/dev/cephx_protocol/	)

We'd like to do interesting things with public keys in the future.
So we want a sufficiently flexible algorithm that we can plug
such use in without redoing everything.

					-Marcus Watts
