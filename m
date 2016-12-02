From: Federico Lucifredi <federico@redhat.com>
Subject: Re: Ceph QoS user stories
Date: Fri, 2 Dec 2016 17:16:16 -0500
Message-ID: <CAJhGp1E3wMN8evMJhaFREKFn+jbJcCSsWyAdaYs1PSn1wW4hLg@mail.gmail.com>
References: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36805 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbcLBWQs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2016 17:16:48 -0500
Received: by mail-qt0-f174.google.com with SMTP id w33so265143752qtc.3
        for <ceph-devel@vger.kernel.org>; Fri, 02 Dec 2016 14:16:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Hi Sage,

 The primary QoS issue we see with OpenStack users is wanting to
guarantee minimum IOPS to each Cinder-mounted RBD volume as a way to
guarantee the health of well-mannered workloads against badly-behaving
ones.

 As an OpenStack Administrator, I want to guarantee a minimum number
of IOPS to each Cinder volume to prevent any tenant from interfering
with another.

  The number of IOPS may vary per volume, but in many cases a
"standard" and "high" number would probably suffice. The guarantee is
more important than the granularity.

  This is something impacting users at today's Ceph performance level.

  Looking at the future, once Bluestore becomes the default,  there
will also be latency requirements from the crowd that wants to run
databases with RBD backends — both low latency and low jitter in the
latency, but rather than applying that to all volumes, it will be only
to select ones backing RDBMs. Well, at least in the case of a general
purpose cluster.


 My hunch is that Enterprise users that want hard-QoS guarantees will
accept that a capacity planning exercise is necessary, software can
only allocate existing capacity, not create more. Community users may
value more some "fairness" in distributing existing resources instead.
Just a hunch at this point.

 Best -F

_________________________________________
-- "You must try until your brain hurts —Elon Musk
(Federico L. Lucifredi) - federico at redhat.com - GnuPG 0x4A73884C

On Fri, Dec 2, 2016 at 2:01 PM, Sage Weil <sweil@redhat.com> wrote:
>
> Hi all,
>
> We're working on getting infrasture into RADOS to allow for proper
> distributed quality-of-service guarantees.  The work is based on the
> mclock paper published in OSDI'10
>
>         https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.pdf
>
> There are a few ways this can be applied:
>
>  - We can use mclock simply as a better way to prioritize background
> activity (scrub, snap trimming, recovery, rebalancing) against client IO.
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS or
> proportional priority/weight) on RADOS pools
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS) for
> individual clients.
>
> Once the rados capabilities are in place, there will be a significant
> amount of effort needed to get all of the APIs in place to configure and
> set policy.  In order to make sure we build somethign that makes sense,
> I'd like to collection a set of user stores that we'd like to support so
> that we can make sure we capture everything (or at least the important
> things).
>
> Please add any use-cases that are important to you to this pad:
>
>         http://pad.ceph.com/p/qos-user-stories
>
> or as a follow-up to this email.
>
> mClock works in terms of a minimum allocation (of IOPS or bandwidth; they
> are sort of reduced into a single unit of work), a maximum (i.e. simple
> cap), and a proportional weighting (to allocation any additional capacity
> after the minimum allocations are satisfied).  It's somewhat flexible in
> terms of how we apply it to specific clients, classes of clients, or types
> of work (e.g., recovery).  How we put it all together really depends on
> what kinds of things we need to accomplish (e.g., do we need to support a
> guaranteed level of service shared across a specific set of N different
> clients, or only individual clients?).
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
