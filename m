From: Sage Weil <sage@newdream.net>
Subject: Re: About the "temperature histogram" of tier-agent
Date: Tue, 28 Nov 2017 13:20:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711281319000.2819@piezo.novalocal>
References: <CAHMqkF7XOhzrQJODwOGnz-0Y8echtdQPEamcNL126w5ctW4+Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:53138 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbdK1NUn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 08:20:43 -0500
In-Reply-To: <CAHMqkF7XOhzrQJODwOGnz-0Y8echtdQPEamcNL126w5ctW4+Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mingxinliu@ubuntukylin.com, liwang@ubuntukylin.com
Cc: ceph-devel@vger.kernel.org, YuFan Chen <wiz.chen@gmail.com>

Hi MingXin, Li,

Does the below make sense to you?

Thanks!
sage


On Tue, 28 Nov 2017, YuFan Chen wrote:

> Hi,
> 
>    Before Jewel, the code uses "atime" to distinguish hot/cold data:
> 
>           agent_estimate_atime_temp() calculates the distance.
>           It means colder data gets longer distance (larger value)
> 
> 
>    In Jewel, it changes to use temperature with weight.
>             So, colder data gets smaller value.
> 
>     However, it still use the "old semantics" to determine evicting or not in
>            ReplicatedPG::agent_estimate_atime_temp();
> 
>     if (1000000 - temp_upper >= agent_state->evict_effort)
>        return false;
> 
> 
>      if there is no misunderstanding, should it change to that:
> 
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -12211,7 +12211,7 @@ bool
> ReplicatedPG::agent_maybe_evict(ObjectContextRef& obc, bool
> after_flush)
>      delete f;
>      *_dout << dendl;
> 
> -    if (1000000 - temp_upper >= agent_state->evict_effort)
> +    if (temp_upper >= agent_state->evict_effort)
>        return false;
>    }
> 
> Yu Fan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
