Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D63033CB
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573399; cv=pass; b=SglMRkwqbYv/6YrV5ynrgBnRWczEkzvbfEMvdbKVSxOjw5hCsOKruFuwXnPWZdiG1THu9K7vIcxqwp25fBqocbXpgx06vRPkRrRSTUbpkMHs4sXHnWG/P9ECnc23MCM6kgOGl2OJm7VIpMfasBM+cXcxbUJyhFy3ZCpNQvXZILg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573399; c=relaxed/simple;
	bh=wKWt3bAyC1SW1YDpXh0f0Dkut/2IKRfq6rSq0CdGr5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjylZsRrr3Ss2YJQyvBUOxuOwrq81y3ArwyznC7qr7BGPDGLsJAEObJg2Y5b1HM1TwPgxEXzFJ++insHY97f8DxKlZAtx4cJW5082/vdAcwFo3so1jQ568AS7Sl+O76HJeKw+ctZUQMXVzJgAKlvMOKu4cqK/IIKa/PnwXzipsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=EURWS2Cv; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="EURWS2Cv"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2533d83e3bso265313066b.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 18:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788573395; cv=none;
        d=google.com; s=arc-20260327;
        b=SdrNq6LNDx+8zqoG2JCxzgeDdjev+BnBMwYdCkjKmaXgrrPMpcnaDCIndw+0psKD9w
         jOGUanJw4WUZEIA9jUGiV2LVKqhbrjpm7SlNrJKo65nvbzBj3EbC2ksV4tn9bc96P8A6
         IqMswWvtuMjGM7YCtFbnVs07SGZwr2ccmf/aXFxQFKs1tusKMOczj2baIKt71RPsfrGp
         Zd+i9HujTrxVCVtULDWiF2GzD3EGg+av8Ls8yknNirhxOWOcXVeqisshWnr1fJ7+440s
         ee8gQeQmtPBrpjaEu1Wo7FIpLy6BObXtBoEON0p/C8wRZhQkAWyocUuJTbqrJJDu1YqK
         j2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=64iQUgMJ50ECTx99FYmqUsZAWJ9dQnizuLl55Ewxi3o=;
        fh=uuS5kQVaouQYELHVGZPyWCHjWpKSyUFotjcDATOWYKk=;
        b=PPKwWwl1YDIxsl8IioInH9HcqXMlwrX77e+ThnCjQEGspJqdiINdasi8vItiF3jXbQ
         sXKXzN2qZmOH/+t1Qv7lb53ioEssNWPqnxdPPhJyNW2f73jU7M1m2qg6sQ6wbH2HwbgZ
         W2f4iwW094YkXwWjQVl6kPcTATV2r5Qj0mt1m0V1KRiU1qdxTqoPK5aAGnJLIBwoIHDq
         ZwbCGp71YcpbZ2iih5vK3I6208dARvERF/L6NfRSt3yrl52YJwCl0AREeRLNO8V00ZHx
         8PU1s8pgA2WQsxt7zGwWNr8jI/4DAh9X6dEc1rlCxjgUiYIg4BGyO0IKw+3PaV5BKnh5
         yVoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788573395; x=1789178195; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64iQUgMJ50ECTx99FYmqUsZAWJ9dQnizuLl55Ewxi3o=;
        b=EURWS2CvzZWAGC3hj4onqafma5aF4p1Fjd19llgz6/F8kcUugXDoENhaxekqmfb7HH
         P8cRFiU67vbnv/xfanHUShj//+SCFRdx5gP+6rZHAP4aKK9Ze4tXpJvuvJHfMLA/aGOV
         rnt4jGe1apppanb5CMs+I1omgwSXFITz7pYWl9IsyMD4n0EXc0qeVr/XYrZ43e70iWLd
         sJUHYKOdyPukgT/2o8HinfdSrN8cuSs0guwbYiaIdH3rAlq4d+dJ9qyIcDcgN0GnAs5d
         +6Gqj8CW6ayVCnFVCnfo8DFF6FHof5zH54cmCg0daEI8pmxrewEjVuAYM43RE1T3D+DB
         2QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788573395; x=1789178195;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=64iQUgMJ50ECTx99FYmqUsZAWJ9dQnizuLl55Ewxi3o=;
        b=QNPs95mThyxIycj2OudAb1tGHozj+RYirbLAZuOArS9kLTPfQRZxpio4wC4zR0OlKP
         QVIY0+beS+EqXuEUOSJSpAoU9h+FjOU7WyhzwxfDVBUH8OrjcOQ0uDsbHrLPy4BmHHZ1
         4onXE4ct1ExUm+/0tjbo+9qR2xmbxwH5q692OsbN6z29VHflw4+3e4rPZG4r9PvhudbO
         VVhaAKKouRNT80qXZfLKMbCwbQZNiBG9KtxwW5wCl2v8SZ5y0iERH7L638hiqLaVWRoU
         ymkMVAumSANC/M7ShKA6B+HWbVULFlUmgDfbBSBtjTIVe0nnKq8Ow/gWSzcsMokXaVD6
         Ckkg==
