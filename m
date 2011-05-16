From: Sage Weil <sage@newdream.net>
Subject: Re: rbd create error with 0.26
Date: Sun, 15 May 2011 21:33:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105152130240.21842@cobra.newdream.net>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
 <BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
 <BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
 <BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
 <BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
 <BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com>
 <BANLkTikPk32SMy0-bNrto8+6tSajciZ4pw@mail.gmail.com>
 <Pine.LNX.4.64.1105130854110.12286@cobra.newdream.net>
 <BANLkTimr+Ov=s=He5eKFmb6QFspDU=YmHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-115531924-1305520403=:21842"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52705 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1EPEcX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2011 00:32:23 -0400
In-Reply-To: <BANLkTimr+Ov=s=He5eKFmb6QFspDU=YmHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-115531924-1305520403=:21842
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 15 May 2011, Simon Tian wrote:
> > What is the IO size? =A0Is write_test_data synchronous?
> >
> > For simple write benchmarking you can also use
> > =A0 =A0 =A0 =A0rados mkpool foo
> > =A0 =A0 =A0 =A0rados -p foo bench <seconds> write -b <blocksize> -t <th=
reads>
> >
> > and you'll see latency and throughput. =A0Blocksize defaults to 4M and
> > "threads" (parallel IOs) default to 16, IIRC.
>=20
>=20
> Hi, Sage:
>=20
> I just did the bench:
> rados -p rbd bench 60 write -t 64 =A0 and =A0 =A0rados -p data bench 60 w=
rite -t 64
> the avg throughput is about 46MB/s, one of the result is as follow.
> But why it's slow with rbd api from <rbd/librbd.h>?

The problem is that your test is only doing a single IO at a time.  The=20
request latency is relatively high because the data has to pass over the=20
network to the OSD (and, for writes, do it again to be replicated), so=20
the client node spends a lot of time waiting around.  The rados tool, by=20
default, keeps 16 concurrent IOs in flight.

You'll want to look at the async (aio) read/write calls, or use multiple=20
threads.

sage


