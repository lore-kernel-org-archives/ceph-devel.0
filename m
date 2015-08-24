From: Sage Weil <sweil@redhat.com>
Subject: async messenger
Date: Mon, 24 Aug 2015 14:28:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508241427170.13128@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438AbbHXV2e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Aug 2015 17:28:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomaiwang@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Haomai,

How did your most recent async messenger run go?

If there aren't major issues, we'd like to start mixing it in with the 
regular rados suite by doing 'ms type = random'...

sage
