From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Autotest results from 2011-03-22
Date: Tue, 22 Mar 2011 11:17:45 -0700
Message-ID: <20110322181745.GC8083@dreamer>
References: <20110322172419.GB8083@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57623 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab1CVSRr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2011 14:17:47 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2648C2C173
	for <ceph-devel@vger.kernel.org>; Tue, 22 Mar 2011 11:17:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110322172419.GB8083@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

And here are the results of the re-reruns:

* autotest summary 2011-03-22 #2
** ceph_tiobench (job 265) SUCCESS
captures performance info but does not analyze it
http://autotest.ceph.newdream.net/results/265-tv/group0/sepia78.ceph.dreamhost.com/tiobench/results/raw_output_1
** ceph_direct_io_test (job 266)
exact same symptoms as with earlier run
it seems direct_io_test hoses a ceph installation bad enough that exec segfaults reliably
http://tracker.newdream.net/issues/915
earlier ceph_bonnie hang (job 263) might be the same bug

-- 
:(){ :|:&};:
