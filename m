From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RFC: progress bars
Date: Wed, 27 May 2015 22:47:19 -0700
Message-ID: <CAC6JEv8FEMieXZH0+muXNNMT1xkY863HGvsUy0qB9AMzeQLfWQ@mail.gmail.com>
References: <5523D388.6010008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:33905 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbbE1FrV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 01:47:21 -0400
Received: by qcbhb1 with SMTP id hb1so13451493qcb.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 22:47:20 -0700 (PDT)
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com. [209.85.192.50])
        by mx.google.com with ESMTPSA id b31sm633597qge.5.2015.05.27.22.47.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 22:47:20 -0700 (PDT)
Received: by qgez61 with SMTP id z61so12127192qge.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 22:47:19 -0700 (PDT)
In-Reply-To: <5523D388.6010008@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thread necromancy! (Is it still necromancy if it's been waiting in my
inbox the whole time?)

On Tue, Apr 7, 2015 at 5:54 AM, John Spray <john.spray@redhat.com> wrote:
> Hi all,
>
> [this is a re-send of a mail from yesterday that didn't make it, probably
> due to an attachment]
>
> It has always annoyed me that we don't provide a simple progress bar
> indicator for things like the migration of data from an OSD when it's marked
> out, the rebalance that happens when we add a new OSD, or scrubbing the PGs
> on an OSD.
>
> I've experimented a bit with adding user-visible progress bars for some of
> the simple cases (screenshot at http://imgur.com/OaifxMf). The code is here:
> https://github.com/ceph/ceph/blob/wip-progress-events/src/mon/ProgressEvent.cc
>
> This is based on a series of "ProgressEvent" classes that are instantiated
> when certain things happen, like marking and OSD in or out.  They provide an
> init() hook that captures whatever state is needed at the start of the
> operation (generally noting which PGs are affected) and a tick() hook that
> checks whether the affected PGs have reached their final state.
>
> Clearly, while this is simple for the simple cases, there are lots of
> instances where things will overlap: a PG can get moved again while it's
> being backfilled following a particular OSD going out. These progress
> indicators don't have to capture that complexity, but the goal would be to
> make sure they did complete eventually rather than getting stuck/confused in
> those cases.

I haven't really looked at the code yet, but I'd like to hear more
about how you think this might work from a UI and tracking
perspective. This back-and-forth shuffling is likely to be a pretty
common case. I like the idea of better exposing progress states to
users, but I'm not sure progress bars in the CLI are quite the right
approach. Are you basing these on the pg_stat reports of sizes across
nodes? (Won't that break down when doing splits?)

In particular, I think I'd want to see something that we can report in
a nested or reversible fashion that makes some sort of sense. If we do
it based on position in the hash space that seems easier than if we
try to do percentages: you can report hash ranges for each subsequent
operation, including rollbacks, and if you want the visuals you can
output each operation as a single row that lets you trace the overlaps
between operations by going down the columns.
I'm not sure how either would scale to a serious PG reorganization
across the cluster though; perhaps a simple 0-100 progress bar would
be easier to generalize in that case. But I'm not really comfortable
with the degree of lying involved there.... :/
-Greg

>
> This is just a rough cut to play with the idea, there's no persistence of
> the ProgressEvents, and the init/tick() methods are peppered with
> correctness issues.  Still, it gives a flavour of how we could add something
> friendlier like this to expose simplified progress indicators.
>
> Ideas for further work:
>  * Add in an MDS handler to capture the progress of an MDS rank as it goes
> through replay/reconnect/clientreplay
>  * A handler for overall cluster restart, that noticed when the mon quorum
> was established and all the map timestamps were some time in the past, and
> then generated progress based on OSDs coming up and PGs peering.
>  * Simple: a handler for PG creation after pool creation
>  * Generate estimated completion times from the rate of progress so far
>  * Friendlier PGMap output, by hiding all PG states that are explained by an
> ongoing ProgressEvent, to only indicate low level PG status for things that
> the ProgressEvents don't understand.

Eeek. These are all good ideas, but now I'm *really* uncomfortable
reporting a 0-100 number as the progress. Don't you remember how
frustrating those Windows copy dialogues used to be? ;)
-Greg
