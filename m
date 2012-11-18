From: Chen Baozi <baozich@gmail.com>
Subject: Re: Fail to build the latest ceph tree on Fedora 17
Date: Sun, 18 Nov 2012 11:55:49 +0800
Message-ID: <20121118035549.GA22651@cbz-workstation>
References: <20121117112900.GA23992@cbz-workstation>
 <CAC-hyiH31rfvnzNZnWusCTXBGLsA4o2WeCDnAwMv=v8A9ELLfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37566 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab2KRDz6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 22:55:58 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2673757pad.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 19:55:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAC-hyiH31rfvnzNZnWusCTXBGLsA4o2WeCDnAwMv=v8A9ELLfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Gary Lowell <gary.lowell@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 17, 2012 at 01:20:51PM -0800, Yehuda Sadeh wrote:
> On Sat, Nov 17, 2012 at 3:29 AM, Chen Baozi <baozich@gmail.com> wrote:
> > Hi, everyone.
> >
> > I was tring to build the latest ceph tree on my fedora 17 box.
> > However, there is an error message when linking radosgw as following:
> >
> >   CXXLD  radosgw
> >   /usr/bin/ld: radosgw-rgw_resolve.o: undefined reference to symbol
> >   '__res_nquery@@GLIBC_2.2.5'
> >   /usr/bin/ld: note: '__res_nquery@@GLIBC_2.2.5' is defined in DSO
> >   /lib64/libresolv.so.2 so try adding it to the linker command line
> >   /lib64/libresolv.so.2: could not read symbols: Invalid operation
> >   collect2: error: ld returned 1 exit status
> >   make[3]: *** [radosgw] Error 1
> >   make[3]: Leaving directory `/home/cbz/src/ceph/src'
> >   make[2]: *** [all-recursive] Error 1
> >   make[2]: Leaving directory `/home/cbz/src/ceph/src'
> >   make[1]: *** [all] Error 2
> >   make[1]: Leaving directory `/home/cbz/src/ceph/src'
> >   make: *** [all-recursive] Error 1
> >
> > I've also tried build the version 0.53 which is checked out from
> > fedora's pkg repo. And it can pass the building process without this
> > error.
> >
> > Any suggestion?
> 
> Linking with libresolv failed. Garry, any idea?
I've tried to add "LIBS=-lresolv" when doing "./configure". And it works.
I'm trying to fix it from the configure.ac now. 
> 
> Yehuda
