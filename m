From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW CORS fixes for Access-Control-Request-Headers
Date: Tue, 17 Dec 2013 19:00:33 +0000
Message-ID: <20131217190033.GI19109@orbis-terrarum.net>
References: <robbat2-20131215T205912-773698930Z@orbis-terrarum.net>
 <CABBk=J_1yAsmHvnPfZSd_dm1wo+QcAv0SBjZcvajPcfzM9fiwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:50368 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab3LQTAe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Dec 2013 14:00:34 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 35CD233F565
	for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 19:00:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABBk=J_1yAsmHvnPfZSd_dm1wo+QcAv0SBjZcvajPcfzM9fiwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org, robbat2@gentoo.org

On Tue, Dec 17, 2013 at 12:17:23AM -0800, Yehuda Sadeh wrote:
> On Sun, Dec 15, 2013 at 1:16 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > Hi,
> >
> > I was trying to use the RGW CORS support, and found that it flubbed
> > handling of the Access-Control-Request-Headers header badly.
> >
> > It was expecting Access-Control-Allow-Headers in the request where it
> > should have taken the Access-Control-Request-Headers, and it was also
> > validating the content in a case-sensitive manner, when the CORS
> > standard (6.2.6) requires that headers are validated case-insensitive.
> >
> > I have submitted a pull request with the fixes:
> > https://github.com/ceph/ceph/pull/949
> >
> > I think they should be backported to emperor as well.
> >
> 
> Overall it looks ok, I still want to run the test suite against it.
Nothing in your existing tests [1] covers the CORS at all.

[1] I checked s3-tests, teuthology, ceph-qa-suite

> Can you open corresponding issues in the ceph tracker?
> (tracker.ceph.com).
Your tracker seems to be broken, I put in my OpenID URL, and hit login,
and it just cycles me back to the login page.

Also, could you please document requiring tracker issues if that's
required to get fixes in Ceph? It's not mentioned in your
SubmittingPatches at all.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
