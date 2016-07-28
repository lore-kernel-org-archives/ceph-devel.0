From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: static member variable in libcommon and double free
Date: Thu, 28 Jul 2016 10:55:19 +1000
Message-ID: <20160728005519.GA7101@rskikr.localdomain>
References: <CAJE9aONBeLSw-tqanviSHB=u_LjKkHrGoQ6WMXvzH4gc8FfFYQ@mail.gmail.com>
 <CALe9h7f_VP0jzx2QnCMHAHPtwrOSMvxAbJg2_Spkdf48MeUQdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35411 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277AbcG1Az3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2016 20:55:29 -0400
Received: by mail-pa0-f49.google.com with SMTP id iw10so15141186pac.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2016 17:55:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALe9h7f_VP0jzx2QnCMHAHPtwrOSMvxAbJg2_Spkdf48MeUQdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jul 27, 2016 at 12:23:23PM +0100, John Spray wrote:
> On Tue, Jul 26, 2016 at 10:32 AM, kefu chai <tchaikov@gmail.com> wrote:
> > Hey Cephers,
> >
> > we are almost finished the transition to cmake. but we are also facing
> > some problems which did not exist in autotools.
> >
> > last time i asked help on static library versus dynamic library in
> > this mailing list. and the consensus was we should just build and
> > package dynamic libraries. but this time, i ran into a more difficult
> > one: http://tracker.ceph.com/issues/16686.
> 
> I strongly suspect that http://tracker.ceph.com/issues/16556 is caused
> by the same problem with the symbols in lockdep.cc, although in this
> instance it is only causing a problem when we fork.  I have a patch
> (https://github.com/ceph/ceph/pull/10452) which demonstrates that the
> issue goes away when we don't load librados and libcephfs into the
> same process.

Actually, this is a different problem IMHO (after some research) and I believe
it's the use of fork that is the problem. If I'm right the issue is timing
dependant (I don't see it on current master as an example) and your patch may
subtly effect the timing or somehow else work around the problem. I'm looking
into this further but I can already see that this is a very dangerous and
optimistic use of fork :) Any test that uses that code is in danger of
unexpected behaviour.

HTH,
Brad

> 
> John
> 
> > a little bit background: we have a convenience library named libcommon
> > which wraps some of the class/methods shared across the Ceph project,
> > messenger among the other things. and in tracker#16686, i found that
> > in AsyncMessenger.cc, we have a static member variable named
> > WorkerPool::name. it is a std::string. see
> > https://github.com/ceph/ceph/blob/master/src/msg/async/AsyncMessenger.cc#L346
> >
> > if we load both libceph.so and librados.so in the same process, when
> > the process exists, this variable will be destructed twice. hence the
> > double free. because the linker thinks that the symbols the two copies
> > of libcommon in libcephfs and librados are the same ones. while the
> > two libraries destruct the variable individually. that's why we have
> > this problem.
> >
> > you might want to ask, "it works in autotools!". i asked myself the
> > same question. and i found that we don't pass
> > "-Wl,--exclude-libs=libcommon.a" or "-Wl,--exclude-libs,ALL" to linker
> > when linking libcephfs and librados, as we did in automake. this
> > confuses the run-time linker. yeah, we can do the same in cmake. but
> > this breaks the build. see
> > http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-trusty-amd64-basic/log.cgi?log=87ff7617bf2c07d43b6a6b7d116ea61f9ea6e905:
> >
> > ```
> > /srv/autobuild-ceph/gitbuilder.git/build/out~/ceph-11.0.0-902-g87ff761/src/common/Formatter.h:92:
> > undefined reference to `ceph::Formatter::~Formatter()'
> >
> > error: collect2: ld returned 1 exit status
> >
> > make[4]: *** [bin/ceph_test_rados_api_c_read_operations] Error 1
> > ```
> >
> > some librados tests (maybe more of them) are using the non-public
> > symbols. so we have two solutions:
> >
> > - extract the .cc files which are used by these tests into a
> > convenience library and link the tests against it *and* librados. but
> > again this introduces the risk of double free. the extracted .cc files
> > should be non-POD static variable free.
> > - compile a static librados and link the tests against it. this
> > actually mimics the behavior of autotools. but this approach
> > complicates the cmake file, as we discussed before.
> >
> >
> > so, maybe we should just forbid the non-POD static variables in
> > libcommon? if you have  better solution, or i am completely wrong (i
> > wish so), please let me know.
> >
> > thanks,
> >
> > --
> > Regards
> > Kefu Chai
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
