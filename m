From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: endless flying slow requests
Date: Wed, 14 Nov 2012 10:12:26 +0100
Message-ID: <50A3607A.6050209@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47474 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446Ab2KNJMd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 04:12:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i see this several times. Endless flying slow requests. And they never 
stop until i restart the mentioned osd.

2012-11-14 10:11:57.513395 osd.24 [WRN] 1 slow requests, 1 included 
below; oldest blocked for > 31789.858457 secs
2012-11-14 10:11:57.513399 osd.24 [WRN] slow request 31789.858457 
seconds old, received at 2012-11-14 01:22:07.654922: 
osd_op(client.30286.0:6719 rbd_data.75c55bf2fdd7.0000000000001399 [write 
282624~4096] 3.3f6d2373) v4 currently delayed
2012-11-14 10:11:58.513584 osd.24 [WRN] 1 slow requests, 1 included 
below; oldest blocked for > 31790.858646 secs
2012-11-14 10:11:58.513586 osd.24 [WRN] slow request 31790.858646 
seconds old, received at 2012-11-14 01:22:07.654922: 
osd_op(client.30286.0:6719 rbd_data.75c55bf2fdd7.0000000000001399 [write 
282624~4096] 3.3f6d2373) v4 currently delayed
2012-11-14 10:11:59.513766 osd.24 [WRN] 1 slow requests, 1 included 
below; oldest blocked for > 31791.858827 secs
2012-11-14 10:11:59.513768 osd.24 [WRN] slow request 31791.858827 
seconds old, received at 2012-11-14 01:22:07.654922: 
osd_op(client.30286.0:6719 rbd_data.75c55bf2fdd7.0000000000001399 [write 
282624~4096] 3.3f6d2373) v4 currently delayed
2012-11-14 10:12:00.513909 osd.24 [WRN] 1 slow requests, 1 included 
below; oldest blocked for > 31792.858971 secs
2012-11-14 10:12:00.513916 osd.24 [WRN] slow request 31792.858971 
seconds old, received at 2012-11-14 01:22:07.654922: 
osd_op(client.30286.0:6719 rbd_data.75c55bf2fdd7.0000000000001399 [write 
282624~4096] 3.3f6d2373) v4 currently delayed
2012-11-14 10:12:01.514061 osd.24 [WRN] 1 slow requests, 1 included 
below; oldest blocked for > 31793.859124 secs
2012-11-14 10:12:01.514063 osd.24 [WRN] slow request 31793.859124 
seconds old, received at 2012-11-14 01:22:07.654922: 
osd_op(client.30286.0:6719 rbd_data.75c55bf2fdd7.0000000000001399 [write 
282624~4096] 3.3f6d2373) v4 currently delayed

When i now restart osd 24 they go away and everything is fine again.

Stefan
