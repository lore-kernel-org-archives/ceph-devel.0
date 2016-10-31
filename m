From: John Calcote <john.calcote@gmail.com>
Subject: Re: Fwd: pools without rules
Date: Mon, 31 Oct 2016 09:59:31 -0600
Message-ID: <CA+LTicszpfwTGHH1F5Ayys2=QMP2+61DeRPWk-F52JWV4nhOLQ@mail.gmail.com>
References: <CA+LTicvDBOTt=d-W8FzgBbpmxrgtM0VFWKFFoEspk+Wekr2deA@mail.gmail.com>
 <CA+LTicsMfaG4C-yL_VGPMuKV0+gmXaTR+E9-1JrNYTgM0g9Drg@mail.gmail.com> <alpine.DEB.2.11.1610311332100.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:32887 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753204AbcJaP7f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2016 11:59:35 -0400
Received: by mail-vk0-f41.google.com with SMTP id d65so80229168vkg.0
        for <ceph-devel@vger.kernel.org>; Mon, 31 Oct 2016 08:59:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610311332100.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Thank you for the response.

First: I've been writing ceph management software for a large storage
vendor for a year now and this is the first I've heard of this. I'll
admit, all of the bits of "urban knowledge" I've picked up from more
experienced co-workers along the way has pointed me in the direction
of a single rule per ruleset with matching ids, but none of them could
tell me where they learned this "fact". Because these bits of
information were out of context and word-of-mouth in nature, I've
spent a fair amount of time pouring over the Ceph docs to determine
the "real story". All my research for the last few months - both in
the Ceph docs and in the CRUSH whitepaper, as well as from
experimentation where the docs fell short - has lead me to believe
that the intended use of rules and rulesets was different than you
suggest. Don't get me wrong - I believe you know what you're talking
about - I'm just concerned that others who are new to Ceph will come
to the same conclusions.

Second: By my experimentation with very late code, Ceph monitor does,
indeed, allow deletion of all rules in a set. It also allows the use
of a ruleset in a pool whose size is outside the size constraints of
all of the rules in the set. One thing I have NOT tried is writing to
a pool in these conditions. Now that I consider it in light of other
such situations, I'm inclined to believe that the write would hang or
fail - probably hang. (I recently set up a pool whose single crush
rule specified replicas on OSDs across more hosts than I had
available, and the write attempt simply hung, and there was no log
information in any logs to indicate a problem.)

Q: Is there something I can do to help make this issue less fuzzy for
other noobs like myself? I'd be happy to work on docs or do whatever
you suggest.

Kind regards,
John

On Mon, Oct 31, 2016 at 7:33 AM, Sage Weil <sage@newdream.net> wrote:
> On Sun, 30 Oct 2016, John Calcote wrote:
>> Hi all -
>>
>> I posted this question to the ceph-user list a few days ago but no one
>> responded, so I thought I'd send it to the devel list too:
>>
>> What happens if I create a pool and associated it with a ruleset (say,
>> set '2', for instance), and then I remove all the rules from set '2'?
>>
>> Similarly, what happens if I add a single rule to ruleset 2 that's
>> size-constrained to pools of size 2 - 3, but then create a replicated
>> pool of size 4 using that ruleset?
>>
>> Is there a fundamental rule that ceph uses (e.g., random selection) to
>> choose osds on which to store the replicas?
>
> 1- Ceph mon's should prevent you from removing the rule.  If not, that's a
> usability bug.
>
> 2- If you somehow get to the point where there is no rule, the PGs
> map to an empty set of OSDs, and they'll probably just show up as 'stale'
> + something or inactive until you fix the pool to point to a valid
> crush rule.
>
> 3- Most of the rule "set" logic has been deprecated/streamlined so that
> for new clusters and new rules there is only one rule per ruleset and the
> ids match up.
>
> sage
