From: Sage Weil <sage@newdream.net>
Subject: Re: cosd death by oom-killer
Date: Wed, 26 May 2010 16:28:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005261626220.24698@cobra.newdream.net>
References: <1274912650.4773.243.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51383 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933697Ab0EZX2S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 May 2010 19:28:18 -0400
In-Reply-To: <1274912650.4773.243.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

Interesting.. we saw a similar report on irc.  Can you add

	debug osd = 20
	debug filestore = 20
	debug journal = 20
	debug ms = 1

to your [osd] section, reproduce the crash, and then send us the osd log?  
(It's at /var/log/ceph/osd$id, unless you've put it somewhere else.)

Thanks!
sage


On Wed, 26 May 2010, Jim Schutt wrote:

> Hi,
> 
> I'm running an interesting test case where I can
> cause an instance of cosd to use all available memory on
> its server.
> 
> On the server side I'm running the testing branch (at 
> commit  817495d2).  On the client side I'm running the
> for-linus branch (at commit 240ed68e).  Client and server
> are both CentOS 5.5.
> 
> My filesystem has one monitor daemon, two mds daemons,
> and one osd daemon, all running on one system with 4 GiB
> memory.  I'm running with no swap, because otherwise 
> during this test the system swaps like mad and becomes
> unresponsive.  The swapping is what made me look deeper.
> 
> I mount this filesystem on a client system, then try to 
> create a 16 GiB file on it using dd.  While creating
> the file I watch the server with top, and see that both
> the virtual memory use and resident set size of the
> cosd instance grow to ~4 GiB, and a short time later cosd 
> dies by oom-killer:
> 
> May 26 16:12:28 sasa008 kernel: [  902.544418] Killed process 6621 (cosd) vsz:4319672kB, anon-rss:3832152kB, file-rss:208kB
> 
> The osd has a 100 GiB partition for its data.
> 
> Am I maybe doing something wrong? 
> Is there anything else I can do to help debug this?
> 
> Thanks -- Jim
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
