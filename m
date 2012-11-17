From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Fail to build the latest ceph tree on Fedora 17
Date: Sat, 17 Nov 2012 13:20:51 -0800
Message-ID: <CAC-hyiH31rfvnzNZnWusCTXBGLsA4o2WeCDnAwMv=v8A9ELLfA@mail.gmail.com>
References: <20121117112900.GA23992@cbz-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63333 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab2KQVUw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 16:20:52 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5210228iea.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 13:20:51 -0800 (PST)
In-Reply-To: <20121117112900.GA23992@cbz-workstation>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chen Baozi <baozich@gmail.com>, Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 17, 2012 at 3:29 AM, Chen Baozi <baozich@gmail.com> wrote:
> Hi, everyone.
>
> I was tring to build the latest ceph tree on my fedora 17 box.
> However, there is an error message when linking radosgw as following:
>
>   CXXLD  radosgw
>   /usr/bin/ld: radosgw-rgw_resolve.o: undefined reference to symbol
>   '__res_nquery@@GLIBC_2.2.5'
>   /usr/bin/ld: note: '__res_nquery@@GLIBC_2.2.5' is defined in DSO
>   /lib64/libresolv.so.2 so try adding it to the linker command line
>   /lib64/libresolv.so.2: could not read symbols: Invalid operation
>   collect2: error: ld returned 1 exit status
>   make[3]: *** [radosgw] Error 1
>   make[3]: Leaving directory `/home/cbz/src/ceph/src'
>   make[2]: *** [all-recursive] Error 1
>   make[2]: Leaving directory `/home/cbz/src/ceph/src'
>   make[1]: *** [all] Error 2
>   make[1]: Leaving directory `/home/cbz/src/ceph/src'
>   make: *** [all-recursive] Error 1
>
> I've also tried build the version 0.53 which is checked out from
> fedora's pkg repo. And it can pass the building process without this
> error.
>
> Any suggestion?

Linking with libresolv failed. Garry, any idea?

Yehuda
