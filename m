From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: infernalis feature freeze
Date: Tue, 25 Aug 2015 19:51:45 +0000
Message-ID: <robbat2-20150825T194654-420709030Z@orbis-terrarum.net>
References: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
 <robbat2-20150818T220440-454479178Z@orbis-terrarum.net>
 <CADRKj5RF0BoaUCGQhp5unr5wrFxT=_mL3Oe2J9GvGR10AyVuZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33667 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755895AbbHYTvq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Aug 2015 15:51:46 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 223DC3408EA
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2015 19:51:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CADRKj5RF0BoaUCGQhp5unr5wrFxT=_mL3Oe2J9GvGR10AyVuZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

https://github.com/ceph/ceph/pull/5642 - HTML formatter
https://github.com/ceph/ceph/pull/5665 - most of static-sites code

On Tue, Aug 25, 2015 at 09:54:17AM -0700, Yehuda Sadeh-Weinraub wrote:
> Can you send a pull request so that I can review it?
> 
> Thanks,
> Yehuda
> 
> On Tue, Aug 18, 2015 at 3:52 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > On Wed, Aug 12, 2015 at 02:20:11PM -0700,  Sage Weil wrote:
> >> The infernalis feature freeze is coming up Real Soon Now.
> > How soon is RSN?
> >
> > I'm interested in trying to land the Static-Website code in Infernalis
> > (has tests added in a fork of s3-tests as well), but the ErrorDoc
> > handling part is being stubborn.
> >
> > I'll settle for getting the changes for RGWRegion (changing hostnames
> > and endpoints to maps by type) and RGWBucketInfo (storing the actual
> > WebsiteConfiguration data) into infernalis
> >
> > --
> > Robin Hugh Johnson
> > Gentoo Linux: Developer, Infrastructure Lead
> > E-Mail     : robbat2@gentoo.org
> > GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
