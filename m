From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 09:16:17 +0200
Message-ID: <4FC5C941.6010105@profihost.ag>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57645 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab2E3HQO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 03:16:14 -0400
In-Reply-To: <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2012 09:01, schrieb Stefan Majer:
> Hi Stefan,
> 
> what is your replication factor ? If it set to 2 and your osds have a
> single 1GB/sec link you never will see more than 120MB/sec i suspect
> much less because every write have to go to the same wire twice from
> each osd.
Sure - but right now i see 10MB/s with kernel 3.4 and 170MB/s with
3.0.30 using bonded 2x 1Gbit/s links.

Stefan
