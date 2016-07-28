From: Nathan Cutler <ncutler@suse.de>
Subject: Re: v0.94.8 timeframe
Date: Thu, 28 Jul 2016 16:25:16 +0200
Message-ID: <1f584fef-324c-f452-55e0-490ce8605130@suse.de>
References: <CALqRxCwDvsR__Cztj7w+kFE7T=3mt0mWRXNT+yej=iPQDX==cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35343 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024AbcG1OZS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Jul 2016 10:25:18 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 557C8AC11
	for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2016 14:25:17 +0000 (UTC)
In-Reply-To: <CALqRxCwDvsR__Cztj7w+kFE7T=3mt0mWRXNT+yej=iPQDX==cg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


Hi Ken:

 > When should we expect v0.94.8 to be released?

Thanks to Loic and Sam, who helped me with teuthology log analysis, I 
can report that 0.94.8 is starting to look greenish! I would like to 
think/hope it could be released within the next 30 days.

Release preparation notes are here: http://tracker.ceph.com/issues/15895

tl;dr/current status:

_rados_: green (waiting for leads to give permission to merge PRs)

_rgw_: one valgrind issue that appears harmless (today I am going to ask 
the leads for permission to merge the rgw PRs)

_cephfs_: two reproducible failures (reproducible in both 
hammer-backports and hammer!) - see 
http://tracker.ceph.com/issues/15895#note-21 for details

 > What are the remaining blocking issues?

John (Spray), could you give your opinion on the cephfs issues?

Nathan
