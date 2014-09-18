From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: radosgw-admin list users?
Date: Thu, 18 Sep 2014 20:01:57 +0000
Message-ID: <robbat2-20140918T195955-487876044Z@orbis-terrarum.net>
References: <1464A418-AB3C-46C6-8D20-8FA796538A62@gmail.com>
 <robbat2-20140918T171125-842049841Z@orbis-terrarum.net>
 <CABBk=J8bUPZLCxfJy5X9-X=oZzwZQW_ftvOR-=VFeLQpygx7aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33902 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757044AbaIRUCI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Sep 2014 16:02:08 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id DC84633BDEC
	for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 20:02:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABBk=J8bUPZLCxfJy5X9-X=oZzwZQW_ftvOR-=VFeLQpygx7aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 18, 2014 at 10:38:19AM -0700,  Yehuda Sadeh wrote:
> On Thu, Sep 18, 2014 at 10:27 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > Related to this thread, radosgw-admin doesn't seem to have anything to
> > list the users.
> >
> > The closest I have as a hack is:
> > rados ls --pool=.users.uid |sed 's,.buckets$,,g' |sort |uniq
> >
> 
> Try:
> 
> $ radosgw-admin metadata list user
Ooh nice!
Nothing in the --help output says 'metadata list' takes arguments (and
the manpage for radosgw-admin doesn't even have the metadata commands).

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
