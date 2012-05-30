From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 15:51:05 +0200
Message-ID: <4FC625C9.3070701@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62038.7080205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55642 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab2E3NvD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 09:51:03 -0400
In-Reply-To: <4FC62038.7080205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2012 15:27, schrieb Mark Nelson:
> Great, thanks.  I'll try to look at the results later this morning.  If
> you want to look at them yourself you can open them with the blkparse
> program (and seekwatcher too, though there is a bug in the src you have
> to fix to make it work right)
I've no idea about blkparse and seekwatcher - so i don't know what i
should do with the output...

>>> If you could archive/send me the results, that might help us get an idea
>>> of what is actually getting sent out to the disk.  Your data disk
>>> throughput on 3.0 looks pretty close to what I normally get (including
>>> on 3.4).  I'm guessing the issue you are seeing on 3.4 is probably not
>>> the seek problem I mentioned earlier (unless something is causing so
>>> many seeks that it more or less paralyzes the disk).
>> As i have a SSD i can't believe seeks can be a problem.
> 
> Ah, sorry. I  forgot you were on SSD.  Honestly I'm surpised that with
> 3.0 you weren't getting better performance.  Something to look into once
> we figure out why your 3.4 performance is so bad!
Yes i think this is another problem.

Stefan
