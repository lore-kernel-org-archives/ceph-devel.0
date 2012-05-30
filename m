From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 14:41:58 +0200
Message-ID: <4FC61596.3050703@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60048 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab2E3Mlx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 08:41:53 -0400
In-Reply-To: <4FC60FC8.207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

didn't had the time to answer your mails - but i will get on this one first.

> Would you mind installing blktrace and running "blktrace -o test-3.4 -d
> /dev/sdb" on the OSD node during a short (say 60s) test on 3.4?
sure no problem.

here it is:
http://www.mediafire.com/?6cw87btn7mzco25

Output:
=== sdb ===
  CPU  0:                18075 events,      848 KiB data
  CPU  1:                10738 events,      504 KiB data
  CPU  2:                 8639 events,      405 KiB data
  CPU  3:                 8614 events,      404 KiB data
  CPU  4:                    0 events,        0 KiB data
  CPU  5:                    0 events,        0 KiB data
  CPU  6:                  143 events,        7 KiB data
  CPU  7:                    0 events,        0 KiB data
  Total:                 46209 events (dropped 0),     2167 KiB data

> If you could archive/send me the results, that might help us get an idea
> of what is actually getting sent out to the disk.  Your data disk
> throughput on 3.0 looks pretty close to what I normally get (including
> on 3.4).  I'm guessing the issue you are seeing on 3.4 is probably not
> the seek problem I mentioned earlier (unless something is causing so
> many seeks that it more or less paralyzes the disk).
As i have a SSD i can't believe seeks can be a problem.

Stefan
