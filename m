Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793653737;
	b=DvfWjz2pnV2+whvTByQC4pEVmblHZPueiiV1/NzqtGQxb5r8cZ/p4V96YLTOnCQP2qDj
	 syltM0SOJ0hd7UqD9Z2fSXDpb+bi77e6Vp5JAydK7SYLI+v5wBezxS1U30j/Xh2AQE8VN
	 it1iW3pfBbKt0Z4ujot3JDd7EiqnvaGti7RwHiD3URAI9wMGkLTaa+dBiWm7wNl6q52cx
	 qRuD/V5hbNt3SMMoDqmZdFEwlw2mOalUeeHzs+TWiqEOfseNhlcqMjNCU/BdR+U7gCmbm
	 F3iPtq/pzrzwqVsDDg0r2HHtllVVb13EbfX31rAxO6tYKomNrRdtxneGTP1TWTn1o1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QGD7MhFVk1bv3I3FAIE488QygLRtUHvj1HzdJadYoHA=;
	b=tMvp4jjdFTzFxm4giRM6gI5prOgWGT4xNrVKQABHmu7RFBprmx3HFvzPxVGI1EsjNwUZ
	 2Hbn7OzTVSY3jvEkbuTLBAjKeEAvAbnmIYVdIhJbe8hJZ09thKXXFXoRuJr+jtWKoPP3g
	 SioH0GrM3+cZXj3pD3M9kX0/zZIkIun3DS2j1EpL0b/Vx0i2zBfIzAZ2kDCx7x0sg2ttz
	 Mz6X94otF+OJUUa+NRvHnTXgBOoZrtXnhGu0UOUmZqztNH/prEN75qP3cl/B8XN97MwFo
	 uzj/93hjbt0MTLNb1LbTAaxnnSZ6VtTMewrG3XBXtQkqClpZT/jEpj9VO68yO4JuG8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Je2WuyDY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3562606A324
	for <ceph-devel@vger.kernel.org>; Mon,  2 Nov 2026 21:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3562606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Je2WuyDY
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so2792423e0c.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2026 13:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793653736; cv=none;
        d=google.com; s=arc-20260327;
        b=sitifFthj6V/Uj9e7VYKTGDxDm4vMWIOOuNfpkOaPgJnawxqR5l+tm8vs4R5vJEuJx
         Y5dmuJJ62YzxWnO5jYOuWywkEvNwEpfpYYne2ooYyfm07hwmPECO1wUgqF+V2RZ10ubr
         RmGxZ37971oRq6Xj1KBmmJlrgQvc3LyUr/yU7yV9MtEVcTTGSt3V2d4IsJ2nmYnoPGAm
         tx4uQ49VmLL9vxx+w0HAkKq++U0MibHOI0EurWZacNQ0l/Tr2ECuY25E8v03FIlOdea7
         5LPhj9aBACnaYY7Kq8mocN1BZ9x5ffSWDNdBphgNcvQywJD3OMg8hYJNd00cMDZD/5gg
         ZG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QGD7MhFVk1bv3I3FAIE488QygLRtUHvj1HzdJadYoHA=;
        fh=MHoHWJmjPDkxNhu32OO1ftvZRlSVFVLeQPzPuVQg0PM=;
        b=Pq3shDAvEt+KtsPzHAJr/eU7n3xMawx2Umce3F1uKiNGoCnlgmTrkpnpcIawAH7Opi
         MfPohv0gP9cfobBVRMQuVy7Kn9RB50M0VUEpb42VOswf/8msN2M0W4Gx0Z0iujaO7pOs
         YzICy7MB2iDVAcIrQEesc1iqHlm5PyBOCU61bVjXqABgHKbu6P0s3nPcQSCVtu+gQJSX
         W7t1nOObYexJ6DkB8reFftoRl4Y1VT35wGkQZOVnpBNdK43nUNhMGpIKJM3RKLxnmH/1
         U+HA0qXxogrG4tUlElgO9bzbn1o7+rGA26JvXzP3UNDHDx95jnFFNfD8v3IRP7MY8YbR
         hp6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793653736; x=1794258536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QGD7MhFVk1bv3I3FAIE488QygLRtUHvj1HzdJadYoHA=;
        b=Je2WuyDYanAdaei3Z5xuc+nZGwnpXpv4gtbnKDQvC6+EFqCMGjJGyb5sgtLcg9luLx
         3wXA6QEMykjZcOPbssGQuAJ37FHrDPX8/mvyUctntwQt6buhIx4n0o4qSN8hyqX/SFIj
         HEtdvcVrSOAWfnPIv2uxn5MlDz34wTVmtbki7Gl5TKHAo0UhGDZBFuJIU5Bu4+NDCDtW
         a1CEA8LZ04DxNRmmywtPCIJhWZcHqf8vBOgDeSNC0BABBzk5ojhjBU9Xcp4Rv8IheR5N
         yyh4G+hQwBpJy4HE/viMR4TOeBHlcQu5qgTbwFfsYalQ3cskOxMUzMjOYAwgHSlWLxpF
         rtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653736; x=1794258536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QGD7MhFVk1bv3I3FAIE488QygLRtUHvj1HzdJadYoHA=;
        b=LfU0YtAJKiyJRqGoCorwTCWweZxk/WxGZ0C+cQLPFXG26RRA6SSOjx4neMQOZdDuUI
         s2LkqfUj10XyQoEfAEJaiJsVhU4yVVLR9pvYZdQW7u2vaHaHwgKTFOQJLkYyhULu2X+w
         FnSUdnf6JqziFmU6FWdDJAb4glebq+WTqwwOqcqWUzhsEGhjWKEqOQeSuegKvLzBKXH4
         S8Fdr2HUI2twViFihE8BsCZKprjj15nN6yETANn93i+6W2T8HPYQUi9P71wp+RI2WfS7
         kaANbEs7lGurLPiDL6Ic/GDAhmfN2fj5aais4oYPd1aYLhaT0y7jrQsxZEyve7iYLcu1
         eB/A==
