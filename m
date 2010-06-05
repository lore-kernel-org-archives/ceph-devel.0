From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: ceph_dentry_info: Objects remaining on kmem_cache_close()
 (ceph-client-standalone/master-backport on kernel 2.6.32)
Date: Sat, 5 Jun 2010 09:21:40 +0000 (UTC)
Message-ID: <hud4v4$j7u$2@dough.gmane.org>
References: <hud40h$j7u$1@dough.gmane.org>
	<1275729396.5836.35.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51741 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932656Ab0FEJWD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Jun 2010 05:22:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OKpZq-0001xi-4i
	for ceph-devel@vger.kernel.org; Sat, 05 Jun 2010 11:22:02 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 11:22:02 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 11:22:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Sat, 05 Jun 2010 11:16:36 +0200 schrieb Wido den Hollander:

> Hi,
> 
> That's a known issue, already reported on:
> http://tracker.newdream.net/issues/139
> 
> FYI, still present with the 2.6.35 kernel.

ok, somehow i managed to overlook the bugtracker link on the ceph page. :/

sorry for the redundant post.

 -Thomas

