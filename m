From: Sage Weil <sage@newdream.net>
Subject: Re: profiling ceph
Date: Mon, 31 Oct 2011 09:42:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110310940180.17869@cobra.newdream.net>
References: <CAB7xdik94Dc5C=PGaiknk-9fVDGJ35hTUfsoeOdCt+G5_oAXuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56396 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab1JaQmK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2011 12:42:10 -0400
In-Reply-To: <CAB7xdik94Dc5C=PGaiknk-9fVDGJ35hTUfsoeOdCt+G5_oAXuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 30 Oct 2011, sheng qiu wrote:
> hi,
> 
> is there any way to see how much time spend on each part of ceph when
> running it. i just want to see which part of ceph codes spend more
> time or have larger cost.
> i tried to config ceph adding -pg, but when i use gprof command, it
> said no gmon.out.
> i also checked the ceph wiki, the profiling on cpu part do get an
> output on time cost. but it does not show details on ceph (how much
> time spend on each part).

I've used gprof in the past, but not recently.  Two things to watch out 
for, IIRC:

- The gmon.out is written out on shutdown in the current directory.  do 
'--chdir .' on the command line, and make sure you somehow tell the daemon 
to stop in order to get some output.

- You used to need to LD_PRELOAD gprof_helper.so in order to get results 
for all threads.  There should be a copy of the source in test/ or 
scripts/, although there is no Makefile line.  Google it for more info.


sage

> 
> Thanks,
> Sheng
> 
> -- 
> Sheng Qiu
> Texas A & M University
> Room 302 Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
