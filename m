From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: global_init_daemonize: BUG: there are 1 child threads already started that will now die!
Date: Thu, 17 May 2012 13:53:57 +0200
Message-ID: <12500703.xTHoDB74aK@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:56019 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760246Ab2EQME0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 May 2012 08:04:26 -0400
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by mail.ki.iif.hu (Postfix) with ESMTP id 31D0C87ADF
	for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 13:54:05 +0200 (CEST)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id B2mSAaC2FF10 for <ceph-devel@vger.kernel.org>;
	Thu, 17 May 2012 13:53:59 +0200 (CEST)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:401:e91b:8801:2580:ce66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id 0AEBF87A20
	for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 13:53:58 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I get the $subject message when starting Ceph with the init script. I have to 
try it 15-20 times until the start suceeds. I've seen this message emitted by 
the monitor and MDS daemons, but never by OSDs. Is this really a bug as the 
message says? I have two theoretically identical clusters, and only one of 
them produces this error, so something might be wrong on my side, but what?

Thanks,
-- 
cc


