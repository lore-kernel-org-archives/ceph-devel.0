From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 13:34:24 +0200
Message-ID: <4FC75740.8090404@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CADdPHGv0YjxDQFnZML-55jDj7XxHxaxUZ_FeQ=ReKK6Rs7NNhw@mail.gmail.com> <4FC725F0.9040207@profihost.ag> <CADdPHGtiTp8nK07O-6EiSd4k68TP_HQEa4_ZmOqV6zQrnhPo4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36903 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab2EaLe1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 07:34:27 -0400
In-Reply-To: <CADdPHGtiTp8nK07O-6EiSd4k68TP_HQEa4_ZmOqV6zQrnhPo4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, yehuda@inktank.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 31.05.2012 10:09, schrieb Stefan Majer:
> Hi Stefan,
>
> then you should probably describe this in a short mail to Jason Wang
> and ask him how to circumvent this commit with sysctl settings.

done hopefully he can help

> I=B4m pretty sure my sysctl setting reverts the first part of the
> commit. So probably the second part is the evil one ?
Yes it seems like that

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
