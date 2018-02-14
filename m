From: John Spray <jspray@redhat.com>
Subject: Re: Disabling the "old" dashboard in the dashboard v2 pull request?
Date: Wed, 14 Feb 2018 15:48:04 +0000
Message-ID: <CALe9h7cBT6WEiZ-cxhs4Kwq9TDVotQU+dJnqE7gw-W=xFHK_Xw@mail.gmail.com>
References: <8dfb4e57-8413-8fa1-6712-2ed31a8ba6a1@suse.com> <1f16b6b9-5f02-6232-b344-05233908f987@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38181 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031671AbeBNPs0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Feb 2018 10:48:26 -0500
Received: by mail-wr0-f179.google.com with SMTP id n7so409434wrn.5
        for <ceph-devel@vger.kernel.org>; Wed, 14 Feb 2018 07:48:26 -0800 (PST)
In-Reply-To: <1f16b6b9-5f02-6232-b344-05233908f987@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: Lenz Grimmer <lgrimmer@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 14, 2018 at 2:40 PM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 02/14/2018 11:44 AM, Lenz Grimmer wrote:
>>
>> Are there any objections/concerns about aiming at replacing the original
>> dashboard with the initial v2 submission?
>
>
> I do think it makes sense to only have one dashboard, and to have v2
> replacing the current dashboard.
>
> I do not think it needs to happen on the PR introducing `dashboard v2` to
> the ceph project though, especially because the act of "replacing" the
> dashboard (if it actually means a full removal) will entail a lot of deleted
> lines of code.
>
> Instead, I'd suggest the initial PR to perform a
>
>   `git mv dashboard dashboard_legacy`
>
> or something similar, and introduce dashboard_v2 as the new dashboard. Once
> that's merged, then we can have a PR removing the current dashboard or
> whatever people are comfortable doing.

Seems reasonable to me.  I'm happy for the "v1" dashboard code to go
away quickly, but yeah, there's no need to literally have all the
removal LOC in the same PR.

> However, one thing comes to mind:
>
> Given v2 is currently using the `dashboard_v2` namespace, which I'm guessing
> also means its own config-key namespace --different from `dashboard`--, we
> need to ensure that once v2 is renamed to `dashboard` it still plays nice
> with any and all things that have been set through config-key for the
> previous dashboard.
>
> Maybe this is not a problem, but if the dashboard v2 code is currently using
> config-key to set options (I think at least the admin user/pass is, right?),
> I'd ensure that transitioning from the current dashboard to the new is as
> seamless as possible.

Yep, this came up yesterday -- I'm expecting that the new dashboard
will just use the same setting names where it makes sense, and
magically inherit the configuration.

John

>
>
>   -Joao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
