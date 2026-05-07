Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218F41325E
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181757; cv=none; b=A3LxNEWVA/gmtjJGsBcbJoAlzsokAuPKnlsyEC5tG9bfFj+Gzft7s9ELvl3PvGgukOeYzYToiqVb/4aJZ0eE8Mp/2RlSMUsvCT2bKbQ0xa1imr/1c8h6efE2i93K99GStK3Ep+uAlI/NSW6fc2RUHthI0Jce5tqPUh4/RSP95BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181757; c=relaxed/simple;
	bh=k0K4eI3+VYC8Gl8VXesM4PGtvx02DQtPwHozfFSXxCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f2v2mPfTeHTRvfj+kPEBitJUY1zLilqSOMEFfHZvr84/uyEc8jOgq7lu0sEID/un0NnqSyRqGUmjhhk3I620FQDiz/gWiM2dd/j+dESzofwI6g7i5NEybo9nb+9alemsC+xNlX8KyG46dxDvU8zDpo7tzhJ+cw4fWp7i34g8lw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1YQ7ZJN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHaqWWA7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1YQ7ZJN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHaqWWA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778181754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UV7cJTsfQAhuvMWUxthMUvI3jp0Ay7yW6iBG9vehno0=;
	b=Q1YQ7ZJN+n6iifWCSWWZkYXeD2eNR6sFnW9JV/qRmX2CNBb+x/LhZ88uFb2xeuTMTsIsdo
	x4U5vUFx57ONi1wrzTOGpKaxzyAfVqrNBJ30edHl1B7iu+ggPmG42vBtupMo3FdtVCgu9q
	L4Zn8QF9jDc7smkdfWjEfaEZYuwq0f8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-TfJW6lhDObeGpU-mm3pJ8w-1; Thu, 07 May 2026 15:22:30 -0400
X-MC-Unique: TfJW6lhDObeGpU-mm3pJ8w-1
X-Mimecast-MFC-AGG-ID: TfJW6lhDObeGpU-mm3pJ8w_1778181750
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd5c9e2e4aso31008027b3.2
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778181750; x=1778786550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UV7cJTsfQAhuvMWUxthMUvI3jp0Ay7yW6iBG9vehno0=;
        b=ZHaqWWA7FLC2la61DScpAcM3mvBuZ/+oHcVwYY/JUcnWYKTiREQ6dFPijM0x01306r
         8w57qI7NwOmptytGPQljarx5jb949p+MCntgOA/1robrCBTxqajCx72iR4HTgwOkM4qf
         7FSUWq7RhGGtFpIC/H6A8a0g06/eDx9B3D2IqXtz2K5rKV1BZJxFXHGlKeotDMirBl+y
         tNJSjmbpa6bBG/NgnzwD1DSvem1XP/Hb9guquxbUhPloyK7nXmP4SNFMP30IQN7j1jW/
         l1eohUsKtt7nhEr28I1NfoF7OAO8tjqtnbGFXKz0iA4W4JuR8vhiQZdSStvJXhrvp3+U
         JVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181750; x=1778786550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UV7cJTsfQAhuvMWUxthMUvI3jp0Ay7yW6iBG9vehno0=;
        b=coZmtLUIIdUe8Q5li9wkkiUfUbf3O8xDZRVaj57cWT65mp8mJm8Z/sx1vrjzv6tReH
         3zvTt3+QHVaKYdG8CZDklSRcJwa72kAnlWtH/3195kWWosES1X3rSiiqWw+qWcu90Q6Y
         Y1SejSDiw62FF+TbK95r4lfB3068rQofNLlFzjbHxyVR5hSMLWmnDaG4QxAkh/1j/5uI
         9AcKv6r3/ZWwcWArpW3XESlU634ujO00eUEJmiYnNg0koeL9RtNa8OJ5wPV5GEvf5Nw7
         o/OczyOvTbIMxCj7szNsOc5w9/FMWBonwY1UI4zgsufwvGx0IKTlxZLTT1SmOaXIDxWk
         Mr1g==
