From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: libcrush.so
Date: Fri, 8 May 2015 01:29:24 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF01F60F19@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27970 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbbEHBaX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 21:30:23 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Cohen, David E" <david.e.cohen@intel.com>, "Yu, Zhidong" <zhidong.yu@intel.com>

Ceph use crush algorithm to provide the mapping of objects to OSD servers. This is great for clients so they could talk to with these OSDs directly. However there are some scenarios where the application needs to access the crush map, for load-balancing as an example. 

Currently Ceph doesn't provides any API to render the layout. If your application needs to access the crush map you'll going to rely on the command 'ceph osd map pool_name obj_name'. With this libcrush.so we could let the application to choose which nodes to access. The other advantage is we could provide some other bindings(python, go) based on this also.

From the git log we find libcrush was there before but removed out since Argonaut. Can anyone kindly share us the background of this change?


Thanks, -yuan

