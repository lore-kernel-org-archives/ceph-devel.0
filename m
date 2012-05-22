From: =?ISO-8859-15?Q?=22SPONEM=2C_Beno=EEt=22?= <b.sponem@baclesse.fr>
Subject: Re: broken init script under debian squeeze
Date: Tue, 22 May 2012 12:09:31 +0200
Message-ID: <4FBB65DB.60501@baclesse.fr>
References: <4FBB64EF.70402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from maili2.baclesse.fr ([195.220.156.15]:45324 "EHLO
	S-RME2.baclesse.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751755Ab2EVKTU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 06:19:20 -0400
In-Reply-To: <4FBB64EF.70402@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Same issue for me under debian wheezy.

Greets,
Beno=EEt



Le 22/05/2012 12:05, Stefan Priebe - Profihost AG a =E9crit :
> Hi,
>
> the ceph init script seems to be broken - at least under debian lenny=
=2E
>
> It does simply nothing on a configured osd / mon server, so while sys=
tem
> start the daemons won't start. Ow do i have to configure the hostname=
 to
> match anything special in ceph.conf?
> [root@system123 /etc]# /etc/init.d/ceph start
> [root@system123 /etc]#
>
> option -a works fine (/etc/init.d/ceph -a start)
>
> Greets
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
