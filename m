Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF994A43E6
	for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470957; cv=none; b=o9ORHY7k8ViHAudstol68SH+D7r/SOSfkDRNf3sDGvuqCvJu2HoUUAxvnKyblxqs2zl980dtQWxZPySL8OoKr39yFfOezvz5RDi1mjwwIPJD1xOISSPMxCsh4LTn/d7ZFLugDc9WVNK8cxwIRymnTEk90CBpj9QtzdCwc4JCNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470957; c=relaxed/simple;
	bh=pDG+LUYfWE/lg9GV3EwC7bNAC2luO8YmosElSYurcVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQI4g9ORqZXpPuBFlmDbTHJDnkNO6q8jTE6YZtNjQJxWXgAjVoFcqmty2IF0ipWFbEZuZG4Bet6xUgMIMsNht3gDY9qJrgySwuHyKpFqvgY/n9VWqCXLsb6BWbo4laoEK+eXtN8QzS3A5DMsjOSRBPvTagF3PUdQ81gYbhGZ1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDLT64d7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pJQAfl/v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDLT64d7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pJQAfl/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789470953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
	b=QDLT64d7K6vCAKE9IpNvf1e3xjqf49KfZrXeZut0gIohkTKaz9edyVSu7R1A7kktX+c/tJ
	vVKZ2aJvhN0sMbE+H+P2ub+XPU4Cm8VDtsfLCkXrvW0UKOrPIe2OV42jaXYy/D72ag6udp
	P1kb5dX6xcQid4jI3Hx5EQPaq08YALo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-OqjR4i_FOEeOrp09ROgowQ-1; Tue, 15 Sep 2026 07:15:50 -0400
X-MC-Unique: OqjR4i_FOEeOrp09ROgowQ-1
X-Mimecast-MFC-AGG-ID: OqjR4i_FOEeOrp09ROgowQ_1789470949
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a9b7c7f405so4420281a12.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789470949; x=1790075749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=pJQAfl/vWWBqTkrfVrUMJCVIAdH2sn1sts8EtEceg+bUnmIy7GJ6Vj7bubX3lJdgFl
         gf4YR9kKesSWQjWafJtdR2FolAb68XG7I9p9K0tdh9FdU3W5aWOScDK/mhgR3dMDDglu
         9glD2N08WY8ef0lg8hL+74rePeci9ssybDPrLZi2pzHEWaRvM9TKAyHKZpWCn5q7fu59
         wgHXMxVWGGZScrVimIr8SCmTChRJMb+tw7cuG1+m5E6y+LZ+JS6pJzcuDLCUZEq78k55
         9qiXBYHQhgUkJR929YOcfn7y3spwpykvpSugevGtzoIsNMoouH3CI2kUaAg9hBURuZLz
         lnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470949; x=1790075749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=cTu+jjZUiokWJJwQNOUUTjDaciPfyOqNF1OQiRGlIlulbQiayTJ1uMxrVO05cVASyw
         0yX0jUeVl+K1BndZ64slKvQ3+C1gHx5ceNQGt8jg8XvVITirRh2zKq3t4uohb3DS+6oX
         jMFGEXkq/SG4y1L0EbObFX/c1utfBllaFnL8qJIIXanPcdLt3HupBWAwRtTF7RwhSIRA
         fDSqLy+uw8bp1994uIhBu1tF2zLbKE10YjWJ5O+CB3Kb7rrHKe6AdVxmzhyVjK2pigBw
         oPJA3xGVXXxdQ+unSDRSu28bX/CfPJgzwJlVxgtsSjsVNgfJAvAWNJ9EuRkAHNtj+iDC
         LJ8w==
X-Gm-Message-State: AFuF++nRj1vf0E7oUuK357aZpEACjPVO2A18Ryes5z61PZLcNapMQPPV
	CrMrrsQeQvHOmZz7lF6Hhbru4zUzlm9qQxZC3r0HqLqBWMdiaiT8LE/9pn10oPMESzSg9pXAhi6
	QIHFItw9aKrPh9zZqTyNR5vEiBt0G0TrfA5tlNI3DmpMC92xok72KWyHX+bxgYHrvtV8x/i1pjw
	==
X-Gm-Gg: AYBFou36OM99RiUto6iSuVFFKfIrEZMfGD0RV5Me5P6lQE5Kd3MxZJFJMKIbiH3EF4F
	e4xqEliYSnz20fpTzc3o4qsNj8kH/W8ztTtJtuMHabhMxuZUXSeFaE4YNWYoFDwFMZQ1m1zLgou
	9YlXBvaLTthZ/XRKQasDlYJrmJAusyUCgNMCjQDFJofuW6V2SZvvN1sJhL8mEiiiRljoaQZTmHj
	GxNFIFk5NiokBdGs8hyCe3rvDKQHVY7f8ylzqTMKnd9tfOGk6sit88PAC9MTOeXz3UGtbQNwqKQ
	3Lw11uGaA61T0X150N1o8DbO9Ns3IBu2lU2RkTCN1uczMJ+/LyHemyM86MQeZHnfhxmiQpEuH3q
	ydQBep+GV6n194D3PkA152A8ogZSxjh9nvWIhaYclQ4M9QJRNnOOJyU95C8bxa7lhzwUUAR4OSK
	nVGBdeMMErkp56SQ==
X-Received: by 2002:a05:6402:280a:b0:6a9:946a:d085 with SMTP id 4fb4d7f45d1cf-6aa12b70107mr498157a12.19.1789470949397;
        Tue, 15 Sep 2026 04:15:49 -0700 (PDT)
X-Received: by 2002:a05:6402:280a:b0:6a9:946a:d085 with SMTP id 4fb4d7f45d1cf-6aa12b70107mr498122a12.19.1789470948585;
        Tue, 15 Sep 2026 04:15:48 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b592470asm5515068a12.17.2026.09.15.04.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:15:48 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: fix off-by-one NUL termination in decode_encrypted_symlink()
Date: Tue, 15 Sep 2026 11:15:46 +0000
Message-Id: <20260915111546.233079-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915044302.711802-1-xmei5@asu.edu>
References: <20260915044302.711802-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiang,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

