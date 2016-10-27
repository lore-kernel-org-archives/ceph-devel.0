From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: starting with jewel v10.2.5
Date: Thu, 27 Oct 2016 12:19:23 +0200
Message-ID: <278431d9-747e-baf6-90f5-8980c992a1c6@suse.cz>
References: <5811D09C.9080307@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753138AbcJ0Oyg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 27 Oct 2016 10:54:36 -0400
In-Reply-To: <5811D09C.9080307@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>

On 10/27/2016 12:02 PM, Loic Dachary wrote:
> Hi Abhishek & Nathan & Abhishek,
>
> Hopefully jewel will start testing with QE tomorrow or early next week.
>
> In the past we kept backporting but we were very careful not to merge anything because the release process is not able to work with a SHA1, it will create the next jewel release with whatever is at the tip of that branch. This limitation has been there for years and there is little chance that it will be resolved any time soon. It routinely creates frustration when something is merged by accident and tests have to be run again (or worse: they are not run and the release is done anyway). It also creates extra work for the backporters who need to collect backports that could have been merged because they passed the tests.
>
> Instead, I propose that we backport, test and merge to wip-jewel, as if it was the jewel branch, until the release is done. And when it's done we rebase wip-jewel on top of jewel (or we verify that there is no need to rebase), we push all commits from wip-jewel to jewel, we delete the wip-jewel branch and we resume backporting to the jewel branch.
>
> In a nutshell it means we have a little extra work:
>
> a) re-targeting backports to wip-jewel in each PR (which is now possible with github)
> b) pushing wip-jewel to jewel after the release and re-targeting backports to jewel
>
> And the benefits are that
>
> a) we don't have to stop merging while QE runs tests and the release is prepared, which takes a few weeks
> b) there is no risk of an accidental merge that would break the release process
>
> What do you think ?

I wouldn't say it completely removes the risk of an accidental merge to 
jewel, but it certainly reduces it :-)

Anyway, it sounds good to me. The only awkwardness is that it will 
require existing backport PRs to be closed and reopened (AFAIK there is 
no other way to "retarget" a PR to a different branch).

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
