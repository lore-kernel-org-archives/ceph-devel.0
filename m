From: Sage Weil <sweil@redhat.com>
Subject: Re: [sepia] how to use teuthology-suite in the new world
Date: Thu, 15 Dec 2016 22:32:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612152231190.10615@piezo.novalocal>
References: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal> <20161215145143.GA1451@gmail.com> <20161215150026.GB1451@gmail.com> <CALe9h7dSLTd7QnBwmQU_wmC7NVQxPwGpxeJknOcWvOtfbHv0-A@mail.gmail.com> <CA+aFP1AwpdYrU+YKoh0p0CRVceYHmHxCZoxyuf=fTEge2sjdVg@mail.gmail.com>
 <CALe9h7dZ-WYhWbQeOVVhNVi8Ds-wRaUTd_nzoKmOrFB_JDv_7g@mail.gmail.com> <CA+aFP1DP98bgv_XDkB6y1RunkpShHRjdpjjBPcWhU3WxS-92bg@mail.gmail.com> <CALe9h7fXGBwcWE0hpk5Bvw6RSpKtqRdUQiUOBf-SXGjrc0L+fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1730427558-1481841181=:10615"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754171AbcLOWd2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Dec 2016 17:33:28 -0500
In-Reply-To: <CALe9h7fXGBwcWE0hpk5Bvw6RSpKtqRdUQiUOBf-SXGjrc0L+fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "Dillaman, Jason" <dillaman@redhat.com>, Mykola Golub <trociny@freebsd.org>, Ceph Development <ceph-devel@vger.kernel.org>, "sepia@ceph.com" <sepia@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1730427558-1481841181=:10615
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 15 Dec 2016, John Spray wrote:
> On 15 Dec 2016 16:12, "Jason Dillaman" <jdillama@redhat.com> wrote:
>       The issue is that this is an example of a workunit pulling
>       support
>       files. You are suggesting that the workunit task now support
>       listing
>       dependent scripts that the teuthology worker task should also
>       download
>       and copy over to the test host? If so, it would definitely need
>       to be
>       done in such a way that we can still run these workunits locally
>       (outside of teuthology).
> 
> 
> Ah, I see what you mean.
> 
> In this particular case the ultimate solution is perhaps to skip the
> indirection of having a workunit that downloads and runs a test script, and
> instead have a teuthology task that just executes the test explicitly (skip
> the bash part)
> 
> However I haven't checked exactly how many tests might need reworking that
> way so if its a lot then we might need a CEPH_REPO var into work units to go
> with the CEPH_REF

This category of tests are fixed by 
https://github.com/ceph/ceph/pull/12511.  The workunit task already does a 
git checkout.  The fix is to run the workunits directly out of the 
checkout directory, and to fix the tests to use relative paths.

CEPH_BASE is also set to the base dir of the checkout, in case that's 
useful.

I'm not sure we need CEPH_REPO since the checkout is already there..

If there are other tests that are still broken, let me know!
sage


 > 
> John
> 
> 
>       On Thu, Dec 15, 2016 at 11:04 AM, John Spray <jspray@redhat.com>
>       wrote:
>       > On Thu, Dec 15, 2016 at 3:54 PM, Jason Dillaman
>       <jdillama@redhat.com> wrote:
>       >> Correct me if I am wrong, but since we are just installing
>       RPMs, I
>       >> wouldn't expect the full source tree to be available on the
>       test host.
>       >> The test scripts would still need to pull the correct scripts
>       from
>       >> git. Preferably, it would be nice if we can get a new
>       environment
>       >> variable that includes the full git url with the branch/sha1
>       already
>       >> embedded. That would allow testing any script changes on
>       teuthology
>       >> w/o forcing a push to ceph-ci and creating an unnecessary
>       build.
>       >
>       > I'm thinking that rather than teuthology (the process
>       executing
>       > workunit.py) calling a git command on the test host, it would
>       take its
>       > local copy of the script (i.e. relative to workunit.py
>       > ../../../qa/workunits etc) and send that directly.
>       >
>       > I think we can already avoid pushing test-only changes to
>       ceph-ci,
>       > because there are separate options for ceph vs. suite branches
>       (even
>       > though both point at ceph.git forks).  So when I want to test
>       a
>       > qa-suite change, I would use --suite-repo <github /jcsp/ path>
>       > --suite-branch wip-whatever.  That would get the workunits
>       from
>       > wip-whatever.
>       >
>       > John
>       >
>       >>
>       >> On Thu, Dec 15, 2016 at 10:46 AM, John Spray
>       <jspray@redhat.com> wrote:
>       >>> On Thu, Dec 15, 2016 at 3:00 PM, Mykola Golub
>       <trociny@freebsd.org> wrote:
>       >>>> On Thu, Dec 15, 2016 at 04:51:44PM +0200, Mikolaj Golub
>       wrote:
>       >>>>> Hi, Sage,
>       >>>>>
>       >>>>> It looks like we still need to push testing branches to
>       ceph.git for
>       >>>>> things like below?
>       >>>>>
>       >>>>> qa/workunits/rbd/test_librbd_python.sh:
>       >>>>>
>       >>>>> wget -O test_rbd.py"https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=$CEPH_REF;f=src/test/pybi
>       nd/test_rbd.py" || \
>       >>>>>     wget -O test_rbd.py"https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=ref/heads/$CEPH_REF;f=src
>       /test/pybind/test_rbd.py"
>       >>>>>
>       >>>>> Do we have some env variable (CEPH_REPO?) we could use
>       simirlaly to
>       >>>>> CEPH_REF here?
>       >>>>
>       >>>> Or rather may be now we can avoid such hacks at all?
>       >>>
>       >>> Exactly - as you notice bits like that, let's convert them
>       to just
>       >>> read their files locally instead of trying to fetch them
>       from git.  I
>       >>> guess the workunit task will be the major one here, if
>       nobody already
>       >>> adjusted it.
>       >>>
>       >>> John
>       >>>
>       >>>> --
>       >>>> Mykola Golub
>       >>>> --
>       >>>> To unsubscribe from this list: send the line "unsubscribe
>       ceph-devel" in
>       >>>> the body of a message to majordomo@vger.kernel.org
>       >>>> More majordomo info at 
>       http://vger.kernel.org/majordomo-info.html
>       >>> _______________________________________________
>       >>> Sepia mailing list
>       >>> Sepia@lists.ceph.com
>       >>> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
>       >>
>       >>
>       >>
>       >> --
>       >> Jason
>       > --
>       > To unsubscribe from this list: send the line "unsubscribe
>       ceph-devel" in
>       > the body of a message to majordomo@vger.kernel.org
>       > More majordomo info at 
>       http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Jason
> 
> 
> 
> 
--8323329-1730427558-1481841181=:10615--
