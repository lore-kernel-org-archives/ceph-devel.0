From: Sage Weil <sage@newdream.net>
Subject: Re: Proposal for a Backport tracker
Date: Fri, 22 May 2015 10:38:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505221035090.6462@cobra.newdream.net>
References: <555DC080.8050508@dachary.org> <555ED569.2090604@suse.cz> <555ED98F.8020402@dachary.org> <555EE989.5070009@suse.cz> <555F0694.1060209@suse.de> <555F0A0B.2040006@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33993 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757606AbbEVRiS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 13:38:18 -0400
In-Reply-To: <555F0A0B.2040006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Joao Eduardo Luis <joao@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 22 May 2015, Loic Dachary wrote:
> On 22/05/2015 12:36, Joao Eduardo Luis wrote:
> > On 05/22/2015 09:32 AM, Nathan Cutler wrote:
> >>> We can probably keep the original ticket in the "Pending Backport"
> >>> status until all backports are resolved, as we currently do.
> >>>
> >>>> So the question is, what will the original ticket's status be changed
> >>>> to? Resolved?
> >>>
> >>> When all backports are resolved, then we can also resolve the original
> >>> ticket. Do you forsee a problem with that ?
> >>>
> >>
> >> Yes and no. It's a scripting problem, not a workflow problem. I'll try
> >> to describe the scenario I'm envisioning:
> >>
> >> We have a simple script that loops over all tickets with status "Pending
> >> Backport". We run it once per week. The first week we run it, the script
> >> finds 3 such tickets. For each one it creates a ticket in the Backport
> >> tracker.
> >>
> >> A week goes by, during which developers marked 4 more tickets "Pending
> >> Backport". It's time to run the script again. Since it is looping over
> >> all tickets marked "Pending Backport", it now finds 7 such tickets: 3
> >> from last week and the 4 new ones. For each one it dutifully creates a
> >> new ticket in the Backport tracker. Now we have duplicate Backport
> >> tickets for 3 bugfixes.
> >>
> >> But I guess it will be trivial to make the script check if a Backport
> >> ticket is already open and refrain from opening a new one in this case.
> > 
> > Alternatively, adding a new state to the tracker that distinguishes
> > between tickets that are pending being picked up on by the stable
> > releases team vs those that are just pending the backport.  Say, "Mark
> > for Backport" vs "Pending Backport".
> > 
> 
> I liked the idea, wrote a reply and then realized: that won't save the 
> script from checking if the reality matches the status. Sometimes the 
> "backports" field is updated to remove or add a new backport target. It 
> may mean closing or creating the corresponding issue and for that the 
> script will have to query the backport tracker.

Being dependent on the states feel fragile to me, especially adding a 
"Mark for Backport" state.  It seems like the bot, once it looks at an 
issue, can look at the related backport items vs the backport field and 
make sure they exist, without worrying about the state.

But, we can't do that for all issues since all the old ones don't have 
this structure.

How about: the bot only looks at Pending Backport, and

 - ensures that linked issues exist for everything in the backport field
 - if all linked issues are resolved, changes status to Resolved.

That's it.  The only workflow requirement is that the dev who fixes the 
original bug can't simply set the ticket to Resolved (they must do Pending 
Backport) or else the process is short circuited.  This is already true 
today anyway.

This is probably already what you have in mind?

sage
