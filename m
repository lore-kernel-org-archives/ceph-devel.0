From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: mds crash on snaptest-2
Date: Tue, 27 Jul 2010 09:22:17 +0000 (UTC)
Message-ID: <i2m8g9$53k$2@dough.gmane.org>
References: <i21p5k$fma$2@dough.gmane.org>
	<AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35417 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754044Ab0G0JWc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Jul 2010 05:22:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OdgMk-0004Ay-Aa
	for ceph-devel@vger.kernel.org; Tue, 27 Jul 2010 11:22:26 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 11:22:26 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 11:22:26 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Mon, 19 Jul 2010 14:16:14 -0700 schrieb Gregory Farnum:

> Can you turn on debugging and verify for me that it's crashing on
> "assert(p->second.first <= snapid && snapid <= p->first); "
> CInode::encode_inodestat:1617?
> I've hit this assert trying to reproduce your issue using cfuse and I
> think this is it, but I'm hitting some ext3 bugs in my kernel on a
> fairly regular basis while trying to reproduce, so a fix will need to
> wait until I've upgraded (tomorrow). :) Thanks!
> -Greg

hi greg

the test still fails with ceph.git/unstable from today. now cmds doesn't 
exit anymore. But after a half an hour the test kills itself because of a 
timeout (normal running time is about 10 minutes).

- Thomas

PS: found out that vstart.sh places logs in subdir "out" too. so tell me 
if you need some of them.

