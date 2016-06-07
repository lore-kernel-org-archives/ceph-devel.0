From: kefu chai <tchaikov@gmail.com>
Subject: Re: new scrub and repair discussion
Date: Tue, 7 Jun 2016 18:44:48 +0800
Message-ID: <CAJE9aOOa4yQ2wAHhVotog-Nvr9gQNBpwpiAwC1HXT3QLL_QJgA@mail.gmail.com>
References: <CA+cZ7sioiiEVVC0G9fkU1iF8J4hAPRuYYhOQ=5pgtg-n3q-iPw@mail.gmail.com>
 <CAJE9aOOrh6LwTAawAOkFZwH+r5VVDUdMBaynxg4VMwpGqDPRJA@mail.gmail.com>
 <CAJE9aOMDLyfOVn-n18m3Ftqc3G=N-71we9qiUuhBSX+qnJBF9Q@mail.gmail.com> <CABZ+qqm5cxnHWJ_ZWm1qXgV_SBiwX7Zfr2fvbNrNfWc289xNGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:32893 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbcFGKot (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 06:44:49 -0400
Received: by mail-yw0-f182.google.com with SMTP id h19so165809178ywc.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2016 03:44:49 -0700 (PDT)
In-Reply-To: <CABZ+qqm5cxnHWJ_ZWm1qXgV_SBiwX7Zfr2fvbNrNfWc289xNGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dan, your comments are more like feature requests related to current
scrub, instead to the
new scrub/repair feature design. reply inlined.

On Fri, May 27, 2016 at 8:03 PM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi all,
>
> I have some high-level feedback for scrub/repair. Apologies if some of
> these are already taken into account.
>
> 1. ceph pg cancel-scrub <pgid>: For a variety of reasons it would be
> useful to be able to cancel an ongoing (deep-)scrub on a PG. The
> no(deep-)scrub flags work more like a pause, but today if I want to
> stop a scrub it requires an OSD to be restarted.

it's a feature request. we did have this feature in rados API before, but it was
not exposed by the rados cli, and hence removed. if you'd like to get it back,
maybe you could file an issue over tracker?

>
> 2. ceph pg scrub/deep-scrub/repair often do not start because the
> master OSD cannot get a reservation on all the replica/EC-part OSDs
> (due to osd max scrubs). It is possible using some strange gymnastics
> to force PG to start repairing/scrubbing immediately, but those are
> not intuitive. IMHO, ceph pg scrub/deep-scrub/repair <pgid> should
> start immediately regardless of the 'osd max scrubs' value.

i think it's more a design decision.

>
> 3. It should be possible to repair an object directly: e.g. couldn't
> we have rados repair <objectname> which reads then re-writes the whole
> object.

that's what we are discussing in this thread.

>
> 4. EC auto-repair on read/write. Surely there are some types of shard
> corruption that we can repair in-line with the IO, rather than waiting
> for the long scrub/repair cycle.

yeah, we are able to detect some shard corruptions when reading. but we
1) won't do repair on behalf of user, 2) want to offload the repair work to
client side to avoid heuristics in the OSD. so i am afraid this won't happen.

>
> 5. Do we even need the shallow scrub functionality? I'm very curious
> how many problems that shallow scrubbing finds IRL compared with
> deep-scrubbing. Does ceph track these stats independently?

i don't have any numbers to support your theory or against it. but i think
having a light-weight scrub is necessary.

> Could ceph-brag be used to gather this info?

yeah, but not yet. actually we call "ceph pg dump pools" in ceph-brag.

>
> Thanks!
>
> Dan
-- 
Regards
Kefu Chai
