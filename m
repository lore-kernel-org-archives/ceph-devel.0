From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: bonnie++ issue with Ceph
Date: Thu, 8 Jul 2010 14:49:38 +0200
Message-ID: <201007081449.38981.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:39400 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0GHMtm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jul 2010 08:49:42 -0400
Received: from sushi.unix-ag.uni-kl.de (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by mailgw1.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o68CneSg015688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 8 Jul 2010 14:49:41 +0200
Received: from localhost.localdomain (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by sushi.unix-ag.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o68CnepW017154
	for <ceph-devel@vger.kernel.org>; Thu, 8 Jul 2010 14:49:40 +0200
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
When I try to test the performance of a Ceph installation with bonnie++, I get this error message:

Bonnie: drastic I/O error (rmdir): Directory not empty
Cleaning up test directory after error.

Is this a known problem?

Best Regards,
   Christian 
