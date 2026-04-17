Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFB36CDEF
	for <ceph-devel@vger.kernel.org>; Fri, 17 Apr 2026 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451294; cv=none; b=gE2922ojv8bJe0iKsZ7a/8Fy0BDlTeOBTOi/alEONUAOFvV+zpx5gIkAfoK1ulS7ehw3ZBz/7fSQCDNavjEUeqrR8g6tZsxbZfkoDHAredWuvCX+wJUdRXwXv2039o+jowLZDsDJfU5sIS6s4NhF6i9nYJY1IXtDgjU9atNOEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451294; c=relaxed/simple;
	bh=0PkolFDNiSJzGabLr7AF6StOXI4t48BAqgWCfl+N190=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XU6alFLlwT2h26YOWVf+oBjF2ukG0kH70AkPFHORe4ppGQBXTCIvcBBc5PZVdanwuc1goptU0kwKQcI3wSSc1IAXz+RaucLL1AE3WPZm5cSROs/moN6TtxEAyeYXQwxS0b1kYZ8ETgL4GKqKpC0UUPjW7S7SGnhjdePseQjrqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaVg6o5H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=scz6Jyuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaVg6o5H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="scz6Jyuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776451291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcRtbNqqeLTm/Jm1vYZ15JpEVH0qSIwekYpYsNXcp34=;
	b=XaVg6o5HoXaJwjzSoAFq855OMYea/qUxGQ/fRayv7eSJLxQphV5hVhJWbWvOTlV2pZOY/Q
	mfnx7+Klee77FiXfyyNnarAt4vwkgk3hZ/G8cw0S5ygWIeVQ2KbWEHwqvsf3EpW/JBqCIN
	dRCYfbqwZEqvVquiuI81FrWvUVl4+jE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-TNQPKFAZP8aOlJogUHge9Q-1; Fri, 17 Apr 2026 14:41:30 -0400
X-MC-Unique: TNQPKFAZP8aOlJogUHge9Q-1
X-Mimecast-MFC-AGG-ID: TNQPKFAZP8aOlJogUHge9Q_1776451290
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7b7e80f7a8bso23026277b3.3
        for <ceph-devel@vger.kernel.org>; Fri, 17 Apr 2026 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776451290; x=1777056090; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UcRtbNqqeLTm/Jm1vYZ15JpEVH0qSIwekYpYsNXcp34=;
        b=scz6JyuqTo3zSbs7yRW54AV+U+75t+oelwn5Jgfm7BJYRlbIXEQwVtkewJNFDVCR6g
         bklT/3UD3MiEfIhh+BTTBDEsoCS96RSBzPjDKBUQb/NAFOdcXab7HX2Jcsjuzd220XF8
         VavwZ0gQkyiOaWH6xVbyh2hd4WXPSPer9ycx6kqjkJ8lVXFHiFEMKXO2/bBLw49Xr0QB
         rFR8/R3RsVUHoq7+kmjJgh4TRgT0TQI/o1+eQhDM7YzUPr8BdXd/3t2QX61ETMoKpLIy
         FUW/mPCYGVM83mJ/jLDpTc7jtQN0+xtCcX0FunwBZs5CCZK4hJvUaUmE9DVAoc039OQf
         iWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776451290; x=1777056090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcRtbNqqeLTm/Jm1vYZ15JpEVH0qSIwekYpYsNXcp34=;
        b=kbg5Syx786H9+/QkElh3xwaR9pOCXURZyEu7qhcaVjiOlFARFa7owFOHEIM+ZPVr0K
         2WMBeQOpUVfxJY5mgQbui52Kdly3FFdd7OlZHZyNyqJ9yh4YqQOBSX8wuxL+bwA0qHw7
         wQeKP55kQMsD8qCLfUb6jiJfG6kkd6xUBLPb9fteXcXAnlPwFajWsPjNZMAmC+IYF0cG
         2FL4OL0Y49YSCCNIjApRnWCbiQegrbDivIx0gZ1EF8GeSx4IO3OcDWahuHAt9U3lYmQT
         n3oFiIOKwzwVBh3jKvnc4cOIPZFXlzpskAE68R70KLN3pwkqc8NSbYn2ZibS3ujf1FGh
         SACg==
X-Forwarded-Encrypted: i=1; AFNElJ/7VQo9isLzk+pTCWMoLVA5qDPlFFUOOed2O9KSW+7yE7hEJfprxrvutjqXHt+hsIRyx6LSqjnUPaHb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw322tZxZvPVOwfIRj4TJB3kTUQWtGP0z0hgv2w2DeJncF0V7mX
	OYGsp9g/6LyFtX9ucjE0We4FYgiiaZfA9eiMS3pY7A33EixJu8Y6P3ThUQn/CiLkGQg+4dPH66K
	Ipr3Ux6rtEBXfCOs24arzFrZEDNnso76bcKaZcjbpye9JSAkH9yCzVuiZDC6H/v8=
X-Gm-Gg: AeBDieu2RE4Z171r9XmoG7CJE7uQJvS03Uq9EPJVUX/dc7vp71akDTGw5TpdbwGUdHx
	NCDcTM6almjUBi5Vf5kL8wP3k5GJDS5wxzAHq03LP+jZFkmgk25PQuZGDO8UsyJNZGo2eHbrrDY
	8k1eh/UAIYryvZPwHAUX+3nOD/svAt2C6Ze2TlNse/smzp65s+8jwFhaiAgR1bnTXjJ7CWpQHJ/
	0Q4TmyxdP2quRE7wbJZhEOzaDZulCf1fQgxYWEmbCICrf1AgPCnEY8Iy35vngEkjlqT/mBMxQ6Z
	5RQgdAY6bSQJEQ3k5/u8DNRoptt1oZSEXHZXmxN0tgJQi4ffu4uroKhSA2ldL5t4QGpoeMLXj4l
	6GwRit+HWc0GRD8aafWdTuOEOPa+X+MXK72kBWtl4oSPDR9o9hLnvoGO5YtmJ5cs=
