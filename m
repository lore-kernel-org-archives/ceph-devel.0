From: Sage Weil <sage@newdream.net>
Subject: Re: Isn't --allhosts dangerous?
Date: Sun, 27 Sep 2015 18:09:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509271807470.11876@cobra.newdream.net>
References: <560864F3.4000900@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41461 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbbI1BJf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Sep 2015 21:09:35 -0400
In-Reply-To: <560864F3.4000900@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel@vger.kernel.org

On Sun, 27 Sep 2015, Nathan Cutler wrote:
> Taking actions cluster-wide via a shell script seems like it could have
> dangerous unexpected side effects, and indeed while looking through old
> tickets, I ran across http://tracker.ceph.com/issues/9407 . . .
> 
> This is "fixed" (by getting rid of the --allhosts option to init-ceph)
> in https://github.com/ceph/ceph/pull/6089
> 
> The same PR also adds getopt to make processing of command-line options
> more flexible.
> 
> Opinions? Reviews?

I certainly won't miss it, but I suspect a fair number of people use it 
(e.g., service ceph -a start).  The general strategy is to avoid adding 
any such hacks to the newer init system scripts, so as everyone moves to 
systemd this will go away.

sage
