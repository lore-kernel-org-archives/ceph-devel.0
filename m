From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: static member variable in libcommon and double free
Date: Thu, 28 Jul 2016 16:03:14 -0400
Message-ID: <CA+2bHPZsc14wsXBTr7ftwqwsQELZaTqk218wnSMGCe817QQHkQ@mail.gmail.com>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7cn19-Rk_RN-F8HtinL8tsoou1-KgczMgT6Jtj9eWKtww@mail.gmail.com>
 <CAJE9aOOumNu1d3dm0HBL_Zr0_dGdqgdQtqrx00rZoitivXf1=A@mail.gmail.com>
 <alpine.LSU.2.20.1607261706350.28641@ancalagon.suse.com> <BLUPR0201MB152490EB7FE729C197978E1DE80F0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <20160727015433.GB22132@rskikr.localdomain> <CA+2bHPbvLaeMNuZcO__KWdCLYOYz+9u-NOGakK9VgrQwuTvL-g@mail.gmail.com>
 <CAJE9aONRiJaOBEkOGhZBUAy6=_cEFTd0hCgmaUyOQ5=a8dvCvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33898 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809AbcG1UDo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2016 16:03:44 -0400
Received: by mail-qk0-f173.google.com with SMTP id o67so72894045qke.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2016 13:03:44 -0700 (PDT)
In-Reply-To: <CAJE9aONRiJaOBEkOGhZBUAy6=_cEFTd0hCgmaUyOQ5=a8dvCvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Jesse Williamson <jwilliamson@suse.de>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 27, 2016 at 8:04 AM, kefu chai <tchaikov@gmail.com> wrote:
>> Ideally the shared libraries should not export any global variables.
>
> thanks Patrick, yeah. this would force us to do the right thing:
>
> * for cephfs
>  - pass `--exclude-libs=libcommon.a` to linker,
>  - find a way to implement libtools' "-export-symbols-regex
> '^ceph_.*'" with cmake
> * for librados
>  - pass `--exclude-libs=ALL` to linker,
> * for those naughty tests who use the internal symbols
>  - link them against the convenience libs (or objects) by which the
> symbols are offered.

Great job kefu on the fix: https://github.com/ceph/ceph/pull/10472

I'll quote my comment on that PR:

This makes a huge reduction in the exported symbols:

$ objdump -T librados.so > librados.so.2850b6f
...
$ wc -l lib*so*
   2082 libcephfs.so.2850b6f
  10744 libcephfs.so.2850b6f^
   2009 librados.so.2850b6f
  10401 librados.so.2850b6f^

And the final set of global symbols look about right to me. (There
could be more pruning done but it's probably not worth it.)

-- 
Patrick Donnelly
