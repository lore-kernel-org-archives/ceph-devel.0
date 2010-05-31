From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: filename too long (pjd-fstest on centos5 with ceph 0.20.2)
Date: Mon, 31 May 2010 11:31:20 +0000 (UTC)
Message-ID: <hu06m8$vgc$2@dough.gmane.org>
References: <hu03dh$vgc$1@dough.gmane.org>
	<AANLkTinYa6a6yqnbjBH99seMT4NJgXpQig38mV4rmEkM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53224 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab0EaLba (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 May 2010 07:31:30 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OJ3DM-0002iu-AW
	for ceph-devel@vger.kernel.org; Mon, 31 May 2010 13:31:28 +0200
Received: from zux221-125-110.adsl.green.ch ([81.221.125.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 31 May 2010 13:31:28 +0200
Received: from thomas by zux221-125-110.adsl.green.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 31 May 2010 13:31:28 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Mon, 31 May 2010 03:42:33 -0700 schrieb Gregory Farnum:

> Thomas:
> The "file name too long" errors are actually supposed to occur in a
> number of places in pjd-fstest -- it's part of the correctness testing!

I can't see these error messages if I run the test on the local fs. 

- Thomas

