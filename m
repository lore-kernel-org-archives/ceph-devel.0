Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204948;
	b=NZH2ILYBWTpj30SnApXI/XY54daMt3IuhA1p5VPN+UZIw/we54UmzIxH6o8qGFa6gojM
	 dgi761HJzdrdP2InVD+py5+Mx4GIRJvsgYLYM01RBVH7Sh37eWZbZSiBjWCcWqvybrQmJ
	 Tt8SMku5F9ibeZjlCpUX2iGWoplPFURKjINZCigklnWX4+/imT6iXIPEFI6ayoKKs3w7/
	 un6tfgMPc/uVxt7IdYYHUZB61mXs7BBHRManTY6pPFUe/+/WR4UnkrExp9ADR4kpOGUcV
	 SoICFDBGmUX6TmgkAlRL0J40R1fQWww3RQmbno/2QP7B0yBFtdWGjepX5JPDaR6fnZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204948;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jz2njDAimzaZ7BVL6rE5Qsvpikag4q3XQYpg9cVtMz4=;
	b=mt6UeT3l6A1OyzUP38yctTe1JY7USkruvLnUMzJk/dP2fLlfk36KtTZpfh7W0IL2ukWN
	 i2GXZSXv1PwBObfQv4qQ9DpzsyBdB++aIffsfYSikMSI8prEdCuLz/xyW1OYSjmkQdQkv
	 eR1hSG8e8vyZkoWTBmczlAj4q5MHwFUM+MjlI+Vy8AuWWhggE8vpvZW79ukwh6ISdN7oh
	 mFiUpx0W1FUD1rf8r8pewvc3/UUHPUnY8i/xeNO6ISFucgXBTRdP5r2Ge65lrv6C9d8kU
	 oFrmHVENUgBf7LmIDI9LBt7zpvWq0nsJiPGNNh/L58mBVqb7gxY42AY6cb73DOdIwMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqNl9pdv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=G7vFEIu6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50AC606A327
	for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2026 16:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D50AC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqNl9pdv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=G7vFEIu6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793204946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jz2njDAimzaZ7BVL6rE5Qsvpikag4q3XQYpg9cVtMz4=;
	b=AqNl9pdvpfq4ooNeCvUetxbKKmYrF3mEJbMSSE23FBg7ojN7cazeNN2wJb/XojW8CMzs2S
	tt/7b9+XiWBUa+rhObBISkML7HPOSH68PiP44WKDPPR172KXguWZJ9W8ch3VWdX/qQgxAg
	oqFucu3K4KIsQJ9AL7b7w3Ecw5Li1+0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-xVOl5rt1NIqle70KOH__yQ-1; Wed, 28 Oct 2026 12:29:05 -0400
X-MC-Unique: xVOl5rt1NIqle70KOH__yQ-1
X-Mimecast-MFC-AGG-ID: xVOl5rt1NIqle70KOH__yQ_1793204944
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c3613c35145so126503366b.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2026 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793204944; x=1793809744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jz2njDAimzaZ7BVL6rE5Qsvpikag4q3XQYpg9cVtMz4=;
        b=G7vFEIu6fOTSJdZdLDXzryCdYCGmsFzY3f5uTb41xd+D3zM8SxVYMzxMtLepwG9xmL
         MqeAlRLW2OFTKpyW1S/hb0zLr/oS3lMRXQuPSKbYmkOtqjo6HVXAWWnDqyPsCbsVllsS
         Y0K+WoeYf8S38Eew8OAtOKfVD5TDccqIKE+xRVsEQ6iI4dTDQyHCecZ90PBJdxk9i5pz
         YenX9qBOdiFWc4D/ubrXAab2dKA66oKC/FUH2zP53qIwRVqV1q0R/LEDM+uBftL0XBVk
         njjXsnsJmhnl4PUTdKbP5+B52BBbBQ9laOkKRm530qkqXvyzV8L1AnG6u56bJ/GsC+Ao
         K06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204944; x=1793809744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jz2njDAimzaZ7BVL6rE5Qsvpikag4q3XQYpg9cVtMz4=;
        b=ihGGgB406BbUwuekdsASdmz1oh+YBVh3QgrNYRG/u4QTtd6pLsuvcoJSc6ioE03LsM
         8OBschZeMV8y7a4lfc6ADzzP+xvq1fGfX72yYZ9GtpMcWiHqwlW6glXWH0jVt3OoYYUl
         aCk4tSSYOzUz/0dYLGhqYP748Q6TDHyToZSxcNDg1w+N+fDcgDEpJVDnAAXKpoeS8/I4
         hgBrk1He5GFTy+52kap8+AgasjJpENOAWy1ZpfyFqyqGaqOm0S/bsYOmujlONoa/+bEn
         BYULujsqyPpfkZeSyzvjHcn179D+HRBCI8O73YC0eEN24/8qEyt4HWCOoPWh58N9GMM4
         fIDQ==
