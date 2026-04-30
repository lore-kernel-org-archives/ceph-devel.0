Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C9478E23
	for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2026 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574341; cv=none; b=JFa41rk7PK4zwfoXLxnPyV9Vdj0B42E8iRAAqA1eWDoEPfGR4tY3xCy4XekQ1s3Io8LEDkIfY2Oz20KmdGbLIrpqNQuHln3W0Jf2ZSQ72EW33sF2RmWV5y3MQOTvEJxnHBQ2IEWouMjEx/WPovNq27e9q2uH3pEtB20h6NT0C8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574341; c=relaxed/simple;
	bh=EqmwHRLLWbHLIcOeZ7vaANmp0S5pENcrV0pJfsuw3Mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsPZgp/MZidkEU4cGPjISV/GJ2rrqmjbDPYAwXJBhCoD673XLUIbrHgn8K8p9Y09MpiuE2IzRVAFomBGMK0JCm5pBhFy/ZRe1qyXy11yewUoEUtNHIrRuYo4I80fj+R7RAm/NpxqjCEul6k9Ov/raWM/TvCtS5TZSH9L4AOMa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeNTt/+0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9mL7/o9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeNTt/+0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9mL7/o9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777574338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9PaaAPZ3VkaMahC4SFvn+PngLwpDYvdyr0OLdGw4Vo=;
	b=ZeNTt/+0f4TMR1DUNOiaf4HdV8lzdPuEGqzu/JT8oi3NjmXd5UEaUAs5+TMR337DL34GDl
	Jqvc4+ZBQJ2y3r4vO0L2uNVJb2Rt7Ahv8twyIgrEL2o/AI7/FKZl1sxup0bBQ9rF44Gh9h
	KHbSu87h4P/+fc2DkvtXOVPwIeiZce4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-NixFVFjhPQ6sPwFHkWDc6w-1; Thu, 30 Apr 2026 14:38:57 -0400
X-MC-Unique: NixFVFjhPQ6sPwFHkWDc6w-1
X-Mimecast-MFC-AGG-ID: NixFVFjhPQ6sPwFHkWDc6w_1777574337
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7986c067508so27162707b3.2
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2026 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777574337; x=1778179137; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c9PaaAPZ3VkaMahC4SFvn+PngLwpDYvdyr0OLdGw4Vo=;
        b=f9mL7/o9SwJfRJ6UqzkPvvRjIaJkkp5ULPG3A/erS6da58UvsMCY/9E9PV6ruPJtfP
         SRUTkSyrrFH97LpC5KuaHQttpCT8QuvWAoe4DAErv6xsooOfz/X0lhiOGQy6IVmnF8Du
         ig0ecT8dU1RkjWS720oU+TFUXNM9lgTEbdu24GrxpR93czFifYkupELWYvdZF0X4LBhp
         a6ALIzPHf5HDcgWt6cRk0mUIzWfQZ8sqmPleF5t1CNa+SXymBmdY6A1DO48PLiNlJPrf
         W9kZgYMifMPPIf16r3dGC9lYIhNn3VRja+cNuKdWogg69fHWNWettZSc3Jl+LXgKYBRk
         edxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574337; x=1778179137;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9PaaAPZ3VkaMahC4SFvn+PngLwpDYvdyr0OLdGw4Vo=;
        b=AkWN5RYBhJ7aWilEzfxqbFJ/AJOEmDoUc/pG7N13NWv15F+ypdxMeVG2Wa40fInaey
         u53NTLc65rYu12RZ9jgxNI3/mvTPjLdVo/+FEYT4KSW1X/xksW7mCU/QA89tNFKQ7ePS
         epnP1ALcuq/B76IA+WDzenCXGeQfv3+bKC5cPWnlDRsINM51buUimGSM3WHYAl36fN0j
         yNtdrf930qd9gX2uk7xFCK2VCMASQ0T+Y57rV9j2awmU0JEkL6HPcUGEK8XJk2ecbnmf
         AaZSwhmm28i1JAOyQuU5ZrhTeHA9/KpcSi9Aj8UXx1eczlk8Nd9/xr39FnpxKl+9ouGp
         KwAw==
X-Forwarded-Encrypted: i=1; AFNElJ+dUF0Xw5qDGSo1WhsTYGS/O2HcTdwdQo7nZkB7wUWBjLgzBYjHalfmMEQ9OEAlkLIvqZjqJa4E5v07@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbu6i7W8QzUTeQAT8/MImKP4koJDywIa+fUyVTtLQCsz3NTui
	kdrysn68g17kmv6ba/rVqLOmMltuCT+Sm0WcdoXQTKM4Kp6JwUnjbv2rZTGyOHMqhqrrcPVHAxM
	eZHpiqSCtxfD5jKL+7Fnft229eqeUiQCU0xeEigzesblAr4w5BBjjBQpUOmAfvdQ=
X-Gm-Gg: AeBDietFSMUnRiUxyO/lZOvkvhkSS3HOXt2a+CK2KUEeMl0v+Br6hob2u5CFxWnjckY
	dubL3xNv9FlyaUaQunCdpKHAn5892jwuk27zgR06nGwGiAwlxbwO5SGAiurgzwt8zU/XJEItoTQ
	56Wl6JxajgS7UNUzCAbrpTpMh0W8j7jdk3x/3uJ94AMqRm7rC7tQynCR/Ot9pDDCfXn9uy4NDTt
	Jqi1tlguC7XF3R6y1d1zc6n4LN/6QpnGos46UjDwEVZ7NcPrjxPoCGdz+ZW5yTn4vaDeJF/9A4e
	MaVus5tBEqcrWw4r1fsSKjztZrpiNBetTLutycXqwv5PPQHef4176ljUhYtmiGVtF6wONYmncXc
	iczTn03WQq3gwvRaUjxTN9PZcaGL5yPxbY3U7achi1TmGHGhgQY7dagIQfA/uJOY=
