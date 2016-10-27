From: Loic Dachary <loic@dachary.org>
Subject: starting with jewel v10.2.5
Date: Thu, 27 Oct 2016 12:02:04 +0200
Message-ID: <5811D09C.9080307@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:57474 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030329AbcJ0OL6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 10:11:58 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 69AB9E240D
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 12:02:13 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>, Abhishek Lekshmanan <abhishek@suse.com>

Hi Abhishek & Nathan & Abhishek,

Hopefully jewel will start testing with QE tomorrow or early next week. 

In the past we kept backporting but we were very careful not to merge anything because the release process is not able to work with a SHA1, it will create the next jewel release with whatever is at the tip of that branch. This limitation has been there for years and there is little chance that it will be resolved any time soon. It routinely creates frustration when something is merged by accident and tests have to be run again (or worse: they are not run and the release is done anyway). It also creates extra work for the backporters who need to collect backports that could have been merged because they passed the tests.

Instead, I propose that we backport, test and merge to wip-jewel, as if it was the jewel branch, until the release is done. And when it's done we rebase wip-jewel on top of jewel (or we verify that there is no need to rebase), we push all commits from wip-jewel to jewel, we delete the wip-jewel branch and we resume backporting to the jewel branch.

In a nutshell it means we have a little extra work:

a) re-targeting backports to wip-jewel in each PR (which is now possible with github)
b) pushing wip-jewel to jewel after the release and re-targeting backports to jewel

And the benefits are that 

a) we don't have to stop merging while QE runs tests and the release is prepared, which takes a few weeks
b) there is no risk of an accidental merge that would break the release process

What do you think ?

-- 
Loïc Dachary, Artisan Logiciel Libre
