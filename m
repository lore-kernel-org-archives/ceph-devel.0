From: Sage Weil <sage@newdream.net>
Subject: Re: Why only support odd number monitors in ceph cluster?
Date: Fri, 23 Dec 2011 07:48:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112230745010.13105@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49DABFBE6@WHQBEMAIL1.whq.wistron>
 <4EF44B13.80301@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46278 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1LWPsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Dec 2011 10:48:07 -0500
In-Reply-To: <4EF44B13.80301@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Eric_YH_Chen@wistron.com, ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com, Alex_KT_Lin@wistron.com

On Fri, 23 Dec 2011, Wido den Hollander wrote:
> Hi,
> 
> On 12/23/2011 08:21 AM, Eric_YH_Chen@wistron.com wrote:
> > Hi, all:
> > 
> >       I am curious about why ceph cluster only support odd number monitors.
> 
> It doesn't only support a odd number. A even number of monitors works in
> theory, but it's recommended to use a odd number to get a majority.

Right.  A bit more detail:

Running an even number of monitors means a slightly higher risk of failure 
than running one less monitor.  For example, if you run 3 monitors, you 
can tolerate 1 failure (2 is a strict majority).  And you have 3 machines 
that can fail.  

On the other hand, if you run four, you can still only tolerate 1 failure 
(3 is a majority but 2 is not).  But then you have 4 machines that can 
potentially fail, and your risk of 2 dying is slightly higher.

The difference is risk is probably pretty small for most failure rates, 
but, generally speaking, odd numbers are slightly better.

sage
