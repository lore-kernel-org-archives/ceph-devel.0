From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 15:54:35 +0200
Message-ID: <4FC6269B.20401@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag>	<4FC60FC8.207@inktank.com>	<4FC61596.3050703@profihost.ag>	<CADdPHGsmr8Ht1pTWH1Oe8=NmAyM81SSdH+c_GV89D8ntfyUmgA@mail.gmail.com>	<4FC61E69.2030408@profihost.ag> <CADdPHGvxCmuViy+0==Vkdz_QjC1K+kD5kD1m7+0tYM2YDTtJbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:38482 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab2E3Nyd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 09:54:33 -0400
In-Reply-To: <CADdPHGvxCmuViy+0==Vkdz_QjC1K+kD5kD1m7+0tYM2YDTtJbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2012 15:38, schrieb Stefan Majer:
> There is a small howto from linus:
> http://kerneltrap.org/node/11753
> 
> you basically need to be able to compile the kernel from source and
> start in the freshly checked out source 
> git bisect good v3.0
> git bisect bad v3.2
>  
> Then git will pick a version inbetween an you can compile this, depoy it
> to your machine an look if it good or bad.
> Then tell git if it was bad or good and git will again choose a version
> between both versions. So you will get a single commit or a handful of
> commits which are probably the cause of the problem.
Thanks will try that after mark has looked into the blktrace ;-)

Thanks,
Stefan
