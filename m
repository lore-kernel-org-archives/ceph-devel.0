From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: v0.75 contributors credits ( experimental)
Date: Wed, 15 Jan 2014 20:19:43 +0000
Message-ID: <robbat2-20140115T201426-879804072Z@orbis-terrarum.net>
References: <52D6450E.1090605@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:51337 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbaAOUTp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 Jan 2014 15:19:45 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 0637733F2D1
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jan 2014 20:19:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <52D6450E.1090605@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jan 15, 2014 at 09:21:34AM +0100,  Loic Dachary wrote:
> Hi Ceph,
> 
> Here is a sorted list of authors and organizations who contributed to
> v0.75, by number of commits or reviews back to v0.74. The affiliation
> of authors to organizations can be updated by submitting a patch to
> https://github.com/ceph/ceph/blob/master/.organizationmap
I think the script should use tags as the marker points, rather than
release dates.

# git log tags/v0.74 |fgrep -c robbat2
0
# git log tags/v0.75 |fgrep -c robbat2
6

Your script output however says I didn't have any changes in v0.75.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
