From: Sage Weil <sweil@redhat.com>
Subject: Re: Resolving the ruleno / ruleset confusion
Date: Fri, 8 Aug 2014 07:12:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408080703370.18917@cobra.newdream.net>
References: <53E4D2C5.8050600@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53842 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbaHHOMI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 10:12:08 -0400
In-Reply-To: <53E4D2C5.8050600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ma Jianpeng <majianpeng@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 8 Aug 2014, Loic Dachary wrote:
> Hi,
> 
> As you noticed, there are places where ruleset and ruleno / ruleid are used interchangeably although they are not. This is a source of subtle bugs that can be hard to trace. By default ruleid and ruleset are the same, but dumping a crush map including
> 
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step chooseleaf firstn 0 type host
>         step emit
> }
> rule metadata {
>         ruleset 1
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step chooseleaf firstn 0 type host
>         step emit
> }
> 
> and swapping the rules as follows
> 
> rule metadata {
>         ruleset 1
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step chooseleaf firstn 0 type host
>         step emit
> }
> 
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step chooseleaf firstn 0 type host
>         step emit
> }
> 
> will have ruleset 1 with rule id 0 and ruleset 0 with rule id 1
> 
> Since the ruleset is the only reliable number, from the user point of 
> view, we could simply change CrushWrapper.h to never return the rule id 
> and assume only ruleset are given in argument, even where it currently 
> claims to be a rule id.

I'm worried about making that sort of change in an internal interface.  
And, more generally, about CRUSH maps in the wild that may have odd 
mappings that we don't want to break with subtle changes (even fixes).  :/

> The downside is that looking up the ruleset implies iterating over all 
> the rules, but that's probably not an issue.
> 
> What do you think ?

I sat down a few months ago and tried to figure out if we could get rid of 
the ruleset concept entirely and simply map pools directly to rules 
(which are the things the user conceptually thinks about, we name, etc.).  
The original motivation for a ruleset was to be able to adjust the pool 
replication factor and have the system adjust the placement behavior 
accordingly, but in reality that is a pretty useless capability: num_rep 
rarely changes, and when it does you can simply adjust the placement rule 
at the same time.  Unfortunately, I didn't come up with any easy and 
clean way to do it and gave up.

I think we should try again.  Getting rid of this particular wart will 
save us a lot of confusion and complexity and improve the user/admin 
experience significantly...

My suspicion is that we may need to have a explicit 'upgrade' validation 
step that rejiggers an existing CRUSH map to remap ruleids and rulesets to 
map to each other, and enforce that constraint on the cluster.  Then we 
could get away with renaming the field and clean up all the admin tools 
and such based on that constraint.  Then, in a year or two, we can change 
the actual placement code to drop the ruleset logic.  Otherwise we'll need 
to set incompatible feature bits and force clients to update and so on, 
which we want to avoid...

sage
