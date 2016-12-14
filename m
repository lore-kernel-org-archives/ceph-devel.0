From: Sage Weil <sweil@redhat.com>
Subject: how to use teuthology-suite in the new world
Date: Wed, 14 Dec 2016 22:22:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933500AbcLNWWh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Dec 2016 17:22:37 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, "sepia@ceph.com" <sepia@ceph.com>

Please read carefully if you use teuthology:

ceph-qa-suite.git is no more.  All tests are now in qa/tasks, qa/suite, 
and so on.  The directory structure is the same (but now prefixed with 
qa/) and the git history is intact.

If you have any pull requests outstanding against ceph-qa-suite, you'll 
need to redo them as a pull-request against ceph.git.

Jenkins + shaman will build packages for both ceph.git and ceph-ci.git.

You should only push official branches (master, kraken, jewel, etc.) to 
ceph.git.

You should only push a branch to ceph-ci.git if you need packages built.  
I suggest

  git remote add ci git@github.com:ceph/ceph-ci

Teuthology now defaults to https://github.com/ceph/ceph-ci.git instead of 
ceph.git.

To schedule a test against something in ceph-ci.git,

  teuthology-suite -s rados -c wip-foo

To schedule against something in ceph.git (e.g., master),

  teuthology-suite -s rados -c master --ceph-repo https://github.com/ceph/ceph.git

In both of these cases, the tests (tasks/ and suite/ yamls) are taken from 
the same repo and branch that we used to resolve your branch name to a 
sha1 (shaman builds are identified by sha1).

To schedule a test against a suite branch that is different from the ceph 
branch you can use --suite-repo and --suite-branch.  For example,

  teuthology-suite -s rados -c wip-mybuild \
	--suite-repo https://github.com/liewegas/ceph.git \
	--suite-branch wip-my-updated-test-case

This is not new, but if you want teuthology-suite to find the most recent 
build for a branch (useful when master is moving quickly but you just need 
a recent build) you can use -n <max # commits to backtrack>:

  teuthology-suite -s rados -c master \
	--ceph-repo https://github.com/ceph/ceph.git \
	-n 10

sage
