From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Fri, 06 Jul 2012 17:35:22 +0200
Message-ID: <4FF705BA.4080501@univ-nantes.fr>
References: <4FF6A27B.7020808@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:38019 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755971Ab2GFPf1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 11:35:27 -0400
In-Reply-To: <4FF6A27B.7020808@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Le 06/07/2012 10:31, Yann Dupont a =E9crit :
> Hello.
>
> Bug happens in rbd client, at least in Kernel 3.4.4 . I have a=20
> completely reproductible bug.
just a note : 3.2.22 doesn't seems to exhibit the problem. I repeated=20
the process 2 times without problems on this kernel.

I'll launch realistic load on our ceph volume this week end (bacula=20
backups). I'll see if 3.2.22 is solid.

Then monday or tuesday I'll take the git bisect route to see which patc=
h=20
introduced the problem.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