X-Forwarded-Encrypted: i=1; AFNElJ8u0K28lg3ZDH6VtTszOgbnnUNMEqfrXAYHinHdajM+VNbS0dVsGvIs+eF9ViOi8+Wt+oczviX/yh3q@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlHxoRP0Pu2No6C0yTsMc2A++B35ILG34I4IxURn40KnXkNHD
	IMiC92x23jDrh0mB2eXTfk4BhLgbAwQpzaXt0Dn2lp2YnWWCabvHdXXc4lkAV31UeeiHLd2QKPL
	HJFyy/uW9SrprrDhxaDSIMpTDd4YuGo0auyX33ehgDh9Z5qqtvFpJvRl+5XgzL1U=
X-Gm-Gg: Acq92OFPrzJ7mIo484AL+BsAEhZfzJe4LYk8rZx+F/Brod/+dX3Jjik7YFbw49NDSvy
	MCc9KN1w+pitUftGDdBwUYvSeDjNAhfvXNzM7RdoLtWr4QTgSSoIeKxyNSeu1klwtHNyzmrWh0S
	z6mywTbTgWURoAb+b1l9s88Qx+JnzfF1NX86qPRiZBh9nLsU5OKQNps1jqWAoGS328r79mOyfTf
	YQpSmHiFlM+7/Q8DYSiitXQeJwREvUgjj02XiXcuUQWRX/BoWr4XkybAzR1SS28hjFQfkSXR6je
	T8EeWPeBBnSQOjLbnsUetgrzKWxJ89uNiHo4BUXaiFjsbC4hUkEVS3pVBYnyp7uMttnOZE79ylB
	gPISvJV0mkLofkF1KxIaQp/MCjjSvgnaDUB99KNLWHSgVfEiXwSyH
X-Received: by 2002:a05:690c:6e85:b0:79a:5fb9:62ad with SMTP id 00721157ae682-7bdf5eeea02mr100854237b3.43.1778181749859;
        Thu, 07 May 2026 12:22:29 -0700 (PDT)
X-Received: by 2002:a05:690c:6e85:b0:79a:5fb9:62ad with SMTP id 00721157ae682-7bdf5eeea02mr100853877b3.43.1778181749211;
        Thu, 07 May 2026 12:22:29 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6656542bsm97141627b3.20.2026.05.07.12.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:22:28 -0700 (PDT)
