From: Sage Weil <sage@redhat.com>
Subject: remove cryptopp support?
Date: Thu, 23 Jun 2016 18:26:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606231824050.14068@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58474 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbcFWS0p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2016 14:26:45 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4C023813D1
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2016 11:26:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [64.111.99.127])
	by cobra.newdream.net (Postfix) with ESMTPSA id 2C132813AC
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2016 11:26:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Right now you can build against either libnss or cryptopp for crypto 
support.  We always build packages with nss, mainly because it has some 
certifications that governments and distros care about.  I don't think 
anybody builds with cryptopp any more, but I may be wrong.

Would anyone object if we just ripped out support for cryptopp? 

sage
