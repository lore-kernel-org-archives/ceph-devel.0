From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: core dumps
Date: Tue, 10 Jul 2012 12:28:24 +0200
Message-ID: <1417057.BKrM6AzGtZ@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from strudel.ki.iif.hu ([193.6.222.244]:44780 "EHLO
	strudel.ki.iif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab2GJK2a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 06:28:30 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by strudel.ki.iif.hu (Postfix) with ESMTP id 76A6D3BE
	for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 12:28:29 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id EGsAQJz0UpKe for <ceph-devel@vger.kernel.org>;
	Tue, 10 Jul 2012 12:28:27 +0200 (CEST)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 35D103BC
	for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 12:28:26 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I usually find core dumps in my root folders belonging to Ceph daemons. 
Yesterday night two of my three monitors dumped core at the exact same moment. 
Are you interested in them?

And in general, if I find such core files, should I send them to you?

Thanks,
-- 
cc