X-Gm-Message-State: AFq9FYLUDNACpQigZBs1Diwd+ZHdWwiP58Xts28JrX73jle+XM72uhxY
	wjk0QLPLlJolEaWYa5oe+2GuCHQg4IrUEwsTe5f5Gau4hIhPcejxgSExBpTu7aulyNkS0hqPXXJ
	i0vE8ECUK7lFYlnMnA5wMJ2XVR/5+eRdGVUHHcOiBfNr3xilYsyVbphp7+V4XefRH2fc/6sw=
X-Gm-Gg: AYBFou3X2l5v6Mpq7I9Z/IoPTXXx1mBKU3hmzqudoaFdKunPvEbATvnSc+5LvCrTbP/
	G5s5ix4PhoblL3kgPqSS+znJgKdfq0KZkTpIrQoMTSHEA22nQfmoeNx+YYCH5VnYtgheesvbaga
	O6Mxvze5BxHnpN4vU1Ky15uxlIeywWudzA3EO/yW0BRp17Dvsq/4zQslh+RQ7Jysbp8av3j8Gdd
	htHE9MnxLYhPlW1HGIQjsNuIFdcTLJa/XezSYJi9Gq0aLCewUNMnn3vbBJ8nq4KoE8zVxMGBqp3
	Y8TDnpmOcLUt1VMyWVvmOrskl8g/qDfsMg63kBcsBIf5bguqgydXj1eGjuKCV8XrXCqKfbIXkyW
	xa9G5oqOPjb93aPJ8VLAJIwj9P6oZ9lJySyseh22cVumWMs2RiU/vf5mShE6PCdy/xW1i0xiJpy
	2NOFuFvvP8OhrNEuma6AfJyV6shdpl6hTivkM9qks5xF+J5udBwLXFQNMzBmcJud8a/kQvX8kRo
	pnU64HAZdYoVZSVBXceR+ECIxczLVPB/QFj3UlrwhG8BoIaoe1p
X-Received: by 2002:a17:907:9723:b0:c46:7b40:1af4 with SMTP id a640c23a62f3a-c49bdb636acmr244406066b.6.1793204944003;
        Wed, 28 Oct 2026 09:29:04 -0700 (PDT)
X-Received: by 2002:a17:907:9723:b0:c46:7b40:1af4 with SMTP id a640c23a62f3a-c49bdb636acmr244405366b.6.1793204943648;
        Wed, 28 Oct 2026 09:29:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a53bdcdcsm305467666b.53.2026.10.28.09.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:29:03 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ceph: write back only the dirty bytes of a lazy I/O write
Date: Wed, 28 Oct 2026 16:29:01 +0000
Message-Id: <179320481135.91990.18372101872369607474.ceph-lazyio-v3-nack@redhat.com>
In-Reply-To: <20261027-b4-wip-ceph-lazyio-fix-v3-3-df2926c30867@clyso.com>
References: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com> <20261027-b4-wip-ceph-lazyio-fix-v3-3-df2926c30867@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK for v3 as it stands. Patch 3 still has a lost-write race, and its
partial writeback can leave stale FS-Cache data readable.

The pin check protects a pin that remains held through the check, but
there is a release window. A process_vm_writev() pin can survive an
initial writeback that cleans and write-protects the shared PTE. After a
later lazy pwrite() marks the folio dirty, the pin holder can finish its
copy outside the pwrite range and unpin before ceph_folio_note_write().
unpin_user_pages_dirty_lock() sees the folio already dirty and skips both
locking and re-dirtying it. The pin check then sees no pin and records
only the pwrite range. The pinned copy uses a kernel mapping, so it does
not dirty the already-clean userspace PTE. With no later store through
the shared mapping, the next writeback need not widen the range, and a
successful fsync can omit the completed process_vm_writev() bytes.

With lazyio,fsc and a populated active cache extent, an overwrite at page
offset +1 passes that unaligned start to FS-Cache. CacheFiles rejects it
with -ENOBUFS before updating the extent, and
ceph_fscache_write_terminated() explicitly ignores that error. OSD
writeback can succeed while the old cache data survives. With CACHE
retained, evicting the clean folio and reading again on the same open fd
can return the old byte. Marking the cache object LOCAL_WRITE does not
invalidate its active data. The rejected update needs to leave the old
extent unreadable, without widening the OSD write to stale neighbours.

These findings are from source inspection, not runtime reproductions.
Could you address them in v4?

-- 
Alex Markuze

