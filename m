Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441541;
	b=jdKHX0m/0VnHP/6oKRGzIyAp0dVa9qyBD+5wC+2y2ph8Sbdn0s7sxU+VFxiVKev8hRKA
	 LqTfzYYaVDpTKEsAf87UjkTb0ngk87OptA7N/sWw4cLut9EqQc41U/L1uMXljRfe6z2DK
	 3sH92xZGCra/A7kIW7wBKv80qFBf+9pO4WgUdHEkemb5TSXi8YEldZFPK+vtfSkQ52HoD
	 L4t5phZS3V26huhhJrgq0iEJ7CNQ5bQj6QD4x/xYoan9QTJQt9guYgcLcCtCj5houaNQX
	 E/tBxZa8i7afhpukLP7EOBvniDpaej4dUXPOaxhk+iZMqNNca1xnFbEiTYoMdeeR/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441541;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OtBub8b20bbqMuFkyJTcKI4DqlyTDvoNk2aq53vrnfc=;
	b=ESzF3XxWUWgsy6USWMdAP96FpepnsqPNhY3sCN2VnJg/xu4uPl21eKiflNS1Jh/FsZbN
	 XFx6K4w7Svy1bOY7GK9p9nMbAJfLIjtx0djTqPBvxTvywDMxN6l+4zrQE6KL4N8isz/8e
	 s0Npjq8uxYsiZeyEQXBlwiULSzLymr2vcQfL5VLoLbgX0xtV9aqxZ8hTMgMIDmYMbNXFF
	 EXSRtHQSdT9q3Zmzj3SH9nFo2qi6RVwpIoQBSZrFjDtAvXVBTfLgtr6TGPSAcTZ+++04x
	 nNEuj0uY/TW8DOzaF7zyO6IVTZStfri6UUPJQ2LPNSSzERUb2q8itjojwsU45RHh5Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjthG5G1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2638606A321
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjthG5G1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775D01F00A05
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 23:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441540;
	bh=OtBub8b20bbqMuFkyJTcKI4DqlyTDvoNk2aq53vrnfc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EjthG5G11Gx7GyWU5tsLdVpO4clAZzkK9SxTO4uY64NKPvdFri8srDZ0FtNHmtLx2
	 wWb2EJfUrAfaPkPJ9F1V3xoS6403dT9Bm/XnEPf3JRrrkEIxSPXyNLdnT8MlBxT3bP
	 vGzR62gI5GVqySisuIX5yQ0spORmE4H3jgUbqjRqtCtEhnkbcWYCWLd8zanJymPv86
	 ICSelHe16P9XPkCUFIyc610BA39Xtn/gQCQKUVX90lKB0V9GB9jJmzGOdqu+mmiCCl
	 6Tu0LoSRzYdow6JGyY1ydP1n+CU/AAK6m4CbIuauh4KBI814CWfZ4DzyWM4D74rnyP
	 OwKjUcVUmXx5A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be47aa555cso3377018e87.3
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 15:59:00 -0800 (PST)
X-Gm-Message-State: APuU4Z/K6tM1f+qoz7Sqhtoass8TMmZyGDZMofCsWO6EcDT2kcc0pEro
	XBkkcU7VMdKQuLMdiQ8FCbEID9kgtJHBxaxRrFkAlNTYCn5tLmZ9wD1gGlvxi096/xRxaxIHsi1
	eGcDwWfAWhRbksyX5vs7SN3HqesSgQ6g=
X-Received: by 2002:ac2:5691:0:b0:5c1:50f6:9b84 with SMTP id
 2adb3069b0e04-5c15d7a209amr1132025e87.58.1794441539234; Wed, 11 Nov 2026
 15:58:59 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110201025.255594-1-idryomov@gmail.com> <20261110201025.255594-2-idryomov@gmail.com>
In-Reply-To: <20261110201025.255594-2-idryomov@gmail.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 12 Nov 2026 00:58:46 +0100
X-Gmail-Original-Message-ID: <CAOuZWzwY5woDuD+L_a2=h5hR++Ro3onSazUV5_1L-Kur+Hy1Vg@mail.gmail.com>
X-Gm-Features: AclHuK85uOSENTtM5gvAwoqfusVpa_QkpNCW9asXOFTOVMsp1U2QH746KtpcihY
Message-ID: <CAOuZWzwY5woDuD+L_a2=h5hR++Ro3onSazUV5_1L-Kur+Hy1Vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libceph: replace lreq->ping_sent with req->r_start_stamp
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Dongsheng Yang <dongsheng.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilya

