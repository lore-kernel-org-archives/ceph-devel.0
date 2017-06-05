From: John Spray <jspray@redhat.com>
Subject: Re: health checks and logging
Date: Mon, 5 Jun 2017 23:46:27 +0100
Message-ID: <CALe9h7exMAZfDVmhCBv_o+Ez3BN-MJ_43jkD7evZ8Ropk4-FKA@mail.gmail.com>
References: <alpine.DEB.2.11.1706052112360.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33134 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdFEWqt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jun 2017 18:46:49 -0400
Received: by mail-wr0-f179.google.com with SMTP id v104so45591847wrb.0
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jun 2017 15:46:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706052112360.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <john.spray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 5, 2017 at 10:21 PM, Sage Weil <sweil@redhat.com> wrote:
> I took a quick look at the get_health() methods in the Monitor after our
> discussion this morning:
>
> - OSDMonitor::get_health() looks at the pool stats for a few things; I
> think these can be safely/easily moved to PGMap::get_health() (so that
> they will run in ceph-mgr)
> - Then it'll be an easy change to calculate the health and detail sets in
> encoding_pending as each OSDMap in published.
> - MgrStatMonitor is already persisting the mgr health messages.
> - MDSMonitor is also strictly a fundion of the FSMap so it'd be easy to
> move to encode_pending.
> - Monitor::get_health() has some odds and ends we can either leave in
> place or improve (e.g, time skew checks).  Not sure it matters much.
>
> My main question is whether you had specific thoughts about how to
> identify warnings so that we can note when they appear and disappear.  We
> can just go by the unique strings but then you'll see something like
>
>  1 osd(s) down
>  ...
>  1 osd(s) down cleared
>  2 osd(s) down
>  ...
>
> (or whatever we make the messages for cleared warnings look like).  Should
> we associate a 'tag' for each message that is used to identify it, so
> that, for example, "%d osd down" for any number of OSDs is considered the
> "same" message and we log when it changes but don't say it has cleared?

Yes, exactly.

All the possible health messages warnings should get a unique error
code (tag, if you like), that would be a stable thing that we explain
in the docs, like we do for the MDS health messages[1].  Adding the
codes for health messages generally was one of the steps on my
favorite tracker ticket[2] (it has aged like a fine wine).

We'll need to look at the interplay between this and other logging --
in some cases, if we're e.g. already logging nice messages for OSDs
going up and down, then we might not want to also have log messages
redundantly printing the health state.  We might also want to get rid
of the places that we echo the map summary on changes like this, or at
least put them at a lower severity than what the operator sees by
default.  Basically, when an OSD goes down, we should make sure there
is one log message to that effect, rather than 2 or 3.

BTW, earlier we were talking about logging things at a host/rack level
when lots of OSDs change at once, which I didn't realize already
existed, but now I'm failing to find it in the tree (looking in
OSDMonitor)...?

John

1. http://docs.ceph.com/docs/master/cephfs/health-messages/#daemon-reported-health-checks
2. http://tracker.ceph.com/issues/7192
