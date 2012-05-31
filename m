From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 16:42:01 +0200
Message-ID: <4FC78339.10900@univ-nantes.fr>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com> <4FC77045.6050907@univ-nantes.fr> <4FC77407.1050401@profihost.ag> <4FC775F3.8080109@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:34111 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752132Ab2EaOmH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 10:42:07 -0400
In-Reply-To: <4FC775F3.8080109@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Yehuda Sadeh <yehuda@inktank.com>, Stefan Majer <stefan.majer@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On 31/05/2012 15:45, Yann Dupont wrote:
> On 31/05/2012 15:37, Stefan Priebe - Profihost AG wrote:

> what puzzles me is that this morning, with 3.4.0 it was rbd that was
> stable, and now I have the exact contrary.
>
> I'll begin to reboot with old 3.4.0 kernel to see if things are
> reproductible.
>
> Cheers,


I'd say my problem is probably not related. Freshly rebooting all osd=20
nodes with 3.4.0 kernel (the same kernel I used this morning) now gives=
=20
pool data stable & rbd unstable. As with current git, and the exact=20
opposite of results I had tuesday & this morning.

Go figure.

Could it have to do with previous usage in OSD ? or active mds ? or mon=
 ?

As I already said, as my osd are using btrfs with big medata features,=20
so going back in 3.0 kernel need a complete reformat of my OSD before.

But I will do it if you judge it can bring some light on this case.

Cheers,
--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
