From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: RGW CORS fixes for Access-Control-Request-Headers
Date: Sun, 15 Dec 2013 21:16:21 +0000
Message-ID: <robbat2-20131215T205912-773698930Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:34568 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab3LOVQX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 15 Dec 2013 16:16:23 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id D840A33F36C
	for <ceph-devel@vger.kernel.org>; Sun, 15 Dec 2013 21:16:22 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was trying to use the RGW CORS support, and found that it flubbed
handling of the Access-Control-Request-Headers header badly.

It was expecting Access-Control-Allow-Headers in the request where it
should have taken the Access-Control-Request-Headers, and it was also
validating the content in a case-sensitive manner, when the CORS
standard (6.2.6) requires that headers are validated case-insensitive.

I have submitted a pull request with the fixes:
https://github.com/ceph/ceph/pull/949

I think they should be backported to emperor as well.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
