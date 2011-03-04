From: Sage Weil <sage@newdream.net>
Subject: Re: about cpu_profiler
Date: Fri, 4 Mar 2011 12:45:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103041244230.25280@cobra.newdream.net>
References: <AANLkTimYykJpXQF3qUPYA7OF2jUf55WruXje1q0xJTet@mail.gmail.com>
 <00BB198CFBE347429653477BED3AA89B@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48586 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760065Ab1CDUn6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 15:43:58 -0500
In-Reply-To: <00BB198CFBE347429653477BED3AA89B@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, ceph-devel@vger.kernel.org

On Fri, 4 Mar 2011, Gregory Farnum wrote:
> On Friday, March 4, 2011 at 12:08 PM, Colin McCabe wrote: 
> > tl;dr: cpu_profiler may randomly crash your program on x86_64.
> > The problem "should" be resolved in the "future".
> 
> From what I've read, it's unfortunately not out of date. However, it 
> manifests itself as a crash so it's not the reason that we can't get 
> debugging output, unless there's something I'm missing. :) And even if 
> it turns out to be very unstable on x86-64, the value of a good cpu 
> profiler is high enough that we can set up x86 boxes or VMs... 

Yeah.  If it's not going to be reliable, though, it's not worth investing 
time/debugging effort into making it (sort of) work.

I suspect oprofile is the way to go here...

sage

