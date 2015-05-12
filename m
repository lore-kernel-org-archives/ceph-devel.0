From: Ken Dreyer <kdreyer@redhat.com>
Subject: Merging PRs on the command line
Date: Tue, 12 May 2015 15:58:09 -0600
Message-ID: <55527771.6060401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57335 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbbELV6K (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 May 2015 17:58:10 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id B657A8EA49
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 21:58:10 +0000 (UTC)
Received: from mbp.ktdreyer.com (vpn-48-128.rdu2.redhat.com [10.10.48.128])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4CLw9sr015710
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 17:58:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,

I was reading over some of the HOWTO docs in the wiki, and saw the steps
here:

http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_the_integration_branch

It looks like you're using curl to get the title of the PR, populating
the commit message, etc.

I've found that GitHub's "hub" utility is really great for simplifying
this. I typically merge PRs in GitHub by running the following in my
local clone:

  git checkout master
  git pull
  hub merge https://github.com/ceph/ceph/pull/4658
  git commit --amend (to add my "Reviewed-by" line to the merge commit)
  git push

The hub utility uses GitHub's APIs to automatically add a
non-fast-forward commit with a "regular" commit message that looks
more-or-less identical to the one that I'd get if I clicked the "Merge"
button in the web UI.

The thing that sold me on this is that all the merge commits are
authored by "kdreyer@redhat.com" instead of my personal email address. I
found that when I clicked the "Merge" button in GitHub's web UI, the
merge commits were authored by my primary email address for my
"ktdreyer" GitHub UID, which isn't really what I want for Ceph.

- Ken
