From: Sage Weil <sweil@redhat.com>
Subject: Re: mgr dashboard and rest api configs
Date: Fri, 2 Jun 2017 13:35:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706021334430.3646@piezo.novalocal>
References: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal>         <CALe9h7fmjF1Yvkvf068nzpvACKfo7qz5PJ5SZdhWsboueg1xFA@mail.gmail.com>         <alpine.DEB.2.11.1706012208360.3646@piezo.novalocal> <1496394883.10067.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-412499128-1496410533=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdFBNfe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Jun 2017 09:35:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5C9561E4A
        for <ceph-devel@vger.kernel.org>; Fri,  2 Jun 2017 13:35:33 +0000 (UTC)
In-Reply-To: <1496394883.10067.8.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Ranto <branto@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-412499128-1496410533=:3646
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 2 Jun 2017, Boris Ranto wrote:
> On Thu, 2017-06-01 at 22:16 +0000, Sage Weil wrote:
> > That part I fixed with NamedTemporaryFile in
> >         https://github.com/liewegas/ceph/commit/c169c8fd461bf94459cd9
> > 8b658d2a2d8bf42bca6
> > 
> > Was there also a python module dependency problem?  If not, it seems 
> > much  more natural for the module to create the crt/key pair the first 
> > time it  stats if it's not present...
> > 
> 
> I had something like that before, see commit 
> 
> https://github.com/ceph/ceph/pull/14457/commits/92fa210aaa87fcc47b2491f
> a44f029f7426cd7b9
> 
> or
> 
> https://github.com/ceph/ceph/pull/14457/commits/f59e9bf0bbda870311c6084
> 74b9aad63f4323c43
> 
> that removed/changed it. I had a couple more implementations that did
> all sorts of things. I later removed all of them and went with as
> simple solution as possible for two reasons:
> 
> - the simple straight-forward solution is usually least likely to bite
> us in the future
> - it seemed almost impossible to get an agreement on how a more
> sophisticated solution should actually look like (it felt like I was
> going in the circles)
> 
> The one removed in the first linked patch did not require any special
> dependencies (make_ssl_devcert is part of werkzeug). The other linked
> one required pyOpenSSL which was kinda bad as afaik, pyOpenSSL is not
> being properly maintained.

I like the make_ssl_devcert approach personally... John?

sage
--8323329-412499128-1496410533=:3646--
