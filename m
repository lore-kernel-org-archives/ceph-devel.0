Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044C37646E
	for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2026 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158094; cv=pass; b=NKUJ6BSx0UR9pPlJEnblKtEeJlgpoFpf2FbqYpl8vqrESyqaJ5SngU7D0+JBhTLTdVtmfFxOHHnden1Ez7AT2MnMjHCS+C/uTI5/5uP41443n9C/oJjwv+2fBfWR4HbdFr4zlKLjLX8fzHPx9qzVi1PgBu6/KJiuxilHJv4w8gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158094; c=relaxed/simple;
	bh=a8jHlklF1gC20OVPgr0TNH+1C0wqwqVjnRU26kK3fck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRPe6Da862OoYDhLpk8kS3RMifeqnfkbJ7L9Uc803uTkU+0GyEsFK6UFXO1ret5O7eRj0gkZURpBYctWc3Jod804N4Bcnha+HSZ3h8qYK6DU68ZAMO1qtxgfZ5z3mJDJsBJ99F7rTlkV0S0C7SctCV6jceI4K6OlPVuDumP0Ex8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=lOM0oyBl; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="lOM0oyBl"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c252e703fa3so454937866b.3
        for <ceph-devel@vger.kernel.org>; Sun, 30 Aug 2026 23:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788158088; cv=none;
        d=google.com; s=arc-20260327;
        b=Etqu2BbIW8mRfKcEHw3iJdAJR32Dgtm0+WddxitzYetOzpyZD62FMY9dFaWlytIw+8
         I3H+KcO4HmoBSjMKoY85n9+WmIdAY0hootAh8iy/fpH7pm/NDGf/jy0wH6UWArLZ6VvZ
         QdjWEBTE3FQDUEJG41xmJoBqbp7RmXG4tlCCRJ3Ys+ul6S1Gd6MDMI/qqS93nuuk5j2j
         WviGZh/EQMW2SXpb/+B4czHRMr2iAdhpbhbj5WUyW5bNvDNHSSxgW9LOxkLL6HYqRSBa
         el62gTz+RAsdex66tX1IpKhcw69eJg8rWDKSSbIQ/cWzIFhVuKWYY4lx6r1tbnDq0alu
         sJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5xkbFh0fQe9Arfb2s6Rv2V6Kg0DTw0/4lqQu8KNODQ4=;
        fh=FI8OSwkgL3KsCnhqckUBG5SZ0q2g227py5cBZMHwsgk=;
        b=AC2z1Q05hkzg0g4gAVf3mkwQqQzlUsTztmsN9igS0EAgEW8jV+Uw7RV1MkdSh1X2bs
         8GPovkbDfnIG9j6qgDycKvGGl6Cke778CDIs4qAdXe3MMnznefIMv0DY46qqFEnijMmM
         wsIqSZFyCwoRYIMjE2I1OL9Up2jF5SPWbUe5TyJaDUGUbIfTZ1mhwYwkVFS4bFp4MykB
         YCXOL2sEjeKZczXlnOeozINqoQErbPq4CXZPayAhli1bgxPOufzB9nq1jghA7gjhjCfv
         twYyX4BGNr/ofxsDY0mDTxVh7rks70t0jVMhFb2Xi2aWas3Qhq7CJsVryggB1r/EH/J+
         TfXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788158088; x=1788762888; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xkbFh0fQe9Arfb2s6Rv2V6Kg0DTw0/4lqQu8KNODQ4=;
        b=lOM0oyBl6uYjREnd9M0JV7prmcyVATGBc8Mgj2OZfhThBTRscT9qbYezE5FGMEn7tF
         wBC4dL74GzDNL3XckZBrN2DHhjXEttDUQI6NvbcerLxcJfg/r8u8HdY2sycXrv/xVzRd
         cY1muYsO2JR8M0ltUrW0XvNKZX1xml5UtOX8FAT0+bpfABG446LBhm5UBHeaiXnaLCL4
         xh8hs/TJPpkUCn8IcEtSpGpH0+oIdEy7+al/fopLc+TbRs8fNTzyIAgpkNL7LIS1hkat
         RhcN7YdJt2EY2i5YsIJmIOkdR9CyTp5ni5jL0OSEMrZs9Z83bvSfIL76ildGVcepA4hr
         1YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788158088; x=1788762888;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5xkbFh0fQe9Arfb2s6Rv2V6Kg0DTw0/4lqQu8KNODQ4=;
        b=VkVTgCjMM5lhuhC27TYYQqHeN2mJzv/xDSvch5mJpIY/o3OzPaXB0FdbRI+zlHJipn
         ue8oWEU+9p0QIUbPq6pEsUNb85ks0agjpQznlYI/0UsydblI7rOX3O5EjD1OwMyNyBk1
         cKlBUvSB3MiYUGnGlAEDUlq0pNmSi3anjlGbvd9uqEDn9g1sc777YMq8G2kf7nssLqYM
         QQ2GO0VIO07S4ofBTAM39LuPVbttUW9gWXLseNN6a6fkd50/HUVAO5jUSRzalMN9/dOa
         98z0MXgyJe+RTDtOAXB82g8Bg7wGoD6dsuiCUv9wrsqZL6ErUdKFqdBKzsD6Olqykf5m
         j1Ig==
X-Forwarded-Encrypted: i=1; AHgh+Rru3HIKaax0IlFLyEoK4TJiTBSx2L/eYJawqzxqiFVID/y7EfzL2SPtqBH7mcQiq2SilPu0JgojXpxD@vger.kernel.org
X-Gm-Message-State: AFuF++mgbE3CxZAy8K5Xdr0/zmptOmC6+LzS5kgVE7Zo17q3TCmMJv6G
	mDVuFKrfDeMP6HsQ4CDrLEhHcHEGWpNXJIdiimY92k3QQYjORKRaF5782+E6AfgyBGfL6Ywd8wp
	35YYP17VLT8mrwHH0zyrEgQMlUGMvJ4KiLuLxhGpsnw==
