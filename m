From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: pools without rules
Date: Mon, 31 Oct 2016 13:33:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610311332100.20331@piezo.us.to>
References: <CA+LTicvDBOTt=d-W8FzgBbpmxrgtM0VFWKFFoEspk+Wekr2deA@mail.gmail.com> <CA+LTicsMfaG4C-yL_VGPMuKV0+gmXaTR+E9-1JrNYTgM0g9Drg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54954 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942972AbcJaNdz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2016 09:33:55 -0400
In-Reply-To: <CA+LTicsMfaG4C-yL_VGPMuKV0+gmXaTR+E9-1JrNYTgM0g9Drg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Calcote <john.calcote@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 30 Oct 2016, John Calcote wrote:
> Hi all -
> 
> I posted this question to the ceph-user list a few days ago but no one
> responded, so I thought I'd send it to the devel list too:
> 
> What happens if I create a pool and associated it with a ruleset (say,
> set '2', for instance), and then I remove all the rules from set '2'?
> 
> Similarly, what happens if I add a single rule to ruleset 2 that's
> size-constrained to pools of size 2 - 3, but then create a replicated
> pool of size 4 using that ruleset?
> 
> Is there a fundamental rule that ceph uses (e.g., random selection) to
> choose osds on which to store the replicas?

1- Ceph mon's should prevent you from removing the rule.  If not, that's a 
usability bug.

2- If you somehow get to the point where there is no rule, the PGs 
map to an empty set of OSDs, and they'll probably just show up as 'stale' 
+ something or inactive until you fix the pool to point to a valid 
crush rule.

3- Most of the rule "set" logic has been deprecated/streamlined so that 
for new clusters and new rules there is only one rule per ruleset and the 
ids match up.

sage
