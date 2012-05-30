From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 20:42:39 +0200
Message-ID: <4FC66A1F.1080407@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51102 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab2E3Smj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 14:42:39 -0400
In-Reply-To: <4FC62BB0.1020003@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

> Specifically, the gap in the movie where there is no write activity
> around second 30 correlates in the blktrace results with one of these
> stalls:
>> 8,16 0 0 29.548567957 0 m N cfq schedule dispatch
>> 8,16 2 2185 34.548923918 2688 A W 2192 + 8 <- (8,17) 144
>
> As to why this is happening, I don't know yet. I'll have more later.
Should i try the bisect thing?

Stefan
