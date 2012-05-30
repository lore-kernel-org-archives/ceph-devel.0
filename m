From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 23:10:02 +0200
Message-ID: <4FC68CAA.9030708@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51053 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab2E3VKD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 17:10:03 -0400
In-Reply-To: <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2012 20:47, schrieb Stefan Majer:

>  From my perspective marks hints regarding blktrace end up in the same
> summary as the iostat ouput gives.
> You see stalls, not induced by disk by any means, no other obvious hints
> where the lag might come from.
> So if you want to know why kernels > 3.2 are slow for your workload i
> would drill down this with git bisect.

OK here are some tests regarding the kernel version - all made with XFS.

Starting with 3.2.0-rc1 it drops from 164MB/s (bonding) to 119MB/s but 
it never goes down to 0MB/s. 3.2.18 shows the same as 3.2-rc1.

Then with 3.3-rc1 i'm seeing even faster speed (178MB/s) than with 3.0.X 
- so everything is fine again. So it seems 3.2.X had another bug which 
reduced the speed which was fixed in 3.3.

Beginning with 3.3-rc4 it get's bad with drops to 0MB/s. So it should be 
a commit between 3.3-rc3 and 3.3-rc4. Sadly this are 370 commits. No 
idea where to start.

Stefan