Message-ID: <114b76303a6f0246878eb986fce509833a5091c2.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 06/11] ceph: add manual reset debugfs
 control and tracepoints
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:22:27 -0700
In-Reply-To: <20260507122737.2804094-7-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-7-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 12:27 +0000, Alex Markuze wrote:
> Add the debugfs and trace plumbing used to trigger and observe
> manual client reset.
>=20
> The reset interface exposes a trigger file for operator-initiated
> reset and a status file for tracking the most recent run.  The
> tracepoints record scheduling, completion, and blocked caller
> behavior so reset progress can be diagnosed from the client side.
>=20
> debugfs layout under /sys/kernel/debug/ceph/<client>/reset/:
>   trigger - write to initiate a manual reset
>   status  - read to see the most recent reset result
>=20
> The reset directory is cleaned up via debugfs_remove_recursive()
> on the parent, so individual file dentries are not stored.
>=20
> Tracepoints:
>   ceph_client_reset_schedule  - reset queued
>   ceph_client_reset_complete  - reset finished (success or failure)
>   ceph_client_reset_blocked   - caller blocked waiting for reset
>   ceph_client_reset_unblocked - caller unblocked after reset
>=20
> All tracepoints use a null-safe access for monc.auth->global_id
> to guard against early-init or late-teardown edge cases.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/debugfs.c           | 103 ++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.c        |   7 +++
>  fs/ceph/super.h             |   1 +
>  include/trace/events/ceph.h |  67 +++++++++++++++++++++++
>  4 files changed, 178 insertions(+)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index e2463f93cf6b..18eb5da03411 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/math64.h>
>  #include <linux/ktime.h>
> +#include <linux/uaccess.h>
>  #include <linux/atomic.h>
> =20
>  #include <linux/ceph/libceph.h>
> @@ -392,6 +393,90 @@ static int status_show(struct seq_file *s, void *p)
>  	return 0;
>  }
> =20
> +static int reset_status_show(struct seq_file *s, void *p)
> +{
> +	struct ceph_fs_client *fsc =3D s->private;
> +	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> +	struct ceph_client_reset_state *st;
> +	u64 trigger =3D 0, success =3D 0, failure =3D 0;
> +	unsigned long last_start =3D 0, last_finish =3D 0;
> +	int last_errno =3D 0;
> +	enum ceph_client_reset_phase phase =3D CEPH_CLIENT_RESET_IDLE;
> +	bool drain_timed_out =3D false;
> +	int sessions_reset =3D 0;
> +	int blocked_requests =3D 0;
> +	char reason[CEPH_CLIENT_RESET_REASON_LEN];
> +
> +	if (!mdsc)
> +		return 0;
> +
> +	st =3D &mdsc->reset_state;
> +
> +	spin_lock(&st->lock);
> +	trigger =3D st->trigger_count;
> +	success =3D st->success_count;
> +	failure =3D st->failure_count;
> +	last_start =3D st->last_start;
> +	last_finish =3D st->last_finish;
> +	last_errno =3D st->last_errno;
> +	phase =3D st->phase;
> +	drain_timed_out =3D st->drain_timed_out;
> +	sessions_reset =3D st->sessions_reset;
> +	strscpy(reason, st->last_reason, sizeof(reason));
> +	spin_unlock(&st->lock);
> +
> +	blocked_requests =3D atomic_read(&st->blocked_requests);
> +
> +	seq_printf(s, "phase: %s\n", ceph_reset_phase_name(phase));
> +	seq_printf(s, "trigger_count: %llu\n", trigger);
> +	seq_printf(s, "success_count: %llu\n", success);
> +	seq_printf(s, "failure_count: %llu\n", failure);
> +	if (last_start)
> +		seq_printf(s, "last_start_ms_ago: %u\n",
> +			   jiffies_to_msecs(jiffies - last_start));
> +	else
> +		seq_puts(s, "last_start_ms_ago: (never)\n");
> +	if (last_finish)
> +		seq_printf(s, "last_finish_ms_ago: %u\n",
> +			   jiffies_to_msecs(jiffies - last_finish));
> +	else
> +		seq_puts(s, "last_finish_ms_ago: (never)\n");
> +	seq_printf(s, "last_errno: %d\n", last_errno);
> +	seq_printf(s, "last_reason: %s\n",
> +		   reason[0] ? reason : "(none)");
> +	seq_printf(s, "drain_timed_out: %s\n",
> +		   drain_timed_out ? "yes" : "no");
> +	seq_printf(s, "sessions_reset: %d\n", sessions_reset);
> +	seq_printf(s, "blocked_requests: %d\n", blocked_requests);
> +
> +	return 0;
> +}
> +
> +static ssize_t reset_trigger_write(struct file *file, const char __user =
*buf,
> +				   size_t len, loff_t *ppos)
> +{
> +	struct ceph_fs_client *fsc =3D file->private_data;
> +	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> +	char reason[CEPH_CLIENT_RESET_REASON_LEN];
> +	size_t copy;
> +	int ret;
> +
> +	if (!mdsc)
> +		return -ENODEV;
> +
> +	copy =3D min_t(size_t, len, sizeof(reason) - 1);
> +	if (copy && copy_from_user(reason, buf, copy))
> +		return -EFAULT;
> +	reason[copy] =3D '\0';
> +	strim(reason);
> +
> +	ret =3D ceph_mdsc_schedule_reset(mdsc, reason);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
>  static int subvolume_metrics_show(struct seq_file *s, void *p)
>  {
>  	struct ceph_fs_client *fsc =3D s->private;
> @@ -450,6 +535,7 @@ DEFINE_SHOW_ATTRIBUTE(mdsc);
>  DEFINE_SHOW_ATTRIBUTE(caps);
>  DEFINE_SHOW_ATTRIBUTE(mds_sessions);
>  DEFINE_SHOW_ATTRIBUTE(status);
> +DEFINE_SHOW_ATTRIBUTE(reset_status);
>  DEFINE_SHOW_ATTRIBUTE(metrics_file);
>  DEFINE_SHOW_ATTRIBUTE(metrics_latency);
>  DEFINE_SHOW_ATTRIBUTE(metrics_size);
> @@ -521,6 +607,13 @@ static int metric_features_show(struct seq_file *s, =
void *p)
> =20
>  DEFINE_SHOW_ATTRIBUTE(metric_features);
> =20
> +static const struct file_operations ceph_reset_trigger_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D simple_open,
> +	.write =3D reset_trigger_write,
> +	.llseek =3D noop_llseek,
> +};
> +
>  /*
>   * debugfs
>   */
> @@ -554,6 +647,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *f=
sc)
>  	debugfs_remove(fsc->debugfs_caps);
>  	debugfs_remove(fsc->debugfs_status);
>  	debugfs_remove(fsc->debugfs_mdsc);
> +	debugfs_remove_recursive(fsc->debugfs_reset_dir);
>  	debugfs_remove(fsc->debugfs_subvolume_metrics);
>  	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
>  	doutc(fsc->client, "done\n");
> @@ -602,6 +696,15 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc=
)
>  						fsc,
>  						&caps_fops);
> =20
> +	fsc->debugfs_reset_dir =3D debugfs_create_dir("reset",
> +						    fsc->client->debugfs_dir);
> +	debugfs_create_file("trigger", 0200,
> +			    fsc->debugfs_reset_dir, fsc,
> +			    &ceph_reset_trigger_fops);
> +	debugfs_create_file("status", 0400,
> +			    fsc->debugfs_reset_dir, fsc,
> +			    &reset_status_fops);
> +
>  	fsc->debugfs_status =3D debugfs_create_file("status",
>  						  0400,
>  						  fsc->client->debugfs_dir,
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index ce773b1095da..b16638ebff7f 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5324,6 +5324,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client=
 *mdsc)
