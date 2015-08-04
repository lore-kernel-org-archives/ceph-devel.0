From: Adam Manzanares <Adam.Manzanares@hgst.com>
Subject: Per Object Scrub
Date: Tue, 4 Aug 2015 16:34:36 +0000
Message-ID: <CY1PR0401MB0985BEEA720362B4E22AA93D88760@CY1PR0401MB0985.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sjc00mx1.hitachigst.com ([199.255.44.36]:35115 "EHLO
	sjc00mx1.hgst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbbHDQek convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:34:40 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ceph Developer List (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

I noticed that there is a blueprint for osd: scrub and repair for Infernalis: 

https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%3A_Scrub_and_Repair

There is also a feature request for per-object scrub:

http://tracker.ceph.com/issues/9951

I noticed in the blueprint that there was no mention of a per-object scrub, I am also interested 
in this feature. Is there any plan of adding per-object scrub when scrub and repair is improved?


Thanks,
Adam
