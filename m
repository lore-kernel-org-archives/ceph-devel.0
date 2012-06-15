From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: map wrongly marked me down
Date: Fri, 15 Jun 2012 11:00:36 +0200
Message-ID: <4FDAF9B4.2060304@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51064 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab2FOJAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 05:00:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i've seen several times this error message:
2012-06-15 10:55:50.794853 mon.0 [INF] osdmap e63: 12 osds: 11 up, 12 in
2012-06-15 10:56:38.810466 7f109a2eb700  0 monclient: hunting for new mon
2012-06-15 10:25:49.882119 mon.1 [INF] mon.b calling new monitor election
2012-06-15 10:55:50.819120 osd.13 [WRN] map e63 wrongly marked me down
2012-06-15 10:56:17.483877 mon.2 [INF] mon.c calling new monitor election
2012-06-15 10:56:22.451578 mon.1 [INF] mon.b calling new monitor election
2012-06-15 10:56:28.335367 mon.1 [INF] mon.b@1 won leader election with 
quorum 1,2
2012-06-15 10:56:28.344252 mon.1 [INF] pgmap v5056: 6536 pgs: 5978 
active+clean, 558 stale+active+clean; 21782 MB data, 17774 MB used, 2663 
GB / 2681 GB avail
2012-06-15 10:56:28.349844 mon.1 [INF] mdsmap e1: 0/0/1 up
2012-06-15 10:56:28.349897 mon.1 [INF] osdmap e64: 12 osds: 12 up, 12 in

Stefan
