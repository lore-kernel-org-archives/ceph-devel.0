From: "Holger Hoffstaette" <holger.hoffstaette@googlemail.com>
Subject: Re: ceph-mon vs leveldb status
Date: Mon, 24 Jun 2013 12:51:37 +0200
Message-ID: <pan.2013.06.24.10.51.37.437785@googlemail.com>
References: <alpine.DEB.2.00.1306191304230.7089@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51308 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab3FXKzI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Jun 2013 06:55:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Ur4QJ-00033h-4l
	for ceph-devel@vger.kernel.org; Mon, 24 Jun 2013 12:55:03 +0200
Received: from p548760b8.dip0.t-ipconnect.de ([84.135.96.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 12:55:03 +0200
Received: from holger.hoffstaette by p548760b8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 12:55:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Wed, 19 Jun 2013 13:09:42 -0700, Sage Weil wrote:

[snip]

> Meanwhile, the next development release will be changing the way all the
> pg metadata in the monitor is stored to be much more efficient and to take
> advantage of leveldb's capabilities; this will be present in 0.66
> (dumpling - 1).

Have you considered using one of the recently annoucned LevelDB forks? The
HyperDex folks recently published their HyperLevelDB fork (still
compatible though) and it has significantly improved behaviour, less
performance variance etc.
See http://hyperdex.org/performance/leveldb/ or github.

-h


