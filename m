From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: gcc-6 is c++14 by default, and hammer does not like it
Date: Mon, 22 Aug 2016 11:13:05 +1000
Message-ID: <20160822011305.GB5955@rskikr.localdomain>
References: <CAJE9aOPoceT-SGM7ANLqtnaF6T8PUcEJJqwefx7BQj7N3A=i4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33923 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753093AbcHVBNN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Aug 2016 21:13:13 -0400
Received: by mail-pa0-f49.google.com with SMTP id fi15so32074642pac.1
        for <ceph-devel@vger.kernel.org>; Sun, 21 Aug 2016 18:13:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJE9aOPoceT-SGM7ANLqtnaF6T8PUcEJJqwefx7BQj7N3A=i4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Sat, Aug 6, 2016 at 12:05 AM, kefu chai <tchaikov@gmail.com> wrote:
> hey cephers,
>
> just a heads up, for those who are using the bleeding edge
> compiler[1], hammer does not compile by default.
>
> i took a while to figure it out tonight. and seems the packaged
> liboost is now compiled using gcc6 with C++14 enabled, so the headers
> are found, but the source does not link with some libboost libraries
> if you pass 'CXXFLAGS=-std=c++98' to configure. and moreover, seems
> libstdc++ does not play well with hammer, i didn't root cause this.

With the following on F24 and gcc 6.1.1 I can successfully run run-make-check.sh
as long as I append -std=c++98 to CXXFLAGS.

$ git log --pretty=oneline -1
eb27865f268eaa4abc4e4b46354f1ea1556d1a5c Merge pull request #10750 from ceph/wip-14799-hammer

$ lsb_release -r
Release:        24

$ g++ -v 2>&1|tail -1
gcc version 6.1.1 20160621 (Red Hat 6.1.1-3) (GCC)

So this appears to have been fixed to at least some degree.

On older commits (such as tag 0.94.7 which I needed to compile on F24) however
you will want to backport 602425abd5cef741fc1b5d4d1dd70c68e153fc8d for the
_LARGEFILE64_SOURCE definition to fix xfs header compilation and for older
versions of rocksdb you may need to add -D_GLIBCXX_INCLUDE_NEXT_C_HEADERS to
CXXFLAGS in rocksdb/configure.ac to enable the previous gcc header include
behaviour (as described by the document Kefu linked). You may also need to pass
"-std=gnu++98" early on the command line since libos_rocksdb_la_CXXFLAGS
includes "-std=gnu++11" so you can't have "-std=gnu++98" overriding that. I
found passing 'CXX="ccache g++ -std=gnu++98"' on the configure line worked
around that.

Oddly I didn't see any problems with the boost libraries.

HTH,
Brad

>
> at last, i cowardly used gcc-5 to compile hammer.
>
> ---
> [1] https://gcc.gnu.org/gcc-6/changes.html
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
