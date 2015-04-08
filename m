From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: lttng broken on i386 trusty
Date: Wed, 8 Apr 2015 16:07:09 -0700
Message-ID: <CAFkUHxckG3r05gbgaHQzYagU8BhjCNjApwj8iWAiyGu1U4Ub-A@mail.gmail.com>
References: <55152926.9000400@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34795 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbDHXHK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 19:07:10 -0400
Received: by pacyx8 with SMTP id yx8so128848712pac.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Apr 2015 16:07:10 -0700 (PDT)
In-Reply-To: <55152926.9000400@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Need help! This is still broken!

-Neo

On Fri, Mar 27, 2015 at 2:55 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> In case you did not notice:
>
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-i386-=
basic/log.cgi?log=3Ddca722ec7b2a7fc9214844ec92310074b5cb2faa
>
> CXXLD radosgw-admin
> CXXLD rados
> /usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-ust.=
so: undefined reference to `dlclose'
> /usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-ust.=
so: undefined reference to `dlsym'
> /usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-ust.=
so: undefined reference to `dlopen'
>
>     error: collect2: ld returned 1 exit status
>
> make[3]: *** [ceph_tpbench] Error 1
> make[3]: *** Waiting for unfinished jobs....
> CXXLD ceph-objectstore-tool
> make[3]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/build/=
src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/build/=
src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/build/=
src'
>
>     make: *** [all-recursive] Error 1
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
