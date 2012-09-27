From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] PG: Do not discard op data too early
Date: Thu, 27 Sep 2012 15:07:24 -0700
Message-ID: <CAPYLRzh_ngQt11Dv17YFJCj5pR3RJino6dbsw3HZ6WGAAhfu-w@mail.gmail.com>
References: <1348782975-7082-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53815 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab2I0WHZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 18:07:25 -0400
Received: by ieak13 with SMTP id k13so5809007iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 15:07:24 -0700 (PDT)
In-Reply-To: <1348782975-7082-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Have you tested that this does what you want? If it does, I think
we'll want to implement this so that we actually release the memory,
but continue accounting it.

On Thu, Sep 27, 2012 at 2:56 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Under a sustained cephfs write load where the offered load is higher
> than the storage cluster write throughput, a backlog of replication ops
> that arrive via the cluster messenger builds up.  The client message
> policy throttler, which should be limiting the total write workload
> accepted by the storage cluster, is unable to prevent it, for any
> value of osd_client_message_size_cap, under such an overload condition.
>
> The root cause is that op data is released too early, in op_applied().
>
> If instead the op data is released at op deletion, then the limit
> imposed by the client policy throttler applies over the entire
> lifetime of the op, including commits of replication ops.  That
> makes the policy throttler an effective means for an OSD to
> protect itself from a sustained high offered load, because it can
> effectively limit the total, cluster-wide resources needed to process
> in-progress write ops.
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>  src/osd/ReplicatedPG.cc |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
> index a64abda..80bec2a 100644
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -3490,10 +3490,6 @@ void ReplicatedPG::op_applied(RepGather *repop)
>    dout(10) << "op_applied " << *repop << dendl;
>    if (repop->ctx->op)
>      repop->ctx->op->mark_event("op_applied");
> -
> -  // discard my reference to the buffer
> -  if (repop->ctx->op)
> -    repop->ctx->op->request->clear_data();
>
>    repop->applying = false;
>    repop->applied = true;
> --
> 1.7.8.2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
