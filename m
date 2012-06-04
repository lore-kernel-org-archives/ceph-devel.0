From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 11:58:47 +0200
Message-ID: <4FCC86D7.1020203@univ-nantes.fr>
References: <4FCB1C0A.4050504@profihost.ag> <CADdPHGvgE7ai6yjzsKmL9bfqEpyx+qxQaUKoOOYjiT4ZCJ-A0g@mail.gmail.com> <4FCC7E34.7040005@univ-nantes.fr> <201206041147.22993.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:57793 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932124Ab2FDJ6y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 05:58:54 -0400
In-Reply-To: <201206041147.22993.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

Le 04/06/2012 11:47, Amon Ott a =E9crit :
> even libc6 in Debian experimental has syncfs() support.
>
> Also see thread "OSD deadlock with cephfs client and OSD on same mach=
ine"

Great , thanks for explanation.

=2E.. lots of tests to do this afternoon :) I need to convert my OSD wi=
th=20
xfs, benchmark with standard libc, then convert libc with your patch &=20
retest.

Thanks,
cheers,
--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
