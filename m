From: Sage Weil <sage@newdream.net>
Subject: Re: msgr2 protocol
Date: Fri, 10 Jun 2016 06:48:33 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606100637310.6221@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com> <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com> <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com> <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com> <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com> <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com> <CACJqLya8rdipTW9hAikgyyDAWTFeTuqOizvDQSY88L_QnzeKFQ@mail.gmail.com>
 <CAEG8a3KKtw122rY1kt3DMw_9y87ivK7FO1h0LbhoWn05mUD8Tg@mail.gmail.com> <20160610083145.GD23426@degu.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33565 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcFJKsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 06:48:07 -0400
In-Reply-To: <20160610083145.GD23426@degu.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Junwang Zhao <zhjwpku@gmail.com>, Haomai Wang <haomai@xsky.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I forgot to address this in the last message:

On Fri, 10 Jun 2016, Marcus Watts wrote:
> 2.
> session handshake & message exchange
> w/ confounder >= block_size, cbc-cts -- there's no need to send pad bytes.
> 	[ cts, ciphertext stealing, is a simple modification of cbc to
> 	not send some bytes which turn out to to be unnecessary; does
> 	not hurt security, see
> 		https://en.wikipedia.org/wiki/Ciphertext_stealing	]

If we knew that we would always know when the end of a payload was 
coming before we got to that last encryption block, we could skip the 
padding, but it would be complex and fragile.  The key requirement is 
that we want to be able to flush data over the wire and have the 
other end process it at any message boundary.  And the receiver would 
need to know that it should do it's ciphertext stealing thing when it has 
only read a fraction of that last block off the wire.

IMO just specifying the block_size as an auth method attributes simplifies 
everything: we don't have to write code to do the ciphertext stealing, and 
we can more or less blindly read data off the wire in chunks that we know 
can be decrypted.  It costs a few extra bytes, per frame, but I think the 
performance and simplicity win is more than worth it.

sage
