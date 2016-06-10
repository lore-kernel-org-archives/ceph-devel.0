From: Marcus Watts <mwatts@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 10 Jun 2016 15:05:10 -0400
Message-ID: <20160610190510.GA18999@degu.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
 <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
 <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com>
 <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
 <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
 <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>
 <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>
 <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42852 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcFJTFO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 15:05:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Haomai Wang <haomai@xsky.com>, ceph-devel <ceph-devel@vger.kernel.org>

I'm going to try to respond to several messages with this one message...

1. bitmask
2. authentication.
3. final sequence
4. confounder
5. encryption per message or per connection?

____ 1. bitmask
banner phase - bitmask.

hex digits will work fine for the protocol - but
can't just use %llx %llx for parsing - when parsing for required, should
reject for any non-zero hex digits above word size; for supported should
ignore hex digits above word size.

____ 2. authentication.
We're already talking about 2 methods:
"initial connect"
"reconnect".
the client doesn't know when it tries to reconnect if the
server will accept a reconnect.  being able to say :
	c->s
		continue: reconnect
		continue: new_connect: phase 1
then either
	s->c
		accept: reconnect
or
	s->c
		reject: reconnect: no data
		continue: new connect phase 2

means 1 fewer round trips.

if the ident & feature exchange can be done at the same time (being
careful to make sure they're part of the signing process) I think that's
a further win.

Optimizing round trips is particularly important for high latency
connections.

I don't think the client has any business sending
a "set method" message before it sees the server's
"banner" - so there's already another round trip there.

____ 3. final sequence
"final sequence"
sorry, bad wording.
for a reconnect: last sequence number from previous connection.
(for a new connect after a reconnect: probably the client should be
setting this to its remembered last value even if the server doesn't
remember that value.)

____ 4. confounder
(but see next point too)
The confounder is really a lower-level feature of the encryption.
So it has to be per-message.  It needs to be part of the message hash,
but should not be visible past that.  With cbc mode, encryption looks like;
	given plaintext p[0..n]
	to encrypt,
		c[0] = e(p[0])
		c[n] = e(c[n-1] ^ p[n])
	to decrypt,
		p[0] = d(c[0])
		p[n] = d(c[n]) ^ c[n^1]
by making p[0] be a "random" value - that ensures for each
message all c[n] are likely unique, including the hash.
If p[0] were a set value, then c[0]
becomes a fixed value and further values of c[x] become
more deterministic as well.  That allows a bad guy to build up
a dictionary of p[x] -> c[x] even without knowing the key,
and we really don't want to give bad guys that capability.

____ 5. encryption per message or per connection?

You're thinking of doing encryption over the entire byte stream
not having framing outside.  Ah!.  Interesting...
Well, you certainly don't need extra confounders past the start
of your encryption.  That can be (more or less) a one time thing.
You will definitely need some sort of block flushing/padding
thing between messages.  I imagine you'll want something like:
	size message hash(size+message) padding-to-block
And you will want to have some sort of notion
that such connections are size limited - "do not encrypt more than N
bytes on a connection".  You probably should have some sort of
"new key every N bytes" notion over smaller byte ranges in addition.
(wouldn't hurt to do a new confounder for each new key too.)

					-Marcus Watts
