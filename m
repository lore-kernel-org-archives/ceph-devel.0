From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 10:09:28 +0200
Message-ID: <CADdPHGtiTp8nK07O-6EiSd4k68TP_HQEa4_ZmOqV6zQrnhPo4w@mail.gmail.com>
References: <4FBE415E.8030702@profihost.ag>
	<4FC54CDB.1000506@inktank.com>
	<4FC5BF27.5060704@profihost.ag>
	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>
	<4FC5C941.6010105@profihost.ag>
	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>
	<4FC5FEC1.90103@profihost.ag>
	<4FC60FC8.207@inktank.com>
	<4FC61596.3050703@profihost.ag>
	<4FC62BB0.1020003@inktank.com>
	<4FC66A1F.1080407@profihost.ag>
	<CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com>
	<4FC68CAA.9030708@profihost.ag>
	<CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com>
	<4FC7197D.5010406@profihost.ag>
	<CADdPHGv0YjxDQFnZML-55jDj7XxHxaxUZ_FeQ=ReKK6Rs7NNhw@mail.gmail.com>
	<4FC725F0.9040207@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f180.google.com ([209.85.160.180]:41179 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab2EaIJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 04:09:29 -0400
Received: by ghbz12 with SMTP id z12so671372ghb.11
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 01:09:28 -0700 (PDT)
In-Reply-To: <4FC725F0.9040207@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, yehuda@inktank.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

then you should probably describe this in a short mail to Jason Wang
and ask him how to circumvent this commit with sysctl settings.
I=B4m pretty sure my sysctl setting reverts the first part of the
commit. So probably the second part is the evil one ?

Greetings
Stefan

On Thu, May 31, 2012 at 10:04 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>
> Am 31.05.2012 09:27, schrieb Stefan Majer:
> > we have set them in /etc/sysctl.conf to:
> > net.ipv4.tcp_mem =3D 10000000 10000000 10000000
>
> This does not help ;-(
>
> > wow, this was fast !
> > if i understand this commit correct it simply skips a in-kernel
> > configuration of network related sysctl parameters, especialy
> > net.ipv4.tcp_mem
>
> I also tied this one:
> net.ipv4.tcp_rmem =3D 4096 524287 16777216
> net.ipv4.tcp_wmem =3D 4096 524287 16777216
> # grabbed values from 3.0.X
> net.ipv4.tcp_mem =3D 1162962 =A0 =A0 =A01550617 2325924
>
> still - no help -. But if i use 3.4 and revert the commit it works fi=
ne.
> But i wasn't able to find which other parts are influenced by this li=
mit
> while browsing through the source.
>
> I only found:
> net.ipv4.tcp_mem
> and
> net.ipv4.tcp_rmem
> and
> net.ipv4.tcp_wmem
>
> Greets
> Stefan




--
Stefan Majer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
