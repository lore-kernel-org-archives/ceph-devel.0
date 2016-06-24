From: Sage Weil <sage@newdream.net>
Subject: Re: teuthology-suite new feature: --newest [n]
Date: Fri, 24 Jun 2016 12:22:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606241222050.3223@piezo.us.to>
References: <576C6829.4010204@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34819 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbcFXMWU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2016 08:22:20 -0400
In-Reply-To: <576C6829.4010204@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: "sepia@lists.ceph.com" <sepia@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 23 Jun 2016, Dan Mick wrote:
> If you don't use teuthology-suite, you can stop reading now.
> 
> I've added a new option to teuthology-suite, --newest, that will modify
> how searching for builds works.
> 
> Currently, you can specify -c/--ceph to name a Ceph branch or -S/--sha1
> to name a specific commit.  This chooses the version of Ceph that is
> used to search for completed builds for the arch/distro/versions in your
> run. The branchname is translated to a sha1 by looking up the branch on
> a git server, and then the process is the same for both -c and -S: look
> for that sha1 to have successfully built on all gitbuilders; if it
> doesn't exist, the run fails.
> 
> With --newest, rather than failing, suite will try 'backtracking' along
> the commit history of the branch/sha1, and searching for older commits
> that have been built, backtracking as many times as you allow (by
> default, 10 commits).  So, for instance, if you specify "-c master
> --newest", suite will search for a build corresponding to the current
> HEAD of master, as usual, but, if not found, will then try HEAD^, and
> HEAD^^, and so on up to HEAD~10.  The newest commit that has a clean
> build will be used for the run, and you'll see a log message about which
> sha1 was chosen and how many commits older it was.
> 
> I expect this to be most-useful for nightly runs, but others may find it
> useful as well.  Please try it if you wish, and send questions, bugs,
> comments etc. to me or to the sepia list.

This is awesome!!

sage
