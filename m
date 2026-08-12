Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F738B7D4
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553923; cv=pass; b=rINI95Cn813B/i0OiocOADtdzT0mhhQgbTTvuO6/yu0QfiE/H6c8aFd6YO2MzSbZ6itGHzrsG+HQ99mgHb8eqbqFzdWwaQ2oXRFQ+nleiKINdh+E8IumHR5o2I8FrL55phzdlBYzwiEpMZeQXPVZIgayl6qoqn4IIsHntgHIsGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553923; c=relaxed/simple;
	bh=WzTfTYfA+XBMy+IxV2qSelmnpd4pNGvNSTG9YBQ06ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhBM5junC8+gEHpQ5JScbBy7EYDSG8VmK1nb+YA7d4HCj73MtiXLdCl3HI6Y8+a8/RUt8By3k7sO0Dn7Rz7ga++6kC2FGepxp1ilbB1Fnbbcf+Yfx0cjRECH5V4eJfpwDMzARNtajnfy29oCMTTohxigui08f0mUGWPOM5j7bPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Zsw8aFgp; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zsw8aFgp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4957eefd361so9197825e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 09:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786553920; cv=none;
        d=google.com; s=arc-20260327;
        b=IB/eoKS86i3G+SLykYEWUSM9h1L7kWlFLBsz7+lVKG6r2tR/jPmFXi8RVqDPNpjS0h
         zhZQ2ylOxjELLdpeGZfePEThMhNt+U1cHvSFU0OY8lKw8nPSgzb7/DBugtblmpK5yKMd
         oMvWUkEtBnddsef0bsI4cQfV+nnpI1P8gBDnHqHQ3/0SeDq0QLEHk+1oW81TALRY9tGB
         j0AZq/o7f5ageSikdTdP2ParJEfW+dbHwtztZKkIrSfUl7h9Ih4jdm8sOZwO2Lw5v7xj
         y3Vzx02f8o/kNJOInYz7U8rA1EsHXVR2XXKpjo9P8c+gGX40h307hR8of3mAh/nwev6J
         IaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DpRgjLFPZdUlZInctBe+DLdsNY3zvFsP5PI6aD1BDP0=;
        fh=GFTyfpdbzywfZj9tf+aEQr6vCBmVI6W1/rtwh0VZuXU=;
        b=Zi2KuHYinHe21REHvwG0E31KmHMCxq/7KYr51Kff6/f3uw/RfWRubJfw745vG1G3No
         6B2xtKTwkRj+pXfFVMYdSTFmp8nEOWJSGS0pP05QEq2A/hECR44sCsrnMUQszHYPh0eQ
         75uHtMbB8vdMOqrO2U5NUPEbltotRH8z6n5zZTPwJD4KG0Qy1Yl/dZ4SdF1w2e7ooU0G
         2x82uIS3klccJxHG5WEt2BBdSXZiyUZjfQhTUcIASY38FK7akIRDOlroHLYZcFr3Nef1
         DBI/NZIppCKObQfzer73a4pULof+DuNiCXqlpzb6gbw53V8uSzt3/Tt4rBHTXfwprd9n
         RH4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786553920; x=1787158720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DpRgjLFPZdUlZInctBe+DLdsNY3zvFsP5PI6aD1BDP0=;
        b=Zsw8aFgpZl1Iu8dm4j/cEf2ioaQuHLdsu43I5JTzGTGP8gNjAC9DrL0M7qmcFPJh+Y
         2goZdTMGC0kN074gB36XRCH1JmFjgKX7ebMk14IxJvh2tVFWN6t+o1RsrdaJcOg6/3VI
         69eB70YgofiPdnfMFMzZSpLOFf7RiBWJ4oTGCvdPkJ8MN51uTu9wpUiiNCW439eLC98F
         Bs3CdwpjTYj5TkHevIRhfu4F0qoOOlnxiQx9yifo0h8YiFrmJSEirE8eiJNCc+bAZorj
         E7Az0IXdc0SK1pf6Nxanbv611HYysJGVub7MYcKm+gMMtD7LI+iKLd0YZOyzhIpoi7F/
         LYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553920; x=1787158720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DpRgjLFPZdUlZInctBe+DLdsNY3zvFsP5PI6aD1BDP0=;
        b=mqMliS3ygQvsAZRb9D82xSeoVV6TCLPtktN81eYN8kmc0gqHjjMg7/IDZBU/BNa61a
         3E4kGZ71aVbqPIFgdWkAu9aVqMkMFEX/CLNI8rsyXe9HzRL2dJCnPR0ELPUkB6VYJTI8
         esgwjWhOgXu5WZ5utRS7wt2uHMsgBzBo3FFhOF9kTVzftpQlVGhKSFpoaUl6qpAzcdKR
         q4dtQ1sUZ5ZfxJSEavkadcdIutBc5IHwg1xn77z8QW+cTuuV3JZY7VLRxba7V2eh6vfp
         V//Bi9tQdBNcbHtmanDXE6gqd0whjBG4MlxjpgJiYoLr4XYK7oPn2zeNTMlib+941b2M
         mF3w==