X-Gm-Gg: AR+sD13tF+5v6BTkRAIFVPac7S6q6ZHF69k3KF4rzF/I3J64rJIRtyjQvWy+N3glL6T
	7yek1FJOBZiAqU6SaYd8lE0yP02GbIMm+4YwxFFxErop0+rHkrl3gy4HbQ8VDQq0Cgl8ImRtDTW
	PrdPCCf+NtL48r8lZXq14GbFb49cOwS+axFLbQC8C60LpB9la2dKgJ9rSsyGJB9BOWcVy0QfpHm
	GDT+C9nPgkbZ8Pv2X1qf2++mBo4JVEFcmG+Lu34lM35dY2HGcexpK4etA2HlHYbxsgXWhT2BqBN
	V6IIiluUVI03WX9leG5tfvs6rU3FRKtXZSzAfKSR3r0wRQ==
X-Received: by 2002:a17:907:960d:b0:c25:659:89ba with SMTP id
 a640c23a62f3a-c2556c4b566mr1384348366b.9.1788158087791; Sun, 30 Aug 2026
 23:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828174504.1247038-1-max.kellermann@ionos.com> <20260828174504.1247038-4-max.kellermann@ionos.com>
In-Reply-To: <20260828174504.1247038-4-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Sun, 30 Aug 2026 23:34:36 -0700
X-Gm-Features: AcwNN1WTI1xhAQKPyCaikqSqU7WO9dHoU71eM2apdekKJD61pFzwO4h9_cZvPnE
Message-ID: <CAOJNxRL2UkiOTMkBTK1+trQk82RFHShAUNk5e8nmudTeSOoi+Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Max

Patches 1 and 2 LGTM.

But it seems the ceph_mdsc_reset_workfn() still unregisters before the
teardown. The admin-reset teardown loop in ceph_mdsc_reset_workfn()
still does:

        sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
        __unregister_session(mdsc, sessions[i]);
        __wake_requests(mdsc, &sessions[i]->s_waiting);
        mutex_unlock(&mdsc->mutex);

        mutex_lock(&sessions[i]->s_mutex);
        cleanup_session_requests(mdsc, sessions[i]);
        remove_session_caps(sessions[i]);

That is exactly the pattern this series fixes: the rank is vacant while the old
session still owns all its caps.  It is even more exposed here, because
__wake_requests() synchronously re-dispatches parked requests and
__do_request() will register a fresh session for the rank before
remove_session_caps() has even started.  Once the new session opens,
ceph_add_cap() finds the old caps by rank, moves them onto the new
session's list without decrementing the old session's s_nr_caps, and the
reset thread hits the same BUG_ON(session->s_nr_caps > 0).

Please apply the same treatment as in mds_peer_reset(): keep the session
registered in CLOSED state, do the verify-guarded unregister after
remove_session_caps(), then wake_up_all(&mdsc->session_close_wq)
before __wake_requests()/kick_requests().

Thanks
Xiubo

On Fri, 28 Aug 2026 at 10:45, Max Kellermann <max.kellermann@ionos.com> wrote:
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
> decrement `old_session->s_nr_caps`, this will quickly run into a BUG()
> instead of crashing:
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
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> v1->v2: skip CLOSED sessions in check_new_map()
> v2->v3: split session pinning and stale-map guards into two preparatory
>     patches; rework CLOSED-session and export-target teardown handling
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/caps.c       |   3 +
>  fs/ceph/mds_client.c | 138 ++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 127 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index d7283fb54cec..b21d0a9ac324 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -4195,6 +4195,9 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>                 }
>                 new_cap = ceph_get_cap(mdsc, NULL);
>         } else {
> +               if (tsession == ERR_PTR(-EAGAIN))
> +                       return;
> +
>                 WARN_ON(1);
>                 tsession = NULL;
>                 target = -1;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 03809328e4aa..ec8ee95cad6e 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1733,6 +1733,30 @@ static int __open_session(struct ceph_mds_client *mdsc,
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
> @@ -1750,6 +1774,16 @@ __open_export_target_session(struct ceph_mds_client *mdsc, int target)
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
> @@ -1769,7 +1803,19 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
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
> @@ -4492,8 +4538,20 @@ static void handle_session(struct ceph_mds_session *session,
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
> @@ -4551,12 +4609,24 @@ static void handle_session(struct ceph_mds_session *session,
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
> +                * Now that all caps are removed, it is safe release
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
> @@ -5802,6 +5872,10 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                 s = __ceph_lookup_mds_session(mdsc, i);
>                 if (!s)
>                         continue;
> +               if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
> +                       ceph_put_mds_session(s);
> +                       continue;
> +               }
>                 oldstate = ceph_mdsmap_get_state(oldmap, i);
>                 newstate = ceph_mdsmap_get_state(newmap, i);
>
> @@ -5814,18 +5888,24 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
> @@ -5844,6 +5924,16 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
> @@ -5902,6 +5992,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>          * Only open and reconnect sessions that don't exist yet.
>          */
>         for (i = 0; i < newmap->possible_max_rank; i++) {
> +               if (mdsc->stopping)
> +                       return;
> +
>                 /*
>                  * In case the import MDS is crashed just after
>                  * the EImportStart journal is flushed, so when
> @@ -5927,6 +6020,19 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
> @@ -7087,9 +7193,7 @@ static void mds_peer_reset(struct ceph_connection *con)
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
> @@ -7114,18 +7218,24 @@ static void mds_peer_reset(struct ceph_connection *con)
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
