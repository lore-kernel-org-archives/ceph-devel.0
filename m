From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Files disappearing
Date: Mon, 17 Sep 2012 15:59:56 +0200
Message-ID: <2083014.9EhmjNYb6C@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from imap.ki.iif.hu ([193.6.222.244]:37847 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab2IQOFl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Sep 2012 10:05:41 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by strudel.ki.iif.hu (Postfix) with ESMTP id 961193FD
	for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 16:00:00 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id 00UqLGtNxK57 for <ceph-devel@vger.kernel.org>;
	Mon, 17 Sep 2012 15:59:58 +0200 (CEST)
Received: from mranderson.localnet (unknown [IPv6:2001:738:0:401:2ccf:f62e:1cfa:5bbd])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 425C3F1
	for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 15:59:57 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have a problem that newly copied files disappear from the FS after a few 
minutes. The only suspicious log entries look like this:

2012-09-17 15:45:40.251610 7f7024f25700  0 mds.0.server missing 
10000000818 #1/vmdir/2414/images/deployment.0 (mine), will load later

I see messages like this when the (only) active MDS is shut down and the 
backup (standby replay) takes over (and vice versa).

I know cephfs is not the main focus of development, but if there's a quick 
solition, then please let me know.

Thanks,
-- 
cc


