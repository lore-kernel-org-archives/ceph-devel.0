Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF24746C1
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832962; cv=pass; b=YTuDELhl49yAX03nfcF5mXwPtqo7atd9TJZMyFZuXEPX0mL//zOt8d4sC//wVh2u/URmzyCmPHyRFnyPSDG8+dWSIsee7sjwfI8kNvErsLmxa7HWQJWDDvr62mT35BYBOaqT6rpjBDvxWa9XrSuZsVTjeFFbvdf+dXzQfAkorMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832962; c=relaxed/simple;
	bh=MHZ8J49tNTE4EotXskkEXdwNQpj/62XCRu1SCSNlL1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqKplgvrSitszg0qhD+2IIjiwM+hSLyrctskjov8F1BKkD8PpYJaTq5atNJumxahqVOifSrU+Fj7T/4dZ9ehui5NxrRGMU2Q+4sQAPUqwbNCTLavGlk8TsX9xOacgJzklPvzp1hl6cdqPmRC9zadTPaKee0+Tsi4rt+cSqcXP6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRn0tZG1; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRn0tZG1"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bfbbe5220dso433042e0c.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2026 11:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784832957; cv=none;
        d=google.com; s=arc-20260327;
        b=EsNx7VaG9ZNUAwqVfmiXvvQ75OQOPDpTLR0WOqrVfWYn+hDkgiurjgyLYD8I91zCiS
         uZzr7bLQEXhILhgHzKRcbeNOTHSxByfL2bX+OLIX18ZgJNzBopQH5RCCufNMLUuOWxFg
         djfnz9GnSNTI6NiLBH5AvlaACVbOWgy4jpawyb8jYEjY6YkH4ILp8uodqM4WzTaNlL7V
         awKiuTb5RfLNx++txFPSAjHRXI/8SgbRIu64QvAxaD90Wgq8SunCFETEYiPOgeexhYd8
         v07qjBV8epCDkVkinQ6EYRZXUDhNp/GsM8AmRUtj1qBuEmjDkX6ZI6uiHWoEdXEf+05S
         htmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJVimJO7g+lWcev3AGpWBpyZXuhN6l7qACUcGOp6mYo=;
        fh=v2WG4ZbWVUre1mVQr/7g8j49eJ3ErDpZaAwh7wZuD2A=;
        b=MknAbD0GVyC4CS6sqhwZib2F/kdgy1PnTI1Es62xgbewiXs7/ARYFw5csmP4TlGJRi
         /ctNJTDzKTr7PKykII8zmE4urVGaIn9Rak53O968iuz36RzME5umjG1NVc7mpRMCAsmp
         8EdtvHK3V1fXMk8q+8OI0SN9CYWpZ253raRvxmf8MWh0Va570tAbqbRLZm2uhvV0/AYG
         QWtJgFjKyzb0xcZdgyfW8arMOmZVc9sCWfDebBYNkYqJg6v6PqM2tg0tS70zWGYqVbe7
         6cy59K+Q0hqE2OjVkETFnIJxv+2mkvJdIOtOwGhfcjQsYO2TqPaVXhfNx+039dravDdS
         tg0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832957; x=1785437757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJVimJO7g+lWcev3AGpWBpyZXuhN6l7qACUcGOp6mYo=;
        b=GRn0tZG1i5sPcktH0l7x6wYZAmDNmYvAqpuh2qFC8uRKgLvLy8DTBzstINwDxaPWcb
         8VQPx7DjQb9uM0p37unJGgWBRfvPB/mURonX0V0t4dRYKnQrxskmkepWFHbmlKp0qc0P
         cyuhGHGu6BzRaHZgRT2kL7gB228hUyrz9Hs/Qrma2Y7TFc5HmGWSMGN5degaWLRb5DAD
         hcsU2Fl+AMdclohiiDbqtKAo2t9yAHyf2Z/iN4Cn3qHELodHOt/fIIK5Mi1CYovjuElm
         s5KZDzY2Tw3XlK1CnyeIRMlbptNum3EFN26PK4a2WU1QJAMuWV4DaWV7VNqELEGkRNTY
         kavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832957; x=1785437757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJVimJO7g+lWcev3AGpWBpyZXuhN6l7qACUcGOp6mYo=;
        b=qIaF0PAv+hAz7BlZ16ncrGEVqBJn6CmRXEWq9K8EBXrcy6rY2/ZU9+e5YylB8QplLS
         6ubVtE5/XaYmDPCjr8o0MUdhbOdjjfiFMKY2nPU6fWDPJ/SOJB/iBUvd64xYKKCtkcVr
         fvImwc9+/SJwwVnB3vWwxuDm5MqIJkCOkJOcInnn6bPAE1u/39pnWRhKPbuop3KdL47D
         8q7dBzrcifeJ9MYg4HFQ1rgr8CBD50erjTyH5I0zZDRdNuyghbOz6SpuVmxKmjphtHdq
         MHXDaGCZX1BGbB/OvzVuYc4+F+JjHRT/hQEeMbsS2jFPlcpL8SUE2PBAwWEQv1fm1xGl
         ZPJg==
X-Gm-Message-State: AOJu0YwCzCi4laOVVBo8tA7FlWolF+BIrZWJbPfl0WkSJw+PyhpYRkCc
	kwR2+f6cs620asGHF8MSjLQ8CO2JICdj0+0DJXRsskNhxGxYTtfvxxfIUr3auV/eixLMz5mwcvg
	0kgYk0pA94LXJhiwrDPu/lNFQmt9RLlg=