X-Gm-Message-State: AOJu0YxDOeATbuqgGxw9AWhRiP2jkevdi1DKvtknVZFoORIiBXFZn7+N
	sVoJVgwY2+9jgo2RxEqAWNBpMVNXD/cEIJdLQ9BcDCXpEOKRzMMcgflYtqnutMV69i8chpMLuJ6
	fMbmFOVqsVGSaCM9cpy3oeA398Qqu+vv6HoNeLBMruw==
X-Gm-Gg: AR+sD10TclprcRIDkJ3QsSVD83A9cBKVqdCekgiFn7LxfTPz5WrJRNC2goULyj/3469
	g0sxceWoHV7WDnTUMdn1UeW3TbP7B9iTdyd5oySqTO0jfm9XrHF7f/gPwrIlmrx0P7ZNUGwAMwr
	62Hkixik/Da+lN6YSziQ1Z8XT7yBuYtrgchRL7KemRxOe2NIWfueyL0yFXW5X1SotlvdtRWSDxs
	opBpFsGcalz0PoEriX38OnEiL8/xwOB+nZLovyxLi7iOuZ1awO3Bcf2yuytqsGpxNCDFpKpzMl8
	LkL5QKa49wMzKba3Pr31ZfJ8p9/0pmXjTEWVB4phF+kzK6/UpDVBQ/0pB6sHA/ygtsRYwFbGMA=
	=
X-Received: by 2002:a05:600c:a21b:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-4997c0fd924mr62159735e9.3.1786553919892; Wed, 12 Aug 2026
 09:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-fix-rbd-keepalives-v3-1-c344fbad63a4@cloudflare.com>
In-Reply-To: <20260720-fix-rbd-keepalives-v3-1-c344fbad63a4@cloudflare.com>
From: Chris Arges <carges@cloudflare.com>
Date: Wed, 12 Aug 2026 11:58:28 -0500
X-Gm-Features: AUfX_mxED6ES08e7ucAcWrqk9MEk56SHJyeqJbRzWu5rPAMi5dPT9jBaENV4E2w
Message-ID: <CAFzkdvgpoDAXJasTrwaPSmckmfWcWynuL6Fh18RNU8ZDPoj+kA@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: reset OSD session when keepalive2 acks stop arriving
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Andrew DeMaria <ademaria@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Pinging about this patch. Is there any additional feedback or changes neede=
d?
We have been successfully testing this patch since it was posted.
Thanks,
--chris

