Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A43815D4
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845658; cv=none; b=aTfX3q886T2vF+3VlGMRX3/arFyW6EguSnH8Ei2ITU1StI8zJI+QcOAQM/+S0s4loiraF2xna5eD+TteunQioHDBEotm/39pidKTnJa24/M3J2ItGQsf8mmvQcSki1fl7vAl5vdDyWuYLbTtEDC7Xd2N9eUpeH9pTawlWHIK6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845658; c=relaxed/simple;
	bh=Z6ZGoyHb9NmXVLosRz1dxCUx9e6dCtP4ashWrhBPdwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZC+TOnmRRblNV3KCNG79X0dxq9AJOe5tD80BopxhlqRfxFjgYSi9kOslcpZZiFwuMcrVvtXXfiL8i0Fof/nNnFfD/W0TPmxWISkhvS6NL9VifbghnK1vFC0KFKGH+lrSUcS/NG87v9BiIziSexn9xYe2db0JYHnO5AaUEg0AMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMu8eaBJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVhSmeWw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMu8eaBJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVhSmeWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782845655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWynFfWgu63wPzD8GyaDn2aiG9V3Nxp1KOTWSuMm4uQ=;
	b=eMu8eaBJNGkQgDC08fVp3YeJmz5gOuaJZPb0nBFQ3wTn8ezNGKgNeNUlvyuPqENlSgAnTM
	8SxPtyYYIUw7Ij/brWp8eOerPItCkBqm/ZjQgkcXUi0Pl4kbYOSyP6gd+Y8I80X20MYf+X
	Fvk+Y4mI0ihMzRuYewIZOQNTBDhoXWg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-cDFxJDPnPWyYEjav6w7btg-1; Tue, 30 Jun 2026 14:54:14 -0400
X-MC-Unique: cDFxJDPnPWyYEjav6w7btg-1
X-Mimecast-MFC-AGG-ID: cDFxJDPnPWyYEjav6w7btg_1782845653
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-698883d0621so351504a12.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782845653; x=1783450453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWynFfWgu63wPzD8GyaDn2aiG9V3Nxp1KOTWSuMm4uQ=;
        b=aVhSmeWw+l1LSdCou3NK6q9JrjCrfkpZFrolzvv15DeKJuuCbFVnSRAzzVTUA19zVS
         aDb91xcPXSCn/Y5gIEYBcq1Z1XVEiuJ5DJFdWTeXoRpbKD3+eymU4gR/neOyq4sAX5GK
         MjiDJCHPwhG69zW9qYxAncADozFSH/ovqtZj1CbP6S8IvIs4HtAOm9xnuBXgH5r3JGTn
         qIMlAdISE8tHKIPN7FAWRaScDNEW48LNVOW0Nwck3s6SW+mryvEdeDlYOJj1kn0UhB5f
         WPc67OCt+A8Wbgt03OK8ffREhr2wv9FKIk1TPeUWgg8CBLtW6vIHwnjoarqZk70CR3IX
         +Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845653; x=1783450453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWynFfWgu63wPzD8GyaDn2aiG9V3Nxp1KOTWSuMm4uQ=;
        b=JwJoKA7T9S4RXmMFp79gfoR1IksU73ClEP8/IFGQ7JvD15wU51cziIUjo4Powjp896
         ie3ahx1npKCjwBOORwcxlgyLOc1eUoBronf6g9eSo4cE2Xzritr+fjQOS/A+/hidUxzY
         dvqWZmgbM7cFmZcfBhIpoomp9uMlzhWqyjZaSso5WXmbW/mexdc5vG5O+jgoxeDfEsRl
         02lyOP6qv0wBzcdCSb0mzv4e2Q5K2pJ9J9lGA0oxYs8wYkhSjdMwyPEv+itMhnLQz61f
         8Kct4lkAvJ+F3d3lf8vc8q6XtFyWHLOwKzq/uABv6vDkCbeKSvitiqxJMpZen/WVTne2
         bGrA==
X-Gm-Message-State: AOJu0Yyi3osKf3SsyJub5PViGmQBLLKr2TkJRjXwMAOwXx+EHoKVN1C0
	Z4X31uyH4NBPRSZuZNBUcKhGoG+abb8KjvO2lJcwZaH+mX4nnlECWirYW/7Iu+KxL5/97hVjtQQ
	PK7PHOq/+Irw6/3pl1QDsNph3ZXQq6jW6Ju8w2ONrV61JcK6wYAjhHCE0KvyUm8b10so6XAkN7g
	==
X-Gm-Gg: AfdE7clnzZ3K3roQg82Dq68ULje+i0SsfHcQFJwiUFx77VVugxhj8LrhWn4St13IUjB
	C1WRe6dD5BYkgEQn4DJe/16MgPN/a+8xTsG6fpFgiwdmvLEpBy+sprbohQholji1d0dWeH1rhKU
	tGckXdovXvcZYCLFVxazuCYsDozDgEZxS21yPR3pxSPihGi7JelCNxjAVk/0T6wZH0oDcl8csUf
	tmL+4OVVpxrd2dRpJ3rLV9tRZT86ej+8jho9o4eoyWchofevzfufsTwAxWETdMMHDIzFYKHyY6N
	thLSQBHF69jHaBtByDe0aZibJ9O9vaKrzzQsdh0Aon+ZEWv00RInqODvw4C+Ap7NGd1BPaMuxXp
	aJkKyEFS4SpJ312qGKdDfCgvPHDq7ZeMOm7GBA+JdGPeY
X-Received: by 2002:a05:6402:4029:b0:698:3b7c:7e2a with SMTP id 4fb4d7f45d1cf-69887887c1emr1145455a12.34.1782845652991;
        Tue, 30 Jun 2026 11:54:12 -0700 (PDT)
X-Received: by 2002:a05:6402:4029:b0:698:3b7c:7e2a with SMTP id 4fb4d7f45d1cf-69887887c1emr1145445a12.34.1782845652709;
        Tue, 30 Jun 2026 11:54:12 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c968849sm1544582a12.27.2026.06.30.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:54:11 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: use fscrypt_finalize_bounce_page() for cleanup
Date: Tue, 30 Jun 2026 18:54:09 +0000
Message-Id: <20260630185409.458992-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616110543.3188181-1-chao@kernel.org>
References: <20260616110543.3188181-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chao,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

