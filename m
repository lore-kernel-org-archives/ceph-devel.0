From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 15:19:37 +0200
Message-ID: <4FC61E69.2030408@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag>	<4FC60FC8.207@inktank.com>	<4FC61596.3050703@profihost.ag> <CADdPHGsmr8Ht1pTWH1Oe8=NmAyM81SSdH+c_GV89D8ntfyUmgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36720 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab2E3NTd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 09:19:33 -0400
In-Reply-To: <CADdPHGsmr8Ht1pTWH1Oe8=NmAyM81SSdH+c_GV89D8ntfyUmgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2012 15:11, schrieb Stefan Majer:
> Hi,
> 
> I dont think seeks are a problem, because Stefan would see huge disk
> util percentage with iostat which is not the case.
> I guess the problem with 3.2 and greater is somewhere else for example
> in a network card driver which changed dramaticalle or something like that.

Can't beliebe that the e1000 driver is now so buggy - although iperf
still shows me around 950MBit/s no matter if 3.0, 3.2, ...

> Is it possible to to a git bisect, on that machine and do some runs,
> otherwise i see no point how to identify this.
I'm not familiar with git bisect so i can't answer this question

Stefan
