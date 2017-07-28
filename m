From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: mgr balancer module
Date: Fri, 28 Jul 2017 17:48:23 -0400
Message-ID: <43A8CF62-77CC-4804-8627-2DB86ACB52B9@redhat.com>
References: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:37128 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbdG1VsZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 17:48:25 -0400
Received: by mail-qk0-f182.google.com with SMTP id z18so44762000qka.4
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 14:48:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


> On Jul 27, 2017, at 11:51 PM, Sage Weil <sage@redhat.com> wrote:
> 
> The basics:
> 
>  ceph balancer mode <none,upmap,crush-compat,...>
> 	- which optimiation method to use
>  ceph balancer on
> 	- run automagically
>  ceph balancer off
> 	- stop running automagically

So this would leave the last CRUSH map installed by the balancer in place? Or would it restore the CRUSH map that was in place before applying running the balancer? If the former (which seems more reasonable, perhaps), is there a command to revert to the last user-applied map?
 
>  ceph balancer status
> 	- see curent mode, any plans, whehter it's enabled
> 
> The useful bits:
> 
>  ceph balancer eval
> 	- show analysis of current data distribution
>  ceph balancer optimize <plan>
> 	- create a new plan to optimize named <plan> based on the current 
> 	  mode
> 	- ceph balancer status will include a list of plans in memory 
>          (these currently go away if ceph-mgr daemon restarts)
>  ceph balancer eval <plan>
> 	- analyse resulting distribution if plan is executed
>  ceph balancer show <plan>
> 	- show what the plan would do (basically a dump of cli commands to 
> 	  adjust weights etc)
>  ceph balancer execute <plan>
> 	- execute plan (and then discard it)
>  ceph balancer rm <plan>
> 	- discard plan
> 
> A normal user will be expected to just set the mode and turn it on:
> 
>  ceph balancer mode crush-compat
>  ceph balancer on
> 
> An advanced user can play with different optimizer modes etc and see what 
> they will actually do before making any changes to their cluster.
> 
> Does this seem like a reasonable direction for an operator interface?

I think it makes sense.

Possibly unrelated: is there a way to adjust the rate of map changes manually or do we just expect the balancer to handle that automagically?

