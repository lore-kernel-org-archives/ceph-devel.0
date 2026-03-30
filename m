Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9471A9B46
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894577; cv=none; b=XSKicyDJz+UDcB9a4QM8jDxprnzCI9HJB9W0har7UT9nwzlbbw0FeJ9nk3lDzLyvdr9cn7kj4q0XjyywiaPx0rQytTHBZ7PUd+KVIlygKG4y1z2b/6Hke67XaIpMaFCve0k6W5uEAj/n/EtMlFM5mhJiuThHvzhwWJz35TBsS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894577; c=relaxed/simple;
	bh=2MUGWTwlsCIKjzfMYAHprgLL+OfM29E4dnKJpTPa2iQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpytK4SnzQUY26rZYKqni6hfDZ/5ssHBWZlp59Pa3PkqI0xOKEnAogpgW6S6ZdjZzl2CQa5euvJsQnP2HaVgmPVauo5UEipH9IGESBHz2SzrjngNPuuC/vFNHrXCjDi+6WqPlKyYrsi8YlklGBY2iny+W6PkPjbpl488cObniJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+69nh/n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL2DqPpd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+69nh/n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL2DqPpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774894574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzMAsHryt0gvU/q6n5gq0LZXsxOeEPk6w/0QqSARdgk=;
	b=e+69nh/nlbaMUnQ46r0lqudK7G5SJlj+f1TImlnH7XN//x0RSEZReTw81fKtfrRSIQeA1h
	VIu/RKBkz+x2oMpexF4wsLSTraY7MQ9ihcxrRIduqz4S1mRGa+j12dOR4q9kq36lToQ2ou
	Pt1kLyUVjYhbHkHYJ+UOeLsbyAl9tlo=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-0FZRA8DUNTern9qCyw3hLA-1; Mon, 30 Mar 2026 14:16:12 -0400
X-MC-Unique: 0FZRA8DUNTern9qCyw3hLA-1
X-Mimecast-MFC-AGG-ID: 0FZRA8DUNTern9qCyw3hLA_1774894572
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-649f0d26e5eso11194625d50.0
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774894572; x=1775499372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzMAsHryt0gvU/q6n5gq0LZXsxOeEPk6w/0QqSARdgk=;
        b=FL2DqPpdSjR99X+o5ndFJ3LJvqOcHXpPzG+QZyeSIqj2uz35YSMG+UaUsCmxN0VVEK
         s4pQSa+NmNzmghgFZm3jDgIoDCwi4upNEVpv9G3ZEgvyMXsIo+m1isZCC/vqHDZ7ja7h
         3/mDrNmakXLWAcD+B2Diu6eM6+a/FAS23sLellY3pImJ6sgwyb5OFhXgzCrRozuiyoMT
         S3esQ5GyAZH8crsXSaPITyK7gghUB41Skxt1v2kXWSjO7P6IEyhWV2Ql2+FC/U6naIDg
         Sk+50zV22GzEGbyIWUjk1aqYzFz4k27jJMMCxSurqcobeCDDMLG3TbQiAS1fQjb0LUFj
         R7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894572; x=1775499372;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzMAsHryt0gvU/q6n5gq0LZXsxOeEPk6w/0QqSARdgk=;
        b=tQENwzZnUGc5CiQd1l+BlCVfsknCLaqIBgJ1Mr00cocMcOytAGujflRF7idpcdy67z
         Y9Px4x4rVtMIV672nrxYD9J4LPH/VjWjvvEPEr+oyq+MBs3UPpc3VLmVbfoXjsGyFsPS
         9h2gx4Ypu1Q22mpz9A1k07bB+rVxj/oGKqO3IW6ju9xsXwzNkl99sZFeTS+Jf+Oqj6cc
         9WPu5+YfkVtIklNB+Ij7WL5jvjQKFr4EGAFB8qbrd75RY9P5g09xTXR/2rop1W1lQt6+
         OTSJNNxNYb9NgqiSwDOs1KghC3LDxIvzo1UR04ES1GS40LViFp3N8Kh1qEcxq51SbaL+
         Odqw==
