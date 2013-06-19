From: John Nielsen <lists@jnielsen.net>
Subject: Re: recent osd changes
Date: Wed, 19 Jun 2013 15:46:50 -0600
Message-ID: <158BDFA0-46FF-43D6-9FC5-1F3BC9EDBABF@jnielsen.net>
References: <alpine.DEB.2.00.1306191259430.6742@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from secure.freebsdsolutions.net ([69.55.234.48]:58981 "EHLO
	ns1.jnielsen.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935070Ab3FSWNr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 18:13:47 -0400
In-Reply-To: <alpine.DEB.2.00.1306191259430.6742@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the update (and, as always, the great work)!

Could you also indicate for each change which development and stable release(s) they (will) appear in?

On Jun 19, 2013, at 2:04 PM, Sage Weil <sage@inktank.com> wrote:

> The OSDs used to only heartbeat on teh cluster interface.  Since they 
> actually talk to clients on the public interface this didn't detect 
> certain assymetrical network failures; this was fixed in the last release.
> 
> We also fixed a long-standing isue where the failure of the backend 
> network would cause an OSD to be marked down, but it would mark itself 
> back up by talking to the mon on the public interface.  It now verifies 
> that the backend network is working (by pinging random other osds) before 
> marking itself back up to avoid the problem.
> 
> The last change was a more robust writeback model.  We have a general 
> problem where we are journaling writes and then applying them to the file 
> system, but the two devices/targets may go at different speeds.  We don't 
> want to journal to get too far ahead of the fs or else request latency 
> become erratic/bursty and the eventual fs commit can take a very long 
> time.  Sam put togther a simple model of how much work the fs has pending 
> for the next commit (based on dirty bytes, dirty files, dirty inodes) and 
> bases throttling decisions on that instead of the very rough limits that 
> used to be in place.  This resolves many 'slow request' warnings and even 
> OSD failures (due to op_tp timeouts from very deep queues) on certain 
> torturous workload (ffsb).

