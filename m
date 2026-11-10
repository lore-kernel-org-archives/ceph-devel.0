Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309369;
	b=tRGBV7M60ohZHkz6i+0XZVBqxZqkjBgT96WE/Abzx0rjw3Uo7/O7gih5WK4OXfxA7sE/
	 ME+0oYZJDuFjvZwtdd5I1lZaffMzxEIrPLFTOIxxyfkbxCsbm0Zjb+AD01NK9IMNcEnst
	 tKTl4092FR3CC/iCXmZ1ufbI60ycsrLb0YZbriVcQhiUbLUSfP/FkFQ4ssvh/qDe29Az8
	 inuuHbU1IFrH1YM6PGBDCVPqJivDYFY8HlABfx93XsqnHKaHrcpPUXzBeAzGI7XfNNLw0
	 2tj9pSNVMubo6PJdXnIesQhkCeZI66MHW9Rkd9JqbyTVwvGu8d1Mdil5EmxRHeNFqGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309369;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+kw+vTWjaE8NYlNHDFWxbSfypN+V7fDlsKDI7JVen4o=;
	b=ejBCTGEKu4rbVhIXLsOlJ1pw8gITVKeaVtYlDwMm94EDf2lZjqTMGgGGbAgrFKsSRCx6
	 2aA9/sjIVYkQGFjAs/Uf2MfvgxkufLSOP+oXrHP8Rnf2tauG7jHGeOurdVM7bxdpiTCbG
	 qGEvWtUUJPAByND5WfD9uWieHB0/IMGlboeMCWDQDbBnj+k2Ayed/1Xp9adUg15Y08/sz
	 0P92yvJLeC+WrIHBXlMbfLVGeXi5pyJWG3dii0P0DM9gZdN2IylKwAmiCOmxFIwPRgZji
	 z3xwRs4C1yv4kOB01vEZNzYF/aacKNgfYbHmpREyITUC3yGkP+HbNDKj1usGnj7Z55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bCPtvpcx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DqAA6goy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53A606A325
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 11:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB53A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bCPtvpcx;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DqAA6goy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794309367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kw+vTWjaE8NYlNHDFWxbSfypN+V7fDlsKDI7JVen4o=;
	b=bCPtvpcxXo70M+oFAPZ9Hgst8su9JsHpd+eaafcApaWU/4awpPo48z+1sTvDK782V4GbTL
	LoImoTYtvXptrxnzWQhkZl2NcL/lRWCI/kbrWdW/OH8GE/yDa30HpGFmy08sN9mFgZSDLz
	T0td4sNdha+CWM9B/nQcdDsBnDvITHk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-AxYH9BxKMta-HykpbL98pA-1; Tue, 10 Nov 2026 06:16:06 -0500
X-MC-Unique: AxYH9BxKMta-HykpbL98pA-1
X-Mimecast-MFC-AGG-ID: AxYH9BxKMta-HykpbL98pA_1794309365
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c465c4c8da0so216510766b.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794309365; x=1794914165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+kw+vTWjaE8NYlNHDFWxbSfypN+V7fDlsKDI7JVen4o=;
        b=DqAA6goyIS4XkKpJi+4dTvNCIHuO1f4lRY9cEAIDh7Xo+EQq/wb35RW8+jc/1CPjvm
         yYH+D7BIu/DC1ZFPDWpJ9ICcwwmdRnkIuJMw1AbKD8hKMXkJZE6TW2nBYWFUqolvCEx/
         pGnzQ6qDn47mcVmyLcxYqBRMlgyeDSaQ80mxrJPjF2cyhHeIaql2qmVfPCeIW0pP2dHn
         X3nRWbMbJcLK52Tn0MguZkDFOXJ7xYop7znGWItqkbPzKW4QBm093rNKzZICtsSxzNiF
         gz/Va6I/lvfCtz57/SeALj3Wvq6JvMYm9cjlJ8QGlGvJvCKy7pGDUn4IRONDJm8hrvcN
         heQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309365; x=1794914165;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kw+vTWjaE8NYlNHDFWxbSfypN+V7fDlsKDI7JVen4o=;
        b=CvtShnDDsjV5lB9McOE3Tt1JRemgoJ0Dsf2IFgy+grz4XNoIONYeSY1APgXyyuK+Xe
         /2nir4oj4co8uwmZPYmIrBIPVAsCELq01dDWm9Gz5brMKdLqt06nvs6Riynm3E8ji08S
         W8DUMs/wLpAdkw/Yhtvrtjxh6wA/uh1vXDY218UVCRvD2NXe63cr3/dKU1XaIXvuCxSP
         psqS594Otp++0amBMPnd/n20esyOxgc+xR/VB11w92UjNE+iuQRig9FZKfTIbz+NuRxn
         Fg8Wjj794l/o8PaovYz/dcGJD6vex/u02frx/IL6kOBInQyQ+KS14q7ofUl3eI94fSWg
         QDew==