This patch lgtm. Tested it and works well.

Tested-by: Xiubo Li <xiubo.li@clyso.com>
Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks,
Xiubo

Ilya Dryomov <idryomov@gmail.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=8C 21:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Eliminate lreq->ping_sent by making more use of req->r_start_stamp.
> This requires setting req->r_start_stamp outside of account_request()
> but it only has one other caller apart from send_linger_ping().
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/osd_client.h |  1 -
>  net/ceph/osd_client.c           | 14 ++++++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_cli=
ent.h
> index 50b14a5661c7..0847c522f897 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -316,7 +316,6 @@ struct ceph_osd_linger_request {
>         struct ceph_osd *osd;
>         struct ceph_osd_request *reg_req;
>         struct ceph_osd_request *ping_req;
> -       unsigned long ping_sent;
>         unsigned long watch_valid_thru;
>         struct list_head pending_lworks;
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b8e4740d07fe..5053363134ee 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2482,12 +2482,13 @@ static void account_request(struct ceph_osd_reque=
st *req)
>         req->r_flags |=3D CEPH_OSD_FLAG_ONDISK;
>         atomic_inc(&req->r_osdc->num_requests);
>
> -       req->r_start_stamp =3D jiffies;
>         req->r_start_latency =3D ktime_get();
>  }
>
>  static void submit_request(struct ceph_osd_request *req, bool wrlocked)
>  {
> +       req->r_start_stamp =3D jiffies;
> +
>         ceph_osdc_get_request(req);
>         account_request(req);
>         __submit_request(req, wrlocked);
> @@ -3195,11 +3196,11 @@ static void linger_ping_cb(struct ceph_osd_reques=
t *req)
>         }
>
>         dout("%s lreq %p linger_id %llu result %d ping_sent %lu last_erro=
r %d\n",
> -            __func__, lreq, lreq->linger_id, req->r_result, lreq->ping_s=
ent,
> +            __func__, lreq, lreq->linger_id, req->r_result, req->r_start=
_stamp,
>              lreq->last_error);
>         if (lreq->register_gen =3D=3D req->r_ops[0].watch.gen) {
>                 if (!req->r_result) {
> -                       lreq->watch_valid_thru =3D lreq->ping_sent;
> +                       lreq->watch_valid_thru =3D req->r_start_stamp;
>                 } else if (!lreq->last_error) {
>                         lreq->last_error =3D normalize_watch_error(req->r=
_result);
>                         queue_watch_error(lreq);
> @@ -3218,6 +3219,7 @@ static void send_linger_ping(struct ceph_osd_linger=
_request *lreq)
>  {
>         struct ceph_osd_client *osdc =3D lreq->osdc;
>         struct ceph_osd_request *req;
> +       unsigned long now =3D jiffies;
>         int ret;
>
>         if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD)) {
> @@ -3225,10 +3227,8 @@ static void send_linger_ping(struct ceph_osd_linge=
r_request *lreq)
>                 return;
>         }
>
> -       lreq->ping_sent =3D jiffies;
>         dout("%s lreq %p linger_id %llu ping_sent %lu register_gen %u\n",
> -            __func__, lreq, lreq->linger_id, lreq->ping_sent,
> -            lreq->register_gen);
> +            __func__, lreq, lreq->linger_id, now, lreq->register_gen);
>
>         if (lreq->ping_req) {
>                 if (lreq->ping_req->r_osd)
> @@ -3251,6 +3251,8 @@ static void send_linger_ping(struct ceph_osd_linger=
_request *lreq)
>         req->r_linger =3D true;
>         lreq->ping_req =3D req;
>
> +       req->r_start_stamp =3D now;
> +
>         ceph_osdc_get_request(req);
>         account_request(req);
>         req->r_tid =3D atomic64_inc_return(&osdc->last_tid);
> --
> 2.55.0
>
>