>  	blocked_count =3D atomic_inc_return(&st->blocked_requests);
>  	doutc(cl, "request blocked during reset, %d total blocked\n",
>  	      blocked_count);
> +	trace_ceph_client_reset_blocked(mdsc, blocked_count);
> =20
>  retry:
>  	remaining =3D max_t(long, deadline - jiffies, 1);
> @@ -5334,10 +5335,12 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_clie=
nt *mdsc)
>  	if (wait_ret =3D=3D 0) {
>  		atomic_dec(&st->blocked_requests);
>  		pr_warn_client(cl, "timed out waiting for reset to complete\n");
> +		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
>  		return -ETIMEDOUT;
>  	}
>  	if (wait_ret < 0) {
>  		atomic_dec(&st->blocked_requests);
> +		trace_ceph_client_reset_unblocked(mdsc, (int)wait_ret);
>  		return (int)wait_ret;  /* -ERESTARTSYS */
>  	}
> =20
> @@ -5352,12 +5355,14 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_clie=
nt *mdsc)
>  		if (time_before(jiffies, deadline))
>  			goto retry;
>  		atomic_dec(&st->blocked_requests);
> +		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
>  		return -ETIMEDOUT;
>  	}
>  	ret =3D st->last_errno;
>  	spin_unlock(&st->lock);
> =20
>  	atomic_dec(&st->blocked_requests);
> +	trace_ceph_client_reset_unblocked(mdsc, ret);
>  	return ret ? -EAGAIN : 0;
>  }
> =20
> @@ -5387,6 +5392,7 @@ static void ceph_mdsc_reset_complete(struct ceph_md=
s_client *mdsc, int ret)
>  	/* Wake up all requests that were blocked waiting for reset */
>  	wake_up_all(&st->blocked_wq);
> =20
> +	trace_ceph_client_reset_complete(mdsc, ret);
>  }
> =20
>  static void ceph_mdsc_reset_workfn(struct work_struct *work)
> @@ -5749,6 +5755,7 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client=
 *mdsc,
