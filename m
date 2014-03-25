From: Sage Weil <sage@inktank.com>
Subject: Re: OSD's failing to start due to failed ASSERT
Date: Tue, 25 Mar 2014 13:54:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403251353060.893@cobra.newdream.net>
References: <CAH3XFThHs8qqiHUwnrz3EaFtQ9K1L2wtjP3uksQgFKBS3BXYWg@mail.gmail.com> <alpine.DEB.2.00.1403160950420.10242@cobra.newdream.net> <CAH3XFTh9axDib-oeqk7b_1aArXn0hkyei+VVDQAPM_o-Pbj2TQ@mail.gmail.com>
 <CAH3XFTiB8ekKWrOSkWMXOYj-eO23S=twkw+-pM8J+k7rHsLSfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36623 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbaCYUy4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 16:54:56 -0400
In-Reply-To: <CAH3XFTiB8ekKWrOSkWMXOYj-eO23S=twkw+-pM8J+k7rHsLSfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevinsky Dy <kevinsky@acale.ph>
Cc: ceph-devel@vger.kernel.org

On Tue, 25 Mar 2014, Kevinsky Dy wrote:
> Hi again.
> 
> The cluster is currently running on wip-dumpling-sloppy-log but based
> on the revision you made, the assert is checking for a less strict
> condition and I'm thinking it might be a cause for data inconsistency
> in the future. I'm thinking we should revert back to the main Dumpling
> release. Does this make sense?

Yeah, you'll want to switch back to regular dumpling.  The caveat is 
that enough time needs to have gone by for the problematic log entires to 
have fallen off the end of the PG logs.  You can look at a pg query of the 
problematic PG from before, or just try restarting and go back to the 
hacked version if it doesn't start up.

sage

