From: Sage Weil <sweil@redhat.com>
Subject: RE: Resolving the ruleno / ruleset confusion
Date: Fri, 8 Aug 2014 09:08:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408080859390.3410@cobra.newdream.net>
References: <53E4D2C5.8050600@dachary.org> <alpine.DEB.2.00.1408080703370.18917@cobra.newdream.net>, <53E4DFEB.40105@dachary.org> <125EBE20-6632-496D-AD2D-7E553C7E13CE@intel.com> <53E4E871.6040907@dachary.org>
 <6F3FA899187F0043BA1827A69DA2F7CC02085B6E@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54529 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbaHHQId (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 12:08:33 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC02085B6E@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Loic Dachary <loic@dachary.org>, Ma Jianpeng <majianpeng@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 8 Aug 2014, Chen, Xiaoxi wrote:
> For my side, I have seen some guys(actually more than 80% of the user I have seen in university/company)   do as the following way:
> 
> 0.What they want to do is : create a pool that located in a specified rack.
> 
> 1.Create a rule with "ceph osd crush rule create-simple myrule1 rack2 host firstn
> 2.Create a pool named mypool1
> 3.Set the ruleset of the pool, but they aren't that clear about the difference in concepts of rule and ruleset... Here they just need an ID, so they use "ceph osd crush rule ls" to list all the rules(they may imaging rule=ruleset), and then start to count, 0, 1,2, 3, aha, the ID for myrule1 is 3.  So they simply type in "ceph osd pool set mypool1 crush_ruleset 3....
> 
> In most case, this works, but actually this is not the right way to do.....

Yeah, this is exactly the sort of flow we should fix.

How about this:

Starting with Giant (or whatever), we enforce that ruleset == rule id.  
That is, the ruleset must be unique.  We have a conversion function in the 
monitor that will take an existing OSDMap (w/ embedded CRUSH map) and make 
any changes needed to make this true by giving a new ruleset to any 
rules that share, and adjusting the pools accordingly.  Moving forward, 
the mon will refuse to accept an injected CRUSH map that doesn't satisfy 
this constraint, and the new crushtool will refuse to compile one.

We set a flag on the OSDMap indicating that this invariant (one rule per 
ruleset and rule id == ruleset id) is now true.  If this flag is set, the 
mapping code can skip the old rule resolution (which searches all rules 
for a rule with the right ruleset and size) and look up the rule directly.

We also adjust crushtool decompile to say

rule replicated_ruleset {
	id 0		# do not change unnecessarily
	type replicated

instead of

rule replicated_ruleset {
	ruleset 0
	type replicated

We can continue to recognize "ruleset" instead of "id" when compiling but 
issue a warning.  We can also drop the min/max size values when 
decompiling and ignore them when compiling (and always set them to large 
numbers, like 0/255).

Then we adjust all of the mon commands to take rule ids (== ruleset ids) 
or rule name.

What do you think?
sage


> 
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org] 
> Sent: Friday, August 8, 2014 11:11 PM
> To: Chen, Xiaoxi
> Cc: Sage Weil; Ma Jianpeng; Ceph Development
> Subject: Re: Resolving the ruleno / ruleset confusion
> 
> I guess most users just think of ruleset and never finds out there are two different numbers with slightly different semantic. 
> 
> For me the use case is, 100% of the time : creating a rule via the command line and get the ruleset via dump OR create and update a rule via dump / load the osdmap, in which case I diligently (for no reason, just because it seemed right) increment the ruleset and keep them in order.
> 
> I have no use of rule ids and only use rulesets.
> 
> Cheers
> 
> On 08/08/2014 16:54, Chen, Xiaoxi wrote:
> > I think before we start bug fix or try to get rid of ruleset concept, we can start with define a reasonable use case. How we expect user to play with rule and pools.  there is no CLI to create/modify a ruleset, even worse , you are not able to get the ruleset id without dump a rule. 
> > 
> > currently the logic of command flow is really strange, user writes a rule, when he wants to use the rule,he need to find out the ruleset who contains the rule, and specified the ruleset to a pool. If the ruleset only contains a rule, the concept of ruleset is  confusing and useless, if the ruleset contains more than one rules, user may have the risk that ceph select a rule in the ruleset, but not the one he want...
> > 
> > 
> > 
> > ? 2014-8-8?22:34?"Loic Dachary" <loic@dachary.org> ???
> > 
> >>
> >>
> >> On 08/08/2014 16:12, Sage Weil wrote:
> >>> On Fri, 8 Aug 2014, Loic Dachary wrote:
> >>>> Hi,
> >>>>
> >>>> As you noticed, there are places where ruleset and ruleno / ruleid 
> >>>> are used interchangeably although they are not. This is a source of 
> >>>> subtle bugs that can be hard to trace. By default ruleid and 
> >>>> ruleset are the same, but dumping a crush map including
> >>>>
> >>>> rule data {
> >>>>        ruleset 0
> >>>>        type replicated
> >>>>        min_size 1
> >>>>        max_size 10
> >>>>        step take default
> >>>>        step chooseleaf firstn 0 type host
> >>>>        step emit
> >>>> }
> >>>> rule metadata {
> >>>>        ruleset 1
> >>>>        type replicated
> >>>>        min_size 1
> >>>>        max_size 10
> >>>>        step take default
> >>>>        step chooseleaf firstn 0 type host
> >>>>        step emit
> >>>> }
> >>>>
> >>>> and swapping the rules as follows
> >>>>
> >>>> rule metadata {
> >>>>        ruleset 1
> >>>>        type replicated
> >>>>        min_size 1
> >>>>        max_size 10
> >>>>        step take default
> >>>>        step chooseleaf firstn 0 type host
> >>>>        step emit
> >>>> }
> >>>>
> >>>> rule data {
> >>>>        ruleset 0
> >>>>        type replicated
> >>>>        min_size 1
> >>>>        max_size 10
> >>>>        step take default
> >>>>        step chooseleaf firstn 0 type host
> >>>>        step emit
> >>>> }
> >>>>
> >>>> will have ruleset 1 with rule id 0 and ruleset 0 with rule id 1
> >>>>
> >>>> Since the ruleset is the only reliable number, from the user point 
> >>>> of view, we could simply change CrushWrapper.h to never return the 
> >>>> rule id and assume only ruleset are given in argument, even where 
> >>>> it currently claims to be a rule id.
> >>>
> >>> I'm worried about making that sort of change in an internal interface.  
> >>> And, more generally, about CRUSH maps in the wild that may have odd 
> >>> mappings that we don't want to break with subtle changes (even 
> >>> fixes).  :/
> >>>
> >>>> The downside is that looking up the ruleset implies iterating over 
> >>>> all the rules, but that's probably not an issue.
> >>>>
> >>>> What do you think ?
> >>>
> >>> I sat down a few months ago and tried to figure out if we could get 
> >>> rid of the ruleset concept entirely and simply map pools directly to 
> >>> rules (which are the things the user conceptually thinks about, we name, etc.).
> >>> The original motivation for a ruleset was to be able to adjust the 
> >>> pool replication factor and have the system adjust the placement 
> >>> behavior accordingly, but in reality that is a pretty useless 
> >>> capability: num_rep rarely changes, and when it does you can simply 
> >>> adjust the placement rule at the same time.  Unfortunately, I didn't 
> >>> come up with any easy and clean way to do it and gave up.
> >>>
> >>> I think we should try again.  Getting rid of this particular wart 
> >>> will save us a lot of confusion and complexity and improve the 
> >>> user/admin experience significantly...
> >>>
> >>> My suspicion is that we may need to have a explicit 'upgrade' 
> >>> validation step that rejiggers an existing CRUSH map to remap 
> >>> ruleids and rulesets to map to each other, and enforce that 
> >>> constraint on the cluster.  Then we could get away with renaming the 
> >>> field and clean up all the admin tools and such based on that 
> >>> constraint.  Then, in a year or two, we can change the actual 
> >>> placement code to drop the ruleset logic.  Otherwise we'll need to 
> >>> set incompatible feature bits and force clients to update and so on, which we want to avoid...
> >>
> >> Understood. Even before going into this, it looks like we need a way to find all bugs like http://tracker.ceph.com/issues/9044 and fix them. Reading the code won't be enough I'm afraid. What about changing ruleno and ruleset into structs so that compilation shows where they are used interchangeably when they should not ? 
> >>
> >> Cheers
> >>
> >> --
> >> Lo?c Dachary, Artisan Logiciel Libre
> >>
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
