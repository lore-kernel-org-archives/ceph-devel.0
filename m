From: John Spray <jspray@redhat.com>
Subject: Re: Questions regarding ceph -w
Date: Thu, 17 Aug 2017 11:13:12 +0100
Message-ID: <CALe9h7ed29w63Z3my=8dthn94ZusqfQNsosfT54_CKWkk=zpgA@mail.gmail.com>
References: <CAKn7kBnGqRsSuatnhJSnp=-YYq1Q9fM7Ma7oRoHzAN9F7Uy_ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34508 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdHQKNe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 06:13:34 -0400
Received: by mail-oi0-f52.google.com with SMTP id x3so61718781oia.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 03:13:33 -0700 (PDT)
In-Reply-To: <CAKn7kBnGqRsSuatnhJSnp=-YYq1Q9fM7Ma7oRoHzAN9F7Uy_ow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neha Ojha <nojha@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 17, 2017 at 2:27 AM, Neha Ojha <nojha@redhat.com> wrote:
> Hi John,
>
> I am working on the following tracker issue:
> http://tracker.ceph.com/issues/20995.
> I was wondering if you could help me figure out a couple of things -
>
> 1. What should be the expected output of only using ceph -w? Adding
> --watch-channel=* logs things properly, but as for ceph -w alone, I am
> unable to understand why I see very few log messages(in some cases
> none).

"ceph -w" just follows the cluster log at "info" severity, so if there
is nothing going to the cluster log, the command doesn't output
anything.

It used to also include the audit log, but that is now filtered out by
default, because it's usually not interesting (the administrator
doesn't need to be told what they just typed), and because it's very
hard to read (the log lines are basically JSON dumps).  All that
content is still going to the log file, it's just not visible by
default in ceph -w.

This is causing some confusion, because historically we had code that
wrote the PG status to the cluster log continuously (every 5 seconds
or so), so people are accustomed to always seeing something.  Also the
old documentation talked about this command "watching the cluster's
events" which created the impression that this was something other
than a log tailing command.

> 2. For which cases would it show log messages? Like for example, for
> "ceph osd out" it does, but not for "ceph osd in", "ceph osd pool
> create" etc.

In general you'll see messages about bad or unexpected things (every
failing health check now comes with log messages).  For actions that
are done by the administrator, the audit log is still present (if
hidden by default).  If you look at the log at "debug" level of
severity (--watch-debug), you can still see the summary prints of the
cluster maps (excluding the pg map) when they change.

The motivation behind all this is to have a cluster log that tells a
somewhat human-readable story about failures and recovery.  There is
certainly scope for adding in some more logging at carefully chosen
points, such as:
 - if a user marks an OSD out which was down, we could log that to
indicate that the user pre-empted the timeout-based "out" path.
 - when a pool is created we could print a message to say that it is
being created, and then when all its PGs are out of "creating" we
could print another message to that effect.

The key thing is to make sure the messages are intelligible to
non-expert users and that they are not overwhelming: there are a set
of guidelines here http://docs.ceph.com/docs/master/dev/logging/

John

> I would really appreciate your help on this issue.
>
> Thanks,
> Neha
