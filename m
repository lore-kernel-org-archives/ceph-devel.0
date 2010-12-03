From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Fri, 3 Dec 2010 09:48:23 -0700
Message-ID: <1291394903.4879.206.camel@sale659.sandia.gov>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
 <1291323999.4879.198.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:41192 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab0LCQsc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Dec 2010 11:48:32 -0500
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 11B3E47CACC
	for <ceph-devel@vger.kernel.org>; Fri,  3 Dec 2010 09:48:26 -0700 (MST)
In-Reply-To: <1291323999.4879.198.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've got a testing update on this...

On Thu, 2010-12-02 at 14:06 -0700, Jim Schutt wrote:
> 
> Hi,
> 
> On Thu, 2010-12-02 at 12:41 -0700, Jim Schutt wrote:
> > If poll() says a socket is ready for reading, but zero bytes
> > are read, that means that the peer has sent a FIN.  Handle that.
> >
> > One way the incorrect handling was manifesting is as follows:
> >
> > Under a heavy write load, clients log many messages like this:
> >
> > [19021.523192] libceph:  tid 876 timed out on osd6, will reset osd
> > [19021.523328] libceph:  tid 866 timed out on osd10, will reset osd
> > [19081.616032] libceph:  tid 841 timed out on osd0, will reset osd
> > [19081.616121] libceph:  tid 826 timed out on osd2, will reset osd
> > [19081.616176] libceph:  tid 806 timed out on osd3, will reset osd
> > [19081.616226] libceph:  tid 875 timed out on osd9, will reset osd
> > [19081.616275] libceph:  tid 834 timed out on osd12, will reset osd
> > [19081.616326] libceph:  tid 874 timed out on osd10, will reset osd
> >
> > After the clients are done writing and the file system should
> > be quiet, osd hosts have a high load with many active threads:
> >
> > $ ps u -C cosd
> > USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME
> COMMAND
> > root      1383  162 11.5 1456248 943224 ?      Ssl  11:31
> 406:59 /usr/bin/cosd -i 7 -c /etc/ceph/ceph.conf
> >
> > $ for p in `ps -C cosd -o pid --no-headers`; do grep -nH
> State /proc/$p/task/*/status | grep -v sleep; done
> > /proc/1383/task/10702/status:2:State:   R (running)
> > /proc/1383/task/10710/status:2:State:   R (running)
> > /proc/1383/task/10717/status:2:State:   R (running)
> > /proc/1383/task/11396/status:2:State:   R (running)
> > /proc/1383/task/27111/status:2:State:   R (running)
> > /proc/1383/task/27117/status:2:State:   R (running)
> > /proc/1383/task/27162/status:2:State:   R (running)
> > /proc/1383/task/27694/status:2:State:   R (running)
> > /proc/1383/task/27704/status:2:State:   R (running)
> > /proc/1383/task/27728/status:2:State:   R (running)
> >
> > With this fix applied, a heavy load still causes many client
> > resets of osds, but no runaway threads result.
> 
> Hmmm, no runaway threads, but harder testing with
>   dd conv=fdatasync
> has at least one of my clients stuck -- not sure
> if this patch caused the issue or exposed something
> else:
> 
> [  982.608021] libceph:  tid 183 timed out on osd10, will reset osd
> [  982.608119] libceph:  tid 114 timed out on osd12, will reset osd
> [  982.608179] libceph:  tid 179 timed out on osd11, will reset osd
> [  982.608237] libceph:  tid 162 timed out on osd1, will reset osd
> [  982.608300] libceph:  tid 169 timed out on osd0, will reset osd
> [  982.608357] libceph:  tid 204 timed out on osd4, will reset osd
> [  982.608414] libceph:  tid 159 timed out on osd9, will reset osd
> [ 1042.704025] libceph:  tid 114 timed out on osd12, will reset osd
> [ 1042.704072] libceph:  tid 174 timed out on osd1, will reset osd
> [ 1080.602058] INFO: task dd:3545 blocked for more than 120 seconds.
> [ 1080.602063] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1080.602067] dd            D ffff88018e161610     0  3545   3542
> 0x00000000
> [ 1080.602074]  ffff88018f647d18 0000000000000086 ffff88018f647e20
> ffff88018e161610
> [ 1080.602082]  ffff880199105840 000000008f647d78 0000000017c00000
> ffff88018e090fa0
> [ 1080.602088]  0000000000000000 0000000000018000 ffff88018f647c78
> ffffffff81063032
> [ 1080.602095] Call Trace:
> [ 1080.602112]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
> [ 1080.602117]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
> [ 1080.602121]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
> [ 1080.602125]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
> [ 1080.602131]  [<ffffffff8136a76e>] io_schedule+0x3f/0x59
> [ 1080.602136]  [<ffffffff810aaf1e>] sync_page+0x49/0x4d
> [ 1080.602139]  [<ffffffff8136ac87>] __wait_on_bit+0x4a/0x7b
> [ 1080.602143]  [<ffffffff810aaed5>] ? sync_page+0x0/0x4d
> [ 1080.602147]  [<ffffffff810ab0cf>] wait_on_page_bit+0x74/0x7b
> [ 1080.602152]  [<ffffffff8105b6c4>] ? wake_bit_function+0x0/0x2f
> [ 1080.602156]  [<ffffffff810b3f18>] ? pagevec_lookup_tag+0x27/0x30
> [ 1080.602161]  [<ffffffff810ab5d4>] filemap_fdatawait_range
> +0x79/0x15d
> [ 1080.602165]  [<ffffffff810ab786>] filemap_write_and_wait_range
> +0x43/0x56
> [ 1080.602171]  [<ffffffff8110b444>] vfs_fsync_range+0x35/0x7c
> [ 1080.602174]  [<ffffffff8110b4f0>] vfs_fsync+0x1c/0x1e
> [ 1080.602178]  [<ffffffff8110b525>] do_fsync+0x33/0x49
> [ 1080.602181]  [<ffffffff8110b54e>] sys_fdatasync+0x13/0x17
> [ 1080.602187]  [<ffffffff81002c2b>] system_call_fastpath+0x16/0x1b
> [ 1102.800022] libceph:  tid 114 timed out on osd12, will reset osd

FWIW, I've seen no sign of this client hung task issue 
since I started testing with server code built from 
current unstable branch (63fab458f625) + current
rc branch (39b42b21e980) + current testing branch
(1a4ad835de66) + my half-open connection patch.

This combination has survived the heaviest write loads
(64 clients against 13 osds) that I've tested with to date.

I still see lots of clients resetting osds, but it has no
ill effects now.

-- Jim




