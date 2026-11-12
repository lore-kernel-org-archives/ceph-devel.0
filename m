Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487802;
	b=JS18P0orDh7Jr87pwT/iH8t9brbDTAKUEvnLXJJpnbNATr8lU6vFac6y3EHxPFVXBiGZ
	 R5w9fkeAxbOPX9ysPLlFnHWUf+m0IRwB2ZoMUTS00W0W/OAZ/lGKIGAfZAB4Iwydxj+8h
	 HPQcV6eukoVCbReNIhajDOxmqo6u7xciobRMKmx65cMrQ8XPSWTdP6/vxTfi5uQoJKFP9
	 sA1CPmN9xWSo+hFdyncup1R8Yeyf9vr5/LRMKJ15w9xZ1w7tfv8qShlGpOLWVhrxgIodI
	 HzxamHUVKk1kBTwCr62/OPZcGqheKOlQAjL0hinG9Fmm8MTnd/wi4jflGVBy8GhG0YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487802;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Db2RZB2V+beVTyA6lzdWJLAdwOHFnWT6eleJgNgBec0=;
	b=14NH/W+ihveLfvE7f4iC8O3rTXQl9Ar9L8MBFQCLjMyXs/bY4iol4wO2QW+jzsbeTMfe
	 sTupVyT5qrwMsO410d08cmpC7a7tK8vvTJx+QC7hHC5r7VFzYIGKHyhSC7V5BCiPDoMNB
	 P6EjqBmHj3ScFhchLneI+lyjzOxVQSUpnXljIe6ZYsglA07w9ct+7ubwCTLOzs8Zva0qe
	 Czn/4u/1s6MVc98fSBz8HRx82EofAIdGttMeK8J5JmyI2ZL7pnxtOLMXCIvxMax1Ra5rJ
	 7MT1wXUKuWZ38RTrm2Cy3tzOC2SfM6O44T/ivTyDoLyVZ3wgh7WozzqJAhu4B1u8TLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LpSXgoyt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TX8a3KVN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A0606A323
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 12:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B24A0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LpSXgoyt;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TX8a3KVN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794487800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Db2RZB2V+beVTyA6lzdWJLAdwOHFnWT6eleJgNgBec0=;
	b=LpSXgoyt1v1xzwgtiFBo/zpawHCeHDsQkPzipPyThJkmPJTLqMqfUx0m5mH/LqEjyyOfo7
	YBMxo0BtnXKgpX4rcduw3XL0Nir1PHgfy1ImhxmvSxsyAsz7cMnENVdkY4LJNoy8z1Jwo6
	iRBPB68JbEOg/NfJngLHN3AXBLWUoCw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-nP8AjeG8MG6wHIqd1Ej5Fg-1; Thu, 12 Nov 2026 07:49:57 -0500
X-MC-Unique: nP8AjeG8MG6wHIqd1Ej5Fg-1
X-Mimecast-MFC-AGG-ID: nP8AjeG8MG6wHIqd1Ej5Fg_1794487796
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b57668479aso4784545a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 04:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794487796; x=1795092596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Db2RZB2V+beVTyA6lzdWJLAdwOHFnWT6eleJgNgBec0=;
        b=TX8a3KVN6AqCvkbj2XOukrqlRdTDkPZkGatLr/rCeAi+q/rfEdokIGS5TuCykEWnvm
         nayfQbeoxZrBkidh+IQnfyTc1dy28klldXmc//ysFlNMqFfwRzGfIezIaEhskMWiZ8uO
         ee5oySeoxgydHcuNzS34aedizCKVUpMqnKtUO2cEhGzHr+q3PXeXOqFEWG8Ub2JEHIfd
         uDzyURKibX7LoYENMlGtkSTiNZsoUQ87x36Ty0Z6ofYgwWRrDn/E7Gv0Ak9Fksnkq9s6
         /BTrgdVQMdCllMY/sux+WD3gdBkfUq0hG4mzTGuDZw1IlRz3+Ybqw3JmCUdMwieIBkYy
         qihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487796; x=1795092596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Db2RZB2V+beVTyA6lzdWJLAdwOHFnWT6eleJgNgBec0=;
        b=g9poerdHSXBABoKu37IRjiVtDhWXB1mKMymQz9s2il43GdsEAE9XlP7tD+YqO/bNAK
         4pt5BcYDM74RZWsUq0TBAbFgLnZzMy6tYZBSHjpbZhQ8klH/FWZ33fk0q03uAh5R97ol
         8yCLbJp9Ao7P8XO1hEX86FjzqZBDMrlL9OGb+74Taa/kFWCMFA4xu4xH+CTj+z/tJ3sX
         5lk17pWkBYjdTxjUcYeFhFrq6/h7d/8v6LS4lsEIfzdh4OWGnQLVbJFmEs0T2Eaxs85K
         BCPYi5FYGE5GtWGgYyYMWXVTQCzBXy+MC7cg+Shv2mUPYnlqGZ7xX/eRPZ/LossNSccX
         Af+A==
