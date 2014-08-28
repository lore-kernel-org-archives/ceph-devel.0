From: Samuel Just <sam.just@inktank.com>
Subject: Re: [PATCH] osd: requeue replays we couldn't start in this tick
Date: Thu, 28 Aug 2014 11:14:24 -0700
Message-ID: <CA+4uBUarDQV66HqB4NmrOHNKS0ZukbkyjncQEb8mU3JB2bTJaw@mail.gmail.com>
References: <orbns6uvpo.fsf@free.home>
	<orzjep9ica.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:63868 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaH1SOZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Aug 2014 14:14:25 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so1164486qgf.28
        for <ceph-devel@vger.kernel.org>; Thu, 28 Aug 2014 11:14:24 -0700 (PDT)
In-Reply-To: <orzjep9ica.fsf@free.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Updated to master and pushed as wip-8758 for the moment.
-Sam

On Thu, Aug 28, 2014 at 12:36 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> Ping?
>
>
> If a PG is in replay but it's not active yet by the time the OSD tick
> gets to running the replay queue, we'll drop the PG from the replay
> queue without clearing its replay state.
>
> This patch arranges for PGs that weren't ready for replaying (or that
> weren't replayed for any other reason) to be requeued, so that they
> will be retried in the next tick.
>
> I have confirmed, with this patch, that my memory-starved nodes would
> often trigger the new log message, indicating the PGs were not active
> yet.  I have not observed instances of non-primary or replay_until
> mismatch, and I'm not sure the latter should justify a requeue, an
> assertion failure or whatever, but simply dropping the PG on the floor
> leaving it indefinitely in replay state is not something that should
> be done, since it prevents other operations from being processed.
>
> This patch does NOT fix the other problem reported in Issue #8758,
> that restarting any of the osds holding a PG is enough to clear the
> replay state.
>
> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> ---
>  src/osd/OSD.cc |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
> index 1e08c28..40d1121 100644
> --- a/src/osd/OSD.cc
> +++ b/src/osd/OSD.cc
> @@ -7228,6 +7228,7 @@ void OSD::check_replay_queue()
>    }
>    replay_queue_lock.Unlock();
>
> +  list< pair<spg_t,utime_t> > requeue;
>    for (list< pair<spg_t,utime_t> >::iterator p = pgids.begin(); p != pgids.end(); ++p) {
>      spg_t pgid = p->first;
>      if (pg_map.count(pgid)) {
> @@ -7239,12 +7240,33 @@ void OSD::check_replay_queue()
>           pg->replay_until == p->second) {
>         pg->replay_queued_ops();
>        }
> +      if (pg->is_replay()) {
> +       dout(12) << "check_replay_queue requeueing " << pgid
> +                << (pg->is_active() ? "" : ", not active")
> +                << (pg->is_primary() ? "" : ", not primary")
> +                << (pg->replay_until == p->second ? ""
> +                    : ", mismatched replay_until")
> +                << ", pg->until " << pg->replay_until
> +                << ", queued " << p->second << dendl;
> +       requeue.push_back(*p);
> +      }
>        pg->unlock();
>      } else {
>        dout(10) << "check_replay_queue pgid " << pgid << " (not found)" << dendl;
>      }
>    }
>
> +  if (!requeue.empty()) {
> +    replay_queue_lock.Lock();
> +    // reverse order to preserve it; push to the front of the queue,
> +    // where these entries came from
> +    while (!requeue.empty()) {
> +      replay_queue.push_front(requeue.back());
> +      requeue.pop_back();
> +    }
> +    replay_queue_lock.Unlock();
> +  }
> +
>    // wake up _all_ pg waiters; raw pg -> actual pg mapping may have shifted
>    wake_all_pg_waiters();
>  }
>
>
> --
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
