Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815947;
	b=dCZcHGxxYSzwCUFOa3hj71IJuLaVsljhmiKrPqSKSMaFtYxPFyC4hfeLtv1UpViiROeG
	 IaMKf5/k386l1qPxSHtl7UQr+Eadj0/GD4QZFY13UhZSAhlXfN0aCq1SQGNvHcpW8LJZg
	 TINJQ6ha4eSVEExuIFnIhBPWWUdAnxoyR5ta8hzax2iGaivKq8uCyLAl2+WIVlUKTJIPm
	 2e5x5vnr9KCVgI9HL0PmYXAtL7eOsGPA3jXeYOE1IbD0GtnrfrJ86Ys+jEBfp4vIjkWpb
	 4c9oR/1n0yA2siSUYivyPTbT5i+mmKQvLlKYh86EF/X6RKFrN0+HuhiR8vgAg6QNMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815947;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LsP3QJmfoaqcwGcAYnJTpAKS0D0QdAt9aeuo0QSRyf4=;
	b=gvw+3Ah6yL/RJ+YGYoIerSf4wh8qu8pLX66dS3uzZ8MHOmcpY0REOOHgvQoJR8Er15KV
	 13qV5FEmu0f3NcMTLF6iPfHKoa9eadMMAEXMeT1vh+69E9zAPGGajsK3R47QPke9/C/NQ
	 OLZiSLMVS3N2WpjoP+pRdCyJ4eCsg7UupLL+arU0BkNKG8HDdn3btzNUShhWCJ3g5CPdp
	 eznjv8LNCo/DkMv86dw/FNpZymXEmL50QXOFAa1OfzfSHIJxzmfEZJI6dqigmneWfYBWU
	 dZulbciS1wI2SEjE5/gxErbBa1Ya4l6y1SxqYBrLF5HTeGYVjYBm4ze8/vbf+xnNGbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHPd5Q3n;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kouarHxN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD6606A337
	for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2026 07:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BABD6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHPd5Q3n;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kouarHxN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794815945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LsP3QJmfoaqcwGcAYnJTpAKS0D0QdAt9aeuo0QSRyf4=;
	b=BHPd5Q3npcCNOB7wWV3tAdARC70IxtJDgtr/1hA6owKuSPlnoejLIXk1z5VPI0nT00fQom
	jIzB/sNt/Cw+dsU5bW8H+W6WETFjtVK9rHsbP3+CYqvksnedmm7m9NS7NBPHYsgNtvbu6H
	uDy6+yLk5zQycsDAnaVu0wDvrBEGpIE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-9R9JwbqiNICAgwKLQhSnFQ-1; Mon, 16 Nov 2026 02:59:03 -0500
X-MC-Unique: 9R9JwbqiNICAgwKLQhSnFQ-1
X-Mimecast-MFC-AGG-ID: 9R9JwbqiNICAgwKLQhSnFQ_1794815942
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b56a350f2aso3629258a12.3
        for <ceph-devel@vger.kernel.org>; Sun, 15 Nov 2026 23:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794815942; x=1795420742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsP3QJmfoaqcwGcAYnJTpAKS0D0QdAt9aeuo0QSRyf4=;
        b=kouarHxNrYC6MFNIdiGUuOQ6rOzfHf6BKx+EvW3UNylypU2ke0ulSARrudKnEjP4Ly
         U2V1NwXVydirb0nLslRxVbKJ932nElVAKNZGPJT1T8ZAe10OtlVPRPInhmKJgcUaGjJM
         VYg6UKLYTQBS5rL69dVSlagLSttggLBdb5Xa3NjCFOOf6JpNhH7rhDnNWlYUeZ6Hljmp
         Ptj5RCjLdN6Xuul2vUrGxT37yn+2B46VyN4H/UIa84f33oXVXrSuEcdxoyqsYyelOMK6
         Mg+N9cLYvhlOV64u/60hAcf+wnECF3Qnq8FQCjf1tGjpym9c5wKq/GEmzEyrl9X7IDBJ
         T8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815942; x=1795420742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsP3QJmfoaqcwGcAYnJTpAKS0D0QdAt9aeuo0QSRyf4=;
        b=cfTGfVKyUHBYZ7yOogmMMQag78qjaDhYvV/GdUtUMUo5vHJ5sHFR5kGPu8/d4IZxLN
         ErFf9cn18s59017S0gyNiRfDNVbb6igjlMtqJadmayp/sILcp8jqHvyYF3bpHCf2ieae
         rMX3fCSe8/n1ZqCZFIkkoyDWAfLTvJnR/gS+Jfg9bFn3MKN4WR2dF/kwwUB/c2fBncvl
         kck7JDnIXlPzeanD9zLmtGpjGPMDFqYXDvq5dgXn0o9DkOoh5jZQNzMge7qk2EM+W85k
         kBY7WQUAEN4vseH/cTpLNllLp+rz5n+g3/gPv8GDf7TOs87KTLterhvr9Z3tH5DbGwVz
         Av+A==
