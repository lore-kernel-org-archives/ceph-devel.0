From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW CORS fixes for Access-Control-Request-Headers
Date: Fri, 20 Dec 2013 00:06:36 +0000
Message-ID: <robbat2-20131220T000518-388520092Z@orbis-terrarum.net>
References: <robbat2-20131215T205912-773698930Z@orbis-terrarum.net>
 <CABBk=J_1yAsmHvnPfZSd_dm1wo+QcAv0SBjZcvajPcfzM9fiwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53637 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201Ab3LTAGi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Dec 2013 19:06:38 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id DC6DC33F642
	for <ceph-devel@vger.kernel.org>; Fri, 20 Dec 2013 00:06:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABBk=J_1yAsmHvnPfZSd_dm1wo+QcAv0SBjZcvajPcfzM9fiwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: "	Robin H. Johnson" <robbat2@gentoo.org>

On Tue, Dec 17, 2013 at 12:17:23AM -0800,  Yehuda Sadeh wrote:
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
> Overall it looks ok, I still want to run the test suite against it.
> Can you open corresponding issues in the ceph tracker?
> (tracker.ceph.com).
http://tracker.ceph.com/issues/7043

Pull request recreated because I relocated the repo (for work reasons):
https://github.com/ceph/ceph/pull/975

I've also got an unrelated fix I'm working on in the S3 POST code, I
think the signature validation is wrong.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
