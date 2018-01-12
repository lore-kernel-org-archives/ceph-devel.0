From: Sage Weil <sweil@redhat.com>
Subject: Re: mon config commands
Date: Fri, 12 Jan 2018 23:56:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801122349160.24931@piezo.novalocal>
References: <alpine.DEB.2.11.1801112044230.23413@piezo.novalocal> <CAJ4mKGbpTo_B3XghsLHzXki_RhCLbikiRKcw9bGV6TpPCFxEqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965291AbeALX4J (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 18:56:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CE8AC0587C7
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jan 2018 23:56:09 +0000 (UTC)
In-Reply-To: <CAJ4mKGbpTo_B3XghsLHzXki_RhCLbikiRKcw9bGV6TpPCFxEqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 12 Jan 2018, Gregory Farnum wrote:
> The rest looks good, but I don't understand this thing about "RO"
> values at all. Based on what's here, it represents options that aren't
> live yet, but will be on reboot?

These are options that can't change at runtime, so they need a daemon 
restart. (Or, in some cases, they only matter at osd or cluster creation 
time.)  In reality, we have an enum of (cluster_create, daemon_create, 
startup, runtime) for each option for when it can take effect.  
Generally the question for the user, though, is "can i set this value 
now and have it take effect".  If it's flagged as RO, then they can set it 
via the mon, but then 'config show' will then show 'mon' under IGNORES 
because it's something we can't change at runtime.

> On Thu, Jan 11, 2018 at 1:21 PM, Sage Weil <sage@redhat.com> wrote:
> > gnit:build (wip-config) 02:48 PM $ bin/ceph config show mon.a
> > NAME                                                       VALUE                                              SOURCE  OVERRIDES IGNORES
...
> > ms_type                                                    async+posix                                        default           mon
...
> >
> > (sorry for the wide table)
> >
> > A few things to note: SOURCE can be any of default, file, mon, env,
> > cmdline, or override.  You'll notice that ms_type SOURCE is 'default' and
> > IGNORES is 'mon', because the daemon is ignoring the mon value--this
> > option can only be set during startup.
> 
> I also don't get how one mon having a different setting means that all
> mons are marked as ignoring it.

This is saying that 'mon.a' (who we just 'show'ed) is ignoring the 
mon-managed config.  If mon.b was restarted and we did a show it would...
well it would also say the same thing since  mon's don't fetch the 
mon-stored config before startup.  (Not sure if we should implement that 
or not.)

Is that what you're asking?
 
> Putting them right next to each other also makes it clear in my mind
> that people are going to be confused about "config get" versus "config
> show". Perhaps it should be "get_stored" and "show_running" or
> something? I don't like those names, but they need to be clearer.

I don't really like 'show' either.  'show-running'?  'running'?  I like 
'get' though.

> And now I've got a new feature request: a command that outputs the 
> difference between those two. Or perhaps that goes through *all* the 
> configs and dumps any daemons whose running config differs from their 
> stored ones.

'show' already shows you this information via the OVERRIDES and IGNORES 
columns.

Oh, you mean that shows *only* the mismatch for the daemon or 
cluster...

sage
