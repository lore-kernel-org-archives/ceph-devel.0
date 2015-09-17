From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Important security noticed regarding release signing key
Date: Thu, 17 Sep 2015 20:37:02 +0000
Message-ID: <robbat2-20150917T203636-914888604Z@orbis-terrarum.net>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
 <robbat2-20150917T173223-066349316Z@orbis-terrarum.net>
 <alpine.DEB.2.00.1509171117540.31198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:40490 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbIQUhD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Sep 2015 16:37:03 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 1C883340ACE
	for <ceph-devel@vger.kernel.org>; Thu, 17 Sep 2015 20:37:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1509171117540.31198@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Thu, Sep 17, 2015 at 11:19:28AM -0700, Sage Weil wrote:
> > Please revoke the old keys, so that if they were taken by the attacker,
> > they cannot be used (you can't un-revoke a key generally).
> Done:
> 	http://pgp.mit.edu/pks/lookup?search=ceph&op=index
Thank you!

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
