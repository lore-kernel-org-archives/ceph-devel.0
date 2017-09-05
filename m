From: Sage Weil <sweil@redhat.com>
Subject: Re: build-integration-branch
Date: Tue, 5 Sep 2017 14:08:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709051406000.20435@piezo.novalocal>
References: <alpine.DEB.2.11.1708302045570.20435@piezo.novalocal> <CA+2bHPbwsUwpp7k1P=54uet1SsW7PKDX_U=4xgj=tbPOKN3yiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdIEOIp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Sep 2017 10:08:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24FC1750C1
        for <ceph-devel@vger.kernel.org>; Tue,  5 Sep 2017 14:08:45 +0000 (UTC)
In-Reply-To: <CA+2bHPbwsUwpp7k1P=54uet1SsW7PKDX_U=4xgj=tbPOKN3yiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 4 Sep 2017, Patrick Donnelly wrote:
> On Wed, Aug 30, 2017 at 1:58 PM, Sage Weil <sweil@redhat.com> wrote:
> > I got tired of doing this by hand and finally wrote a script to do it
> > instead:
> >
> >         https://github.com/ceph/ceph/pull/17382
> >
> > Go tag your PRs with wip-whatever-testing, then
> >
> >  git checkout master
> >  git pull
> >  ../src/script/build-integration-branch wip-whatever-testing
> >  make && ctest -j12 && git push ci $(git rev-parse --abbrev-ref HEAD)
> 
> I figure I'll share my own integration branch script (attached) which
> is based on some work John Spray did. It's probably too specific to my
> own workflow but pieces can be pulled out to suit others' needs.
> 
> How it's used:
> 
> $ python2 ptl_tool.py pr#1 pr#2 [...]
> 
> which does:
> 
> 1) Builds a branch based on refs/upstream/heads/master named
> wip-$NAME-testing-$DATE.
> 2) Fetches comments/reviews from GitHub for each PR, looking for
> review approvals for Reviewed-bys.
> 3) Merges refs/upstream/pull/pr#/head with a commit message including
> each commit's title and "Reviewed-by".
> 4) Labels each merged PR with "wip-$NAME-testing".
> 5) Tags the integration branch locally for posterity.
> 
> You can also then merge into master or a release branch using:
> 
> $ python2 ptl_tool.py master pr#1 [...]
> 
> and the commit message is adjusted accordingly. (Also, no testing
> label is applied as it's not an integration branch.)

Nice! Populating the merge commit with the reviewers is tedious.. 
automating that would be great. 

The one bit of the above workflow I don't much like is having to manually 
copy/paste or type the PR #'s.  It's easy to tag them in github while 
browsing reviewing, so having the tool query the tags (instead of setting 
them) seems easier (although the tool could easily support both 
workflows).

Similarly, for merging, we could make the tool merge all prs tagged with a 
label.. or give it a specific pr # (or list).

sage
