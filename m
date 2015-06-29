From: Daniel Swarbrick <daniel.swarbrick@profitbricks.com>
Subject: Re: CRC32 of messages
Date: Mon, 29 Jun 2015 13:30:31 +0200
Message-ID: <mmra8n$ifi$1@ger.gmane.org>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>	<90559C83A9C7FA45B5846C975DFA612DDB4C4DC457@ABGEX73E.FSC.NET>	<CABZ+qqkjYQBQJEjHGA8xs78d59khNLf9oDjA0ORTpFG0QiGtTQ@mail.gmail.com> <CAC6JEv938Os5jcNoV08vQJ6tLnR8y1kKLHR_z1iNRHXitQkMmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43741 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513AbbF2Laq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Jun 2015 07:30:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Z9XGr-0007dX-EZ
	for ceph-devel@vger.kernel.org; Mon, 29 Jun 2015 13:30:41 +0200
Received: from 62.217.45.26 ([62.217.45.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 13:30:41 +0200
Received: from daniel.swarbrick by 62.217.45.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 13:30:41 +0200
In-Reply-To: <CAC6JEv938Os5jcNoV08vQJ6tLnR8y1kKLHR_z1iNRHXitQkMmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 29/06/15 12:51, Gregory Farnum wrote:
> 
> Yes, we have our own CRC32 checksum because loooong ago (before I
> started!) Sage saw a lot of network corruption that wasn't being
> caught by the TCP checksums so he added some to the Ceph message
> stream. I can't tell you with any authority whatsoever how common that
> problem is, but I don't think we're turning them off by default in
> upstream. :)

If the CRC32 implementation in Ceph is that dated (particularly the
software implementations that will be used on AMD hardware), would it be
worth checking out some of the updated implementations, such as the
slice-by-16 or chunked methods?

I found this link http://create.stephan-brumme.com/crc32/ and tried
running the benchmark on an AMD Opteron 6386 SE system, with the
following results:

bitwise          : CRC=221F390F, 47.525s, 21.546 MB/s
half-byte        : CRC=221F390F, 11.828s, 86.576 MB/s
  1 byte  at once: CRC=221F390F, 6.347s, 161.332 MB/s
  4 bytes at once: CRC=221F390F, 2.875s, 356.178 MB/s
  8 bytes at once: CRC=221F390F, 2.004s, 510.932 MB/s
4x8 bytes at once: CRC=221F390F, 1.929s, 530.811 MB/s
 16 bytes at once: CRC=221F390F, 1.892s, 541.179 MB/s
 16 bytes at once: CRC=221F390F, 1.926s, 531.797 MB/s (including
prefetching)
    chunked      : CRC=221F390F, 1.919s, 533.656 MB/s

AFAIK, Ceph uses the slice-by-8 method if no hardware crc32 is found.