X-Forwarded-Encrypted: i=1; AKwUvBw91+80P9SgaX9N6fm64f21YyQFazwzrtaMiq4bC1hNPkzoqq2RsbfRWe134AC6k3vo+X5JH5HAyukj@vger.kernel.org
X-Gm-Message-State: AFuF++mc+5/vyGZghXiAnoJuJauwVtAJlQN1C3JqFgEHom457G3XimdA
	SaVbwm099zJo/sQHu6boDMb7CRAPC6P6uYvizrHIBlpI97EoDE3iEGLq5vu+ELkDfBt1CpbenMd
	6oXK1MuLtq/CusV4he7UQSbEIPkyGHVHn3JoT4w6yAg==
X-Gm-Gg: AYBFou1AMKKLTscUQ2s1+cVW2kuVxHUag6eSRerdZodisBOoMox3DJS92vmIjsmmCab
	FE/hvu/Tf7Kp2mN2t5TnkfysxJXqzGdnMPkuCtL6smXdhr27mhoNq0VRvyAWJRB62U89TNElrcM
	36pQLk4OJ49KezHZpEcoFPfLTurBABdkM6jJj+oi1sCrItnz7jnMeVUj5aylTLXaL6gtdA3CKQ9
	jPx7CjlH1FCISiDBl2Zrmu+LcBKb8YqJPryj4e1hlnFIVJ622lXPVlbbnfc1vsgz5LPNnl293y8
	9Bwtr2F8+EA7N/Jhb5e5Z6EpBAQBMqOJmewSZVjgE7HruQ==
X-Received: by 2002:a17:907:d28:b0:c25:8eb7:f388 with SMTP id
 a640c23a62f3a-c260cc0bcdbmr656999166b.17.1788573394975; Fri, 04 Sep 2026
 18:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com> <20260904150304.49104-4-max.kellermann@ionos.com>
In-Reply-To: <20260904150304.49104-4-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:56:23 -0700
X-Gm-Features: AcwNN1V2_9bl4T1sj_5dTilZTOBUX-ygseBv2Vtt7jqYUX-VmM0O4adaBDyDbOE
Message-ID: <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Max,

The fix is correct.

Just one remaining teardown path still unregisters the session before
removing its caps: the fallback loop in ceph_mdsc_close_sessions():