X-Received: by 2002:a05:690c:ec7:b0:7b4:ad41:4847 with SMTP id 00721157ae682-7bd52aa43bdmr43017357b3.47.1777574336683;
        Thu, 30 Apr 2026 11:38:56 -0700 (PDT)
X-Received: by 2002:a05:690c:ec7:b0:7b4:ad41:4847 with SMTP id 00721157ae682-7bd52aa43bdmr43016817b3.47.1777574336120;
        Thu, 30 Apr 2026 11:38:56 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685c06csm768937b3.34.2026.04.30.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:38:55 -0700 (PDT)
Message-ID: <765228488ac0a9025df8116790cedbbc85264d8f.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v3 06/11] ceph: add manual reset debugfs
 control and tracepoints
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 30 Apr 2026 11:38:54 -0700
In-Reply-To: <20260429125206.1512203-7-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
	 <20260429125206.1512203-7-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-29 at 12:52 +0000, Alex Markuze wrote:
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
>  fs/ceph/debugfs.c           | 102 ++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.c        |   8 +++
>  fs/ceph/super.h             |   1 +
>  include/trace/events/ceph.h |  67 +++++++++++++++++++++++
>  4 files changed, 178 insertions(+)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 7dc307790240..beee4cfe8b18 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/math64.h>
>  #include <linux/ktime.h>
> +#include <linux/uaccess.h>
> =20
>  #include <linux/ceph/libceph.h>
>  #include <linux/ceph/mon_client.h>
> @@ -360,16 +361,107 @@ static int status_show(struct seq_file *s, void *p=
)
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
>  DEFINE_SHOW_ATTRIBUTE(mdsmap);
>  DEFINE_SHOW_ATTRIBUTE(mdsc);
>  DEFINE_SHOW_ATTRIBUTE(caps);
>  DEFINE_SHOW_ATTRIBUTE(mds_sessions);
>  DEFINE_SHOW_ATTRIBUTE(status);
> +DEFINE_SHOW_ATTRIBUTE(reset_status);
>  DEFINE_SHOW_ATTRIBUTE(metrics_file);
>  DEFINE_SHOW_ATTRIBUTE(metrics_latency);
>  DEFINE_SHOW_ATTRIBUTE(metrics_size);
>  DEFINE_SHOW_ATTRIBUTE(metrics_caps);
> =20
> +static const struct file_operations ceph_reset_trigger_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D simple_open,
> +	.write =3D reset_trigger_write,
> +	.llseek =3D noop_llseek,
> +};
> =20
>  /*
>   * debugfs
> @@ -404,6 +496,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *f=
sc)
>  	debugfs_remove(fsc->debugfs_caps);
>  	debugfs_remove(fsc->debugfs_status);
>  	debugfs_remove(fsc->debugfs_mdsc);
> +	debugfs_remove_recursive(fsc->debugfs_reset_dir);

I started to have troubles to apply the patches from the 3rd one. And lates=
t
kernel version contains:

debugfs_remove(fsc->debugfs_subvolume_metrics);

So, patchset needs to be rebased on the latest state of CephFS kernel clien=
t.

Thanks,
Slava.

>  	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
>  	doutc(fsc->client, "done\n");
>  }
> @@ -451,6 +544,15 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc=
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
> index 777af51ec8d8..8339c2c72f9a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5261,6 +5261,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client=
 *mdsc)
>  	blocked_count =3D atomic_inc_return(&st->blocked_requests);
>  	doutc(cl, "request blocked during reset, %d total blocked\n",
>  	      blocked_count);
> +	trace_ceph_client_reset_blocked(mdsc, blocked_count);
> =20
>  retry:
>  	remaining =3D max_t(long, deadline - jiffies, 1);
> @@ -5272,10 +5273,12 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_clie=
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
> @@ -5290,12 +5293,14 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_clie=
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
>  	return ret ? -EIO : 0;
>  }
> =20
> @@ -5324,6 +5329,8 @@ static void ceph_mdsc_reset_complete(struct ceph_md=
s_client *mdsc, int ret)
> =20
>  	/* Wake up all requests that were blocked waiting for reset */
>  	wake_up_all(&st->blocked_wq);
> +
> +	trace_ceph_client_reset_complete(mdsc, ret);
>  }
> =20
>  static void ceph_mdsc_reset_workfn(struct work_struct *work)
> @@ -5633,6 +5640,7 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client=
 *mdsc,
>  	pr_info_client(mdsc->fsc->client,
>  		       "manual session reset scheduled (reason=3D\"%s\")\n",
>  		       msg);
> +	trace_ceph_client_reset_schedule(mdsc, msg);
>  	return 0;
>  }
> =20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 9aca42c89ea0..5bf976b6c4fe 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -179,6 +179,7 @@ struct ceph_fs_client {
>  	struct dentry *debugfs_status;
>  	struct dentry *debugfs_mds_sessions;
>  	struct dentry *debugfs_metrics_dir;
> +	struct dentry *debugfs_reset_dir;
>  #endif
> =20
>  #ifdef CONFIG_CEPH_FSCACHE
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

