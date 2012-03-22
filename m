From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Logging braindump
Date: Thu, 22 Mar 2012 11:29:03 -0700
Message-ID: <CAORUGqBQ=EKHfSFwRO65wLfJBRT4Oh=OFoXKdvG9uwYRisuJJA@mail.gmail.com>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
 <CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com> <4F6B6CB0.1000400@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43735 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab2CVS3Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 14:29:24 -0400
Received: by ghrr11 with SMTP id r11so2045316ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 11:29:24 -0700 (PDT)
In-Reply-To: <4F6B6CB0.1000400@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <Mark.Kampe@dreamhost.com>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 22, 2012 at 11:17, Mark Kampe <Mark.Kampe@dreamhost.com> wr=
ote:
> (a) I actually favor not simply mmaping the circular buffer,
> =C2=A0 =C2=A0but having a program that pulls the data out of memory
> =C2=A0 =C2=A0and writes it to disk (ala Varnish). =C2=A0In addition t=
o doing
> =C2=A0 =C2=A0huge writes (greatly reducing the write overhead), it ca=
n
> =C2=A0 =C2=A0filter what it processes, so that we have extensive logg=
ing
> =C2=A0 =C2=A0for the last few seconds, and more manageable logs on di=
sk
> =C2=A0 =C2=A0extending farther back in time (modulo log rotation).

varnishlog communicates via a mmap'ed ringbuffer. These are not in conf=
lict.

> (b) The most interesting logs are probably the ones in coredumps
> =C2=A0 =C2=A0(that didn't make it out to disk) for which we want a
> =C2=A0 =C2=A0crawler/extractor anyway. =C2=A0It probably isn't very h=
ard to
> =C2=A0 =C2=A0make the program that extracts logs from memory also be
> =C2=A0 =C2=A0able to pick the pockets of dead bodies (put a big self
> =C2=A0 =C2=A0identifying header on the front of each buffer).

A single memory area for this makes it easier.. that's why I like the
ringbuffer.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0If we are logging a lot, buffer management=
 has the potential
> =C2=A0 =C2=A0 =C2=A0 =C2=A0to become a bottle-neck ... so we need to =
be able to allocate
> =C2=A0 =C2=A0 =C2=A0 =C2=A0a record of the required size from the cir=
cular buffer
> =C2=A0 =C2=A0 =C2=A0 =C2=A0with atomic instructions (at least in non-=
wrap situations).
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0But if records are allocated and then fill=
ed, we have to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0consider how to handle the case where the =
filling is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0delayed, and the reader catches up with an=
 incomplete
> =C2=A0 =C2=A0 =C2=A0 =C2=A0log record (e.g. skip it, wait how long, ?=
??).
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0And while we hope this will never happen, =
we have to deal
> =C2=A0 =C2=A0 =C2=A0 =C2=A0with what happens when the writer catches =
up with the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reader, or worse, an incomplete log block =
=2E.. where we might
> =C2=A0 =C2=A0 =C2=A0 =C2=A0have to determine whether or not the owner=
 is deceased (making
> =C2=A0 =C2=A0 =C2=A0 =C2=A0it safe to break his record lock) ... or s=
hould we simply take
> =C2=A0 =C2=A0 =C2=A0 =C2=A0down the service at that point (on the ass=
umption that something
> =C2=A0 =C2=A0 =C2=A0 =C2=A0has gone very wrong).

The Disruptor design handles all these, is simple in the sense of
"that's what I would have built", and looks good.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
