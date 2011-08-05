From: Sage Weil <sage@newdream.net>
Subject: Re: read performance not perfect
Date: Thu, 4 Aug 2011 18:26:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108041825230.29841@cobra.newdream.net>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
 <Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
 <CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
 <Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
 <loom.20110804T213454-854@post.gmane.org> <Pine.LNX.4.64.1108041252230.26398@cobra.newdream.net>
 <4E3B2D78.5060605@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60239 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab1HEBVt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2011 21:21:49 -0400
In-Reply-To: <4E3B2D78.5060605@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, 5 Aug 2011, Fyodor Ustinov wrote:
> On 08/04/2011 10:53 PM, Sage Weil wrote:
> > 
> > The current patches are on top of v3.0, but you should be able to rebase
> > the readahead stuff on top of anything reasonably recent.
> > 
> > sage
> 
> As usual.
> cluster - latest 0.32 from your ubuntu rep.
> client - latest git-pulled kernel.
> 
> dd file from cluster to /dev/null and press ctrl-c. In syslog:
> 
> [   12.950114] libceph: mon0 10.5.51.230:6789 connection failed
> [   19.971512] libceph: client4119 fsid af9be081-9777-e2cc-8988-ba02fff0f390
> [   19.971845] libceph: mon0 10.5.51.230:6789 session established
> [   92.891202] libceph: try_read bad con->in_tag = -108
> [   92.891258] libceph: osd5 10.5.51.145:6801 protocol error, garbage tag
> [  114.508350] libceph: try_read bad con->in_tag = 122
> [  114.508406] libceph: osd1 10.5.51.141:6800 protocol error, garbage tag
> [  119.077246] libceph: try_read bad con->in_tag = -39
> [  119.077301] libceph: osd7 10.5.51.147:6801 protocol error, garbage tag

Hmm, this is something new.  Can you confirm which commit you're running?

Have you seen this before?  It may be in the batch of stuff on top of 
3.0.

sage
