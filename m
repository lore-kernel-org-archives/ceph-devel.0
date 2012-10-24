From: Sage Weil <sage@inktank.com>
Subject: getting kernel debug output
Date: Wed, 24 Oct 2012 10:11:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210241007500.31573@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50178 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab2JXRLR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 13:11:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org

I'm working on http://tracker.newdream.net/issues/3342 and was able to 
reproduce the msgr bug (some annoying msgr race I think) while generating 
full libceph debug output.  I used a teuthology yaml fragment like so:

tasks:
- clock: null
- ceph:
    log-whitelist:
    - wrongly marked me down
    - objects unfound and apparently lost
- thrashosds: null
- kclient: null
- exec:
    client.0:
      - echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control
- workunit:
    clients:
      all:
      - suites/ffsb.sh

I was pleasantly surprised that even though this is putting copious 
amounts of crap in dmesg it didn't slow things down enough to avoid 
tripping the bug.  And the 'dmesg' command in kdb appears to be working 
now (a couple months back it wasn't).  Yay!

Anyway, this might be useful in tracking down other bugs as well...

sage
