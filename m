From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph-mgr is in master
Date: Mon, 3 Oct 2016 10:45:11 -0700
Message-ID: <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35628 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbcJCRpN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Oct 2016 13:45:13 -0400
Received: by mail-it0-f49.google.com with SMTP id r192so122333282ita.0
        for <ceph-devel@vger.kernel.org>; Mon, 03 Oct 2016 10:45:12 -0700 (PDT)
In-Reply-To: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Sep 30, 2016 at 4:24 AM, John Spray <jspray@redhat.com> wrote:
> Hi all,
>
> A big thank you to everyone who helped with the reviews, packaging and
> design discussions.  This will be included in forthcoming Kraken
> (11.2.x) release.
>
> There is a new section in the documentation:
> http://docs.ceph.com/docs/master/mgr/
>
> There is a new sub-project on tracker.ceph.com, populated with some
> issues by me:
> http://tracker.ceph.com/projects/mgr/issues
>
> Pull requests are of course welcome.
>
> At some point before Kraken I'll try to remember to send out a message
> to ceph-users to give people a heads up about this mysterious new
> daemon that's appearing on their systems.

Awesome, this is going to be great. :) A few questions just from going
over the admin guide:

1) It says to run a ceph-mgr on each monitor host. Does this mean
admins need to do this manually when setting up a cluster?

2) I gather that the way HA works is that traffic just gets directed
to whichever one the monitors pick. It seems like we'd want that to
migrate to the same host as the leader monitor when possible; is that
possible? Is it planned? Is it actually undesirable because it
increases CPU usage and network savings isn't worth that?

3) It uses "ceph tell" syntax. I thought we were moving away from
top-level "tell" commands and towards making them part of the
sub-command (eg "ceph osd tell", "ceph mgr tell"); is this a
deliberate new lease on life for that? Unintended? Something I just
made up?

-Greg
