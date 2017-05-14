From: John Spray <jspray@redhat.com>
Subject: Re: Monitoring ceph and prometheus
Date: Sun, 14 May 2017 23:27:03 +0100
Message-ID: <CALe9h7fhson-vgFpbUoi+x+nSiqZRw72qmKKEMgrT-KQtWy93g@mail.gmail.com>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
 <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com>
 <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal> <20170513101414.wisczvozh6kilps7@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34963 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdENW1Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 14 May 2017 18:27:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id b84so63190221wmh.0
        for <ceph-devel@vger.kernel.org>; Sun, 14 May 2017 15:27:24 -0700 (PDT)
In-Reply-To: <20170513101414.wisczvozh6kilps7@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, May 13, 2017 at 11:14 AM, Lars Marowsky-Bree <lmb@suse.com> wrote:
> On 2017-05-11T12:47:21, Sage Weil <sage@newdream.net> wrote:
>
>> > I would love to see a mgr module for prometheus integration!
>> Me too!  It might make more sense to do it in C++ than python, though, for
>> performance reasons.
>
> I'm leaning the other way. (Disclaimer: I started this dialogue
> internally and was originally thinking of putting it into ceph-mgr.)
>
> prometheus implements a pull model for time series data / metrics. For
> those to be pull-able from ceph-mgr, either ceph-mgr needs to pull
> itself, or daemons stream to it. Clearly it can't pull something that's
> not there.
>
> Both have slightly different issues with aligning the periods/intervals.
>
> Prometheus also can scale through polling via several instances; if we
> pull everything from ceph-mgr, that is a single chokepoint.

The question of bottlenecks comes up regularly when discussing this.
Before going and adding new interfaces to the OSDs to talk to
prometheus, I think it would be useful to find out if there really is
a problem.  We're talking about pretty small messages here, doing
nothing but updating some counters in memory, and it's a lot less work
than the OSDs already do.

When passing that data onwards, I don't know if prometheus has an
issue dealing with a single endpoint that gives them a huge amount of
data.  I have not looked into it, but I wonder if the federation
interface[1] would be appropriate: make ceph-mgr look like a federated
prometheus instance instead of a normal endpoint.

1. https://prometheus.io/docs/operating/federation/

> Further, if ceph-mgr were to pull data from individual daemons - why not
> have prometheus do this directly? What benefit does this additional
> indirection step offer?

Simplicity.  It makes it super simple for a user with nothing but
vanilla Ceph and vanilla Prometheus to connect the two things
together.  Anything that requires lots of per-daemon configuration
relies on some addition orchestration tool to do that plumbing.

While that orchestration is not intrinsically complex, it's an area of
fragmentation in the community, whereas things we can simply build
into Ceph have a better chance of wider adoption.  If we build this
into ceph-mgr, then we can have a super-simple page on docs.ceph.com
that tells people how to plug any Ceph cluster into Prometheus in a
couple of commands.  If it relies on (various) external orchestrators,
we lose that.

In conversations about this topic (centralized vs. per-daemon stats),
we usually come to the conclusion that both are useful: the simple
"batteries included" configuration where we present a single endpoint,
vs. the configuration where some external program is aware of all
individual daemons and monitoring them directly.  If we end up with
both, that's not an awful thing.

As you point out, one ends up putting a prometheus endpoint into the
mgr anyway to expose the cluster-wide stats (as opposed to the daemon
perf counters), so it's probably absurdly easy to just make it expose
the perf counters too, even if one also continues to add code to
(optionally?) expose perf counters directly from daemons too.

John

> If we have rather detailed stats per daemon, ceph-mgr would either relay
> them on as-is (pure overhead), or aggregate them - and likely not
> aggregate them as well/flexibly as Prometheus would allow via PQL.
>
> Now, that's not to say that ceph-mgr would not benefit from a Prometheus
> interface! I could easily see ceph-mgr have stats of its own that are
> worth monitoring, and we should make it easy to export those.
>
> So, in short, I believe an easy way to export per-daemon metrics is
> desirable. ceph-mgr might choose to pull these in as well if it has a
> use for them, but I think Prometheus would best attach to the daemons
> directly too.
>
>
> Regards,
>     Lars
>
> --
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar Wilde
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
