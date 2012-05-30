From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 13:25:25 +0200
Message-ID: <4FC603A5.2010806@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag> <CADdPHGuLAL5+hkzq0tigqu355DvPxkhE5sxBhOVZPj=EzDSVtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52853 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab2E3LZV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 07:25:21 -0400
In-Reply-To: <CADdPHGuLAL5+hkzq0tigqu355DvPxkhE5sxBhOVZPj=EzDSVtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2012 13:20, schrieb Stefan Majer:
> H,
> 
> 
> On Wed, May 30, 2012 at 1:04 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag <mailto:s.priebe@profihost.ag>> wrote:
> 
>     Am 30.05.2012 09:19, schrieb Stefan Majer:
>     > Hi,
>     >
>     > ok, so your replication level is 2 and you have 2*1GB/sec right ?
>     Generally yes - but for this new test it was just 1*1GB/s (see below).
> 
>     > do you have a iostat -x 3 output and or a dstat from all effected
>     > machines during your rados bench runs as well ?
> 
>     As the output looks exactly the same on all OSDs here is it from ONE
>     osd:
> 
>     Kernel 3.4:
>     http://pastebin.com/raw.php?i=sV9vKsWy
> 
> This is strange, looks like a real regression in 3.4 ? but i guess it is
> only possible to track down this by doing 
> git bisect on the kernel sources :-(
I also tried 3.3 and 3.2 it's the same... (haven't tested 3.1).

>     Kernel 3.0:
>     http://pastebin.com/raw.php?i=eafjpPpK
> 
> 
> Here you can see a constant rate to disk of ~ 50 - 70Mbyte/sec with
> about 10-15% utilization on  them. So this test is not disk bound i
> guess your network is saturated. Can you run dstat during this test as
> well to see the network bandwith used as well.
Absolutely correct. I'm aware of this. I just want to have this result
with 3.4 so that i can use btrfs.

Stefan
