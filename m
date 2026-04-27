Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71D3A784A
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292417; cv=pass; b=U9uAMvM7+uZw8m74lhFVNBjdAwHtTnVHu0Z3LgpzGvnx0XUncIQ+47CSHHIVPqI5sqGeZAE4QkU12Wq327QSDkS2Z20Zx+ZbG1rrmJIMntLOWAvZjs6ydaEDZrUvWh/PWNLt/DTEHp77hihoy4gj6r6h6y39oI2lyuR5zwwcIMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292417; c=relaxed/simple;
	bh=7ND6Qeugqma/lV+rmaSyCzo7YD1hP0YqUQcNKsMAkek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/ekcvlhfiKgm1WPVqjqYANAljrRX2GWJjiXEs5TA+ALyVVyp7HXiggP4ZcNLMppcmUf5Faj0XWJQG4YBzuslVftbH2i9I6/u04M0Fjgrlso87pzxLWgVc7m+VrWC8cs8T3eJJ0NnDmMhqtWofmBpQcst/xDoRZMXGOeGSJ+E8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDmz+GOm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeJMFTY+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDmz+GOm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeJMFTY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777292414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
	b=HDmz+GOm9mtlJkpantu2+m978JNopxS4mm/hZsjlcc/KqMMjRbQa7p1clbc7mxwf4a9Kpx
	3xyaMKSU94V6KdFNWyqDElJVFbZQsX2JwFTtVt5CmRMAdCw/+L2JRxvgOTFvK11IbQlOdD
	VeDmjIOHKV8jr+XZBS1PkhTQfqjVq04=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-8T29-o-3OeuFqy67j2f01g-1; Mon, 27 Apr 2026 08:20:13 -0400
X-MC-Unique: 8T29-o-3OeuFqy67j2f01g-1
X-Mimecast-MFC-AGG-ID: 8T29-o-3OeuFqy67j2f01g_1777292413
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5675cb317e3so7559449e0c.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 05:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292413; cv=none;
        d=google.com; s=arc-20240605;
        b=Cai3Nccu0rkqs8P/fn/yfbAO+J0jOkZl/Em8jnVt2i1ravbkXLw2lJPeUro3sHVhhj
         FDKR8Ub4IWEM76+GcXkyILAevzmfufgn7iEAnCFz2PftNq4Rt5azZp21A5cM7nxOdwWM
         qua+QqgbIUnQhdC6GPI2sjNXt6153wYQAUy7o4MQEiCMiPnvcW2mRcyrpQ+y5OACH9wW
         8ELRpfAwh6LWhYxqh5UNr2tW5J64uCx0IIaVmonYjcBo78Zn2wEJQVDKOBwXcDFNHKlX
         v9wlBcikuOpF8w1zPXemM8hk1vNMOhJOcte6bcuueKk3kyVA8sqriNvY8eJQ+t+q3VIL
         SKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
        fh=4sJrSkY7V8JT6AvZB1ZW0rR3MBJS7LN5g3XPU6S/PJI=;
        b=WFxgBSU/MNNP/79fy/iZ+X6geqmjqGihmzXdKu9wOazOM2xVxFrrLp2nSwTWIVf3SD
         X4nNyS8q/EVpKhkD/EpGZlrZNUiynUvAXgV0I4S3GtLQ+wpMzJUWkO7NZVv31vmo5OQD
         v6+WK0GU+Qc0K/Hs10Vv5ieVLFgNKwSe+Pfeymyz/QcjjA0t1aqlzGUp87sqqsgAM8va
         4Iqyj33KlzyBryChcgli8TstORAX3oGaThRozHe0oisoaP+Jkw4K1W+Qh1WDF3gP+N3i
         vtS7IaVitxLwDA4T/RR6ZVz7V4srMwWP/B0kI+dRDWGApre3hxagfMA9+i3Bq3gAyhKt
         +0zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777292413; x=1777897213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
        b=DeJMFTY+Ln5d22IDbnR74B1NyFIeIK72ax6uJs99bstW+hoebwKQg05H0SQFZWnuz1
         ZkVfBngM7f93fYVVAtihhMMy1ZKMBBrNnn/SgfzF8ddxDa4pe5+YLKvAa3h6hG909P39
         VkROeT206k3znx205hp1LCLzpJfuytSm4miH9NnzDKgs9eKs5lqhY8nCxNHF0F0sdvdD
         LJCBpzYNwMc64+VAcRG9Xuz6gtY9GG3cc9tWOq9eTo0j+jVzhYamcQRQCcW/ZJTFlWhF
         HGUri4zfS7ymBoNbqpDDKE2sVkRZJfVnr7GT7i4sMkHq3hTUR3XWcWVcK6i6xrA4DNwf
         am4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292413; x=1777897213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
        b=NIUKk0d117EF/jujEpYiVrQY0dvyVceNtFEtDLr61dcvum9XwlU54PiCPdCLRPSq5R
         fT1W2QxQT766W+5RKeCHI+7dg4B01MtySNCWo/hf4hKGndHKZnA23LIdIRyT6uHyrHjg
         W299iYVhyT3XXt2jwT1Ht/GFHsj4Z+DSqShiLB+eSbundZcVZu7aNXZ5MS+Y6oig0KhF
         lA2jbRDFKjZoYNxzbpHZIrgaBFiN6ShlyTTfCz05ysPUX0PEvh2mCR/OXfZwsotVcgbC
         K0+zh+rkrbsYxrxzFnt1dH/CU+fUusRzns6Kkl0u08gnaCeS0A1vlCVABsY2nGBeUpp9
         LR8w==
