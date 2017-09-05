From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: build-integration-branch
Date: Tue, 05 Sep 2017 17:28:33 +0200
Message-ID: <871snlupum.fsf@suse.com>
References: <alpine.DEB.2.11.1708302045570.20435@piezo.novalocal> <CA+2bHPbwsUwpp7k1P=54uet1SsW7PKDX_U=4xgj=tbPOKN3yiw@mail.gmail.com> <alpine.DEB.2.11.1709051406000.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:58648 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdIEP2m (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 5 Sep 2017 11:28:42 -0400
In-Reply-To: <alpine.DEB.2.11.1709051406000.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sage Weil <sweil@redhat.com> writes:

> On Mon, 4 Sep 2017, Patrick Donnelly wrote:
>> On Wed, Aug 30, 2017 at 1:58 PM, Sage Weil <sweil@redhat.com> wrote:
>> > I got tired of doing this by hand and finally wrote a script to do it
>> > instead:
>> >
>> >         https://github.com/ceph/ceph/pull/17382
>> >
>> > Go tag your PRs with wip-whatever-testing, then
>> >
>> >  git checkout master
>> >  git pull
>> >  ../src/script/build-integration-branch wip-whatever-testing
>> >  make && ctest -j12 && git push ci $(git rev-parse --abbrev-ref HEAD)
>> 
>> I figure I'll share my own integration branch script (attached) which
>> is based on some work John Spray did. It's probably too specific to my
>> own workflow but pieces can be pulled out to suit others' needs.
>> 
>> How it's used:
>> 
>> $ python2 ptl_tool.py pr#1 pr#2 [...]
>> 
>> which does:
>> 
>> 1) Builds a branch based on refs/upstream/heads/master named
>> wip-$NAME-testing-$DATE.
>> 2) Fetches comments/reviews from GitHub for each PR, looking for
>> review approvals for Reviewed-bys.
>> 3) Merges refs/upstream/pull/pr#/head with a commit message including
>> each commit's title and "Reviewed-by".
>> 4) Labels each merged PR with "wip-$NAME-testing".
>> 5) Tags the integration branch locally for posterity.

We use
http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_the_integration_branch

for populating integration branches for teuthology runs, this currently
populates all the prs in a milestone, but making it do a label should be
easy enough, also after the tests,
a simple
$ git log --oneline --merges master..integration-branch

should list all the PRs that are merge-worthy

>>
>> You can also then merge into master or a release branch using:
>> 
>> $ python2 ptl_tool.py master pr#1 [...]
>> 
>> and the commit message is adjusted accordingly. (Also, no testing
>> label is applied as it's not an integration branch.)
>
> Nice! Populating the merge commit with the reviewers is tedious.. 
> automating that would be great. 
>
> The one bit of the above workflow I don't much like is having to manually 
> copy/paste or type the PR #'s.  It's easy to tag them in github while 
> browsing reviewing, so having the tool query the tags (instead of setting 
> them) seems easier (although the tool could easily support both 
> workflows).
>
> Similarly, for merging, we could make the tool merge all prs tagged with a 
> label.. or give it a specific pr # (or list).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Abhishek 
