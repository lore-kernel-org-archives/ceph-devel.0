From: John Spray <jspray@redhat.com>
Subject: Re: ceph-mgr is in master
Date: Tue, 4 Oct 2016 13:16:58 +0100
Message-ID: <CALe9h7dHVfTJgi-JBMiXtxAO9wLWJ5_N0TiE+hk0eg52DV420g@mail.gmail.com>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
 <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
 <CALe9h7eZO2XCWqmMhM+hiJqSgmLPLqs5yBgyOD-6sRCYDD3jDQ@mail.gmail.com> <bf4c0368-09f1-0f6d-16c3-ed7a321cba51@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34504 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbcJDMRU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Oct 2016 08:17:20 -0400
Received: by mail-qk0-f176.google.com with SMTP id j129so181512407qkd.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Oct 2016 05:17:19 -0700 (PDT)
In-Reply-To: <bf4c0368-09f1-0f6d-16c3-ed7a321cba51@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Oct 4, 2016 at 1:03 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 4-10-2016 08:07, John Spray wrote:
>> As Dan says, `ceph tell` is the new one, the one that sends commands
>> directly from the CLI to the named service (not via the mon).
>> However, this is a bit of a placeholder, as we'll eventually be
>> switching to some commands (especially PG stats ones) to silently go
>> to the mgr instead of the mon.  There are various ways of
>> accomplishing that, the simplest one is to have the CLI fetch both mgr
>> and mon command descriptions, and preferentially send commands to
>> matching entries from the mgr.
>
> ATM I had to disable building MGR, because Clang/Python/FreeBSD throw a
> fit when having to compile on of the python files...
> Something to do with function-signatures not matching.
> I'll look into it after I've completed most of my other blocking
> problems. Unless you'd really want to have the compiler errors now, I'll
> fireup a build with MGR on.

Ah... yeah, I do seem to recall some places the compiler warned about
(perfectly safe) const char* casts.  I'll look into cleaning that up,
assuming it's what's making clang unhappy.

> Just hope that this switch is not enforced before that...
> And I'd then expect the WITH_MGR flag to go away?

Yeah, I think it would be reasonable to remove it some time before
Luminous, or whenever we move essential user-facing stuff (like pg
dump commands) into mgr so that it ceases to be optional.

John

>
> --WjW
>
