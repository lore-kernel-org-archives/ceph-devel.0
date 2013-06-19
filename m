From: Sage Weil <sage@inktank.com>
Subject: Re: recent osd changes
Date: Wed, 19 Jun 2013 15:42:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306191541150.27409@cobra.newdream.net>
References: <alpine.DEB.2.00.1306191259430.6742@cobra.newdream.net> <158BDFA0-46FF-43D6-9FC5-1F3BC9EDBABF@jnielsen.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56167 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934961Ab3FSWmz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 18:42:55 -0400
In-Reply-To: <158BDFA0-46FF-43D6-9FC5-1F3BC9EDBABF@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Nielsen <lists@jnielsen.net>
Cc: ceph-devel@vger.kernel.org

On Wed, 19 Jun 2013, John Nielsen wrote:
> Thanks for the update (and, as always, the great work)!
> 
> Could you also indicate for each change which development and stable release(s) they (will) appear in?

Sure!

> On Jun 19, 2013, at 2:04 PM, Sage Weil <sage@inktank.com> wrote:
> > The OSDs used to only heartbeat on teh cluster interface.  Since they 
> > actually talk to clients on the public interface this didn't detect 
> > certain assymetrical network failures; this was fixed in the last release.
> > 
> > We also fixed a long-standing isue where the failure of the backend 
> > network would cause an OSD to be marked down, but it would mark itself 
> > back up by talking to the mon on the public interface.  It now verifies 
> > that the backend network is working (by pinging random other osds) before 
> > marking itself back up to avoid the problem.

This will land in v0.65 (out next week).

> > The last change was a more robust writeback model.  We have a general 
> > problem where we are journaling writes and then applying them to the file 
> > system, but the two devices/targets may go at different speeds.  We don't 
> > want to journal to get too far ahead of the fs or else request latency 
> > become erratic/bursty and the eventual fs commit can take a very long 
> > time.  Sam put togther a simple model of how much work the fs has pending 
> > for the next commit (based on dirty bytes, dirty files, dirty inodes) and 
> > bases throttling decisions on that instead of the very rough limits that 
> > used to be in place.  This resolves many 'slow request' warnings and even 
> > OSD failures (due to op_tp timeouts from very deep queues) on certain 
> > torturous workload (ffsb).

Also v0.65
