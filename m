From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 14:33:08 +0200
Message-ID: <4FC76504.7040807@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com> <CADdPHGtz9Jq624DMO6Dve2AcJ9vrnFHbyqRa+qheA+0-y4k++g@mail.gmail.com> <4FC76496.9020001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55907 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565Ab2EaMdL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 08:33:11 -0400
In-Reply-To: <4FC76496.9020001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Majer <stefan.majer@gmail.com>, Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org

Am 31.05.2012 14:31, schrieb Mark Nelson:
> Hi Stefan,
>
> Please do share! I was planning on starting out on the wiki and
> eventually getting these kinds of things into the master docs. If you
> (and others) have already done testing it would be really interesting to
> compare experiences. So far I've been just kind of throwing stuff into:
>
> http://ceph.com/wiki/Performance_analysis
>
> In it's current form it's pretty inadequate, but I'm hoping to
> eventually get back to it. A lot of the work I've been doing recently is
> looking at underlying FS write behavior (specifically seeks) and if we
> can get any reasonable improvement through mkfs and mount options.

At least i'll start sharing when i've a fine running system ;-) I plan 
to switch to 10Gbe next week.

Stefan