X-Forwarded-Encrypted: i=1; AJvYcCX/QRUZ599QH7f2VZvJiyfQf/CcAnK8phwRSx/wYo+hQgH2sCoi5hVr5eXB6ritKeC+SQQvuJ2sPghb@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+gnHwIx0ZTT3qdNoYXp+e5/4xGJqmSU85/clVoas01QHFH6F
	nF3LwoBqYnltZHoCEkJ8469UzCb7pRtTEk4VLAA6Jp63WmmnJg+Xb6WodSsb1aGT3IOhhteMEDG
	rF9j9Z1pReSpHliEVSP0u8GqB2ieoGYDTUH6rCxTHek5m/pJYi53VCC+UUfMyYkg=
X-Gm-Gg: ATEYQzx8oTMAncgsQ/rFRAO70NuqiQQLdseJW17uEgavh/VpesFjO/zR5OuTMIkb8Bg
	uNLaFSOCLj33tzgT8Q7pND6EYzDOCEMQ7y1t8t6RolqxY/dSGPR1Efm1zES07BlkYZBQSKyWkzj
	oA2riOqDfH7l2Ad3I6GcLb/ck8CQU68taoSMQHLYozOZN8ZgMrHbqyU+/tPvVb6t71nyan2eYdH
	4kJ8En+scubuPz6OOXX7EY5nhwwoqwmi7pmlLDhZBDilzAZxojkbi8zgrdpOqiaPOEVBnBa6zcY
	HpqTbUOo3al1EdcxWvkwAJ1iwhW87fHsR97VcfGSjguilv5pW9bKe0NQ4jqHoMOlhm9ndQfbiQA
	TJ7imrrpINgO5ZB/7AqBB1Wo0G/gEJiOaRANhq77b6S3junCF7rKX
X-Received: by 2002:a05:690c:c0c8:b0:79a:6d65:c333 with SMTP id 00721157ae682-79bde019cc8mr125173247b3.40.1774894571754;
        Mon, 30 Mar 2026 11:16:11 -0700 (PDT)
X-Received: by 2002:a05:690c:c0c8:b0:79a:6d65:c333 with SMTP id 00721157ae682-79bde019cc8mr125172837b3.40.1774894571174;
        Mon, 30 Mar 2026 11:16:11 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8daf5sm39587827b3.25.2026.03.30.11.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:16:10 -0700 (PDT)
Message-ID: <949b1b933bc7e219caa8390d0786d3cc97fd58ed.camel@redhat.com>
Subject: Re: [PATCH 04/10] ceph: add manual reset debugfs control and trace
 plumbing
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 30 Mar 2026 11:16:09 -0700
In-Reply-To: <20260327143045.1393612-5-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
	 <20260327143045.1393612-5-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 14:30 +0000, Alex Markuze wrote:
