Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44183386425
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896108; cv=none; b=lv+hP7y+sPErF/vwUBM9PIKd6/wfwhvjk6pwiJ0gClPElywlkfKMnrMThH/Xt02DXPyW9jWhYrnN3SlebuYfbh7QPOjMgyZzsuBYWlZUbX8lpqLJVu0gZ0l1N51aQKqWfnegYBpeaVbFdWTyJHdwX74w+0Cvfo5ynnRVtR3BL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896108; c=relaxed/simple;
	bh=EN9at9x9V8S0y5kJtqHIZBO3YU97E2buKJXoq230DeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ie40ay0eUcWfjEEQTh7soGDIdukWAt7XQAnf46YuQaRP26ofzm1gjamPdfOgpGWpmlZO0iXzAoqVXIfxt9XfGv3ywPtUWF8gKSgkZj4eksUuKh9ET6wBblBM8KCYceNrwNXzxexKZ3KPSugnKmHse3Y9tHv+acH+hDF5241cIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3U3eBy+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDxiDkHY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3U3eBy+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDxiDkHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774896105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPRiVGwE2OQlw3QeeOucAVQSdHHXv2a9/FppSCEf6K8=;
	b=f3U3eBy+RqysuX+LTS0jjiNmR8afQyO1WBL2A0tZ4vITnGODCOwWfd0x1Un5dCzpuOSjYs
	86pJimjdUeC89fNzC1FKPZCi8lYrumM0JgjvOyx+bw2EOOKLJnvdIyRcicz5foGpodO0JX
	yr+R6gxxkMS17yEu6SgViVDxSgLtiqI=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-7lSCTz0qO9OC_qBJWaLgnw-1; Mon, 30 Mar 2026 14:41:44 -0400
X-MC-Unique: 7lSCTz0qO9OC_qBJWaLgnw-1
X-Mimecast-MFC-AGG-ID: 7lSCTz0qO9OC_qBJWaLgnw_1774896103
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c18175fc54so13632966eec.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774896103; x=1775500903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EPRiVGwE2OQlw3QeeOucAVQSdHHXv2a9/FppSCEf6K8=;
        b=dDxiDkHYzbxw4FuQe37DCaloWcZDfagTm/g4aVjhbuRGFqzuw41Wb9VkHnCJDutiBU
         4f9DCMQlIcR/TrvkMvvjOXT4GZZnKa0TxpDledrpWRnXVQ8hQcGNfZhvOfbpzrMEKKg9
         I4czuYUktXIZJYLgUJY0xxhyZURhHL8JWLMn/FKxNy7xg6G+tju/dvCup0/F8P5RnG8t
         luC+hwJwrqH1W07kqvnPcA7On++O/IBWaX5b5AY9nGjzjok8XbUOYMVZuSdKicMGGmXo
         T8XITqSRjxZMrwh6baRQuF43pxCwt1lrflwez6c9XWjiM6KQBsSnvwvSuio703F2o3ZY
         k6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774896103; x=1775500903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPRiVGwE2OQlw3QeeOucAVQSdHHXv2a9/FppSCEf6K8=;
        b=SAWMXUBXWHcFWmYDxHSOHqtGb91boMGRUF1ozAcvNSakAM2juqucN/GQQN7yCr9LuY
         PTnQuyr6rdSW51KwQkZUk7dS5eezMFqBmqUhH/Bz07H+TMjSGkp2ZJjTEmJzOuRf6QYo
         u9NwSttwY9KSOPSCib9Pdcn42mIUB/hXGjVcHGBoKZfHRxYq+5zfyj6RiCoBpOieZaVK
         6h6DCYU2c2wzQDRwf0VL0y03VlDSBQkfq7QWmtc1dSEH4esv40eTItOpIepDX9DxpNGn
         lHnxSHsTqkg21KRKxCwCOZb5ZHx0ZwGckRuVlCTTWYUf/vcPL98OJkXmwQAG8uIkCEt8
         2rkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0lN0Dy2VLzyJ2kWUirGMRtAhJxk3INQ8O20H9pEQP5erOZZx7We7yPeQc4mp/3fjHqXtUbyfN4cUY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5EbSTIaOqIPZGUuSGLzhrFug9H8X9O9EEUGcZKoDYOVyV+tZ
	CVxaYGGD7zn9BHRd8uvOH1w5AgbOqBguUTBGDa4W1yuky8H7RXBHWXhEMsz7BWy10ccamcGsQq9
	rhDXEzTTksmm9mW9FfE98vwy/BDfGYbnFhIHYs3Nx02w6szxBL3hNrR9eIDBoFiQ=