X-Forwarded-Encrypted: i=1; AKwUvBzzbsjJmd9pEESrNFWL5yAujmM7uSguakhRA5qBOtkxxZti+l1p6vRsqb3STO2ITErHse5g7IYKXLpr@vger.kernel.org
X-Gm-Message-State: APuU4Z+QiGR5BI0lZCmiIfkKICeLRznONGzRXyOg83i68Fel/LsLL4Vb
	UeNvzBdJUksJZZfj26ylrUYdQgdT+e62yuqkuGutpK9H3lxeJB6tNHJf6XLLfedpshihhr/TkZz
	bmpPhCdeOc48/ofUYaVW3vJFX2sRql4MLj0rVYGw=
X-Gm-Gg: AYBFou2HSC1gQ5qoR596BnwCxrbIHeDSwiczNfk9SYozeEf9HZkYNhgKcGFLd4qtZY1
	ZFu/aEl13Pn7714li3PzA+HAXP8XjzEI8MxIHvvubZJe9ucsLjvHuMaycVRdSJOmezUPZqAPFE1
	vMtdkSXI8sGQk+KoLSybSBh2buEobpkL+nZQQ77ZM7xY2ort74P4+OqpBMgpfMFteL6GZC/Ugcn
	mQX4NHl4MlO7S6vcyNjhDTnG6inLhlydE+1Kuc8Yb1BPb+JbU4oCFL/nghck81DdhniY2izWslE
	uM2H9+ILDUOXKqCxrMe4t7VH7qYbskbix59bTXVZRNAB7U2iT3rh8bUbeGqLY0BNH4d2HodIFOo
	ZVB4jq03LedYb+usGY3jE3q61jOOFdMiFxkV45gb8LU6LMfLMpTyCqU29PtKFLUJvA6vEPSw7H/
	VoNWf8WvWpRI0XrMtOzA==
X-Received: by 2002:a05:6102:370e:b0:7c3:2168:d603 with SMTP id
 ada2fe7eead31-7d071f40bc7mr4465939137.0.1793653735698; Mon, 02 Nov 2026
 13:08:55 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260910123951.1241279-1-max.kellermann@ionos.com>
In-Reply-To: <20260910123951.1241279-1-max.kellermann@ionos.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Nov 2026 22:08:43 +0100
X-Gm-Features: AclHuK_PiPKWF4q2Nwn7LD0p5r5C2AXzqyrRzuUqyoEaVhZH22H5uFHAPxl8LHk
Message-ID: <CAOi1vP9mrDMaABV=KtLRwrGVkBrPrGGBU8mUUnfm6wpdn_rM7Q@mail.gmail.com>
Subject: Re: [PATCH] net/ceph/messenger: print TCP connect error
To: Max Kellermann <max.kellermann@ionos.com>
Cc: amarkuze@redhat.com, xiubo.li@clyso.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 2:39=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> A non-blocking connect() usually returns `-EINPROGRESS` and fails
> later, asynchronously; the actual error is then only visible as
> `sk->sk_err` in the sk_state_change() callback and was silently
> dropped.  All the user got was:
>
>  libceph: mon4 (1)192.168.1.42:6789 socket closed (con state V1_BANNER)
>
> Save the error in the new field `ceph_connection.error_code` and let
> con_fault() print it next to `error_msg`:

Hi Max,

I wonder if saving the error that way is actually needed.  Can
con_fault() just reap it with sock_error() at the time it runs?

Thanks,

                Ilya

>
>  libceph: mon4 (1)192.168.1.42:6789 socket closed (con state V1_BANNER) (=
-ECONNREFUSED)
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  include/linux/ceph/messenger.h |  1 +
>  net/ceph/messenger.c           | 23 ++++++++++++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenge=
r.h
> index 6aa4c6478c9f..f3aa977d7886 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -482,6 +482,7 @@ struct ceph_connection {
>
>         unsigned long flags;  /* CEPH_CON_F_* */
>         const char *error_msg;  /* error message, if any */
> +       int error_code;  /* errno (negative), if any */
>
>         struct ceph_entity_name peer_name; /* peer name */
>         struct ceph_entity_addr peer_addr; /* peer address */
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 212e7797f9e4..f989e043686d 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -398,6 +398,7 @@ static void ceph_sock_state_change(struct sock *sk)
>         case TCP_CLOSE_WAIT:
>                 dout("%s TCP_CLOSE_WAIT\n", __func__);
>                 con_sock_state_closing(con);
> +               WRITE_ONCE(con->error_code, -READ_ONCE(sk->sk_err));
>                 ceph_con_flag_set(con, CEPH_CON_F_SOCK_CLOSED);
>                 queue_con(con);
>                 break;
> @@ -448,8 +449,10 @@ int ceph_tcp_connect(struct ceph_connection *con)
>         ret =3D sock_create_kern(read_pnet(&con->msgr->net), ss.ss_family=
,
>                                SOCK_STREAM, IPPROTO_TCP, &sock);
>         memalloc_noio_restore(noio_flag);
> -       if (ret)
> +       if (ret) {
> +               con->error_code =3D ret;
>                 return ret;
> +       }
>         sock->sk->sk_allocation =3D GFP_NOFS;
>         sock->sk->sk_use_task_frag =3D false;
>
> @@ -467,9 +470,9 @@ int ceph_tcp_connect(struct ceph_connection *con)
>                      ceph_pr_addr(&con->peer_addr),
>                      sock->sk->sk_state);
>         } else if (ret < 0) {
> -               pr_err("connect %s error %d\n",
> -                      ceph_pr_addr(&con->peer_addr), ret);
>                 sock_release(sock);
> +               /* reported by con_fault() */
> +               con->error_code =3D ret;
>                 return ret;
>         }
>
> @@ -501,6 +504,7 @@ int ceph_con_close_socket(struct ceph_connection *con=
)
>          * shut the socket down.
>          */
>         ceph_con_flag_clear(con, CEPH_CON_F_SOCK_CLOSED);
> +       con->error_code =3D 0;
>
>         con_sock_state_closed(con);
>         return rc;
> @@ -1613,12 +1617,21 @@ static void ceph_con_workfn(struct work_struct *w=
ork)
>   */
>  static void con_fault(struct ceph_connection *con)
>  {
> +       int error_code;
> +
>         dout("fault %p state %d to peer %s\n",
>              con, con->state, ceph_pr_addr(&con->peer_addr));
>
> -       pr_warn("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
> -               ceph_pr_addr(&con->peer_addr), con->error_msg);
> +       error_code =3D READ_ONCE(con->error_code);
> +       if (error_code)
> +               pr_warn("%s%lld %s %s (%pe)\n", ENTITY_NAME(con->peer_nam=
e),
> +                       ceph_pr_addr(&con->peer_addr), con->error_msg,
> +                       ERR_PTR(error_code));
> +       else
> +               pr_warn("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
> +                       ceph_pr_addr(&con->peer_addr), con->error_msg);
>         con->error_msg =3D NULL;
> +       con->error_code =3D 0;
>
>         WARN_ON(con->state =3D=3D CEPH_CON_S_STANDBY ||
>                 con->state =3D=3D CEPH_CON_S_CLOSED);
> --
> 2.47.3
>
