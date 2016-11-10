From: Loic Dachary <loic@dachary.org>
Subject: Re: starting with jewel v10.2.5
Date: Thu, 10 Nov 2016 11:44:41 +0100
Message-ID: <edf0820f-4ffc-223c-1804-e817a9d77fd2@dachary.org>
References: <5811D09C.9080307@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37207 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755024AbcKJKpR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Nov 2016 05:45:17 -0500
In-Reply-To: <5811D09C.9080307@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, Abhishek Lekshmanan <abhishek@suse.com>

Hi,

For the record the plan was implemented (i.e. using jewel-next until 10.2.4 is released):

* Documentation http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_keep_backporting_while_the_release_branch_is_frozen
* jewel 10.2.5 backports http://tracker.ceph.com/issues/17851
* all PR re-targeted to jewel-next https://github.com/ceph/ceph/milestone/8
* tests running on jewel-backports (integration branch with ~40 PRs) http://tracker.ceph.com/issues/17851#note-2

The only unforseen inconvenience is that we must not use the ceph-workbench script to set the release version after merging because it relies on the existing tags to figure out which is next. This is however self discipline that only is a concern for backporters and will be transparent to everyone else. Ideally ceph-workbench is patched to address that but I'd rather wait until we are sure the plan to keep backporting while testing actually is helpful.

Cheers

On 27/10/2016 12:02, Loic Dachary wrote:
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
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