X-Gm-Gg: ATEYQzwUuIEkJUr1HpxD0l1L1szWQjRO35CGA1YBTHXV5TE4YT4bsqLaZXJZOuvw3GS
	MeG/b3KZKazJ/owSIgkU1mWQhAh5A9m/N9jHnEVqXGGXam1i90n55Iad8Ctsw5xDQ+8USj+Y48E
	MrNMGU989xvnzRtraTyIhHn4EvSanbZDALPQgm7kWjXwfhW2lKED+LDC2/1lbUCGLMdTXfNLuPj
	oLNfXFQOWq7JuijPwWQRx7xCTQowRMV8EutKxdwJsf0C3yuBNtj7tpwH0JoGzC4My5HsrgCUK4A
	SI8ukYgz9VGU/LlGpEyCBCIf4pgDGxGYb/cLCsbaJ878YFrdqrGmBGHTwdu4MTQctFM5P0dxSSa
	3410n6JdU8T0v/ujTOqRGKVaHgfByvnNXt4EFeaunVFdIl3gufwbs
X-Received: by 2002:a05:7301:1298:b0:2c7:11f2:d081 with SMTP id 5a478bee46e88-2c711f31321mr1652511eec.14.1774896102593;
        Mon, 30 Mar 2026 11:41:42 -0700 (PDT)
X-Received: by 2002:a05:7301:1298:b0:2c7:11f2:d081 with SMTP id 5a478bee46e88-2c711f31321mr1652481eec.14.1774896101815;
        Mon, 30 Mar 2026 11:41:41 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9c088sm7596970eec.21.2026.03.30.11.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:41:41 -0700 (PDT)
