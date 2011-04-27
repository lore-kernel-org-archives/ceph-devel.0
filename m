From: Sage Weil <sage@newdream.net>
Subject: Re: Better debug log levels for autotest jobs
Date: Wed, 27 Apr 2011 16:48:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104271646100.31111@cobra.newdream.net>
References: <20110427232516.GB6405@dreamer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57310 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab1D0XsF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 19:48:05 -0400
In-Reply-To: <20110427232516.GB6405@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 27 Apr 2011, Tommi Virtanen wrote:
> Hi. Our autotest runs log just way too much debug stuff. A 20-minute
> run often creates >10GB uncompressed data. That's enough that
> compressing & transporting it for archival slows down the test
> significantly.
> 
> Ceph devs, I need your help in determining what debug logs can be
> turned down a notch or two without losing anything really valuable.
> 
> The base config is at ceph-autotests.git teuthology/ceph.conf,
> relevant lines pasted below:
> 
> [mon]
>         lockdep = 1
> 	debug mon = 20
>         debug paxos = 20
>         debug auth = 20
>         debug ms = 1
> 
> [osd]
>         lockdep = 1
>         debug ms = 1
>         debug osd = 25
>         debug monc = 20
>         debug journal = 20
>         debug filestore = 20
> 
> [mds]
>         lockdep = 1
>         debug ms = 1
>         debug mds = 20
>         debug auth = 20
>         debug monc = 20
>         mds debug scatterstat = true
>         mds verify scatter = true
>         mds log max segments = 2
> 	mds cache size = 10000
>         mds debug frag = true
> 
> What can I turn down? If I don't get helpful suggestions, everything
> 20 goes down to 10 ;)

That's my initial suggestion.

I wonder, though, if we should really turn it all the way off.  That will 
make our tests run much faster and mimic real life more closely.  If 
something fails, we can re-run that one test with logging and go from 
there.  As long as that part is easy enough to do...

sage


> 
> 
> The worst that happens if we have the defaults not include some debug
> you wanted see is you make your test override it and re-run; for
> example,
> 
> class ceph_dbench(skeleton.CephTest):
>     ...
>     @skeleton.role('client')
>     def init_025_moar_debug(self):
>         self.ceph_conf['osd']['debug osd'] = 9000
> 
> should do it just fine.
> 
> (We can make that even easier, if it becomes commonplace enough. My
> motto is to first feel the pain. YAGNI and all that.)
> 
> -- 
> :(){ :|:&};:
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
