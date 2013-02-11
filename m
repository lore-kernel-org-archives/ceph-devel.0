From: Simon Leinen <simon.leinen@switch.ch>
Subject: IPv6 address confusion in OSDs
Date: Mon, 11 Feb 2013 09:36:31 +0100
Message-ID: <20760.44431.980428.594955@Simons-MacBook-Air-33597.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from elenski.switch.ch ([130.59.108.140]:43905 "EHLO
	elenski.switch.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab3BKIgc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 03:36:32 -0500
Received: from surlej.switch.ch (surlej.switch.ch [IPv6:2001:620:0:e::69])
	by elenski.switch.ch (8.14.3/8.14.3/Debian-9.4) with ESMTP id r1B8aQ8g001340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 09:36:27 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We run a ten-node 64-OSD Ceph cluster and use IPv6 where possible.

Today I noticed this error message from an OSD just after I restarted
it (in an attempt to resolve an issue with some "stuck" pgs that
included that OSD):

2013-02-11 09:24:57.232811 osd.35 [ERR] map e768 had wrong cluster addr ([2001:620:0:6::106]:6822/1990 != my [fe80::67d:7bff:fef1:78b%vlan301]:6822/1990)

These two addresses belong to the same interface:

root@h1:~# ip -6 addr list dev vlan301
7: vlan301@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 
    inet6 2001:620:0:6::106/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::67d:7bff:fef1:78b/64 scope link 
       valid_lft forever preferred_lft forever

2001:620:... is the global-scope address, and this is how OSDs are
addressed in our ceph.conf.  fe80:... is the link-local address that
every IPv6 interface has.  Shouldn't these be treated as equivalent?
-- 
Simon.