Message-ID: <7930c8018436cdc672756db9faf6783d8183591c.camel@redhat.com>
Subject: Re: [PATCH 05/10] ceph: implement reconnect-based manual reset
 worker
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 30 Mar 2026 11:41:40 -0700
In-Reply-To: <20260327143045.1393612-6-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
	 <20260327143045.1393612-6-amarkuze@redhat.com>
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
> Add the reconnect-based reset worker that snapshots eligible sessions,
> tracks reconnect completion, and wires reset-driven reconnect handling
> through the session state machine. This keeps the initial manual reset
> path functional before the later patches switch recovery over to direct
> session teardown.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/mds_client.c | 534 +++++++++++++++++++++++++++++++------------
>  1 file changed, 394 insertions(+), 140 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 4b5adc38f7b7..5a2a9e473058 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -12,6 +12,7 @@
>  #include <linux/bits.h>
>  #include <linux/ktime.h>
>  #include <linux/bitmap.h>
> +#include <linux/workqueue.h>
>  #include <linux/mnt_idmapping.h>
> =20
>  #include "super.h"
> @@ -61,6 +62,7 @@ struct ceph_reconnect_state {
>  	struct ceph_pagelist *pagelist;
>  	unsigned msg_version;
>  	bool allow_multi;
> +	bool from_reset;
>  };
> =20
>  static void __wake_requests(struct ceph_mds_client *mdsc,
> @@ -68,6 +70,8 @@ static void __wake_requests(struct ceph_mds_client *mds=
c,
>  static void ceph_cap_release_work(struct work_struct *work);
>  static void ceph_cap_reclaim_work(struct work_struct *work);
>  static void ceph_mdsc_reset_workfn(struct work_struct *work);
> +static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mds=
c,
> +					     struct ceph_mds_session *session);
> =20
>  static const struct ceph_connection_operations mds_con_ops;
> =20
> @@ -3743,133 +3747,6 @@ static void kick_requests(struct ceph_mds_client =
*mdsc, int mds)
>  	}
>  }
> =20
> -/*
> - * Wait for an active reset to complete.
> - * Returns 0 if reset completed successfully or no reset was active.
> - * Returns -ETIMEDOUT if we timed out waiting.
> - * Returns -ERESTARTSYS if interrupted by signal.
> - */
> -int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
> -{
> -	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> -	struct ceph_client *cl =3D mdsc->fsc->client;
> -	long timeout =3D CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
> -	int blocked_count;
> -	int ret;
> -
> -	if (!READ_ONCE(st->in_progress))
> -		return 0;
> -
> -	blocked_count =3D atomic_inc_return(&st->blocked_requests);
> -	doutc(cl, "request blocked during reset, %d total blocked\n",
> -	      blocked_count);
> -	trace_ceph_client_reset_blocked(mdsc, blocked_count);
> -
> -	ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> -					       !READ_ONCE(st->in_progress),
> -					       timeout);
> -
> -	atomic_dec(&st->blocked_requests);
> -
> -	if (ret =3D=3D 0) {
> -		pr_warn_client(cl, "timed out waiting for reset to complete\n");
> -		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
> -		return -ETIMEDOUT;
> -	}
> -	if (ret < 0) {
> -		trace_ceph_client_reset_unblocked(mdsc, ret);
> -		return ret;
> -	}
> -
> -	spin_lock(&st->lock);
> -	ret =3D st->last_errno;
> -	spin_unlock(&st->lock);
> -	trace_ceph_client_reset_unblocked(mdsc, ret);
> -	return ret;
> -}
> -
> -static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int r=
et)
> -{
> -	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> -
> -	spin_lock(&st->lock);
> -	st->last_finish =3D jiffies;
> -	st->last_errno =3D ret;
> -	st->in_progress =3D false;
> -	if (ret)
> -		st->failure_count++;
> -	else
> -		st->success_count++;
> -	spin_unlock(&st->lock);
> -
> -	wake_up_all(&st->blocked_wq);
> -	trace_ceph_client_reset_complete(mdsc, ret);
> -}
> -
> -static void ceph_mdsc_reset_workfn(struct work_struct *work)
> -{
> -	struct ceph_mds_client *mdsc =3D
> -		container_of(work, struct ceph_mds_client, reset_work);
> -	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> -	bool inject_error;
> -	int ret =3D 0;
> -
> -	spin_lock(&st->lock);
> -	inject_error =3D st->inject_error;
> -	if (inject_error)
> -		st->inject_error =3D false;
> -	spin_unlock(&st->lock);
> -
> -	if (inject_error)
> -		ret =3D -EIO;
> -
> -	ceph_mdsc_reset_complete(mdsc, ret);
> -}
> -
> -int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
> -			     const char *reason)
> -{
> -	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> -	struct ceph_fs_client *fsc =3D mdsc->fsc;
> -	const char *msg =3D (reason && reason[0]) ? reason : "manual";
> -	int mount_state;
> -
> -	mount_state =3D READ_ONCE(fsc->mount_state);
> -	if (mount_state !=3D CEPH_MOUNT_MOUNTED) {
> -		pr_warn_client(fsc->client,
> -			       "reset rejected: mount_state=3D%d (not mounted)\n",
> -			       mount_state);
> -		return -EINVAL;
> -	}
> -
> -	spin_lock(&st->lock);
> -	if (st->in_progress) {
> -		spin_unlock(&st->lock);
> -		return -EBUSY;
> -	}
> -
> -	st->in_progress =3D true;
> -	st->active_reset_gen++;
> -	st->last_start =3D jiffies;
> -	st->last_errno =3D 0;
> -	st->trigger_count++;
> -	strscpy(st->last_reason, msg, sizeof(st->last_reason));
> -	spin_unlock(&st->lock);
> -
> -	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
> -		spin_lock(&st->lock);
> -		st->in_progress =3D false;
> -		st->last_errno =3D -EALREADY;
> -		st->failure_count++;
> -		spin_unlock(&st->lock);
> -		wake_up_all(&st->blocked_wq);
> -		return -EALREADY;
> -	}
> -
> -	trace_ceph_client_reset_schedule(mdsc, msg);
> -	return 0;
> -}
> -
>  int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode =
*dir,
>  			      struct ceph_mds_request *req)
>  {
> @@ -4524,9 +4401,11 @@ static void handle_session(struct ceph_mds_session=
 *session,
> =20
>  	switch (op) {
>  	case CEPH_SESSION_OPEN:
> -		if (session->s_state =3D=3D CEPH_MDS_SESSION_RECONNECTING)
> +		if (session->s_state =3D=3D CEPH_MDS_SESSION_RECONNECTING) {
>  			pr_info_client(cl, "mds%d reconnect success\n",
>  				       session->s_mds);
> +			ceph_mdsc_reconnect_session_done(mdsc, session);
> +		}
> =20
>  		session->s_features =3D features;
>  		if (session->s_state =3D=3D CEPH_MDS_SESSION_OPEN) {
> @@ -4559,9 +4438,11 @@ static void handle_session(struct ceph_mds_session=
 *session,
>  		break;
> =20
>  	case CEPH_SESSION_CLOSE:
> -		if (session->s_state =3D=3D CEPH_MDS_SESSION_RECONNECTING)
> +		if (session->s_state =3D=3D CEPH_MDS_SESSION_RECONNECTING) {
>  			pr_info_client(cl, "mds%d reconnect denied\n",
>  				       session->s_mds);
> +			ceph_mdsc_reconnect_session_done(mdsc, session);
> +		}
>  		session->s_state =3D CEPH_MDS_SESSION_CLOSED;
>  		cleanup_session_requests(mdsc, session);
>  		remove_session_caps(session);
> @@ -4600,7 +4481,13 @@ static void handle_session(struct ceph_mds_session=
 *session,
>  		break;
> =20
>  	case CEPH_SESSION_REJECT:
> -		WARN_ON(session->s_state !=3D CEPH_MDS_SESSION_OPENING);
> +		WARN_ON(session->s_state !=3D CEPH_MDS_SESSION_OPENING &&
> +			session->s_state !=3D CEPH_MDS_SESSION_RECONNECTING);
> +		if (session->s_state =3D=3D CEPH_MDS_SESSION_RECONNECTING) {
> +			pr_info_client(cl, "mds%d reconnect rejected\n",
> +				       session->s_mds);
> +			ceph_mdsc_reconnect_session_done(mdsc, session);
> +		}
>  		pr_info_client(cl, "mds%d rejected session\n",
>  			       session->s_mds);
>  		session->s_state =3D CEPH_MDS_SESSION_REJECTED;
> @@ -4862,6 +4749,17 @@ static int reconnect_caps_cb(struct inode *inode, =
int mds, void *arg)
>  	cap->mseq =3D 0;       /* and migrate_seq */
>  	cap->cap_gen =3D atomic_read(&cap->session->s_cap_gen);
> =20
> +	/*
> +	 * Don't set CEPH_I_ERROR_FILELOCK here - instead, we attempt to
> +	 * reclaim locks by sending them in the reconnect message.
> +	 * The MDS will do best-effort reclaim. If locks can't be reclaimed
> +	 * (e.g., another client grabbed a conflicting lock), future lock
> +	 * operations will fail and the error flag will be set then.
> +	 *
> +	 * Note: i_filelock_ref > 0 means we have locks to reclaim.
> +	 * The lock info will be encoded below if flock_len is non-zero.
> +	 */
> +
>  	/* These are lost when the session goes away */
>  	if (S_ISDIR(inode->i_mode)) {
>  		if (cap->issued & CEPH_CAP_DIR_CREATE) {
> @@ -4877,8 +4775,22 @@ static int reconnect_caps_cb(struct inode *inode, =
int mds, void *arg)
>  		rec.v2.issued =3D cpu_to_le32(cap->issued);
>  		rec.v2.snaprealm =3D cpu_to_le64(ci->i_snap_realm->ino);
>  		rec.v2.pathbase =3D cpu_to_le64(path_info.vino.ino);
> -		rec.v2.flock_len =3D (__force __le32)
> -			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
> +		if (recon_state->from_reset) {
> +			/*
> +			 * Reset-initiated reconnect: always try to reclaim
> +			 * locks. The MDS does best-effort; failures are
> +			 * handled on future lock operations.
> +			 */
> +			rec.v2.flock_len =3D cpu_to_le32(1);
> +		} else {
> +			/*
> +			 * Normal reconnect: skip lock reclaim if locks
> +			 * were already known to be in error state.
> +			 */
> +			rec.v2.flock_len =3D cpu_to_le32(
> +				test_bit(CEPH_I_ERROR_FILELOCK_BIT,
> +					 &ci->i_ceph_flags) ? 0 : 1);
> +		}
>  	} else {
>  		struct timespec64 ts;
> =20
> @@ -5075,8 +4987,9 @@ static int encode_snap_realms(struct ceph_mds_clien=
t *mdsc,
>   *
>   * This is a relatively heavyweight operation, but it's rare.
>   */
> -static void send_mds_reconnect(struct ceph_mds_client *mdsc,
> -			       struct ceph_mds_session *session)
> +static int send_mds_reconnect(struct ceph_mds_client *mdsc,
> +			      struct ceph_mds_session *session,
> +			      bool from_reset)
>  {
>  	struct ceph_client *cl =3D mdsc->fsc->client;
>  	struct ceph_msg *reply;
> @@ -5084,6 +4997,7 @@ static void send_mds_reconnect(struct ceph_mds_clie=
nt *mdsc,
>  	int err =3D -ENOMEM;
>  	struct ceph_reconnect_state recon_state =3D {
>  		.session =3D session,
> +		.from_reset =3D from_reset,
>  	};
>  	LIST_HEAD(dispose);
> =20
> @@ -5100,6 +5014,30 @@ static void send_mds_reconnect(struct ceph_mds_cli=
ent *mdsc,
>  	xa_destroy(&session->s_delegated_inos);
> =20
>  	mutex_lock(&session->s_mutex);
> +	if (session->s_state =3D=3D CEPH_MDS_SESSION_CLOSED ||
> +	    session->s_state =3D=3D CEPH_MDS_SESSION_REJECTED) {
> +		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
> +			       mds,
> +			       ceph_session_state_name(session->s_state));
> +		mutex_unlock(&session->s_mutex);
> +		ceph_msg_put(reply);
> +		err =3D -ESTALE;
> +		goto fail_nomsg;
> +	}
> +
> +	mutex_lock(&mdsc->mutex);
> +	if (mds >=3D mdsc->max_sessions || mdsc->sessions[mds] !=3D session) {
> +		mutex_unlock(&mdsc->mutex);
> +		pr_info_client(cl,
> +			       "mds%d skipping reconnect, session unregistered\n",
> +			       mds);
> +		mutex_unlock(&session->s_mutex);
> +		ceph_msg_put(reply);
> +		err =3D -ENOENT;
> +		goto fail_nomsg;
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +
>  	session->s_state =3D CEPH_MDS_SESSION_RECONNECTING;
>  	session->s_seq =3D 0;
> =20
> @@ -5229,7 +5167,7 @@ static void send_mds_reconnect(struct ceph_mds_clie=
nt *mdsc,
> =20
>  	up_read(&mdsc->snap_rwsem);
>  	ceph_pagelist_release(recon_state.pagelist);
> -	return;
> +	return 0;
> =20
>  fail:
>  	ceph_msg_put(reply);
> @@ -5240,7 +5178,301 @@ static void send_mds_reconnect(struct ceph_mds_cl=
ient *mdsc,
>  fail_nopagelist:
>  	pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
>  		      err, mds);
> -	return;
> +	return err;
> +}
> +
> +/*
> + * Called when a session completes reconnection (success or failure).
> + * Only counts toward reset completion if this session's reconnect was
> + * initiated by the currently active reset generation.  Late completions
> + * from a prior (timed-out) reset are silently ignored.
> + *
> + * Caller must hold session->s_mutex to serialize s_reset_gen updates.
> + */
> +static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mds=
c,
> +					     struct ceph_mds_session *session)
> +{
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	u64 active_gen;
> +
> +	lockdep_assert_held(&session->s_mutex);
> +
> +	if (!session->s_reset_gen)
> +		return;
> +
> +	spin_lock(&st->lock);
> +	active_gen =3D st->active_reset_gen;
> +	spin_unlock(&st->lock);
> +
> +	if (session->s_reset_gen !=3D active_gen) {
> +		session->s_reset_gen =3D 0;
> +		return;
> +	}
> +
> +	session->s_reset_gen =3D 0;
> +
> +	if (atomic_dec_and_test(&st->pending_reconnects))
> +		complete(&st->reconnect_done);

What if somehow st->pending_reconnects never reach zero by incorrect
increment/decrement logic?

> +}
> +
> +/*
> + * Wait for a reset to complete if one is in progress.
> + * Returns 0 if reset completed successfully or wasn't in progress.
> + * Returns -ETIMEDOUT if we timed out waiting.
> + * Returns -ERESTARTSYS if interrupted by signal.
> + */
> +int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
> +{
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	long timeout =3D CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
> +	int blocked_count;
> +	int ret;
> +
> +	if (!READ_ONCE(st->in_progress))
> +		return 0;
> +
> +	blocked_count =3D atomic_inc_return(&st->blocked_requests);
> +	doutc(cl, "request blocked during reset, %d total blocked\n",
> +	      blocked_count);
> +	trace_ceph_client_reset_blocked(mdsc, blocked_count);
> +
> +	ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> +					       !READ_ONCE(st->in_progress),
> +					       timeout);
> +
> +	atomic_dec(&st->blocked_requests);
> +
> +	if (ret =3D=3D 0) {
> +		pr_warn_client(cl, "timed out waiting for reset to complete\n");
> +		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
> +		return -ETIMEDOUT;
> +	}
> +	if (ret < 0) {
> +		trace_ceph_client_reset_unblocked(mdsc, ret);
> +		return ret;  /* -ERESTARTSYS */
> +	}
> +
> +	/*
> +	 * Propagate the reset result to all blocked callers.  If the
> +	 * reset failed, sessions may be in an inconsistent state, so
> +	 * failing requests forces the operator to investigate rather
> +	 * than silently proceeding with potentially stale state.
> +	 */
> +	spin_lock(&st->lock);
> +	ret =3D st->last_errno;
> +	spin_unlock(&st->lock);
> +
> +	trace_ceph_client_reset_unblocked(mdsc, ret);
> +	return ret;
> +}
> +
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
> +	/* Wake up all requests that were blocked waiting for reset */
> +	wake_up_all(&st->blocked_wq);
> +
> +	trace_ceph_client_reset_complete(mdsc, ret);
> +}
> +
> +static void ceph_mdsc_reset_workfn(struct work_struct *work)
> +{
> +	struct ceph_mds_client *mdsc =3D
> +		container_of(work, struct ceph_mds_client, reset_work);
> +	struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> +	struct ceph_client *cl =3D mdsc->fsc->client;
> +	struct ceph_mds_session **sessions =3D NULL;
> +	char reason[CEPH_CLIENT_RESET_REASON_LEN];
> +	int max_sessions, i, n =3D 0;
> +	bool inject_error;
> +	u64 reset_gen;
> +	int ret =3D 0;
> +
> +	spin_lock(&st->lock);
> +	strscpy(reason, st->last_reason, sizeof(reason));

It still looks like memory copy operation to me.

> +	inject_error =3D st->inject_error;
> +	if (inject_error)
> +		st->inject_error =3D false;
> +	reset_gen =3D st->active_reset_gen;
> +	spin_unlock(&st->lock);
> +
> +	if (inject_error) {
> +		ret =3D -EIO;
> +		goto out_complete;
> +	}
> +
> +	mutex_lock(&mdsc->mutex);
> +	max_sessions =3D mdsc->max_sessions;
> +	if (max_sessions <=3D 0) {
> +		mutex_unlock(&mdsc->mutex);
> +		goto out_complete;
> +	}
> +
> +	sessions =3D kcalloc(max_sessions, sizeof(*sessions), GFP_NOFS);
> +	if (!sessions) {
> +		mutex_unlock(&mdsc->mutex);
> +		ret =3D -ENOMEM;
> +		pr_err_client(cl,
> +			      "manual session reset failed to allocate session array\n");
> +		ceph_mdsc_reset_complete(mdsc, ret);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < max_sessions; i++) {
> +		struct ceph_mds_session *session =3D mdsc->sessions[i];
> +
> +		if (!session)
> +			continue;
> +
> +		/*
> +		 * Read session state without s_mutex to avoid nesting
> +		 * mdsc->mutex -> s_mutex, which would invert the
> +		 * s_mutex -> mdsc->mutex order used by
> +		 * cleanup_session_requests().  s_state is an int
> +		 * so loads are atomic; send_mds_reconnect() will
> +		 * reject sessions that transitioned to CLOSED or
> +		 * REJECTED under s_mutex before proceeding.
> +		 */
> +		switch (READ_ONCE(session->s_state)) {
> +		case CEPH_MDS_SESSION_OPEN:
> +		case CEPH_MDS_SESSION_HUNG:
> +		case CEPH_MDS_SESSION_OPENING:
> +		case CEPH_MDS_SESSION_CLOSING:
> +			sessions[n++] =3D ceph_get_mds_session(session);

Why n but not i here? It looks like potential really not trivial bug.

> +			break;
> +		case CEPH_MDS_SESSION_RECONNECTING:
> +			pr_info_client(cl,
> +				       "mds%d already reconnecting, skipping\n",
> +				       session->s_mds);
> +			break;
> +		default:
> +			pr_info_client(cl,
> +				       "mds%d in state %s, skipping reconnect\n",
> +				       session->s_mds,
> +				       ceph_session_state_name(session->s_state));
> +			break;
> +		}
> +	}
> +	mutex_unlock(&mdsc->mutex);
> +
> +	pr_info_client(cl,
> +		       "manual session reset executing (sessions=3D%d, reason=3D\"%s\"=
)\n",
> +		       n, reason);
> +
> +	if (n =3D=3D 0) {
> +		kfree(sessions);
> +		goto out_complete;
> +	}
> +
> +	/* Initialize completion tracking */
> +	reinit_completion(&st->reconnect_done);
> +	atomic_set(&st->pending_reconnects, n);
> +
> +	for (i =3D 0; i < n; i++) {
> +		int err;
> +
> +		mutex_lock(&sessions[i]->s_mutex);
> +		sessions[i]->s_reset_gen =3D reset_gen;
> +		mutex_unlock(&sessions[i]->s_mutex);
> +
> +		err =3D send_mds_reconnect(mdsc, sessions[i], true);
> +		if (err) {
> +			bool skipped =3D (err =3D=3D -ESTALE || err =3D=3D -ENOENT);
> +
> +			mutex_lock(&sessions[i]->s_mutex);
> +			sessions[i]->s_reset_gen =3D 0;
> +			mutex_unlock(&sessions[i]->s_mutex);
> +
> +			if (skipped) {
> +				pr_info_client(cl,
> +					       "mds%d reconnect skipped during reset: %d\n",
> +					       sessions[i]->s_mds, err);
> +			} else {
> +				pr_err_client(cl,
> +					      "mds%d reconnect failed: %d\n",
> +					      sessions[i]->s_mds, err);
> +				if (!ret)
> +					ret =3D err;
> +			}
> +			if (atomic_dec_and_test(&st->pending_reconnects))
> +				complete(&st->reconnect_done);
> +		}
> +		ceph_put_mds_session(sessions[i]);
> +	}
> +
> +	kfree(sessions);
> +
> +	/* Wait for all sessions to complete reconnection */
> +	if (!wait_for_completion_timeout(&st->reconnect_done,
> +					 CEPH_CLIENT_RESET_TIMEOUT_SEC * HZ)) {
> +		pr_warn_client(cl,
> +			       "reset timed out waiting for %d sessions\n",
> +			       atomic_read(&st->pending_reconnects));
> +		if (!ret)
> +			ret =3D -ETIMEDOUT;
> +	}
> +
> +out_complete:
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

Thanks,
Slava.

> +	spin_unlock(&st->lock);
> +
> +	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
> +		spin_lock(&st->lock);
> +		st->in_progress =3D false;
> +		st->last_errno =3D -EALREADY;
> +		st->failure_count++;
> +		spin_unlock(&st->lock);
> +		wake_up_all(&st->blocked_wq);
> +		return -EALREADY;
> +	}
> +
> +	pr_info_client(mdsc->fsc->client,
> +		       "manual session reset scheduled (reason=3D\"%s\")\n",
> +		       msg);
> +	trace_ceph_client_reset_schedule(mdsc, msg);
> +	return 0;
>  }
> =20
> =20
> @@ -5321,9 +5553,15 @@ static void check_new_map(struct ceph_mds_client *=
mdsc,
>  		 */
>  		if (s->s_state =3D=3D CEPH_MDS_SESSION_RESTARTING &&
>  		    newstate >=3D CEPH_MDS_STATE_RECONNECT) {
> +			int rc;
> +
>  			mutex_unlock(&mdsc->mutex);
>  			clear_bit(i, targets);
> -			send_mds_reconnect(mdsc, s);
> +			rc =3D send_mds_reconnect(mdsc, s, false);
> +			if (rc)
> +				pr_err_client(cl,
> +					      "mds%d reconnect failed: %d\n",
> +					      i, rc);
>  			mutex_lock(&mdsc->mutex);
>  		}
> =20
> @@ -5387,7 +5625,11 @@ static void check_new_map(struct ceph_mds_client *=
mdsc,
>  		}
>  		doutc(cl, "send reconnect to export target mds.%d\n", i);
>  		mutex_unlock(&mdsc->mutex);
> -		send_mds_reconnect(mdsc, s);
> +		err =3D send_mds_reconnect(mdsc, s, false);
> +		if (err)
> +			pr_err_client(cl,
> +				      "mds%d export target reconnect failed: %d\n",
> +				      i, err);
>  		ceph_put_mds_session(s);
>  		mutex_lock(&mdsc->mutex);
>  	}
> @@ -6314,6 +6556,11 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
>  	/* flush out any connection work with references to us */
>  	ceph_msgr_flush();
> =20
> +	/*
> +	 * Mark reset as failed and wake any blocked waiters before
> +	 * cancelling, so unmount doesn't stall on blocked_wq timeout
> +	 * if cancel_work_sync() prevents the work from running.
> +	 */
>  	spin_lock(&mdsc->reset_state.lock);
>  	if (mdsc->reset_state.in_progress) {
>  		mdsc->reset_state.in_progress =3D false;
> @@ -6498,8 +6745,13 @@ static void mds_peer_reset(struct ceph_connection =
*con)
>  	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
>  		       s->s_mds);
>  	if (READ_ONCE(mdsc->fsc->mount_state) !=3D CEPH_MOUNT_FENCE_IO &&
> -	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >=3D CEPH_MDS_STATE_R=
ECONNECT)
> -		send_mds_reconnect(mdsc, s);
> +	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >=3D CEPH_MDS_STATE_R=
ECONNECT) {
> +		int rc =3D send_mds_reconnect(mdsc, s, false);
> +		if (rc)
> +			pr_err_client(mdsc->fsc->client,
> +				      "mds%d reconnect failed: %d\n",
> +				      s->s_mds, rc);
> +	}
>  }
> =20
>  static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *m=
sg)
> @@ -6511,6 +6763,8 @@ static void mds_dispatch(struct ceph_connection *co=
n, struct ceph_msg *msg)
> =20
>  	mutex_lock(&mdsc->mutex);
>  	if (__verify_registered_session(mdsc, s) < 0) {
> +		pr_info_client(cl, "dropping tid %llu from unregistered session %d\n",
> +			       msg->hdr.tid, s->s_mds);
>  		mutex_unlock(&mdsc->mutex);
>  		goto out;
>  	}

