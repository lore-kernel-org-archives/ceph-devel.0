From: "Jim Schutt" <jaschut@sandia.gov>
Subject: cosd death by oom-killer
Date: Wed, 26 May 2010 16:24:10 -0600
Message-ID: <1274912650.4773.243.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:46296 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0EZWYV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 May 2010 18:24:21 -0400
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1E541529D03
	for <ceph-devel@vger.kernel.org>; Wed, 26 May 2010 16:24:14 -0600 (MDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm running an interesting test case where I can
cause an instance of cosd to use all available memory on
its server.

On the server side I'm running the testing branch (at 
commit  817495d2).  On the client side I'm running the
for-linus branch (at commit 240ed68e).  Client and server
are both CentOS 5.5.

My filesystem has one monitor daemon, two mds daemons,
and one osd daemon, all running on one system with 4 GiB
memory.  I'm running with no swap, because otherwise 
during this test the system swaps like mad and becomes
unresponsive.  The swapping is what made me look deeper.

I mount this filesystem on a client system, then try to 
create a 16 GiB file on it using dd.  While creating
the file I watch the server with top, and see that both
the virtual memory use and resident set size of the
cosd instance grow to ~4 GiB, and a short time later cosd 
dies by oom-killer:

May 26 16:12:28 sasa008 kernel: [  902.544418] Killed process 6621 (cosd) vsz:4319672kB, anon-rss:3832152kB, file-rss:208kB

The osd has a 100 GiB partition for its data.

Am I maybe doing something wrong? 
Is there anything else I can do to help debug this?

Thanks -- Jim