X-Gm-Message-State: APuU4Z8VNnAcFgaTW4phCfkkp07TLgQSMhTJUcfiTP/K05uUUCMHQbYH
	HfFXwqViU/s7xjHfslWMTR7BK+OKXJ9Z5LenhVYwzXAZBuLZ7VvklR/5+McdysYCFbMmeS2P4hq
	W4vrNALnu9iP/djCZ3Q63okWgK47K7qhSkgRIxBfPKqej6UBMRPXaY3NcxvAj6vwHozQ2MUo=
X-Gm-Gg: AYBFou05WsYD0OjN0ptTXsOCth3kB5bvkYrZppVTQwlU88cm0ZqoWc6fbTfGcaAEs4Q
	plbhXj2+zYgetJJxpSaTd74suB3XVo7jYdGDa3VMX5z00VbBIcf3mGAcfuXGi5pzYDswWKeDwYG
	RoBXWnTvKNtcs3SPbwCrueIcrzz5uAfFk6KlWJGB4aO6J9uOVTARJKNfaNDUbJsq2rJPPPy01uH
	5FyV8x7Ove3jyRiip7b85dkgDsurqXolhmhr2i6w0riAqr8HnTdglBYT/FwKIcZ5YYkavcBw6R3
	3DiRPoLAUT6UuNbB5TUccxLBTqdYwMgstI7mjIk3ssgeSCc2HwurGLCJgR49UFI/MDYt1vQsQYJ
	gA1aFAgjUX/5n7qRwFNEVLbVyh+oYLIhnZlVaX1n4x/8lzIYTf79dmQFUFH6dtqh5ufzfJ5Qr3v
	dvy2l5sBgdK8rep1tSdfYauTENgV+RFLtq57iqnb+N9ViqUG6TGGIqS83ha1bOVNPLMZ5IHyzfu
	vnWlnmnJr2d/NcjnKMcdfdohzWkLZC8PXIbNBy929KOKlwbcjAj
X-Received: by 2002:a05:6402:b88:b0:6b5:8c80:d12d with SMTP id 4fb4d7f45d1cf-6b777813c71mr3060665a12.37.1794487795852;
        Thu, 12 Nov 2026 04:49:55 -0800 (PST)
X-Received: by 2002:a05:6402:b88:b0:6b5:8c80:d12d with SMTP id 4fb4d7f45d1cf-6b777813c71mr3060652a12.37.1794487795545;
        Thu, 12 Nov 2026 04:49:55 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757823743sm3501673a12.5.2026.11.12.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:49:55 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ceph: lazy I/O write and LAZYIO revoke fixes
Date: Thu, 12 Nov 2026 12:49:54 +0000
Message-Id: <20261112124954.3595325-1-amarkuze@redhat.com>
In-Reply-To: <20261110-ceph-lazyio-noread-v2-0-259775214b39@clyso.com>
References: <20261110-ceph-lazyio-noread-v2-0-259775214b39@clyso.com>
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

Thanks for the respin.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