>  	pr_info_client(mdsc->fsc->client,
>  		       "manual session reset scheduled (reason=3D\"%s\")\n",
>  		       msg);
> +	trace_ceph_client_reset_schedule(mdsc, msg);
>  	return 0;
>  }
> =20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index a4993644d543..1d6aab060780 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -179,6 +179,7 @@ struct ceph_fs_client {
>  	struct dentry *debugfs_status;
>  	struct dentry *debugfs_mds_sessions;
>  	struct dentry *debugfs_metrics_dir;
> +	struct dentry *debugfs_reset_dir;
>  	struct dentry *debugfs_subvolume_metrics;
>  #endif
> =20
> diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
> index 08cb0659fbfc..1b990632f62b 100644
> --- a/include/trace/events/ceph.h
> +++ b/include/trace/events/ceph.h
> @@ -226,6 +226,73 @@ TRACE_EVENT(ceph_handle_caps,
>  		  __entry->mseq)
>  );
> =20
> +/*
> + * Client reset tracepoints - identify the client by its monitor-
> + * assigned global_id so traces remain meaningful when kernel pointer
> + * hashing is enabled.
> + */
> +TRACE_EVENT(ceph_client_reset_schedule,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, const char *reason),
> +	TP_ARGS(mdsc, reason),
> +	TP_STRUCT__entry(
> +		__field(u64, client_id)
> +		__string(reason, reason ? reason : "")
> +	),
> +	TP_fast_assign(
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth ?
> +			mdsc->fsc->client->monc.auth->global_id : 0;
> +		__assign_str(reason);
> +	),
> +	TP_printk("client_id=3D%llu reason=3D%s",
> +		  __entry->client_id, __get_str(reason))
> +);
> +
> +TRACE_EVENT(ceph_client_reset_complete,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
> +	TP_ARGS(mdsc, ret),
> +	TP_STRUCT__entry(
> +		__field(u64, client_id)
> +		__field(int, ret)
> +	),
> +	TP_fast_assign(
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth ?
> +			mdsc->fsc->client->monc.auth->global_id : 0;
> +		__entry->ret =3D ret;
> +	),
> +	TP_printk("client_id=3D%llu ret=3D%d", __entry->client_id, __entry->ret=
)
> +);
> +
> +TRACE_EVENT(ceph_client_reset_blocked,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, int blocked_count),
> +	TP_ARGS(mdsc, blocked_count),
> +	TP_STRUCT__entry(
> +		__field(u64, client_id)
> +		__field(int, blocked_count)
> +	),
> +	TP_fast_assign(
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth ?
> +			mdsc->fsc->client->monc.auth->global_id : 0;
> +		__entry->blocked_count =3D blocked_count;
> +	),
> +	TP_printk("client_id=3D%llu blocked_count=3D%d", __entry->client_id,
> +		  __entry->blocked_count)
> +);
> +
> +TRACE_EVENT(ceph_client_reset_unblocked,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
> +	TP_ARGS(mdsc, ret),
> +	TP_STRUCT__entry(
> +		__field(u64, client_id)
> +		__field(int, ret)
> +	),
> +	TP_fast_assign(
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth ?
> +			mdsc->fsc->client->monc.auth->global_id : 0;
> +		__entry->ret =3D ret;
> +	),
> +	TP_printk("client_id=3D%llu ret=3D%d", __entry->client_id, __entry->ret=
)
> +);
> +
>  #undef EM
>  #undef E_
>  #endif /* _TRACE_CEPH_H */

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

