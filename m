From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 18:37:05 +0200
Message-ID: <4FC79E31.3090200@univ-nantes.fr>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com> <4FC77045.6050907@univ-nantes.fr> <4FC77407.1050401@profihost.ag> <4FC775F3.8080109@univ-nantes.fr>
 <4FC78339.10900@univ-nantes.fr> <4FC78EFF.1090206@inktank.com> <4FC79193.1000604@univ-nantes.fr> <Pine.LNX.4.64.1205310928550.28422@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:52255 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752132Ab2EaQhK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:37:10 -0400
In-Reply-To: <Pine.LNX.4.64.1205310928550.28422@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Yehuda Sadeh <yehuda@inktank.com>, Stefan Majer <stefan.majer@gmail.com>, ceph-devel@vger.kernel.org

Le 31/05/2012 18:29, Sage Weil a =E9crit :

> Can you post 'ceph osd dump | grep ^pool' so we can see which CRUSH r=
ules
> the pools are mapped to?
>

yes :

root@label5:~# ceph osd dump | grep ^pool
pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 57=
6=20
pgp_num 576 last_change 816 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_nu=
m=20
576 pgp_num 576 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 576=
=20
pgp_num 576 last_change 1 owner 0

cheers,


--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
