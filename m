From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Better debug log levels for autotest jobs
Date: Wed, 27 Apr 2011 16:25:16 -0700
Message-ID: <20110427232516.GB6405@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49189 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155Ab1D0XZO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 19:25:14 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 262D62C166
	for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 16:25:14 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. Our autotest runs log just way too much debug stuff. A 20-minute
run often creates >10GB uncompressed data. That's enough that
compressing & transporting it for archival slows down the test
significantly.

Ceph devs, I need your help in determining what debug logs can be
turned down a notch or two without losing anything really valuable.

The base config is at ceph-autotests.git teuthology/ceph.conf,
relevant lines pasted below:

[mon]
        lockdep = 1
	debug mon = 20
        debug paxos = 20
        debug auth = 20
        debug ms = 1

[osd]
        lockdep = 1
        debug ms = 1
        debug osd = 25
        debug monc = 20
        debug journal = 20
        debug filestore = 20

[mds]
        lockdep = 1
        debug ms = 1
        debug mds = 20
        debug auth = 20
        debug monc = 20
        mds debug scatterstat = true
        mds verify scatter = true
        mds log max segments = 2
	mds cache size = 10000
        mds debug frag = true

What can I turn down? If I don't get helpful suggestions, everything
20 goes down to 10 ;)


The worst that happens if we have the defaults not include some debug
you wanted see is you make your test override it and re-run; for
example,

class ceph_dbench(skeleton.CephTest):
    ...
    @skeleton.role('client')
    def init_025_moar_debug(self):
        self.ceph_conf['osd']['debug osd'] = 9000

should do it just fine.

(We can make that even easier, if it becomes commonplace enough. My
motto is to first feel the pain. YAGNI and all that.)

-- 
:(){ :|:&};:
