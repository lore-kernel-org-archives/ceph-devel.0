From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: mgr balancer module
Date: Sat, 29 Jul 2017 23:18:52 +0530
Message-ID: <CAAXqJ+ovmFtC3dNo_5R5x9cj6smFev2Q9wgXVL_4NcHQCnA2tA@mail.gmail.com>
References: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36437 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbdG2Rsy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Jul 2017 13:48:54 -0400
Received: by mail-wr0-f180.google.com with SMTP id y43so165064295wrd.3
        for <ceph-devel@vger.kernel.org>; Sat, 29 Jul 2017 10:48:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 28, 2017 at 9:21 AM, Sage Weil <sage@redhat.com> wrote:
> Hi all,
>
> I've been working off and on on a mgr module 'balancer' that will do
> automatically optimization of the pg distribution.  The idea is you'll
> eventually be able to just turn it on and it will slowly and continuously
> optimize the layout without having to think about it.
>
> I got something basic implemented pretty quickly that wraps around the new
> pg-upmap optimizer embedded in OSDMap.cc and osdmaptool.  And I had
> something that adjust the compat weight-set (optimizing crush weights in a
> backward-compatible way) that sort of kind of worked, but its problem was
> that it worked against the actual cluster instead of a model of the
> cluster, which meant it didn't always know whether a change it was making
> was going to be a good one until it tried it (and moved a bunch of data
> round). The conclusion from that was that the optmizer, regardless of what
> method it was using (upmap, crush weights, osd weights) had to operate
> against a model of the system so that it could check whether its changes
> were good ones before making them.
>
> I got enough of the OSDMap, OSDMap::Incremental, and CrushWrapper exposed
> to mgr modules in python-land to allow this.  Modules can get a handle for
> the current osdmap, create an incremental and propose changes to it (osd
> weights, upmap entries, crush weights), and apply it to get a new test
> osdmap.  And I have a preliminary eval vfunction that will analyze the
> distribution for a map (original or proposed) so that they can be
> compared.  In order to make sense of this and test it I made up a simple
> interface to interact with it, but I want to run it by people to make sure
> it makes sense.
>
> The basics:
>
>   ceph balancer mode <none,upmap,crush-compat,...>
>         - which optimiation method to use

Regarding the implementation of 'do_osd_weight', can we move the
existing 'reweight-by-utilization' and 'reweight-by-pg' to MonCommands
from MgrCommands? And then, we can simply send a command to "mon"? Or
is there way to call something like "send_command(result, 'mgr',
''...)" ?

>   ceph balancer on
>         - run automagically
>   ceph balancer off
>         - stop running automagically
>   ceph balancer status
>         - see curent mode, any plans, whehter it's enabled
>
> The useful bits:
>
>   ceph balancer eval
>         - show analysis of current data distribution
>   ceph balancer optimize <plan>
>         - create a new plan to optimize named <plan> based on the current
>           mode
>         - ceph balancer status will include a list of plans in memory
>           (these currently go away if ceph-mgr daemon restarts)
>   ceph balancer eval <plan>
>         - analyse resulting distribution if plan is executed
>   ceph balancer show <plan>
>         - show what the plan would do (basically a dump of cli commands to
>           adjust weights etc)
>   ceph balancer execute <plan>
>         - execute plan (and then discard it)
>   ceph balancer rm <plan>
>         - discard plan
>
> A normal user will be expected to just set the mode and turn it on:
>
>   ceph balancer mode crush-compat
>   ceph balancer on
>
> An advanced user can play with different optimizer modes etc and see what
> they will actually do before making any changes to their cluster.
>
> Does this seem like a reasonable direction for an operator interface?
>
> --
>
> The other part of this exercise is to set up the infrastructure to do the
> optimization "right".  All of the current code floating around to reweight
> by utilization etc is deficient when you do any non-trivial CRUSH things.
> I'm trying to get the infrastructure in place from the get-go so that this
> will work with multiple roots and device classes.
>
> There will be some restrictions depending on the mode.  Notably, the
> crush-compat only has a single set of weights to adjust, so it can't do
> much if there are multiple hierarchies being balanced that overlap over
> any of the same devices (we should make the balancer refuse to continue in
> that case).
>
> Similarly, we can't do projections and what utilization will look like
> with a proposed change when balancing based on actual osd utilization
> (what each osd reports as its total usage).  Instead, we need to model the
> size of each pg so that we can tell how things change when we move pgs.
> Initially this will use the pg stats, but that is an incomplete solution
> because we don't properly account for omap data.  There is also some
> storage overhead in the OSD itself (e.g., bluestore metadata, osdmaps,
> per-pg metatata).  I think eventually we'll probably want to build a model
> around pg size based on what the stats say, what the osds report, and a
> model for unknown variables (omap cost per pg, per-object overhead, etc).
> Until then, we can just make do with the pg stats (should work reasonable
> well as long as you're not mixing omap and non-omap pools on the same
> devices but via different subtrees).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Spandan Kumar Sahu
IIT Kharagpur