> Add the debugfs trigger, status, and fault-injection files together with
> the tracepoints and reset scheduling hooks used to observe and drive the
> manual reset flow. This wires the reset bookkeeping into client init and
> shutdown while keeping the actual reconnect-based worker logic in a
> follow-up patch.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/debugfs.c           | 168 +++++++++++++++++++++++++++++++++---
>  fs/ceph/locks.c             |   2 +
>  fs/ceph/mds_client.c        | 116 ++++++++++++++++++++++---
>  fs/ceph/mds_client.h        |  20 +++--
>  fs/ceph/super.h             |   4 +
>  include/trace/events/ceph.h |  60 +++++++++++++
>  6 files changed, 340 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index f3fe786b4143..9e2c32fb1f38 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -9,6 +9,8 @@
>  #include <linux/seq_file.h>
>  #include <linux/math64.h>
>  #include <linux/ktime.h>
> +#include <linux/uaccess.h>
> +#include <linux/kstrtox.h>
> =20
>  #include <linux/ceph/libceph.h>
>  #include <linux/ceph/mon_client.h>
> @@ -22,6 +24,10 @@
>  #include "mds_client.h"
>  #include "metric.h"
> =20
> +#define CEPH_DEBUGFS_MODE_READONLY 0400
> +#define CEPH_DEBUGFS_MODE_WRITEONLY 0200
> +#define CEPH_DEBUGFS_MODE_READWRITE 0600
> +
>  static int mdsmap_show(struct seq_file *s, void *p)
>  {
>  	int i;
> @@ -360,16 +366,140 @@ static int status_show(struct seq_file *s, void *p=
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
> +	bool in_progress =3D false;
> +	bool inject_error =3D false;
> +	int pending_reconnects =3D 0;
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
> +	in_progress =3D st->in_progress;
> +	inject_error =3D st->inject_error;
> +	strscpy(reason, st->last_reason, sizeof(reason));

It is used sizeof(reason) here. It looks like the copying a memory blob but=
 not
a string. Why not used the memcpy() then. :)

> +	spin_unlock(&st->lock);
> +
> +	pending_reconnects =3D atomic_read(&st->pending_reconnects);
> +	blocked_requests =3D atomic_read(&st->blocked_requests);
> +
> +	seq_printf(s, "in_progress: %s\n", in_progress ? "yes" : "no");
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
> +	seq_printf(s, "inject_error_pending: %s\n",
> +		   inject_error ? "yes" : "no");
> +	seq_printf(s, "pending_reconnects: %d\n", pending_reconnects);
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
> +static ssize_t reset_inject_error_write(struct file *file,
> +					const char __user *buf,
> +					size_t len, loff_t *ppos)
> +{
> +	struct ceph_fs_client *fsc =3D file->private_data;
> +	struct ceph_mds_client *mdsc =3D fsc->mdsc;
> +	struct ceph_client_reset_state *st;
> +	bool enable;
> +	int ret;
> +
> +	if (!mdsc)
> +		return -ENODEV;
> +
> +	ret =3D kstrtobool_from_user(buf, len, &enable);
> +	if (ret)
> +		return ret;
> +
> +	st =3D &mdsc->reset_state;
> +	spin_lock(&st->lock);
> +	st->inject_error =3D enable;
> +	spin_unlock(&st->lock);
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
> +
> +static const struct file_operations ceph_reset_inject_error_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D simple_open,
> +	.write =3D reset_inject_error_write,
> +	.llseek =3D noop_llseek,
> +};
> +
> =20
>  /*
>   * debugfs
> @@ -404,6 +534,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *f=
sc)
>  	debugfs_remove(fsc->debugfs_caps);
>  	debugfs_remove(fsc->debugfs_status);
>  	debugfs_remove(fsc->debugfs_mdsc);
> +	debugfs_remove_recursive(fsc->debugfs_reset_dir);
>  	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
>  	doutc(fsc->client, "done\n");
>  }
> @@ -415,7 +546,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>  	doutc(fsc->client, "begin\n");
>  	fsc->debugfs_congestion_kb =3D
>  		debugfs_create_file("writeback_congestion_kb",
> -				    0600,
> +				    CEPH_DEBUGFS_MODE_READWRITE,
>  				    fsc->client->debugfs_dir,
>  				    fsc,
>  				    &congestion_kb_fops);
> @@ -428,31 +559,48 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fs=
c)
>  				       name);
> =20
>  	fsc->debugfs_mdsmap =3D debugfs_create_file("mdsmap",
> -					0400,
> +					CEPH_DEBUGFS_MODE_READONLY,
>  					fsc->client->debugfs_dir,
>  					fsc,
>  					&mdsmap_fops);
> =20
>  	fsc->debugfs_mds_sessions =3D debugfs_create_file("mds_sessions",
> -					0400,
> +					CEPH_DEBUGFS_MODE_READONLY,
>  					fsc->client->debugfs_dir,
>  					fsc,
>  					&mds_sessions_fops);
> =20
>  	fsc->debugfs_mdsc =3D debugfs_create_file("mdsc",
> -						0400,
> +						CEPH_DEBUGFS_MODE_READONLY,
>  						fsc->client->debugfs_dir,
>  						fsc,
>  						&mdsc_fops);
> =20
>  	fsc->debugfs_caps =3D debugfs_create_file("caps",
> -						0400,
> +						CEPH_DEBUGFS_MODE_READONLY,
>  						fsc->client->debugfs_dir,
>  						fsc,
>  						&caps_fops);
> =20
> +	fsc->debugfs_reset_dir =3D debugfs_create_dir("reset",
> +						    fsc->client->debugfs_dir);
> +	if (fsc->debugfs_reset_dir) {

Is it correct check? The debugfs_create_dir returns ERR_PTR(-ENODEV) (never
NULL) when debugfs is disabled.

Maybe, !IS_ERR(fsc->debugfs_reset_dir)?

> +		fsc->debugfs_reset_trigger =3D
> +			debugfs_create_file("trigger", CEPH_DEBUGFS_MODE_WRITEONLY,
> +					    fsc->debugfs_reset_dir, fsc,
> +					    &ceph_reset_trigger_fops);
> +		fsc->debugfs_reset_status =3D
> +			debugfs_create_file("status", CEPH_DEBUGFS_MODE_READONLY,
> +					    fsc->debugfs_reset_dir, fsc,
> +					    &reset_status_fops);
> +		fsc->debugfs_reset_inject =3D
> +			debugfs_create_file("inject_error", CEPH_DEBUGFS_MODE_WRITEONLY,
> +					    fsc->debugfs_reset_dir, fsc,
> +					    &ceph_reset_inject_error_fops);
> +	}
> +
>  	fsc->debugfs_status =3D debugfs_create_file("status",
> -						  0400,
> +						  CEPH_DEBUGFS_MODE_READONLY,
>  						  fsc->client->debugfs_dir,
>  						  fsc,
>  						  &status_fops);
> @@ -460,13 +608,13 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fs=
c)
>  	fsc->debugfs_metrics_dir =3D debugfs_create_dir("metrics",
>  						      fsc->client->debugfs_dir);
> =20
> -	debugfs_create_file("file", 0400, fsc->debugfs_metrics_dir, fsc,
> +	debugfs_create_file("file", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_me=
trics_dir, fsc,
>  			    &metrics_file_fops);
> -	debugfs_create_file("latency", 0400, fsc->debugfs_metrics_dir, fsc,
> +	debugfs_create_file("latency", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs=
_metrics_dir, fsc,
>  			    &metrics_latency_fops);
> -	debugfs_create_file("size", 0400, fsc->debugfs_metrics_dir, fsc,
> +	debugfs_create_file("size", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_me=
trics_dir, fsc,
>  			    &metrics_size_fops);
> -	debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
> +	debugfs_create_file("caps", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_me=
trics_dir, fsc,
>  			    &metrics_caps_fops);
>  	doutc(fsc->client, "done\n");
>  }
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index e6f0c565e9d6..079947a5e42a 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -251,6 +251,7 @@ int ceph_lock(struct file *file, int cmd, struct file=
_lock *fl)
>  {
>  	struct inode *inode =3D file_inode(file);
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
> +	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(inode->i_sb);

This declaration is needed for previous patch. So, previous patch could be =
not
possible to compile.

>  	struct ceph_client *cl =3D ceph_inode_to_client(inode);
>  	int err =3D 0;
>  	u16 op =3D CEPH_MDS_OP_SETFILELOCK;
> @@ -324,6 +325,7 @@ int ceph_flock(struct file *file, int cmd, struct fil=
e_lock *fl)
>  {
>  	struct inode *inode =3D file_inode(file);
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
> +	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(inode->i_sb);

Ditto.

>  	struct ceph_client *cl =3D ceph_inode_to_client(inode);
>  	int err =3D 0;
>  	u8 wait =3D 0;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 0dd9a529850a..4b5adc38f7b7 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -67,6 +67,7 @@ static void __wake_requests(struct ceph_mds_client *mds=
c,
>  			    struct list_head *head);
>  static void ceph_cap_release_work(struct work_struct *work);
>  static void ceph_cap_reclaim_work(struct work_struct *work);
> +static void ceph_mdsc_reset_workfn(struct work_struct *work);
> =20
>  static const struct ceph_connection_operations mds_con_ops;
> =20
> @@ -3756,33 +3757,119 @@ int ceph_mdsc_wait_for_reset(struct ceph_mds_cli=
ent *mdsc)
>  	int blocked_count;
>  	int ret;
> =20
> -	if (READ_ONCE(st->phase) =3D=3D CEPH_CLIENT_RESET_IDLE)
> +	if (!READ_ONCE(st->in_progress))
>  		return 0;
> =20
>  	blocked_count =3D atomic_inc_return(&st->blocked_requests);
>  	doutc(cl, "request blocked during reset, %d total blocked\n",
>  	      blocked_count);
> +	trace_ceph_client_reset_blocked(mdsc, blocked_count);
> =20
>  	ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> -					       READ_ONCE(st->phase) =3D=3D
> -					       CEPH_CLIENT_RESET_IDLE,
> +					       !READ_ONCE(st->in_progress),
>  					       timeout);
> =20
>  	atomic_dec(&st->blocked_requests);
> =20
>  	if (ret =3D=3D 0) {
>  		pr_warn_client(cl, "timed out waiting for reset to complete\n");
> +		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
>  		return -ETIMEDOUT;
>  	}
> -	if (ret < 0)
> +	if (ret < 0) {
> +		trace_ceph_client_reset_unblocked(mdsc, ret);
>  		return ret;
> +	}
> =20
>  	spin_lock(&st->lock);
>  	ret =3D st->last_errno;
>  	spin_unlock(&st->lock);
> +	trace_ceph_client_reset_unblocked(mdsc, ret);
>  	return ret;
>  }
> =20
> +static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int r=
et)
> +{
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +
> +	spin_lock(&st->lock);
> +	st->last_finish =3D jiffies;
> +	st->last_errno =3D ret;
> +	st->in_progress =3D false;
> +	if (ret)
> +		st->failure_count++;
> +	else
> +		st->success_count++;
> +	spin_unlock(&st->lock);
> +
> +	wake_up_all(&st->blocked_wq);
> +	trace_ceph_client_reset_complete(mdsc, ret);
> +}
> +
> +static void ceph_mdsc_reset_workfn(struct work_struct *work)
> +{
> +	struct ceph_mds_client *mdsc =3D
> +		container_of(work, struct ceph_mds_client, reset_work);
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	bool inject_error;
> +	int ret =3D 0;
> +
> +	spin_lock(&st->lock);
> +	inject_error =3D st->inject_error;
> +	if (inject_error)
> +		st->inject_error =3D false;
> +	spin_unlock(&st->lock);
> +
> +	if (inject_error)
> +		ret =3D -EIO;
> +
> +	ceph_mdsc_reset_complete(mdsc, ret);
> +}
> +
> +int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
> +			     const char *reason)
> +{
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	struct ceph_fs_client *fsc =3D mdsc->fsc;
> +	const char *msg =3D (reason && reason[0]) ? reason : "manual";
> +	int mount_state;
> +
> +	mount_state =3D READ_ONCE(fsc->mount_state);
> +	if (mount_state !=3D CEPH_MOUNT_MOUNTED) {
> +		pr_warn_client(fsc->client,
> +			       "reset rejected: mount_state=3D%d (not mounted)\n",
> +			       mount_state);
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&st->lock);
> +	if (st->in_progress) {
> +		spin_unlock(&st->lock);
> +		return -EBUSY;
> +	}
> +
> +	st->in_progress =3D true;
> +	st->active_reset_gen++;
> +	st->last_start =3D jiffies;
> +	st->last_errno =3D 0;
> +	st->trigger_count++;
> +	strscpy(st->last_reason, msg, sizeof(st->last_reason));

Ditto.

> +	spin_unlock(&st->lock);
> +
> +	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
> +		spin_lock(&st->lock);
> +		st->in_progress =3D false;
> +		st->last_errno =3D -EALREADY;
> +		st->failure_count++;

Should we set st->last_finish here?

st->last_finish =3D jiffies;

> +		spin_unlock(&st->lock);
> +		wake_up_all(&st->blocked_wq);
> +		return -EALREADY;
> +	}
> +
> +	trace_ceph_client_reset_schedule(mdsc, msg);
> +	return 0;
> +}
> +
>  int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode =
*dir,
>  			      struct ceph_mds_request *req)
>  {
> @@ -3793,11 +3880,11 @@ int ceph_mdsc_submit_request(struct ceph_mds_clie=
nt *mdsc, struct inode *dir,
>  	 * If a reset is in progress, wait for it to complete.
>  	 *
>  	 * This is best-effort: a request can pass this check just
> -	 * before the phase leaves IDLE and proceed concurrently with
> -	 * reset. That is acceptable because such requests will either
> -	 * complete normally or fail and be retried by the caller, and
> -	 * adding lock serialization here would penalize every request
> -	 * for a rare manual operation.
> +	 * before in_progress is set and proceed concurrently with
> +	 * reset.  That is acceptable because (a) such requests will
> +	 * either complete normally or fail and be retried by the
> +	 * caller, and (b) adding lock serialization here would
> +	 * penalize every request for a rare manual operation.
>  	 */
>  	err =3D ceph_mdsc_wait_for_reset(mdsc);
>  	if (err) {
> @@ -5692,11 +5779,15 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	mdsc->reset_state.last_start =3D 0;
>  	mdsc->reset_state.last_finish =3D 0;
>  	mdsc->reset_state.last_errno =3D 0;
> -	mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
> +	mdsc->reset_state.in_progress =3D false;
>  	mdsc->reset_state.inject_error =3D false;
> +	mdsc->reset_state.active_reset_gen =3D 0;
>  	mdsc->reset_state.last_reason[0] =3D '\0';
> +	atomic_set(&mdsc->reset_state.pending_reconnects, 0);
> +	init_completion(&mdsc->reset_state.reconnect_done);
>  	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
>  	atomic_set(&mdsc->reset_state.blocked_requests, 0);
> +	INIT_WORK(&mdsc->reset_work, ceph_mdsc_reset_workfn);
> =20
>  	ceph_caps_init(mdsc);
>  	ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
> @@ -6224,14 +6315,15 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc=
)
>  	ceph_msgr_flush();
> =20
>  	spin_lock(&mdsc->reset_state.lock);
> -	if (mdsc->reset_state.phase !=3D CEPH_CLIENT_RESET_IDLE) {
> -		mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
> +	if (mdsc->reset_state.in_progress) {
> +		mdsc->reset_state.in_progress =3D false;
>  		mdsc->reset_state.last_errno =3D -ESHUTDOWN;
>  		mdsc->reset_state.failure_count++;
>  	}
>  	spin_unlock(&mdsc->reset_state.lock);
>  	wake_up_all(&mdsc->reset_state.blocked_wq);
> =20
> +	cancel_work_sync(&mdsc->reset_work);

Could we have a race condition between ceph_mdsc_destroy() and the running =
work
function?

The destroy path:
1a. Acquires spin_lock
1b. Sets in_progress =3D false
1c. Increments failure_count
1d. Releases lock                                  =20
2. Calls wake_up_all()                                                     =
   =20
3. Calls cancel_work_sync()

If ceph_mdsc_reset_workfn is already running at step 1, it will call
ceph_mdsc_reset_complete(mdsc, 0) which overwrites last_errno (0 instead of=
 -
ESHUTDOWN), increments success_count, and sets last_finish.

Should cancel_work_sync() be called before?

cancel_work_sync(&mdsc->reset_work);

spin_lock(&mdsc->reset_state.lock);                                        =
   =20
<logic>
spin_unlock(&mdsc->reset_state.lock);

>  	ceph_mdsc_stop(mdsc);
> =20
>  	ceph_metric_destroy(&mdsc->metric);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 5cc22c109cfe..c8269df1a9e5 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -75,15 +75,9 @@ struct ceph_cap;
> =20
>  #define MDS_AUTH_UID_ANY -1
>  #define CEPH_CLIENT_RESET_REASON_LEN	64
> +#define CEPH_CLIENT_RESET_TIMEOUT_SEC	60
>  #define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
> =20
> -enum ceph_client_reset_phase {
> -	CEPH_CLIENT_RESET_IDLE =3D 0,
> -	CEPH_CLIENT_RESET_QUIESCING,
> -	CEPH_CLIENT_RESET_DRAINING,
> -	CEPH_CLIENT_RESET_TEARDOWN,
> -};
> -
>  struct ceph_client_reset_state {
>  	spinlock_t lock;
>  	u64 trigger_count;
> @@ -92,10 +86,15 @@ struct ceph_client_reset_state {
>  	unsigned long last_start;
>  	unsigned long last_finish;
>  	int last_errno;
> -	enum ceph_client_reset_phase phase;
> +	bool in_progress;
>  	bool inject_error;
>  	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
> =20
> +	/* Completion tracking for session reconnects */
> +	u64 active_reset_gen;
> +	atomic_t pending_reconnects;
> +	struct completion reconnect_done;
> +
>  	/* Request blocking during reset */
>  	wait_queue_head_t blocked_wq;
>  	atomic_t blocked_requests;
> @@ -277,6 +276,8 @@ struct ceph_mds_session {
>  	struct list_head  s_waiting;  /* waiting requests */
>  	struct list_head  s_unsafe;   /* unsafe requests */
>  	struct xarray	  s_delegated_inos;
> +
> +	u64		  s_reset_gen; /* generation of reset that initiated reconnect */

The s_reset_gen declared but never used in this patch. Will it be used in o=
ther
patches?

Thanks,
Slava.

>  };
> =20
>  /*
> @@ -562,6 +563,7 @@ struct ceph_mds_client {
>  	struct list_head  dentry_dir_leases; /* lru list */
> =20
>  	struct ceph_client_metric metric;
> +	struct work_struct	reset_work;
>  	struct ceph_client_reset_state reset_state;
> =20
>  	spinlock_t		snapid_map_lock;
> @@ -590,6 +592,8 @@ extern const char *ceph_session_state_name(int s);
>  extern struct ceph_mds_session *
>  ceph_get_mds_session(struct ceph_mds_session *s);
>  extern void ceph_put_mds_session(struct ceph_mds_session *s);
> +int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
> +			     const char *reason);
>  int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
> =20
>  extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 5de1e5923b63..6c403eef6492 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -179,6 +179,10 @@ struct ceph_fs_client {
>  	struct dentry *debugfs_status;
>  	struct dentry *debugfs_mds_sessions;
>  	struct dentry *debugfs_metrics_dir;
> +	struct dentry *debugfs_reset_dir;
> +	struct dentry *debugfs_reset_trigger;
> +	struct dentry *debugfs_reset_status;
> +	struct dentry *debugfs_reset_inject;
>  #endif
> =20
>  #ifdef CONFIG_CEPH_FSCACHE
> diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
> index 08cb0659fbfc..22b755f4c7c7 100644
> --- a/include/trace/events/ceph.h
> +++ b/include/trace/events/ceph.h
> @@ -226,6 +226,66 @@ TRACE_EVENT(ceph_handle_caps,
>  		  __entry->mseq)
>  );
> =20
> +/*
> + * Client reset tracepoints
> + */
> +TRACE_EVENT(ceph_client_reset_schedule,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, const char *reason),
> +	TP_ARGS(mdsc, reason),
> +	TP_STRUCT__entry(
> +		__field(const void *, mdsc)
> +		__string(reason, reason ? reason : "")
> +	),
> +	TP_fast_assign(
> +		__entry->mdsc =3D mdsc;
> +		__assign_str(reason);
> +	),
> +	TP_printk("mdsc=3D%p reason=3D%s", __entry->mdsc, __get_str(reason))
> +);
> +
> +TRACE_EVENT(ceph_client_reset_complete,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
> +	TP_ARGS(mdsc, ret),
> +	TP_STRUCT__entry(
> +		__field(const void *, mdsc)
> +		__field(int, ret)
> +	),
> +	TP_fast_assign(
> +		__entry->mdsc =3D mdsc;
> +		__entry->ret =3D ret;
> +	),
> +	TP_printk("mdsc=3D%p ret=3D%d", __entry->mdsc, __entry->ret)
> +);
> +
> +TRACE_EVENT(ceph_client_reset_blocked,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, int blocked_count),
> +	TP_ARGS(mdsc, blocked_count),
> +	TP_STRUCT__entry(
> +		__field(const void *, mdsc)
> +		__field(int, blocked_count)
> +	),
> +	TP_fast_assign(
> +		__entry->mdsc =3D mdsc;
> +		__entry->blocked_count =3D blocked_count;
> +	),
> +	TP_printk("mdsc=3D%p blocked_count=3D%d", __entry->mdsc,
> +		  __entry->blocked_count)
> +);
> +
> +TRACE_EVENT(ceph_client_reset_unblocked,
> +	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
> +	TP_ARGS(mdsc, ret),
> +	TP_STRUCT__entry(
> +		__field(const void *, mdsc)
> +		__field(int, ret)
> +	),
> +	TP_fast_assign(
> +		__entry->mdsc =3D mdsc;
> +		__entry->ret =3D ret;
> +	),
> +	TP_printk("mdsc=3D%p ret=3D%d", __entry->mdsc, __entry->ret)
> +);
> +
>  #undef EM
>  #undef E_
>  #endif /* _TRACE_CEPH_H */