On Mon, Jul 20, 2026 at 5:43=E2=80=AFPM Chris J Arges <carges@cloudflare.co=
m> wrote:
>
> handle_timeout() in osd_client.c sends CEPH_MSGR2_TAG_KEEPALIVE2 frames
> to OSDs with stalled requests, but libceph never verifies if the ACKs
> actually return.
>
> Consequently, if an OSD messenger queue wedges while the underlying
> TCP socket remains ESTABLISHED, the client will block indefinitely in
> ceph_osdc_wait_request(), causing tasks to hang in D state.
>
> Fix this by introducing a watchdog in handle_timeout() that checks
> ceph_con_keepalive_expired() against a new CEPH_OSD_PING_TIMEOUT (60s).
> On expiry, reset the sparse-read state, call reopen_osd(), and kick
> outstanding requests when the session is reopened.
>
> Because OSD keepalives are only sent to OSDs with stalled requests,
> last_keepalive_ack can be stale on an otherwise healthy connection that
> has simply been idle. Track the start of each slow/probing episode per
> OSD and require the episode to last CEPH_OSD_PING_TIMEOUT before checking
> for an expired keepalive ack, so the watchdog only fires after we have
> been actively pinging.
>
> Additionally, seed last_keepalive_ack to the current time in
> ceph_con_open() to prevent the watchdog from firing spuriously on fresh
> connections for both OSD and monitor clients.
>
> Fixes: 8b9558aab853 ("libceph: use keepalive2 to verify the mon session i=
s alive")
> Link: https://tracker.ceph.com/issues/76202
> Co-developed-by: Andrew DeMaria <ademaria@cloudflare.com>
> Signed-off-by: Andrew DeMaria <ademaria@cloudflare.com>
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
> This patch fixes an issue where the kernel rbd client and an OSD have an
> ESTABLISHED TCP connection, but keepalive2 ACKs stop returning from the
> OSD. When that happens, outstanding OSD requests can remain held by the
> client and callers can hang in D state. We were able to mitgiate this
> issue by using ss -K to kill the affected OSD TCP connection which
> reopened the OSD session.
>
> We were able to reproduce this issue in production a few times, and
> synthetically by dropping OSD to rbd application frames while allowing
> TCP ACKs through.
>
> https://tracker.ceph.com/issues/76202 describes the same situation.
>
> The following patch addresses this by creating a watchdog that resets the
> OSD session if this situation is detected.
> ---
> Changes in v3:
> - Rebase and collected Reviewed-By tag
> - Link to v2: https://patch.msgid.link/20260709-fix-rbd-keepalives-v2-1-3=
9d4846a95ce@cloudflare.com
>
> Changes in v2:
> - add static function to check if osd keepalive timed out
> - Link to v1: https://patch.msgid.link/20260707-fix-rbd-keepalives-v1-1-b=
e888d525d6a@cloudflare.com
>
> To: Ilya Dryomov <idryomov@gmail.com>
> To: Alex Markuze <amarkuze@redhat.com>
> To: Viacheslav Dubeyko <slava@dubeyko.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/ceph/libceph.h    |  1 +
>  include/linux/ceph/osd_client.h |  1 +
>  net/ceph/messenger.c            |  3 +++
>  net/ceph/osd_client.c           | 29 ++++++++++++++++++++++++++++-
>  4 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 63e0e2aa1ce9..1a117c5f1964 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -74,6 +74,7 @@ struct ceph_options {
>   */
>  #define CEPH_MOUNT_TIMEOUT_DEFAULT     msecs_to_jiffies(60 * 1000)
>  #define CEPH_OSD_KEEPALIVE_DEFAULT     msecs_to_jiffies(5 * 1000)
> +#define CEPH_OSD_PING_TIMEOUT          msecs_to_jiffies(60 * 1000)
>  #define CEPH_OSD_IDLE_TTL_DEFAULT      msecs_to_jiffies(60 * 1000)
>  #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
>  #define CEPH_READ_FROM_REPLICA_DEFAULT 0  /* read from primary */
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_cli=
ent.h
> index 50b14a5661c7..52eb76e9d62a 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -94,6 +94,7 @@ struct ceph_osd {
>         struct ceph_auth_handshake o_auth;
>         unsigned long lru_ttl;
>         struct list_head o_keepalive_item;
> +       unsigned long o_keepalive_stamp;
>         struct mutex lock;
>         struct ceph_sparse_read o_sparse_read;
>  };
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 34b3097b4c7b..f7776d83d506 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -610,6 +610,9 @@ void ceph_con_open(struct ceph_connection *con,
>
>         memcpy(&con->peer_addr, addr, sizeof(*addr));
>         con->delay =3D 0;      /* reset backoff memory */
> +
> +       ktime_get_real_ts64(&con->last_keepalive_ack);
> +
>         mutex_unlock(&con->mutex);
>         queue_con(con);
>  }
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c181..c4e1c0534801 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -53,6 +53,7 @@ static void link_linger(struct ceph_osd *osd,
>  static void unlink_linger(struct ceph_osd *osd,
>                           struct ceph_osd_linger_request *lreq);
>  static void clear_backoffs(struct ceph_osd *osd);
> +static void kick_osd_requests(struct ceph_osd *osd);
>
>  #if 1
>  static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
> @@ -3420,6 +3421,15 @@ static int linger_notify_finish_wait(struct ceph_o=
sd_linger_request *lreq,
>         return left;
>  }
>
> +static bool osd_keepalive_timed_out(struct ceph_osd *osd)
> +{
> +       if (!time_after_eq(jiffies,
> +                          osd->o_keepalive_stamp + CEPH_OSD_PING_TIMEOUT=
))
> +               return false;
> +
> +       return ceph_con_keepalive_expired(&osd->o_con, CEPH_OSD_PING_TIME=
OUT);
> +}
> +
>  /*
>   * Timeout callback, called every N seconds.  When 1 or more OSD
>   * requests has been active for more than N seconds, we send a keepalive
> @@ -3480,8 +3490,11 @@ static void handle_timeout(struct work_struct *wor=
k)
>                         mutex_unlock(&lreq->lock);
>                 }
>
> -               if (found)
> +               if (found) {
>                         list_move_tail(&osd->o_keepalive_item, &slow_osds=
);
> +               } else {
> +                       osd->o_keepalive_stamp =3D 0;
> +               }
>         }
>
>         if (opts->osd_request_timeout) {
> @@ -3507,6 +3520,20 @@ static void handle_timeout(struct work_struct *wor=
k)
>                                                         struct ceph_osd,
>                                                         o_keepalive_item)=
;
>                 list_del_init(&osd->o_keepalive_item);
> +
> +               /* Record start of ping timeout from the first slow tick.=
 */
> +               if (!osd->o_keepalive_stamp) {
> +                       osd->o_keepalive_stamp =3D jiffies;
> +               } else if (osd_keepalive_timed_out(osd)) {
> +                       pr_warn_ratelimited("osd%d not responding to keep=
alives, resetting session\n",
> +                                           osd->o_osd);
> +                       osd->o_sparse_op_idx =3D -1;
> +                       ceph_init_sparse_read(&osd->o_sparse_read);
> +                       if (!reopen_osd(osd))
> +                               kick_osd_requests(osd);
> +                       continue;
> +               }
> +
>                 ceph_con_keepalive(&osd->o_con);
>         }
>
>
> ---
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> change-id: 20260707-fix-rbd-keepalives-664fe9266c35
>
> Best regards,
> --
> Chris J Arges <carges@cloudflare.com>
>
