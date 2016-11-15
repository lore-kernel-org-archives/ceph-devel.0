From: Sage Weil <sage@newdream.net>
Subject: Re: Understanding encrypted OSD's and cephx
Date: Tue, 15 Nov 2016 14:27:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611151420160.29579@piezo.us.to>
References: <7a406860-1bc6-7534-9e2c-341bb6ac09eb@suse.com> <alpine.DEB.2.11.1611141608140.29579@piezo.us.to> <c343594b-b84a-ea54-c78b-52ef2d35b81d@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43121 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935175AbcKOO2E (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2016 09:28:04 -0500
In-Reply-To: <c343594b-b84a-ea54-c78b-52ef2d35b81d@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 15 Nov 2016, Owen Synge wrote:
> > and instead define a new monitor command to do all of this in one go.  
> > For example, 'osd bootstrap' could take the necessary arguments (e.g., the 
> > uuid and local key) and in one step set up the various keys for you.  I 
> > think that's going to be the most maintainable and sane solution going 
> > forward.
> 
> Having a single command to do this sounds a good long term solution.
> 
> I would add that a replay attack is still a danger, with a one command
> approach.
> 
> Using the trigger of OSD registering to prevent replay attacks, seems
> like a better compromise than making each command only work once, so
> setup can be repeated until success, and then since replay is prevented
> other keys cannot be exposed.

There are two options:

 (1) Make the command always instantiate a new osd id and set of keys, 
such that you get leaked/garbage state if there is a command resend, 
or

 (2) make the command properly idempotent.  The trick here is that we need 
to uniquely identify the bootstrap command by some piece of state that is 
private so that the command cannot be used to fetch secrets for the 
created osd.  This shouldn't really be a problem.

In the end, this will be significantly more secure than what we were doing 
before.  The recommended workflow will become

 (1) push bootstrap-{osd,mon,mds} key to host
 (2) create daemon (via new bootstrap command that is tailor-made for the 
purpose)
 (3) remove bootstrap key

Before we commit to this, there is an alternative model that does all key 
creation on some other trusted host, but it would mean a more significant 
rewrite of the ceph-disk tooling...

> > In the meantime, though... let's just change the ceph deploy test to 
> > install the admin key so that we can make the tests pass?  And set teh bug 
> > severity on this so that we make sure it's addressed in a complete way 
> > soon.
> 
> I fully agree.
> 
> Please can you (Sage) raise the bug so this plan is executed with
> appropriate timeliness, as I feel if you raise the bug it will enhance
> the importance. I would suggest you also include the replay attack issue
> in the bug report.
> 
> I will need help to understand how to change the functional test suite.
> The change will be just to issue:
> 
>     ceph-deploy admin $TARGET_NODE
> 
> before issuing:
> 
>     ceph-deploy osd create --dmcrypt $TARGET_NODE:sdb:sdc

Yep, that's it.  Should just be a few lines of code in 

https://github.com/ceph/ceph-qa-suite/blob/master/tasks/ceph_deploy.py

Thanks!
sage
