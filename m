From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: RadosGW problems with copy in s3
Date: Wed, 29 Feb 2012 11:44:16 -0800
Message-ID: <CAC-hyiHFUAGWJf1MxGS=MBcdsHSYrtpjcPo6di3MOK=S=6Hj0g@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
	<CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
	<CAMwB3ThZ4jPis_Bb9tsf=HTnh3gLd6CNkn2XMr4xo09bO3hEiQ@mail.gmail.com>
	<CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
	<CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
	<CAMwB3Tje2tgruL8yP29Q1eYTON5kuS3neetA=6zXed4OriJefg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61169 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab2B2ToR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 14:44:17 -0500
Received: by bkcik5 with SMTP id ik5so2678748bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Feb 2012 11:44:16 -0800 (PST)
In-Reply-To: <CAMwB3Tje2tgruL8yP29Q1eYTON5kuS3neetA=6zXed4OriJefg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 29, 2012 at 5:06 AM, S=C5=82awomir Skowron
<slawomir.skowron@gmail.com> wrote:
>
> Ok, it's intentional.
>
> We are checking meta info about files, then, checking md5 of file
> content. In parallel, updating object that have change, and then
> archiving this objects in another key, and last thing is deleting
> objects that expires.
>
> This happens over and over, because, this site is changing many times=
=2E
>
> Now i don't have any idea, how to workaround this problem, without
> shutdown this app :(

I looked at your osd log again, and there are other things that don't
look right. I'll also need you to turn on 'debug osd =3D 20' and 'debug
filestore =3D 20'.
Other than that, I just pushed a workaround that might improve things.
It's on the wip-rgw-atomic-no-retry branch on github (based on
0.42.2), so you might want to give it a spin and let us know whether
it actually improved things.


>
> Another question is, why data from radosgw writing almost everything
> only on one osd, and copies to 2 others, and only those. Is anyone ca=
n
> explain this to me ??
>
> /dev/sdu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.18
> /dev/sdw =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
08M =C2=A0260G =C2=A0 1% /vol0/data/osd.21
> /dev/sdz =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
38M =C2=A0260G =C2=A0 1% /vol0/data/osd.24
> /dev/sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.3
> /dev/sdr =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.16
> /dev/sdaa =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 275G =C2=A0696M =C2=
=A0260G =C2=A0 1% /vol0/data/osd.25
> /dev/sdp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.14
> /dev/sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.2
> /dev/sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.8
> /dev/sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
08M =C2=A0260G =C2=A0 1% /vol0/data/osd.6
> /dev/sds =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.17
> /dev/sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
38M =C2=A0260G =C2=A0 1% /vol0/data/osd.4
> /dev/sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
37M =C2=A0260G =C2=A0 1% /vol0/data/osd.9
> /dev/sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
04M =C2=A0260G =C2=A0 1% /vol0/data/osd.1
> /dev/sdv =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A02=
=2E7G =C2=A0258G =C2=A0 2% /vol0/data/osd.20
> /dev/sdn =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
07M =C2=A0260G =C2=A0 1% /vol0/data/osd.12
> /dev/sdo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.13
> /dev/sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.5
> /dev/sdy =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
33M =C2=A0260G =C2=A0 1% /vol0/data/osd.23
> /dev/sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.11
> /dev/sdx =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.22
> /dev/sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
08M =C2=A0260G =C2=A0 1% /vol0/data/osd.0
> /dev/sdq =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.15
> /dev/sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.10
> /dev/sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
05M =C2=A0260G =C2=A0 1% /vol0/data/osd.7
> /dev/sdt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A06=
04M =C2=A0260G =C2=A0 1% /vol0/data/osd.19
>
That's probably because you're overwriting the same object over and
over. When you do that the old object is still being kept so that any
pending readers may complete reading it. You should run a maintenance
utility in order to remove those (radosgw-admin temp remove --date=3D..
to remove all temp objects that were created before a specific date).

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
