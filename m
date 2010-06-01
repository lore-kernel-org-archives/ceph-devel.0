From: Thomas Mueller <thomas@chaschperli.ch>
Subject: build dep or not: libatomic_ops
Date: Tue, 1 Jun 2010 11:05:31 +0000 (UTC)
Message-ID: <hu2phr$3kv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45214 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab0FALFl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Jun 2010 07:05:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OJPHw-00044Q-Gs
	for ceph-devel@vger.kernel.org; Tue, 01 Jun 2010 13:05:40 +0200
Received: from zux221-125-110.adsl.green.ch ([81.221.125.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jun 2010 13:05:40 +0200
Received: from thomas by zux221-125-110.adsl.green.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jun 2010 13:05:40 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

in ceph.spec libatomic_ops is a build dep. in debian/control it is not.

is libatomic_ops build dep or not ?

- Thomas


