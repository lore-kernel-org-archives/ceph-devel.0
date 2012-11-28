From: "Snider, Tim" <Tim.Snider@netapp.com>
Subject: Multiple CEPH roles on single platform
Date: Wed, 28 Nov 2012 19:10:34 +0000
Message-ID: <DC700C5A3AE74041B17F41EE35500AB90C8ABDE8@SACEXCMBX03-PRD.hq.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.netapp.com ([216.240.18.37]:23631 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab2K1TKg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 14:10:36 -0500
Received: from vmwexceht03-prd.hq.netapp.com (vmwexceht03-prd.hq.netapp.com [10.106.76.241])
	by smtp2.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id qASJAZml006228
	for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 11:10:35 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Another rookie question: What's the thinking on having the same server perform multiple CEPH roles (e.g. osd(s), and monitor roles)? I think this would mainly be a facto for smaller/cost sensitive environments.

Tim
