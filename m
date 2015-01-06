From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph backports
Date: Mon, 5 Jan 2015 21:30:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501052111580.10525@cobra.newdream.net>
References: <54AA7B46.6090706@dachary.org> <CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com> <54AA80AD.2010901@dachary.org> <CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com> <54AB2887.8000503@dachary.org>
 <CAC6JEv-uzfzEtLb5X29ne2ME7gTDeysByG0DDJRNZxBQ2WCUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58560 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbAFFax (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 00:30:53 -0500
In-Reply-To: <CAC6JEv-uzfzEtLb5X29ne2ME7gTDeysByG0DDJRNZxBQ2WCUEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 5 Jan 2015, Gregory Farnum wrote:
> On Mon, Jan 5, 2015 at 4:12 PM, Loic Dachary <loic@dachary.org> wrote:
> > :-) This process is helpful if it allows me to help a little more than I currently do with the backport process. It would be a loss if the end result is that everyone cares less about backports. My primary incentive for sending this mail is to start the conversation and avoid that kind of unintended drawback.
> 
> Why do you want to get involved with other people's backports at all?

Because Ian and I asked.  :)

> I don't mean that to sound possessive, but having the patch's primary
> author responsible for getting backports done at least has the
> singular merit of sharding the work up into manageable pieces. ;)

We have a huge backlog of backports and need some process to move them 
forward.  The goals are to

 - have some process that prevents backports from lingering
   indefinitely
 - test everything in an integration branch before pushing
   to the $stable branch
 - let QE handle the actual integration branch testing
 - limit time investment by leads where possible

> > Here is a revised process which is hopefully more realistic:
> >
> > 0. Developer follows normal process to land PR to master. Once complete and ticket is marked Pending Backport this process initiates.
> > 1. I periodically polls Redmine to look for tickets in Pending Backport state and focus on the ones that are left unattended for too long
> > 1a. Under the supervision of the author of the original patch, I find the commits associated with the Redmine ticket and Cherry Pick to the backport integration branch off of the desired maintenance branch (Dumping, Firefly, etc).
> > 1b. I resolve any merge conflicts with the cherry-picked commit
> > 2. I merge all backports for a given branch in an integration branch
> > 3. I ask the leads of each project to review the integration
> > 4. Once satisfied with group of backported commits to integration branch, I notify QE.
> > 5. QE tests backport integration branch against appropriate suites
> > 6a. If QE is satisfied with test results, they merge backport integration branch.
> > 6b. If QE is NOT satisfied with the test results, they indicate backport integration branch is NOT ready to merge and return to me to work with original Developer to resolve issue and return to steps 2/3
> > 7. Ticket is moved to Resolved once backport integration branch containing cherry-picked backport is merged to the desired mainteance branch(es)
> >
> > What do you think ?
> 
> I think if we're going to add a process to anything it should be
> followed by everybody involved. I really would love for everything to
> be gated by QE before it goes into a backport branch, but if you're
> going off and building integration branches and QE is testing them, I
> think other people are going to keep backporting as we have been and
> trip all over each other. We've periodically used "firefly-next"
> branches and related things, but it's always been ad-hoc.
> 
> Something more realistic might involve locking down the stable
> branches so they can only be merged into by QE or some approved group,
> and then letting people do their own backports onto a
> <stable-branch>-next that is periodically taken up and
> integration-tested prior to merge into the LTS proper. That ensures
> that only patches which have all been tested together get into a
> stable branch without forcing each individual backport into a lot of
> process.

That sounds more or less like what Loic proposed, except that leads are 
always doing the backports.  I'm not sure that will scale, and lots of 
fixes are simple and don't need a huge amount of attention.  I agree that 
it'd be great to have a common workflow, though.

I think the idea is as much to have someone driving the process ("should 
this get backported now?  oh, you want to do it?  ok, ping me when you 
have a PR ready") as to dictate that they do the actual backports.

Maybe we augment Loic's list by changing (1) so that anybody can do 
the backport and open a pull request to merge to the $stable branch.  
The original patch author can do it (ideally at the same time as 
the original fix, espeically when non-trivial), the lead can do 
it, or Loic (or anyone) can do it.

The key piece is that the redmine tickets are regularly polled to ensure 
the backports get done.  We can note things like "wait a few weeks before 
backport" in the ticket or the backport pull request, or possibly in an 
explicit redmine field, depending on how formal we want to be.  (I'd say 
start simple.)

Then Loic (or whoever) prepares an integration branch and passes it to QE 
to test.  If the tests go well, the pull requests can be merged.  
Conflicts here are generally pretty rare, but when present and non-trivial 
the obviously others can review as needed.

?

sage
