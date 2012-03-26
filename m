From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RadosGW problems with copy in s3
Date: Mon, 26 Mar 2012 15:05:40 +0200
Message-ID: <CAMwB3TiPaqbHRd5U4thDUfdg8ZGiuMwJPUh2E0vMoTvXu50YXg@mail.gmail.com>
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
	<CAC-hyiG_sRjF+RrRHyuhVudwAQYQVOPSJ64QY4NvbwPFKsaJow@mail.gmail.com>
	<-7040347706194281020@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58552 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546Ab2CZNFl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 09:05:41 -0400
Received: by wgbdr13 with SMTP id dr13so3866007wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 06:05:40 -0700 (PDT)
In-Reply-To: <-7040347706194281020@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

After some tests. PUT/GET/DELETE via Radosgw now in version 0.44 works
much better.

End of this topic.

Thanks.

2012/3/6 S=B3awomir Skowron <szibis@gmail.com>:
> On 6 mar 2012, at 18:53, Yehuda Sadeh Weinraub
> <yehuda.sadeh@dreamhost.com> wrote:
>
>> On Tue, Mar 6, 2012 at 2:08 AM, S=B3awomir Skowron <szibis@gmail.com=
> wrote:
>>
>>> All logs from osd.24, osd.62, and osd.36 with osd debug =3D20 and
>>> filestore debug =3D 20 from 2012-03-06 10:25 and more.
>>>
>>> http://217.144.195.170/ceph/osd.24.log.tar.gz =A0 (348MB) - machine=
 1 - rack1
>>> http://217.144.195.170/ceph/osd.36.log.tar.gz =A0 (26MB) - machine =
2 - rack 2
>>> http://217.144.195.170/ceph/osd.62.log.tar.gz =A0 (23MB) - machine3=
 - rack 3
>>>
>>
>> I looked at the logs, and it seems that you hit the tmap scaling
>> issue. Luckily we're fixing that for 0.44, so it's going to be fixed
>> in the next version.
>>
>> Yehuda
>
> That's wonderful news. Thanks for everything.
>
> Regards
> Slawomir Skowron



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
