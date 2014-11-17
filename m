From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RE: Question on Ceph LRC design
Date: Mon, 17 Nov 2014 01:00:38 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF01E2916F@SHSMSX104.ccr.corp.intel.com>
References: <06681238D8946F44A60AA400760A1CBF01E28FBD@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26711 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbaKQBCh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Nov 2014 20:02:37 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "Andreas.Joachim.Peters@cern.ch" <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

[resend with plain format, sorry for the duplicated mail]

Hi Loic/Anderas,

I was trying to understand the LRC design in Ceph EC. Per my understanding, it seems Ceph was using a slightly different design with the Microsoft LRC: the local parities were calculated with the global parities included. Is there any special consideration on this change? 
I was asking because in a typical MS LRC design the global and local parities could be calculated at the same time actually(I mean inside the Erasure Code library). But with this new design, we lost this potential optimization.

Thanks, -Yuan