X-Gm-Message-State: AOJu0YzZESWzYL2OmpDalVA/RUBzstwSDGmUh6WIpLNiotLMliIwtE6b
	YlYfD2HSAY1qeyV9YOhy7szcdOKmu3KVWFo7JMdD5jAiR4FcWI+4rJgR5p5osjWZ/R8IlQ0/WfD
	cULI29O6BWHy5qa7pUKpWnMaPk0y8n0//WWIUMo6V/GdklsqQEHzOZkfl51rj7TYgz6MX/UznA0
	ODnBJnwDTbrmdhUpKJRDp2OYhpeVQ5iTz22MOJ3g==
X-Gm-Gg: AeBDievQScrM7aqO529k0dg5lFzBts7aWwaiy/0g4m10F8IZoPT05DoHuiQe6kdftrp
	ikDpIAQYA7JvIka+qUXPiFcme43jnEmi9nmGc7IPYaFdggTBpC927iV2n/CZXpHmASsB4Qq4Ssh
	OdmIRCASz0Iu8+t96VYOHhUV8PyRYyHLcIHdJHTPi45CTCP8oQX59EoquwskVWARURv4YvK8D4J
	TtKINdJIE+ZBXM=
X-Received: by 2002:a05:6122:3110:b0:56d:9e98:4676 with SMTP id 71dfb90a1353d-56fa5a50ef8mr21563612e0c.13.1777292412959;
        Mon, 27 Apr 2026 05:20:12 -0700 (PDT)
X-Received: by 2002:a05:6122:3110:b0:56d:9e98:4676 with SMTP id
 71dfb90a1353d-56fa5a50ef8mr21563593e0c.13.1777292412536; Mon, 27 Apr 2026
 05:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206202757.1535351-2-slava@dubeyko.com>
In-Reply-To: <20260206202757.1535351-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 15:20:01 +0300
X-Gm-Features: AVHnY4KsrXF6FbtCKnOVPXrHM0XTTMBPPxUwKeAJV4Lnc1M8s-oXgLyQqPAN6RY
Message-ID: <CAO8a2SgqvbP-WJAMnKLn=pKmDfjdaq1f86-1MFoqeo-4iehBOg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix generic/639 xfstests failure
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>`


On Fri, Feb 6, 2026 at 10:28=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The generic/639 xfstest fails for Ceph msgr2 protocol:
>
> Ubuntu 22.04.5 LTS (GNU/Linux 6.17.0-rc7+ x86_64)
>
> sudo mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3D=
secure
>
> sudo ./check generic/639
> FSTYP -- ceph
> PLATFORM -- Linux/x86_64 ceph-0005 6.17.0-rc7+ #16 SMP PREEMPT_DYNAMIC We=
d Nov 12 11:01:48 PST 2025
> MKFS_OPTIONS -- 192.168.1.213:3300:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/scr=
atch /mnt/cephfs/scratch
>
> generic/639 - output mismatch (see /home/slavad/XFSTESTS-2/xfstests-dev/r=
esults//generic/639.out.bad)
>
> The simple way to reproduce the issue simply running these steps:
>
> mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsecur=
e
> xfs_io -f -c "pwrite -q 0 32" ./testfile251125-0004
> umount /mnt/cephfs/
> mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsecur=
e
> xfs_io -c "pwrite -q 32 32" ./testfile251125-0004
>
> Finally, we have the unexpected content of the file:
>
> hexdump ./testfile251125-0004
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0000020 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> *
> 0000040
>
> Initial analysis has shown that if we try to write out of
> end of file, then ceph_write_begin() is responsible for
> the issue because it calls netfs_write_begin() and we have
> such logic:
>
> int netfs_write_begin(struct netfs_inode *ctx,
>               struct file *file, struct address_space *mapping,
>               loff_t pos, unsigned int len, struct folio **_folio,
>               void **_fsdata)
> {
> <skipped>
>
>     folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>                     mapping_gfp_mask(mapping));
>
> <skipped>
>
>     if (folio_test_uptodate(folio))
>         goto have_folio;
>
> <skipped>
> }
>
> The reason of the issue that somehow we have folio in uptodate
> state and netfs_write_begin() simply skips the logic of
> reading existing file's content.
>
> Futher analysis revealed that we call ceph_fill_inode() and
> ceph_fill_inline_data() before ceph_write_begin().
>
> void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
>                char    *data, size_t len)
> {
> <skipped>
>
>     if (page !=3D locked_page) {
>         if (len < PAGE_SIZE)
>             zero_user_segment(page, len, PAGE_SIZE);
>         else
>             flush_dcache_page(page);
>
>         SetPageUptodate(page); <--- We set page uptodate if len =3D=3D 0!=
!!!
>         unlock_page(page);
>         put_page(page);
>     }
> }
>
> This patch fixes the issue by checking the len argument and
> setting memory page uptodate only if len > 0.
>
> sudo ./check generic/639
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 ceph-0005 6.19.0-rc5+ #2 SMP PREEMPT_DYNAMI=
C Thu Feb  5 15:43:51 PST 2026
> MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/scr=
atch /mnt/cephfs/scratch
>
> generic/639 6s ...  6s
> Ran: generic/639
> Passed all 1 tests
>
> [1] https://tracker.ceph.com/issues/73829
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/addr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 63b75d214210..436a287fd311 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -2184,7 +2184,9 @@ void ceph_fill_inline_data(struct inode *inode, str=
uct page *locked_page,
>                 else
>                         flush_dcache_page(page);
>
> -               SetPageUptodate(page);
> +               if (len > 0)
> +                       SetPageUptodate(page);
> +
>                 unlock_page(page);
>                 put_page(page);
>         }
> --
> 2.53.0
>

