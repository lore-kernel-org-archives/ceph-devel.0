From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: RadosGW problems with copy in s3
Date: Tue, 6 Mar 2012 09:53:10 -0800
Message-ID: <CAC-hyiG_sRjF+RrRHyuhVudwAQYQVOPSJ64QY4NvbwPFKsaJow@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
	<CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
	<CAMwB3ThZ4jPis_Bb9tsf=HTnh3gLd6CNkn2XMr4xo09bO3hEiQ@mail.gmail.com>
	<CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
	<CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
	<CAMwB3Tje2tgruL8yP29Q1eYTON5kuS3neetA=6zXed4OriJefg@mail.gmail.com>
	<CAC-hyiHFUAGWJf1MxGS=MBcdsHSYrtpjcPo6di3MOK=S=6Hj0g@mail.gmail.com>
	<CAMwB3TjuDhRfTheJvTKx7yiTy7JSiTp2h795fuNS-mjFeJP=Fg@mail.gmail.com>
	<CAMwB3Tg3e7dKpves54sFag6BTp5PAfYwOgYQ4PHW0gs2oDkTJw@mail.gmail.com>
	<CAC-hyiFkVyUHA1mthYaSVoqxQSrz5g2zo1kmLQAfDanzAxjH1A@mail.gmail.com>
	<-8255131364718062163@unknownmsgid>
	<CAMwB3Tjftbdh9kxMgxkU9-vEmyxj2X4b4a0o2HC_e=7xXZ6RMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59930 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab2CFRxK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Mar 2012 12:53:10 -0500
Received: by vbbff1 with SMTP id ff1so4691931vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Mar 2012 09:53:10 -0800 (PST)
In-Reply-To: <CAMwB3Tjftbdh9kxMgxkU9-vEmyxj2X4b4a0o2HC_e=7xXZ6RMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 6, 2012 at 2:08 AM, S=C5=82awomir Skowron <szibis@gmail.com=
> wrote:

> All logs from osd.24, osd.62, and osd.36 with osd debug =3D20 and
> filestore debug =3D 20 from 2012-03-06 10:25 and more.
>
> http://217.144.195.170/ceph/osd.24.log.tar.gz =C2=A0 (348MB) - machin=
e 1 - rack1
> http://217.144.195.170/ceph/osd.36.log.tar.gz =C2=A0 (26MB) - machine=
 2 - rack 2
> http://217.144.195.170/ceph/osd.62.log.tar.gz =C2=A0 (23MB) - machine=
3 - rack 3
>

I looked at the logs, and it seems that you hit the tmap scaling
issue. Luckily we're fixing that for 0.44, so it's going to be fixed
in the next version.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
