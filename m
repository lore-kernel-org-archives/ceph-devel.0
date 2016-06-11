From: Marcus Watts <mwatts@redhat.com>
Subject: Re: msgr2 protocol
Date: Sat, 11 Jun 2016 19:05:03 -0400
Message-ID: <20160611230503.GA18268@degu.eng.arb.redhat.com>
References: <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
 <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com>
 <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
 <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
 <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>
 <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>
 <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com>
 <20160610190510.GA18999@degu.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101658530.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbcFKXFH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 11 Jun 2016 19:05:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1606101658530.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Haomai Wang <haomai@xsky.com>, ceph-devel <ceph-devel@vger.kernel.org>

If the client doesn't look at "features" before it sends stuff, it
will not be able to be very smart about taking advantage of some
future better method.  In fact, there isn't much advantage
to the server sending anything early - it could just as easily
wait until after it's seen the clients request.

Failing hard & retrying on a failed reconnect is going to be slower.
On the bright side, at least it shouldn't happen often.

If you're sending encryption (w/ different auth or keys) from several
different streams, how are you planning to indicate which bits
go with which scheme?, and which bits are you planning to encrypt
and which not?  

Byte count limits.  Basically, you don't want collisions because
of duplicated keys or data.  This depends on your crypto system,
so, for instance, you should not encrypt with one key more than
	aes, cbc	about 2^68 bytes
	aes, ctr	exactly 2^128 bytes
more generally, this depends on mode, blocksize, ...
This applies across *all* uses of the key - and so you would
generally want to use the session key directly as little as possible.
(in particular, using the session key for ctr directly would be very very bad.)

If you've got multiple streams going already, you should be able
to include a fairly simple rekey method with little effort.
For instance, as part of the method, you could,
	up front as part of the method
		send a per-stream key encrypted under the shared secret.
	prepend to the first data sent in a payload
		byte limit, stream key #0 (encrypted under the per-stream key)
		then encrypt the next N bytes with stream key #0
	when the byte limit is reached, prepend to the
		next data sent in a payload
		byte limit, stream key #1 (encrypted under the per-stream key)
		then encrypt the next N bytes with stream key #1
	&etc.

					-Marcus Watts