X-Gm-Message-State: APuU4Z9Z5C4CKfwSaImGNA75zw+vSnc2xrKgGD+09OhMry86uAORicKM
	TMLlch0Suukkb1wBN7d9uSLHGYZn4/gULqBifRied96VoiCiUy5GbgT70NGf9gKCpzmk/eD/vRD
	NpKY2kUg7OSW5HLwmVv9e3liXLNTyvcn49ctrpwpyL7rrT0J8Py3isDBx/FEm7V8=
X-Gm-Gg: AYBFou10bNFw1Ow9ZrA730yVXPFPBVgxF+665eLZETotq49gc44VnTc/KN5CnrxoHIn
	+r24d3AruQDZ3egYAs8aMDpIhxkDAzu0f+xpCGANbbpRWI3i6YDstZfR5BxTP2fYkM4PPSXk6+E
	6erzGzAXy1VNsFsAAxl0ndoKk92tLqqIArHBq3ct7GsoxbNvklkosAkiIPMuIl3xYxMjzFiP0rL
	jkfIG0On4hsgDEoXJwlTiP8ChXEa3Bo81+i5oFgqhaeLGF6Ff50IDlmi0JmpXB+SKaS5Kqsm+hZ
	jJWiUEaoQQA/5+FBKfsn1YQGFvS400JdvSAk2H70DCTgTQKZDSIsgf3xUsnvOUnG7aqTpFW+UNx
	+srNezGmg7/483ZweUtOjOliNo/0P7iGoLPNLnfUzImhg9hfOL3HAK814gMlfqPRl09TGxSFPf4
	Sdb2mjHuFMZJ/4xKO/oqlsc8MAriRxy8wLH4NeWajn8ljwH9CLaT6Fd18YPMuOwB2VeGMWNjS7M
	6h6Ce0g9iXl6uV6ItaoAluti+QU9thyy2xoi/k2+fY7NPLTuJVR
X-Received: by 2002:a17:906:ef0b:b0:c42:4750:8d33 with SMTP id a640c23a62f3a-c50495cbc4amr193273066b.28.1794309364749;
        Tue, 10 Nov 2026 03:16:04 -0800 (PST)
X-Received: by 2002:a17:906:ef0b:b0:c42:4750:8d33 with SMTP id a640c23a62f3a-c50495cbc4amr193270866b.28.1794309364372;
        Tue, 10 Nov 2026 03:16:04 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a5b6asm99739866b.11.2026.11.10.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:16:03 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] ceph: lazy I/O write and LAZYIO revoke fixes
Date: Tue, 10 Nov 2026 11:16:02 +0000
Message-Id: <179430930932.3260974.10127961697716262149.ceph-lazyio-noread-nack@redhat.com>
In-Reply-To: <20261107-ceph-lazyio-noread-v1-0-d04369c70ab7@clyso.com>
References: <20261107-ceph-lazyio-noread-v1-0-d04369c70ab7@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiubo,

I can't give the series a Reviewed-by yet. In 1/2, two paths through
ceph_write_end() in fs/ceph/addr.c can corrupt data:

1. With encryption and fscache disabled, pwrite() 16 bytes at offset 128
   of an existing, uncached 4 KiB page through a lazy descriptor. While
   ceph_write_begin_noread() holds the new order-0 folio locked, concurrent
   mmap faults waiting on that lock can retain 1024 ordinary references.
   That makes folio_maybe_dma_pinned() return a false positive, without
   any GUP pin. ceph_write_end() then sets lazy=false and skips installing
   the dirty range, but leaves the folio not uptodate. The warning does
   not stop the write.

   ceph_folio_dirty_range() treats the missing range as whole-folio dirty,
   so ceph_writepages_start() sends unread bytes outside [128,144) to the
   OSD, overwriting existing file data after a successful partial write.
   The old read-before-write path made those bytes valid.

2. First leave [100,200) dirty and not uptodate with a successful lazy
   write inside an existing page. Then pwritev() 100 bytes at offset 100,
   with a resident 20-byte first iovec and a valid but nonresident second
   iovec. The atomic copy can replace [100,120) before stopping short.
   ceph_write_end() returns zero without restoring the old dirty bytes.

   If range preallocation fails on the generic retry, the netfs fallback
   flushes the old [100,200) range, including those unaccepted bytes.
   Failure of the subsequent netfs read-request allocation then returns
   -ENOMEM with no bytes reported for the new write, although it has
   already replaced part of the earlier successful write on the OSD.
   Neither user buffer needs to change during the call. On the old
   uptodate folio, the copied prefix was accepted and reported instead.

For clean pages with CACHE still issued on the cap being revoked, 2/2
removes the phantom LAZYIO use as intended. But 1/2 needs to preserve byte
validity and short-copy accounting before the series can go in.

Thanks,
Alex

