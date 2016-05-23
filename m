From: Tim Serong <tserong@suse.com>
Subject: For calamari <= 1.3.x, ceph.client.admin.keyring on all nodes, or
 just mons?
Date: Mon, 23 May 2016 11:58:06 +1000
Message-ID: <574263AE.3010401@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:40146 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbcEWB6N (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Sun, 22 May 2016 21:58:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

Quick question: for Calamari <= 1.3.x, the ceph salt module that does
cluster heartbeats and whatnot needs
/etc/ceph/ceph.client.admin.keyring.  Does that need to exist on all
cluster nodes, or only on the MONs?

Thanks,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
