From: Alfredo Deza <adeza@redhat.com>
Subject: Re: repository build process change
Date: Wed, 30 Nov 2016 08:01:04 -0500
Message-ID: <CAC-Np1xvbgN4yiac3KLN8=TOvsFOM5CxiQEoOkfWwJgQj8niFQ@mail.gmail.com>
References: <CAC-Np1zuviMENxn-4ZWMbC78b7J2x1asxg-i3ks+7uTkfuyaRA@mail.gmail.com>
 <CAC-Np1yyC5xuCSJypa7xgJqWF9fx9h6Y9NsJdgvxajdyep56XQ@mail.gmail.com> <CALe9h7cyZ9SE8oXu2kNtWQb2Ut3FzZ_ahw4tzqWvC+eDrXwNGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34902 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933545AbcK3NBG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 08:01:06 -0500
Received: by mail-qt0-f181.google.com with SMTP id c47so186726293qtc.2
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 05:01:06 -0800 (PST)
In-Reply-To: <CALe9h7cyZ9SE8oXu2kNtWQb2Ut3FzZ_ahw4tzqWvC+eDrXwNGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 30, 2016 at 7:54 AM, John Spray <jspray@redhat.com> wrote:
> On Wed, Nov 30, 2016 at 12:49 PM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Wed, Nov 23, 2016 at 3:15 PM, Alfredo Deza <adeza@redhat.com> wrote:
>>> Starting next week we will start building binaries and repositories
>>> from the ceph-ci.git repo (https://github.com/ceph/ceph-ci).
>>>
>>> The current build process, which uses ceph.git will also continue at
>>> the same time, so there is
>>> enough time to transition over.
>>>
>>> This doesn't change anything for a developer except where it needs to
>>> push to get a repository
>>> with binaries for a given branch.
>>>
>>> After a week of correctly building from both repositories I will send
>>> a follow up email to warn of the change.
>>
>> Last night we enabled ceph-ci builds and I managed to get a
>> configuration setting wrong and builds got stuck.
>>
>> This has since been corrected and everything should be as normal. We
>> are working to enable the new ceph-ci builds this week.
>>
>> Sorry for any troubles.
>
> Is this just for the new Jenkins builds or are the gitbuilders being
> pointed at the ceph-ci repo (and/or the old repo) too?

This has nothing to do with gitbuilders. Unsure what goes on with a
gitbuilder workflow.

I am only aware of these changes (ceph.git -> ceph-ci.git) being in
place just for the new CI system.

>
> John
>
>>>
>>> Let me know if you have any questions,
>>>
>>>
>>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