X-Forwarded-Encrypted: i=1; AL+hErFuLubCxc7WyFKf/oIyvrly2UHdXI5X37HRK7jai1EjjC0iox9CllfcB0VQ9xx76HoDqpyDzMlaZcmK@vger.kernel.org
X-Gm-Message-State: APuU4Z/JHNGpw8Amo2bnkWSKQOBYotWce83Xl6D1Jzj9mGZcheIZmd5s
	swEcANwfC9vnfzF6S0geXzXdLwCo7Jlpv6sWjmd1iZmm5cta0zQ01pjgN2b6wtpd4WGEj4mrm+v
	qdqKAnmBJkSzOFlyXTlS90O4MIuGfme0/HUxcWFd1ycS+nRwn6wktbf8dDfi53vo=
X-Gm-Gg: AYBFou2wVcOa53gOMUQhuBF6Su1KCJtv/rsDpFJ7oiRxI6rp3PC6xJrOluqXQSrJMqH
	yUu7J2apWyWBUx+ulo7vLrtgNwC/sGGQu3/8bKZWE+qR2++xucO2bXziVhZykZgdwrb/IuGmymA
	n+qTN5++zbSWDtl+z1Gowk+aJcTBIBErSdXOqZPcbeOQxlJCMYongPhtuSA1or2rVIOuXHcLEMx
	1F8v7v9tuAPOkobWxZDea46Tr+hexn0CXO5c+CZptuSb0aqg9vYwxHxT68RnnGb/FKDIcVGH+u5
	SABaR9wfk9uSDMrQuapE/oBBXw0w8UhmLxEoZuB9F5xTMBRN+PfbAtavo7hduY3pqlK61yLa6CV
	tgUY6cbygsmYOF5PwRzu924vjidU4OzngWNxtOKuEb0IsH6zapD0ze3pt2auSs9b7FqD6wIey1V
	pU2m/x6sd5hl2rPcDXWYjLI7aFak5GDmVPFGs87CxcAUvsri0Cl6xycBozr/REAGFTPk+BHt7Y+
	ubdGOn/XbkjQ5uy9IZPM/sT4LEuZChQy7HR7/Dj3wbpam5sKBga
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id 4fb4d7f45d1cf-6b7c0957c1emr5068824a12.10.1794815942560;
        Sun, 15 Nov 2026 23:59:02 -0800 (PST)
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id 4fb4d7f45d1cf-6b7c0957c1emr5068815a12.10.1794815942154;
        Sun, 15 Nov 2026 23:59:02 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23c35easm4190019a12.14.2026.11.15.23.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:59:01 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: zhangdaolong <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH] libceph: fix 32-bit object_base overflow in ceph_osdc_new_request()
Date: Mon, 16 Nov 2026 07:59:00 +0000
Message-Id: <20261116075900.4134259-1-amarkuze@redhat.com>
In-Reply-To: <1794810212.6AFAA164.001.4jSd904hpVz22V1@fangwg01>
References: <1794810212.6AFAA164.001.4jSd904hpVz22V1@fangwg01>
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

Hi,

object_base is the file offset where the object starts. 864e9197f10c
narrowed it from u64 to u32, so an offset at or above 4 GiB wraps
before the truncate_size adjustment. Restoring u64 is the right fix.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

Thanks,
Alex

