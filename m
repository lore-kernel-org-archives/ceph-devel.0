From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 14:18:59 +0200
Message-ID: <4FC761B3.1090200@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CADdPHGv0YjxDQFnZML-55jDj7XxHxaxUZ_FeQ=ReKK6Rs7NNhw@mail.gmail.com> <4FC725F0.9040207@profihost.ag> <CADdPHGtiTp8nK07O-6EiSd4k68TP_HQEa4_ZmOqV6zQrnhPo4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37177 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895Ab2EaMTB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 08:19:01 -0400
In-Reply-To: <CADdPHGtiTp8nK07O-6EiSd4k68TP_HQEa4_ZmOqV6zQrnhPo4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, yehuda@inktank.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark, Hi Stefan,

i found a way to solve it by comparing /proc/sys/net with an patched and 
an unpatched kernel.

Strangely the problem occours when the values are too big (in new kernel).

With the smaller values everything works fine even under 3.4. Any ideas 
how that can be? I thought these values should be tuned to a maximum for 
max performance.

- => old kernel
+ => new kernel

-/proc/sys/net/ipv4/tcp_rmem:4096       87380   6291456
+/proc/sys/net/ipv4/tcp_rmem:4096       87380   514873
-/proc/sys/net/ipv4/tcp_wmem:4096       16384   4194304
+/proc/sys/net/ipv4/tcp_wmem:4096       16384   514873


Stefan