> And I tried testlibrbdpp.cc, the result is more or less the same.
> The attachments are the test codes. Could you run it on your platform ple=
ase?
>=20
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0last la=
t =A0 avg lat
> =A0 40 =A0 =A0 =A063 =A0 =A0 =A0 482 =A0 =A0 =A0 419 =A0 41.8884 =A0 =A0 =
=A0 =A044 =A0 2.40044 =A0 2.40979
> =A0 41 =A0 =A0 =A063 =A0 =A0 =A0 494 =A0 =A0 =A0 431 =A0 42.0372 =A0 =A0 =
=A0 =A048 =A0 2.11044 =A0 =A0 2.406
> =A0 42 =A0 =A0 =A064 =A0 =A0 =A0 506 =A0 =A0 =A0 442 =A0 42.0837 =A0 =A0 =
=A0 =A044 =A0 2.11266 =A0 2.40229
> =A0 43 =A0 =A0 =A063 =A0 =A0 =A0 518 =A0 =A0 =A0 455 =A0 42.3139 =A0 =A0 =
=A0 =A052 =A0 2.33468 =A0 =A02.3982
> =A0 44 =A0 =A0 =A063 =A0 =A0 =A0 527 =A0 =A0 =A0 464 =A0 42.1703 =A0 =A0 =
=A0 =A036 =A0 =A02.4403 =A0 2.39559
> =A0 45 =A0 =A0 =A063 =A0 =A0 =A0 539 =A0 =A0 =A0 476 =A0 42.2995 =A0 =A0 =
=A0 =A048 =A0 2.19768 =A0 2.39413
> =A0 46 =A0 =A0 =A063 =A0 =A0 =A0 551 =A0 =A0 =A0 488 =A0 42.4232 =A0 =A0 =
=A0 =A048 =A0 2.51232 =A0 =A02.3928
> =A0 47 =A0 =A0 =A063 =A0 =A0 =A0 563 =A0 =A0 =A0 500 =A0 42.5416 =A0 =A0 =
=A0 =A048 =A0 2.18025 =A0 2.38958
> =A0 48 =A0 =A0 =A063 =A0 =A0 =A0 572 =A0 =A0 =A0 509 =A0 42.4051 =A0 =A0 =
=A0 =A036 =A0 2.27111 =A0 2.38791
> =A0 49 =A0 =A0 =A063 =A0 =A0 =A0 584 =A0 =A0 =A0 521 =A0 =A042.519 =A0 =
=A0 =A0 =A048 =A0 2.41684 =A0 2.38695
> =A0 50 =A0 =A0 =A063 =A0 =A0 =A0 596 =A0 =A0 =A0 533 =A0 42.6284 =A0 =A0 =
=A0 =A048 =A0 2.11087 =A0 =A0 2.384
> =A0 51 =A0 =A0 =A063 =A0 =A0 =A0 608 =A0 =A0 =A0 545 =A0 42.7335 =A0 =A0 =
=A0 =A048 =A0 2.18147 =A0 2.37925
> =A0 52 =A0 =A0 =A063 =A0 =A0 =A0 620 =A0 =A0 =A0 557 =A0 42.8345 =A0 =A0 =
=A0 =A048 =A0 2.45287 =A0 2.37787
> =A0 53 =A0 =A0 =A063 =A0 =A0 =A0 629 =A0 =A0 =A0 566 =A0 42.7054 =A0 =A0 =
=A0 =A036 =A0 2.45187 =A0 2.37801
> =A0 54 =A0 =A0 =A063 =A0 =A0 =A0 644 =A0 =A0 =A0 581 =A0 43.0255 =A0 =A0 =
=A0 =A060 =A0 2.22403 =A0 2.37477
> =A0 55 =A0 =A0 =A063 =A0 =A0 =A0 653 =A0 =A0 =A0 590 =A0 42.8976 =A0 =A0 =
=A0 =A036 =A0 2.22782 =A0 2.37157
> =A0 56 =A0 =A0 =A063 =A0 =A0 =A0 668 =A0 =A0 =A0 605 =A0 43.2026 =A0 =A0 =
=A0 =A060 =A0 2.20638 =A0 2.36597
> =A0 57 =A0 =A0 =A063 =A0 =A0 =A0 677 =A0 =A0 =A0 614 =A0 43.0761 =A0 =A0 =
=A0 =A036 =A0 2.19628 =A0 2.36209
> =A0 58 =A0 =A0 =A063 =A0 =A0 =A0 689 =A0 =A0 =A0 626 =A0 43.1608 =A0 =A0 =
=A0 =A048 =A0 2.18262 =A0 2.35762
> =A0 59 =A0 =A0 =A063 =A0 =A0 =A0 704 =A0 =A0 =A0 641 =A0 43.4459 =A0 =A0 =
=A0 =A060 =A0 2.27029 =A0 2.35352
> min lat: 1.87981 max lat: 5.56194 avg lat: 2.34944
> =A0sec Cur ops =A0 started =A0finished =A0avg MB/s =A0cur MB/s =A0last la=
t =A0 avg lat
> =A0 60 =A0 =A0 =A063 =A0 =A0 =A0 716 =A0 =A0 =A0 653 =A0 43.5215 =A0 =A0 =
=A0 =A048 =A0 2.27835 =A0 2.34944
> =A0 61 =A0 =A0 =A064 =A0 =A0 =A0 717 =A0 =A0 =A0 653 =A0 =A042.808 =A0 =
=A0 =A0 =A0 0 =A0 =A0 =A0 =A0 - =A0 2.34944
> =A0 62 =A0 =A0 =A063 =A0 =A0 =A0 717 =A0 =A0 =A0 654 =A0 42.1821 =A0 =A0 =
=A0 =A0 2 =A0 2.25694 =A0 2.34929
> Total time run: =A0 =A0 =A0 =A062.274719
> Total writes made: =A0 =A0 717
> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
> Bandwidth (MB/sec): =A0 =A046.054
>=20
> Average Latency: =A0 =A0 =A0 5.453
> Max latency: =A0 =A0 =A0 =A0 =A0 62.0339
> Min latency: =A0 =A0 =A0 =A0 =A0 1.87981
> N?????r??y???b?X??=FF=FFv?^?)=FF=FF{.n?+???z?]z?{ay?=1D=FF=FF=FF=FF?,j=07=
??f???h???z?=1E?w???=0C???j:+v???w?j?m????=07????zZ+?????=FF=FFj"??!?i
--557981400-115531924-1305520403=:21842--