mutex_lock(&mdsc->mutex);
for (i = 0; i < mdsc->max_sessions; i++) {
        if (mdsc->sessions[i]) {
                session = ceph_get_mds_session(mdsc->sessions[i]);
                __unregister_session(mdsc, session);
                mutex_unlock(&mdsc->mutex);
                mutex_lock(&session->s_mutex);
                remove_session_caps(session);
                mutex_unlock(&session->s_mutex);
                ...

The rest of this series consistently changes the ordering to keep the
rank occupied until remove_session_caps() has completed. Is the
ordering in ceph_mdsc_close_sessions() intentionally excluded?

This path is not limited to shutdown: it is also reached from the
corrupt snap-trace handling in ceph_handle_caps(), ceph_handle_reply()
and handle_snap(). In those cases mdsc->stopping may be false and the
mount need not be in CEPH_MOUNT_FENCE_IO, so a concurrent
__do_request() can register a new session for the rank in the window
between __unregister_session() and remove_session_caps().

That appears to be the same race this series is intended to eliminate.

Unless there is an invariant preventing a new session from being
created in this path, I think this teardown should use the same CLOSED
-> remove caps -> verify/unregister ordering, and wake
mdsc->session_close_wq after unregistering so that
wait_for_mds_rank_not_closing() waiters can proceed.

Thanks
- Xiubo

On Fri, 4 Sept 2026 at 08:03, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> handle_session() removed the session from mdsc->sessions[] at the very
> top of `CEPH_SESSION_CLOSE` handling, before taking `s_mutex`.
> Between session unregistration and remove_session_caps(), the MDS rank
> has no registered session while the old session still owns all caps it
> was granted.
>
> Any concurrent filesystem operation may walk into that and the next
> __do_request() call registers a new session for this rank.  Once it is
> open and the MDS issues caps, ceph_fill_inode() calls
> ceph_add_cap(), which looks caps up by rank, not
> by session identity, finding old caps linked to the old session.
>
> The list_move_tail() call then moves the cap object to the new
> session, which is already a bad thing to do.  Since it doesn't
> decrement `old_session->s_nr_caps`, this quickly triggers:
>
>   kernel BUG at fs/ceph/mds_client.c:1959!
>   Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>   [...]
>   Workqueue: ceph-msgr ceph_con_workfn
>   pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : remove_session_caps+0x2bc/0x2d8
>   lr : remove_session_caps+0x74/0x2d8
>   [...]
>   Call trace:
>    remove_session_caps+0x2bc/0x2d8 (P)
>    mds_dispatch+0xf48/0x1b60
>    ceph_con_process_message+0x74/0xa0
>    ceph_con_v1_try_read+0x3a0/0x1510
>    ceph_con_workfn+0x260/0x460
>    process_one_work+0x168/0x3b8
>    worker_thread+0x1bc/0x3a0
>    kthread+0x118/0x1e0
>    ret_from_fork+0x10/0x20
>
> That's BUG_ON(session->s_nr_caps > 0).
>
> I was able to reproduce this reliably by delaying the close and
> starting I/O during the delay.
>
> This patch keeps the session registered with
> `CEPH_MDS_SESSION_CLOSED`.  New requests will be put on the
> `s_waiting` list where they will be resumed on the new session.
>
> Since `CLOSE` now sets `CLOSED` before taking `s_mutex`, make
> send_mds_reconnect() validate and update the session state under
> `mdsc->mutex`. Preserve `CLOSED` if reconnect preparation later fails.
>
> Fixes: 2600d2dd5085 ("ceph: drop messages on unregistered mds sessions; cleanup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/caps.c       |   4 +
>  fs/ceph/mds_client.c | 182 ++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 156 insertions(+), 30 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index bcb04c6cb92c..024714d7f34e 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -4261,6 +4261,10 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>                 }
>                 new_cap = ceph_get_cap(mdsc, NULL);
>         } else {
> +               if (tsession == ERR_PTR(-EAGAIN))
> +                       /* locks already dropped */
> +                       return;
> +
>                 WARN_ON(1);
>                 tsession = NULL;
>                 target = -1;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 86d592f06196..f091f0eaafc2 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1783,6 +1783,30 @@ static int __open_session(struct ceph_mds_client *mdsc,
>         return 0;
>  }
>
> +/* Is this rank still occupied by a session being torn down? */
> +static bool __mds_rank_closing(struct ceph_mds_client *mdsc, int mds)
> +{
> +       return mds < mdsc->max_sessions && mdsc->sessions[mds] &&
> +               mdsc->sessions[mds]->s_state == CEPH_MDS_SESSION_CLOSED;
> +}
> +
> +/*
> + * Wait until the rank is no longer occupied by a CLOSED session.
> + *
> + * The caller must hold mdsc->mutex.  The mutex is dropped while sleeping and
> + * held again on return.  Another session may occupy the rank by then.  The
> + * wait also ends when shutdown starts, so the caller must check
> + * mdsc->stopping before proceeding.
> + */
> +static void wait_for_mds_rank_not_closing(struct ceph_mds_client *mdsc,
> +                                         int mds)
> +{
> +       wait_event_cmd(mdsc->session_close_wq,
> +                      !__mds_rank_closing(mdsc, mds) || mdsc->stopping,
> +                      mutex_unlock(&mdsc->mutex),
> +                      mutex_lock(&mdsc->mutex));
> +}
> +
>  /*
>   * open sessions for any export targets for the given mds
>   *
> @@ -1800,6 +1824,16 @@ __open_export_target_session(struct ceph_mds_client *mdsc, int target)
>                 if (IS_ERR(session))
>                         return session;
>         }
> +       if (session->s_state == CEPH_MDS_SESSION_CLOSED) {
> +               /*
> +                * handle_session() is currently closing this session;
> +                * it stays registered until its caps are gone.  Do
> +                * not return it to our caller because we don't want
> +                * it to attach new caps to it.
> +                */
> +               ceph_put_mds_session(session);
> +               return ERR_PTR(-EAGAIN);
> +       }
>         if (session->s_state == CEPH_MDS_SESSION_NEW ||
>             session->s_state == CEPH_MDS_SESSION_CLOSING) {
>                 ret = __open_session(mdsc, session);
> @@ -1819,7 +1853,19 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
>         doutc(cl, "to mds%d\n", target);
>
>         mutex_lock(&mdsc->mutex);
> -       session = __open_export_target_session(mdsc, target);
> +       for (;;) {
> +               session = __open_export_target_session(mdsc, target);
> +               if (session != ERR_PTR(-EAGAIN) || mdsc->stopping)
> +                       break;
> +
> +               /*
> +                * Keep the exported cap on its old session until the
> +                * target rank is vacant.  Dropping it here can discard a
> +                * dirty auth cap; handle_session() wakes us after removing
> +                * the old target session's caps and unregistering it.
> +                */
> +               wait_for_mds_rank_not_closing(mdsc, target);
> +       }
>         mutex_unlock(&mdsc->mutex);
>
>         return session;
> @@ -4553,8 +4599,20 @@ static void handle_session(struct ceph_mds_session *session,
>                         ceph_metric_bind_session(mdsc, session);
>         }
>         if (op == CEPH_SESSION_CLOSE) {
> +               /*
> +                * Pin the session for the rest of this function.  The
> +                * __unregister_session() call is deferred until after
> +                * remove_session_caps() below, or else other
> +                * processes may find caps still assigned to this
> +                * session while working with a new session object.
> +                */
>                 ceph_get_mds_session(session);
> -               __unregister_session(mdsc, session);
> +
> +               if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
> +                       pr_info_client(cl, "mds%d reconnect denied\n",
> +                                      session->s_mds);
> +
> +               session->s_state = CEPH_MDS_SESSION_CLOSED;
>         }
>         /* FIXME: this ttl calculation is generous */
>         session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
> @@ -4612,12 +4670,24 @@ static void handle_session(struct ceph_mds_session *session,
>                 break;
>
>         case CEPH_SESSION_CLOSE:
> -               if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
> -                       pr_info_client(cl, "mds%d reconnect denied\n",
> -                                      session->s_mds);
> -               session->s_state = CEPH_MDS_SESSION_CLOSED;
>                 cleanup_session_requests(mdsc, session);
>                 remove_session_caps(session);
> +
> +               /*
> +                * Now that all caps are removed, it is safe to release
> +                * the MDS rank and allow other processes to create a
> +                * new session object.
> +                *
> +                * A concurrent ceph_mdsc_close_sessions() or
> +                * check_new_map() may have unregistered the session
> +                * already, so check __verify_registered_session()
> +                * first.
> +                */
> +               mutex_lock(&mdsc->mutex);
> +               if (!__verify_registered_session(mdsc, session))
> +                       __unregister_session(mdsc, session);
> +               mutex_unlock(&mdsc->mutex);
> +
>                 wake = 2; /* for good measure */
>                 wake_up_all(&mdsc->session_close_wq);
>                 break;
> @@ -5168,16 +5238,6 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
>         /* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
>         xa_destroy(&session->s_delegated_inos);
>         atomic_set(&session->s_num_deleg_inos, 0);
> -       if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
> -           session->s_state == CEPH_MDS_SESSION_REJECTED) {
> -               pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
> -                              mds,
> -                              ceph_session_state_name(session->s_state));
> -               mutex_unlock(&session->s_mutex);
> -               ceph_msg_put(reply);
> -               err = -ESTALE;
> -               goto fail_return;
> -       }
>
>         /* s_mutex -> mdsc->mutex matches cleanup_session_requests() order. */
>         mutex_lock(&mdsc->mutex);
> @@ -5191,12 +5251,23 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
>                 err = -ENOENT;
>                 goto fail_return;
>         }
> -       mutex_unlock(&mdsc->mutex);
> +       if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
> +           session->s_state == CEPH_MDS_SESSION_REJECTED) {
> +               mutex_unlock(&mdsc->mutex);
> +               pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
> +                              mds,
> +                              ceph_session_state_name(session->s_state));
> +               mutex_unlock(&session->s_mutex);
> +               ceph_msg_put(reply);
> +               err = -ESTALE;
> +               goto fail_return;
> +       }
>
>         pr_info_client(cl, "mds%d reconnect start\n", mds);
>         old_state = session->s_state;
>         session->s_state = CEPH_MDS_SESSION_RECONNECTING;
>         session->s_seq = 0;
> +       mutex_unlock(&mdsc->mutex);
>
>         doutc(cl, "session %p state %s\n", session,
>               ceph_session_state_name(session->s_state));
> @@ -5338,7 +5409,10 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
>          * (check_new_map) can retry.  Without this, a transient build
>          * failure strands the session in RECONNECTING indefinitely.
>          */
> -       session->s_state = old_state;
> +       mutex_lock(&mdsc->mutex);
> +       if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
> +               session->s_state = old_state;
> +       mutex_unlock(&mdsc->mutex);
>         mutex_unlock(&session->s_mutex);
>  fail_nomsg:
>         ceph_pagelist_release(recon_state.pagelist);
> @@ -5746,23 +5820,29 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
>                         continue;
>                 }
>                 sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
> -               __unregister_session(mdsc, sessions[i]);
> -               __wake_requests(mdsc, &sessions[i]->s_waiting);
>                 mutex_unlock(&mdsc->mutex);
>
>                 mutex_lock(&sessions[i]->s_mutex);
>                 cleanup_session_requests(mdsc, sessions[i]);
>                 remove_session_caps(sessions[i]);
> +
> +               /* Keep the rank occupied until all old-session caps are gone. */
> +               mutex_lock(&mdsc->mutex);
> +               if (!__verify_registered_session(mdsc, sessions[i]))
> +                       __unregister_session(mdsc, sessions[i]);
> +               mutex_unlock(&mdsc->mutex);
> +
>                 mutex_unlock(&sessions[i]->s_mutex);
>
>                 wake_up_all(&mdsc->session_close_wq);
>
> -               ceph_put_mds_session(sessions[i]);
> -
>                 mutex_lock(&mdsc->mutex);
> +               __wake_requests(mdsc, &sessions[i]->s_waiting);
>                 kick_requests(mdsc, mds);
>                 mutex_unlock(&mdsc->mutex);
>
> +               ceph_put_mds_session(sessions[i]);
> +
>                 torn_down++;
>                 pr_info_client(cl, "mds%d session reset complete\n", mds);
>         }
> @@ -5864,6 +5944,12 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                 s = __ceph_lookup_mds_session(mdsc, i);
>                 if (!s)
>                         continue;
> +
> +               if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
> +                       ceph_put_mds_session(s);
> +                       continue;
> +               }
> +
>                 oldstate = ceph_mdsmap_get_state(oldmap, i);
>                 newstate = ceph_mdsmap_get_state(newmap, i);
>
> @@ -5876,18 +5962,24 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>
>                 if (i >= newmap->possible_max_rank) {
>                         /* force close session for stopped mds */
> -                       __unregister_session(mdsc, s);
> -                       __wake_requests(mdsc, &s->s_waiting);
> +                       s->s_state = CEPH_MDS_SESSION_CLOSED;
>                         mutex_unlock(&mdsc->mutex);
>
>                         mutex_lock(&s->s_mutex);
>                         cleanup_session_requests(mdsc, s);
>                         remove_session_caps(s);
> +
> +                       mutex_lock(&mdsc->mutex);
> +                       if (!__verify_registered_session(mdsc, s))
> +                               __unregister_session(mdsc, s);
> +                       mutex_unlock(&mdsc->mutex);
>                         mutex_unlock(&s->s_mutex);
>
> -                       ceph_put_mds_session(s);
> +                       wake_up_all(&mdsc->session_close_wq);
>
>                         mutex_lock(&mdsc->mutex);
> +                       __wake_requests(mdsc, &s->s_waiting);
> +                       ceph_put_mds_session(s);
>                         if (mdsc->mdsmap->m_epoch != map_epoch)
>                                 return;
>                         kick_requests(mdsc, i);
> @@ -5906,6 +5998,16 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                 ceph_put_mds_session(s);
>                                 return;
>                         }
> +                       if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
> +                               /*
> +                                * handle_session() set state=CLOSED
> +                                * in the mutex gap above and is tearing it
> +                                * down
> +                                */
> +                               mutex_unlock(&s->s_mutex);
> +                               ceph_put_mds_session(s);
> +                               continue;
> +                       }
>                         ceph_con_close(&s->s_con);
>                         mutex_unlock(&s->s_mutex);
>                         s->s_state = CEPH_MDS_SESSION_RESTARTING;
> @@ -5964,6 +6066,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>          * Only open and reconnect sessions that don't exist yet.
>          */
>         for (i = 0; i < newmap->possible_max_rank; i++) {
> +               if (mdsc->stopping)
> +                       return;
> +
>                 /*
>                  * In case the import MDS is crashed just after
>                  * the EImportStart journal is flushed, so when
> @@ -5989,6 +6094,19 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                  * reconnection request in up:reconnect state.
>                  */
>                 s = __ceph_lookup_mds_session(mdsc, i);
> +               if (s && s->s_state == CEPH_MDS_SESSION_CLOSED) {
> +                       /*
> +                        * Wait for handle_session() to remove the caps and
> +                        * unregister this session, so the reconnect below
> +                        * uses a fresh session on the now vacant rank
> +                        */
> +                       ceph_put_mds_session(s);
> +                       wait_for_mds_rank_not_closing(mdsc, i);
> +                       if (mdsc->stopping ||
> +                           mdsc->mdsmap->m_epoch != map_epoch)
> +                               return;
> +                       s = NULL;
> +               }
>                 if (likely(!s)) {
>                         s = __open_export_target_session(mdsc, i);
>                         if (IS_ERR(s)) {
> @@ -7149,9 +7267,7 @@ static void mds_peer_reset(struct ceph_connection *con)
>          * Snapshot session state with READ_ONCE, then revalidate under
>          * mdsc->mutex before acting.  The subsequent mdsc->mutex
>          * section rechecks s_state to catch concurrent transitions, so
> -        * the lockless snapshot here is safe.  s->s_mutex is taken
> -        * separately for cleanup after unregistration, which avoids
> -        * introducing a new s->s_mutex + mdsc->mutex nesting.
> +        * the lockless snapshot here is safe.
>          */
>         session_state = READ_ONCE(s->s_state);
>
> @@ -7176,18 +7292,24 @@ static void mds_peer_reset(struct ceph_connection *con)
>
>                 ceph_get_mds_session(s);
>                 s->s_state = CEPH_MDS_SESSION_CLOSED;
> -               __unregister_session(mdsc, s);
> -               __wake_requests(mdsc, &s->s_waiting);
>                 mutex_unlock(&mdsc->mutex);
>
>                 mutex_lock(&s->s_mutex);
>                 cleanup_session_requests(mdsc, s);
>                 remove_session_caps(s);
> +
> +               /* Keep the rank occupied until all old-session caps are gone. */
> +               mutex_lock(&mdsc->mutex);
> +               if (!__verify_registered_session(mdsc, s))
> +                       __unregister_session(mdsc, s);
> +               mutex_unlock(&mdsc->mutex);
> +
>                 mutex_unlock(&s->s_mutex);
>
>                 wake_up_all(&mdsc->session_close_wq);
>
>                 mutex_lock(&mdsc->mutex);
> +               __wake_requests(mdsc, &s->s_waiting);
>                 kick_requests(mdsc, s->s_mds);
>                 mutex_unlock(&mdsc->mutex);
>
> --
> 2.47.3
>