X-Gm-Gg: AR+sD10UDDt8rg+0HCk2YJ1k/d3r2vapYuupvh++qQYlYwWaxJezTq8BNxRbr0K6IG1
	C32m3TQ0QQG8dCIuEUVLcqFoOCAfb0pezhqEHwpQl6bSUEvGaYMYlTNf42g6jo8STLtifWeEa5Q
	0oC/lWJrf0NdDx63elBe5zz4CEG4GCh3tCat1h+MNA+bJYe80goBELOwZtCoewMmKCDuC0epVV0
	Z3q9icOpCNUbv+Shzguo1vK+jQpLzSOcXqzrN3Uod2O8R/2168/m1nlFPWzVZVb6Z1x+LxS9Xw3
	fDZusKfK9tDtqbgobZE=
X-Received: by 2002:a05:6122:4109:b0:5bd:b47d:1865 with SMTP id
 71dfb90a1353d-5c2dca3461fmr1634116e0c.5.1784832957239; Thu, 23 Jul 2026
 11:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784371310.git.xizh2024@lzu.edu.cn> <bbcdd44d07efd11c7211195b6302b179918cb253.1784371311.git.xizh2024@lzu.edu.cn>
In-Reply-To: <bbcdd44d07efd11c7211195b6302b179918cb253.1784371311.git.xizh2024@lzu.edu.cn>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 23 Jul 2026 20:55:45 +0200
X-Gm-Features: AUfX_myqYZghinHOKFYiG0R0NPj5ykdqDbmqehnldFEJDJ-l08hMs5q2OS-2pFg
Message-ID: <CAOi1vP_A3aNbj6iTRdtMMa37yfKcRNeGdixd=6OmBRnTa0X0AA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libceph: unpublish osdmap before destroying it on stop
To: Ren Wei <enjou1224z@gmail.com>
Cc: ceph-devel@vger.kernel.org, amarkuze@redhat.com, slava@dubeyko.com, 
	sage@newdream.net, vega@nebusec.ai, xizh2024@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 5:49=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wrot=
e:
>
> From: Zihan Xi <xizh2024@lzu.edu.cn>
>
> osdmap_show() takes osdc->lock for reading and then walks
> osdc->osdmap while formatting the debugfs osdmap file. During client
> teardown, ceph_osdc_stop() closes the OSD state under the write side of
> that lock, drops the lock, and only then destroys osdc->osdmap while the
> pointer is still published.
>
> A concurrent debugfs reader can therefore acquire the read side after the
> stop path has dropped it and traverse an osdmap that is being freed or ha=
s
> already been freed.
>
> Take the osdmap pointer out of osdc under the write lock before dropping
> that lock, then destroy the saved pointer after unlocking. This makes the
> write lock wait for any current osdmap_show() reader and makes later
> readers observe a NULL osdmap instead of a freed object. Also make queued
> OSD map messages return after taking the lock if teardown has already
> unpublished the osdmap.
>
> Fixes: 76aa844d5b2f ("ceph: debugfs")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/ceph/osd_client.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c181..70467eede336 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4145,8 +4145,11 @@ void ceph_osdc_handle_map(struct ceph_osd_client *=
osdc, struct ceph_msg *msg)
>         bool pauserd, pausewr;
>         int err;
>
> -       dout("%s have %u\n", __func__, osdc->osdmap->epoch);
>         down_write(&osdc->lock);
> +       if (!osdc->osdmap)
> +               goto out_unlock;
> +
> +       dout("%s have %u\n", __func__, osdc->osdmap->epoch);
>
>         /* verify fsid */
>         ceph_decode_need(&p, end, sizeof(fsid), bad);
> @@ -4238,6 +4241,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *o=
sdc, struct ceph_msg *msg)
>  bad:
>         pr_err("osdc handle_map corrupt msg\n");
>         ceph_msg_dump(msg);
> +out_unlock:
>         up_write(&osdc->lock);
>  }
>
> @@ -5268,6 +5272,8 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, st=
ruct ceph_client *client)
>
>  void ceph_osdc_stop(struct ceph_osd_client *osdc)
>  {
> +       struct ceph_osdmap *osdmap;
> +
>         destroy_workqueue(osdc->completion_wq);
>         destroy_workqueue(osdc->notify_wq);
>         cancel_delayed_work_sync(&osdc->timeout_work);
> @@ -5279,6 +5285,8 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
>                                                 struct ceph_osd, o_node);
>                 close_osd(osd);
>         }
> +       osdmap =3D osdc->osdmap;
> +       osdc->osdmap =3D NULL;
>         up_write(&osdc->lock);
>         WARN_ON(refcount_read(&osdc->homeless_osd.o_ref) !=3D 1);
>         osd_cleanup(&osdc->homeless_osd);
> @@ -5290,7 +5298,7 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
>         WARN_ON(atomic_read(&osdc->num_requests));
>         WARN_ON(atomic_read(&osdc->num_homeless));
>
> -       ceph_osdmap_destroy(osdc->osdmap);
> +       ceph_osdmap_destroy(osdmap);
>         mempool_destroy(osdc->req_mempool);
>         ceph_msgpool_destroy(&osdc->msgpool_op);
>         ceph_msgpool_destroy(&osdc->msgpool_op_reply);
> --
> 2.43.0

Hi Ren,

I think this is already fixed by another patch that you seem to have
been involved in:

https://lore.kernel.org/ceph-devel/e346902d49608e030177ffb00423e776f4a916ee=
.1781280238.git.ldy3087146292@gmail.com/

Thanks,

                Ilya
