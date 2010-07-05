From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: Redundancy with Ceph
Date: Mon, 5 Jul 2010 05:14:32 +0000 (UTC)
Message-ID: <i0rpno$ao1$1@dough.gmane.org>
References: <201007042234.46732.cray@unix-ag.uni-kl.de>
	<AANLkTimXBAtgOFYAoX3aoZN4mLhYlA4514CQcpzj_mQu@mail.gmail.com>
	<201007050033.50739.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34967 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab0GEFOl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Jul 2010 01:14:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OVe0v-0008CU-3p
	for ceph-devel@vger.kernel.org; Mon, 05 Jul 2010 07:14:41 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jul 2010 07:14:41 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jul 2010 07:14:41 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Mon, 05 Jul 2010 00:33:50 +0200 schrieb Christian Baun:

> Hi,
> 
> I created 2 servers and one client
> 
> Server 1 => mon, mds, osd
> Server 2 => osd
> 
> I tried some tests with iozone and I don't think Server 2 is used.


did you read:

http://ceph.newdream.net/wiki/Adjusting_replication_level



- Thomas

