From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: "Inherit members" on redmine subprojects
Date: Tue, 21 Nov 2017 02:21:20 +1100
Message-ID: <CAJ4mKGb7vSSEq1rnKgekeDNWq8T73e0_YL_Yt9xBv_NZ-qk2Wg@mail.gmail.com>
References: <CALe9h7ffKQ9C86ovTh3oGwQgAVSo93u8fD_OwJ8YvgAUD83auw@mail.gmail.com>
 <CAJ4mKGY7u9Jr5yj-cpgDhPprCopTbyH4ZJiWcCPym73DT7iMjA@mail.gmail.com> <CALe9h7exV_yEY0qj2b5WK28TqgM08C-L39aFDYm9wYMc_2DsTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35371 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbdKTPVW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Nov 2017 10:21:22 -0500
Received: by mail-io0-f174.google.com with SMTP id i38so16093968iod.2
        for <ceph-devel@vger.kernel.org>; Mon, 20 Nov 2017 07:21:21 -0800 (PST)
In-Reply-To: <CALe9h7exV_yEY0qj2b5WK28TqgM08C-L39aFDYm9wYMc_2DsTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 21, 2017 at 2:10 AM, John Spray <jspray@redhat.com> wrote:
> On Mon, Nov 20, 2017 at 3:05 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Mon, Nov 20, 2017 at 11:36 PM, John Spray <jspray@redhat.com> wrote:
>>> I just noticed that redmine has this option to have subprojects
>>> inherit their permissions from the parent project.  It seems like a
>>> sensible idea that if some has a role on the toplevel "Ceph" project
>>> they'd have access to the subprojects too -- anybody remember a
>>> historical reason we don't have this box ticked for most of the
>>> subprojects?
>>
>> Redmine's preferences make Ceph's look compact. ;) Where exactly are
>> you looking at? Sometimes option titles are misleading, and at this
>> point I think permission handling is mostly through the groups rather
>> than as individuals.
>
> It's the one on the first "Information" tab under settings for each
> project, after "subproject of".

Ah. Just from googling briefly, it looks like this option didn't exist
when we set stuff up. Unless we have an issue with permissions we know
about I'd be hesitant to flip random checkboxes like that just because
I know some of the subprojects really do want different membership,
and AFAIK the group-based permissions are working fine right now.
