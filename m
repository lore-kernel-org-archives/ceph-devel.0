From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: infernalis feature freeze
Date: Tue, 18 Aug 2015 22:52:41 +0000
Message-ID: <robbat2-20150818T220440-454479178Z@orbis-terrarum.net>
References: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:59972 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbHRWwl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Aug 2015 18:52:41 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 600FF34087C
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2015 22:52:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Wed, Aug 12, 2015 at 02:20:11PM -0700,  Sage Weil wrote:
> The infernalis feature freeze is coming up Real Soon Now.  
How soon is RSN? 

I'm interested in trying to land the Static-Website code in Infernalis
(has tests added in a fork of s3-tests as well), but the ErrorDoc
handling part is being stubborn.

I'll settle for getting the changes for RGWRegion (changing hostnames
and endpoints to maps by type) and RGWBucketInfo (storing the actual
WebsiteConfiguration data) into infernalis

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
