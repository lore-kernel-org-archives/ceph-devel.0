From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: [sepia] how to use teuthology-suite in the new world
Date: Thu, 15 Dec 2016 16:51:44 +0200
Message-ID: <20161215145143.GA1451@gmail.com>
References: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38799 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758382AbcLOOvr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 09:51:47 -0500
Received: by mail-wm0-f54.google.com with SMTP id f82so49619362wmf.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 06:51:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, "sepia@ceph.com" <sepia@ceph.com>

Hi, Sage,

It looks like we still need to push testing branches to ceph.git for
things like below?

qa/workunits/rbd/test_librbd_python.sh:

wget -O test_rbd.py "https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=$CEPH_REF;f=src/test/pybind/test_rbd.py" || \
    wget -O test_rbd.py "https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=ref/heads/$CEPH_REF;f=src/test/pybind/test_rbd.py"

Do we have some env variable (CEPH_REPO?) we could use simirlaly to
CEPH_REF here?

On Wed, Dec 14, 2016 at 10:22:31PM +0000, Sage Weil wrote:
> Please read carefully if you use teuthology:
> 
> ceph-qa-suite.git is no more.  All tests are now in qa/tasks, qa/suite, 
> and so on.  The directory structure is the same (but now prefixed with 
> qa/) and the git history is intact.
> 
> If you have any pull requests outstanding against ceph-qa-suite, you'll 
> need to redo them as a pull-request against ceph.git.
> 
> Jenkins + shaman will build packages for both ceph.git and ceph-ci.git.
> 
> You should only push official branches (master, kraken, jewel, etc.) to 
> ceph.git.
> 
> You should only push a branch to ceph-ci.git if you need packages built.  
> I suggest
> 
>   git remote add ci git@github.com:ceph/ceph-ci
> 
> Teuthology now defaults to https://github.com/ceph/ceph-ci.git instead of 
> ceph.git.
> 
> To schedule a test against something in ceph-ci.git,
> 
>   teuthology-suite -s rados -c wip-foo
> 
> To schedule against something in ceph.git (e.g., master),
> 
>   teuthology-suite -s rados -c master --ceph-repo https://github.com/ceph/ceph.git
> 
> In both of these cases, the tests (tasks/ and suite/ yamls) are taken from 
> the same repo and branch that we used to resolve your branch name to a 
> sha1 (shaman builds are identified by sha1).
> 
> To schedule a test against a suite branch that is different from the ceph 
> branch you can use --suite-repo and --suite-branch.  For example,
> 
>   teuthology-suite -s rados -c wip-mybuild \
> 	--suite-repo https://github.com/liewegas/ceph.git \
> 	--suite-branch wip-my-updated-test-case
> 
> This is not new, but if you want teuthology-suite to find the most recent 
> build for a branch (useful when master is moving quickly but you just need 
> a recent build) you can use -n <max # commits to backtrack>:
> 
>   teuthology-suite -s rados -c master \
> 	--ceph-repo https://github.com/ceph/ceph.git \
> 	-n 10
> 
> sage
> _______________________________________________
> Sepia mailing list
> Sepia@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com

-- 
Mykola Golub