X-Received: by 2002:a05:690c:698b:b0:7b2:dad2:5dee with SMTP id 00721157ae682-7b9ece5aeabmr43292347b3.2.1776451289657;
        Fri, 17 Apr 2026 11:41:29 -0700 (PDT)
X-Received: by 2002:a05:690c:698b:b0:7b2:dad2:5dee with SMTP id 00721157ae682-7b9ece5aeabmr43292067b3.2.1776451289102;
        Fri, 17 Apr 2026 11:41:29 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89ac50sm10065327b3.7.2026.04.17.11.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:41:28 -0700 (PDT)
Message-ID: <bade04c7d9d326db8b4e020f8e39bb785e7790e6.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v2 6/7] ceph: add manual reset debugfs
 control and tracepoints
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Fri, 17 Apr 2026 11:41:27 -0700
In-Reply-To: <20260415170043.3882912-7-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
	 <20260415170043.3882912-7-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 17:00 +0000, Alex Markuze wrote:
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
> Tracepoints:
>   ceph_client_reset_schedule  - reset queued
>   ceph_client_reset_complete  - reset finished (success or failure)
>   ceph_client_reset_blocked   - caller blocked waiting for reset
>   ceph_client_reset_unblocked - caller unblocked after reset
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/debugfs.c           | 104 ++++++++++++++++++++++++++++++++++++
>  fs/ceph/mds_client.c        |   8 +++
>  fs/ceph/super.h             |   3 ++
>  include/trace/events/ceph.h |  63 ++++++++++++++++++++++
>  4 files changed, 178 insertions(+)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 7dc307790240..d46d41ec7a86 100644
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
>  	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
>  	doutc(fsc->client, "done\n");
>  }
> @@ -451,6 +544,17 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc=
)
>  						fsc,
>  						&caps_fops);
> =20
> +	fsc->debugfs_reset_dir =3D debugfs_create_dir("reset",
> +						    fsc->client->debugfs_dir);
> +	fsc->debugfs_reset_trigger =3D
> +		debugfs_create_file("trigger", 0200,
> +				    fsc->debugfs_reset_dir, fsc,
> +				    &ceph_reset_trigger_fops);
> +	fsc->debugfs_reset_status =3D
> +		debugfs_create_file("status", 0400,
> +				    fsc->debugfs_reset_dir, fsc,
> +				    &reset_status_fops);
> +
>  	fsc->debugfs_status =3D debugfs_create_file("status",
>  						  0400,
>  						  fsc->client->debugfs_dir,
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 7e399b0dcc55..98a882cf8b65 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5213,6 +5213,7 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_client=
 *mdsc)
>  	blocked_count =3D atomic_inc_return(&st->blocked_requests);
>  	doutc(cl, "request blocked during reset, %d total blocked\n",
>  	      blocked_count);
> +	trace_ceph_client_reset_blocked(mdsc, blocked_count);
> =20
>  retry:
>  	wait_ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> @@ -5223,10 +5224,12 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_clie=
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
> @@ -5241,12 +5244,14 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_clie=
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
>  	return ret;
>  }
> =20
> @@ -5275,6 +5280,8 @@ static void ceph_mdsc_reset_complete(struct ceph_md=
s_client *mdsc, int ret)
> =20
>  	/* Wake up all requests that were blocked waiting for reset */
>  	wake_up_all(&st->blocked_wq);
> +
> +	trace_ceph_client_reset_complete(mdsc, ret);
>  }
> =20
>  static void ceph_mdsc_reset_workfn(struct work_struct *work)
> @@ -5559,6 +5566,7 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client=
 *mdsc,
>  	pr_info_client(mdsc->fsc->client,
>  		       "manual session reset scheduled (reason=3D\"%s\")\n",
>  		       msg);
> +	trace_ceph_client_reset_schedule(mdsc, msg);
>  	return 0;
>  }
> =20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 1f901b1647e6..98af0a823c81 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -179,6 +179,9 @@ struct ceph_fs_client {
>  	struct dentry *debugfs_status;
>  	struct dentry *debugfs_mds_sessions;
>  	struct dentry *debugfs_metrics_dir;
> +	struct dentry *debugfs_reset_dir;
> +	struct dentry *debugfs_reset_trigger;
> +	struct dentry *debugfs_reset_status;

The debugfs_reset_trigger and debugfs_reset_status initialized in
ceph_fs_debugfs_init() but never used in any methods. Do we really need the=
se
fields?

>  #endif
> =20
>  #ifdef CONFIG_CEPH_FSCACHE
> diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
> index 08cb0659fbfc..e853c891ef71 100644
> --- a/include/trace/events/ceph.h
> +++ b/include/trace/events/ceph.h
> @@ -226,6 +226,69 @@ TRACE_EVENT(ceph_handle_caps,
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
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth->global_id;

All four tracepoints dereference mdsc->fsc->client->monc.auth->global_id. C=
ould
monc.auth be NULL during early client init or late teardown?

Thanks,
Slava.

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
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth->global_id;
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
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth->global_id;
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
> +		__entry->client_id =3D mdsc->fsc->client->monc.auth->global_id;
> +		__entry->ret =3D ret;
> +	),
> +	TP_printk("client_id=3D%llu ret=3D%d", __entry->client_id, __entry->ret=
)
> +);
> +
>  #undef EM
>  #undef E_
>  #endif /* _TRACE_CEPH_H */