> 
> Regards,
> Skye
> 
> On Mon, Mar 17, 2014 at 3:27 AM, Kevinsky Dy <kevinsky@acale.ph> wrote:
> > Thank you for the prompt response and great guidance.
> >
> > There was a power outage prior to this happening. We were able to
> > recover, with 2 hosts shut off, from degradation but with stuck PGs.
> > We rejoined the 2 hosts and while it was rebalancing, we had to shut
> > it down (gracefully) because we were expecting another power outage.
> >
> > For debug levels, we were only using the default log levels.
> > Yesterday, we only increased debug osd level to 20 for one OSD for
> > troubleshooting.
> >
> > Attached are the logs requested.
> > Also, the patch worked like a charm. I hope the logs help determine the cause.
> >
> > Regards,
> > Skye
> >
> > On Mon, Mar 17, 2014 at 12:52 AM, Sage Weil <sage@inktank.com> wrote:
> >> On Sun, 16 Mar 2014, Kevinsky Dy wrote:
> >>> Hi,
> >>>
> >>> I currently have 2 OSDs that won't start and it's preventing my
> >>> cluster from running my VMs.
> >>> My cluster is running on:
> >>> # ceph -v
> >>> ceph version 0.67.7 (d7ab4244396b57aac8b7e80812115bbd079e6b73)
> >>>
> >>> My OSD's are found on different hosts as per the default CRUSH Map
> >>> rules and I got the logs from the problem OSDs as follows
> >>>
> >>> osd.1:
> >>>     -10> 2014-03-16 11:51:25.183093 7f50923e4780 20 read_log
> >>> 12794'1377363 (12794'1377357) modify
> >>> 5ee8f77d/rb.0.1f7b.238e1f29.0000000118fb/head//2 by
> >>> client.1077470.0:376704 2014-03-15 12:37:43.175319
> >>>     -9> 2014-03-16 11:51:25.183122 7f50923e4780 20 read_log
> >>> 12794'1377364 (12794'1377362) modify
> >>> af8f477d/rb.0.24f4.238e1f29.00000000e378/head//2 by
> >>> client.1074837.0:1295631 2014-03-15 12:38:03.613604
> >>>     -8> 2014-03-16 11:51:25.183146 7f50923e4780 20 read_log
> >>> 12794'1377365 (12794'1377348) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1396709 2014-03-15 12:38:33.720354
> >>>     -7> 2014-03-16 11:51:25.183179 7f50923e4780 20 read_log
> >>> 12794'1377366 (12794'1377365) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1396712 2014-03-15 12:38:33.726419
> >>>     -6> 2014-03-16 11:51:25.183207 7f50923e4780 20 read_log
> >>> 12794'1377367 (12794'1377366) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1397305 2014-03-15 12:39:09.863260
> >>>     -5> 2014-03-16 11:51:25.183231 7f50923e4780 20 read_log
> >>> 12794'1377368 (12794'1377367) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1398903 2014-03-15 12:40:13.096258
> >>>     -4> 2014-03-16 11:51:25.183258 7f50923e4780 20 read_log
> >>> 12794'1377369 (12794'1377363) modify
> >>> 5ee8f77d/rb.0.1f7b.238e1f29.0000000118fb/head//2 by
> >>> client.1077470.0:377159 2014-03-15 12:40:13.105469
> >>>     -3> 2014-03-16 11:51:25.183282 7f50923e4780 20 read_log
> >>> 12794'1377370 (12794'1377360) modify
> >>> 19463f7d/rb.0.ecb29.238e1f29.000000000101/head//2 by
> >>> client.1058212.1:358750 2014-03-15 12:40:24.998076
> >>>     -2> 2014-03-16 11:51:25.183309 7f50923e4780 20 read_log
> >>> 12794'1377371 (12794'1377368) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1399253 2014-03-15 12:40:28.134624
> >>>     -1> 2014-03-16 11:51:25.183333 7f50923e4780 20 read_log
> >>> 13740'1377371 (12605'1364064) modify
> >>> 94c6137d/rb.0.d07d.2ae8944a.000000002524/head//2 by
> >>> client.1088028.0:10498 2014-03-16 00:06:12.643968
> >>>      0> 2014-03-16 11:51:25.185685 7f50923e4780 -1 osd/PGLog.cc: In
> >>> function 'static bool PGLog::read_log(ObjectStore*, coll_t, hobject_t,
> >>> const pg_info_t&, std::map<eversion_t, hobject_t>&,
> >>> PGLog::IndexedLog&, pg_missing_t&, std::ostringstream&,
> >>> std::set<std::basic_string<char> >*)' thread 7f50923e4780 time
> >>> 2014-03-16 11:51:25.183350
> >>> osd/PGLog.cc: 677: FAILED assert(last_e.version.version < e.version.version)
> >>
> >> Any idea what might have happened to get the cluster in this state?  Was
> >> logging turned up leading up to the crash?
> >>
> >> The version is an (epoch, v) pair and v is normally monotonically
> >> increasing.  I don't think much relies on this, though, so I pushed a
> >> wip-dumpling-sloppy-log branch that just drops this assert; I
> >> suspect it will come up after that.
> >>
> >> sage
> >>
> >>>
> >>> osd.2:
> >>> -10> 2014-03-16 11:28:45.015366 7fe5a7539780 20 read_log 12794'1377363
> >>> (12794'1377357) modify
> >>> 5ee8f77d/rb.0.1f7b.238e1f29.0000000118fb/head//2 by
> >>> client.1077470.0:376704 2014-03-15 12:37:43.175319
> >>>     -9> 2014-03-16 11:28:45.015381 7fe5a7539780 20 read_log
> >>> 12794'1377364 (12794'1377362) modify
> >>> af8f477d/rb.0.24f4.238e1f29.00000000e378/head//2 by
> >>> client.1074837.0:1295631 2014-03-15 12:38:03.613604
> >>>     -8> 2014-03-16 11:28:45.015394 7fe5a7539780 20 read_log
> >>> 12794'1377365 (12794'1377348) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1396709 2014-03-15 12:38:33.720354
> >>>     -7> 2014-03-16 11:28:45.015405 7fe5a7539780 20 read_log
> >>> 12794'1377366 (12794'1377365) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1396712 2014-03-15 12:38:33.726419
> >>>     -6> 2014-03-16 11:28:45.015418 7fe5a7539780 20 read_log
> >>> 12794'1377367 (12794'1377366) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1397305 2014-03-15 12:39:09.863260
> >>>     -5> 2014-03-16 11:28:45.015428 7fe5a7539780 20 read_log
> >>> 12794'1377368 (12794'1377367) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1398903 2014-03-15 12:40:13.096258
> >>>     -4> 2014-03-16 11:28:45.015441 7fe5a7539780 20 read_log
> >>> 12794'1377369 (12794'1377363) modify
> >>> 5ee8f77d/rb.0.1f7b.238e1f29.0000000118fb/head//2 by
> >>> client.1077470.0:377159 2014-03-15 12:40:13.105469
> >>>     -3> 2014-03-16 11:28:45.015452 7fe5a7539780 20 read_log
> >>> 12794'1377370 (12794'1377360) modify
> >>> 19463f7d/rb.0.ecb29.238e1f29.000000000101/head//2 by
> >>> client.1058212.1:358750 2014-03-15 12:40:24.998076
> >>>     -2> 2014-03-16 11:28:45.015464 7fe5a7539780 20 read_log
> >>> 12794'1377371 (12794'1377368) modify
> >>> cbb2fb7d/rb.0.2355.2ae8944a.00000000849e/head//2 by
> >>> client.1077379.0:1399253 2014-03-15 12:40:28.134624
> >>>     -1> 2014-03-16 11:28:45.015475 7fe5a7539780 20 read_log
> >>> 13740'1377371 (12605'1364064) modify
> >>> 94c6137d/rb.0.d07d.2ae8944a.000000002524/head//2 by
> >>> client.1088028.0:10498 2014-03-16 00:06:12.643968
> >>>      0> 2014-03-16 11:28:45.016656 7fe5a7539780 -1 osd/PGLog.cc: In
> >>> function 'static bool PGLog::read_log(ObjectStore*, coll_t, hobject_t,
> >>> const pg_info_t&, std::map<eversion_t, hobject_t>&,
> >>> PGLog::IndexedLog&, pg_missing_t&, std::ostringstream&,
> >>> std::set<std::basic_string<char> >*)' thread 7fe5a7539780 time
> >>> 2014-03-16 11:28:45.015497
> >>> osd/PGLog.cc: 677: FAILED assert(last_e.version.version < e.version.version)
> >>>
> >>> It seems that the latest version of the object taken from omap is not
> >>> newer than the ones represented in the logs and this failed assert is
> >>> preventing those 2 OSDs to start.
> >>>
> >>> Here's a link to the code.
> >>> https://github.com/ceph/ceph/blob/dumpling/src/osd/PGLog.cc#L667
> >>>
> >>> Any thoughts on how to recover from this?
> >>>
> >>> Thanks,
> >>> Skye Dy
> >>>
> >>> P.S. I apologize to those who will receive this multiple times.
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
