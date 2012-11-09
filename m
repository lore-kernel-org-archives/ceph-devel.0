From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: can't build the last master git (`configure.ac' or `configure.in' is required)
Date: Fri, 9 Nov 2012 10:16:02 -0800
Message-ID: <5B5432DF-6EED-4B56-B3DB-B84C70461562@inktank.com>
References: <7a0da62a-8758-47ad-b101-c6848a9d4a5e@mailpro>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:34053 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab2KISQH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 13:16:07 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1768337dak.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 10:16:06 -0800 (PST)
In-Reply-To: <7a0da62a-8758-47ad-b101-c6848a9d4a5e@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Just tried a fresh checkout and build and didn't see the issue.   There may have been commits between your issue and my test this morning. 

On possible problem might be that your third command reads "module" instead of "submodule".   I assume that's a typo, but if not that would explain configure.ac being missing from leveldb or libs3 subdirectories.

Cheers,
Gary

On Nov 9, 2012, at 2:53 AM, Alexandre DERUMIER wrote:

> Hi,I need help to build last master git,
> I was building fine before,
> 
> #git clone git://ceph.newdream.net/git/ceph.git
> #git submodule init
> #git module update
> #dpkg-buildpackage
> 
> ...
> autoreconf: running: /usr/bin/autoconf --force
> autoreconf: running: /usr/bin/autoheader --force
> autoreconf: running: automake --add-missing --copy --force-missing
> autoreconf: Leaving directory `.'
> autoreconf: `configure.ac' or `configure.in' is required
> make: *** [configure-stamp] Error 1
> dpkg-buildpackage: error: debian/rules build gave error exit status 2
> 
> 
> Any ideas ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

