From: Sage Weil <sage@inktank.com>
Subject: Re: Welcome message to new contributors
Date: Mon, 2 Jun 2014 05:36:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406020535040.1406@cobra.newdream.net>
References: <538AF61D.3010304@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33909 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbaFBMgg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 08:36:36 -0400
In-Reply-To: <538AF61D.3010304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 1 Jun 2014, Loic Dachary wrote:
> Hi Ceph,
> 
> TL;DR: I volunteer to install a bot that posts a welcome message to the 
> first pull request of a new contributor. Unless someone else already has 
> something ready ;-)

This sounds great.  And actually, a bot that complains about missing 
Signed-off-by: in any pull request might be useful, too.  That would make 
some noise about DNM pull requests that may have unfinished commits in 
them, but those could be ignored or the noise simply tolerated.

sage


> 
> As a new contributor you are supposed to go thru https://github.com/ceph/ceph/blob/master/SubmittingPatches and prepare the patch accordingly. But it's a long read if you're going to fix a typo. You're probably going to forget to add the Signed-off-by: in the comment, which is the only thing you really need to comply to in this case.
> 
> The bot would listen to the pull request queue and send a welcome message to new contributors (i.e. no previous Author: commit or Signed-off-by with this name). And a gentle reminder that Signed-off-by: is required if it is missing. 
> 
> Here is a gerrit example of such a message, in the context of OpenStack:
> 
> https://review.openstack.org/#/c/94195/
> 
> Welcome, new contributor!		May 19 3:44 PM
> 
> Patch Set 1:
> 
> Thank you for your first contribution to OpenStack.
> 
> Your patch will now be tested automatically by OpenStack testing frameworks
> and once the automatic tests pass, it will be reviewed by other friendly
> developers. They will give you feedback and may require you to refine it.
> 
> People seldom get their patch approved on the first try, so don't be
> concerned if requested to make corrections. Feel free to modify your patch
> and resubmit a new change-set.
> 
> Patches usually take 3 to 7 days to be reviewed so be patient and be
> available on IRC to ask and answer questions about your work. The more you
> participate in the community the more rewarding it is for you. You may also
> notice that the more you get to know people and get to be known, the faster
> your patches will be reviewed and eventually approved. Get to know others
> and become known by doing code reviews: anybody can do it, and it's a
> great way to learn the code base.
> 
> Thanks again for supporting OpenStack, we look forward to working with you.
> 
> IRC: https://wiki.openstack.org/wiki/IRC
> Workflow: https://wiki.openstack.org/wiki/Gerrit_Workflow
> 
> Cheers
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
