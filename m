From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 0/3] [RFC] rename files from ceph-test package
Date: Wed, 06 Feb 2013 09:30:23 +0100
Message-ID: <5112149F.4000303@bisect.de>
References: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:49971 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751754Ab3BFIa1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 03:30:27 -0500
In-Reply-To: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Hi,

any comments on these patches?

Danny

Am 04.02.2013 18:22, schrieb Danny Al-Gaaf:
> The ceph-test package contains files which are installed to /usr/bin,
> but these files have names which don't give any hint that they are
> part of ceph.
> 
> Rename the files of the ceph-test package to indicate they belong
> to ceph. Prefix them with "ceph_". Update packaging files like
> RPM spec and debian files. Add some files which are present in
> ceph-test of the RPM spec file but not in ceph-test.install.
> 
> I hope I didn't oversee any reference/call of the changed files.
> If the change gets accepted maybe some other tools outside this git
> tree needs to be updated. Let me know which projects I need to update.
> 
> Update and cleanup .gitignore files.
> 
> Danny Al-Gaaf (3):
>   ceph-test: give binaries from ceph-test package useful names
>   .gitignore: cleanup and sort entries
>   ceph-test.install: updated filelist
> 
>  .gitignore                               |  77 ++--
>  ceph.spec.in                             | 122 +++----
>  debian/ceph-test.install                 | 120 +++----
>  doc/.gitignore                           |   3 +-
>  qa/workunits/cls/test_cls_lock.sh        |   2 +-
>  qa/workunits/cls/test_cls_rbd.sh         |   2 +-
>  qa/workunits/cls/test_cls_refcount.sh    |   2 +-
>  qa/workunits/cls/test_cls_rgw.sh         |   2 +-
>  qa/workunits/libcephfs/test.sh           |   2 +-
>  qa/workunits/mon/workloadgen.sh          |   4 +-
>  qa/workunits/osdc/stress_objectcacher.sh |   2 +-
>  qa/workunits/rados/stress_watch.sh       |   2 +-
>  qa/workunits/rados/test.sh               |  24 +-
>  qa/workunits/rbd/smalliobench.sh         |   2 +-
>  qa/workunits/rbd/test_librbd.sh          |   2 +-
>  src/.gitignore                           | 173 +++------
>  src/.gitignore.orig                      | 142 ++++++++
>  src/Makefile.am                          | 586 +++++++++++++++----------------
>  src/client/test_ioctls.c                 |   2 +-
>  src/dupstore.cc                          |   2 +-
>  src/gtest/.gitignore                     |   2 +
>  src/psim.cc                              |   2 +-
>  src/test/filestore/TestFileStoreState.cc |   2 +-
>  src/test/filestore/run_seed_to.sh        |  10 +-
>  src/test/run-rbd-tests                   |   8 +-
>  src/test/test_filejournal.cc             |   2 +-
>  src/test/test_mutate.cc                  |   2 +-
>  27 files changed, 685 insertions(+), 616 deletions(-)
>  create mode 100644 src/.gitignore.orig
>  create mode 100644 src/gtest/.gitignore
> 

