From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Disabling the "old" dashboard in the dashboard v2 pull request?
Date: Wed, 14 Feb 2018 14:40:03 +0000
Message-ID: <1f16b6b9-5f02-6232-b344-05233908f987@suse.de>
References: <8dfb4e57-8413-8fa1-6712-2ed31a8ba6a1@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030759AbeBNOkG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:40:06 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A93CAED9
        for <ceph-devel@vger.kernel.org>; Wed, 14 Feb 2018 14:40:04 +0000 (UTC)
In-Reply-To: <8dfb4e57-8413-8fa1-6712-2ed31a8ba6a1@suse.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lenz Grimmer <lgrimmer@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 02/14/2018 11:44 AM, Lenz Grimmer wrote:
> Are there any objections/concerns about aiming at replacing the original
> dashboard with the initial v2 submission?

I do think it makes sense to only have one dashboard, and to have v2 
replacing the current dashboard.

I do not think it needs to happen on the PR introducing `dashboard v2` 
to the ceph project though, especially because the act of "replacing" 
the dashboard (if it actually means a full removal) will entail a lot of 
deleted lines of code.

Instead, I'd suggest the initial PR to perform a

   `git mv dashboard dashboard_legacy`

or something similar, and introduce dashboard_v2 as the new dashboard. 
Once that's merged, then we can have a PR removing the current dashboard 
or whatever people are comfortable doing.

However, one thing comes to mind:

Given v2 is currently using the `dashboard_v2` namespace, which I'm 
guessing also means its own config-key namespace --different from 
`dashboard`--, we need to ensure that once v2 is renamed to `dashboard` 
it still plays nice with any and all things that have been set through 
config-key for the previous dashboard.

Maybe this is not a problem, but if the dashboard v2 code is currently 
using config-key to set options (I think at least the admin user/pass 
is, right?), I'd ensure that transitioning from the current dashboard to 
the new is as seamless as possible.


   -Joao
