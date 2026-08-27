Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E763DC4D3
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822892; cv=none; b=Iw6eqruwAsGxhLBxvq7hXeod5hI8dIIXtANBN8wmK1Fwo/y2Ep3MJwjGIft2G2rnyEJK5UCGQXieqH4HrcKSYhh3eVZIS08xIqlXIpg3K3VTRBSir4O3IwB/uDVLOrNxwA5oN0xBbQSFep+ABueaKNMgSQvVlJRP+y7lfrM9fsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822892; c=relaxed/simple;
	bh=Xd815Kj2x277WhPneD9EAQa/Z863tOkVJSt5EwaET6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TEjGTpeLprv4qg75RVwgZS7DQKimrNEHM4MsJqC4bOY7/Eob0TsHlNFh0CwjxuSAFiAMwttYevJnhwmIZMzBZk7YSNZXIxJAsF0GxncvMWF+Gs29FWsr02MMphnu9lhTxlpTnpPa6xueFRQTDzCtd2TK8WRPnng6ptx3M+bDhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1DMraSI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPVWfhe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1DMraSI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPVWfhe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787822890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrwc6Xz/CYbvmM6conJxWTpLEHu422zwPyrxjXifxaA=;
	b=C1DMraSIfe7/szoqhNzXo5UavhA643+9eGJd93MoUbMtQFuusRvBtK9AJ/yiAqXSvi6biw
	UZ2btpIyGcUN0aokO3zbMQhlrcK8/L1xfqalmnoyX7EtFa8S9A+JFM8rX3Cnjps74GclLR
	4bmegxFLh9UFnQ79UzuGpUzkhY2H7Lk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-xWRw8O5nNIWxlcYB0tdihg-1; Thu, 27 Aug 2026 05:28:08 -0400
X-MC-Unique: xWRw8O5nNIWxlcYB0tdihg-1
X-Mimecast-MFC-AGG-ID: xWRw8O5nNIWxlcYB0tdihg_1787822887
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so3636927a91.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787822887; x=1788427687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrwc6Xz/CYbvmM6conJxWTpLEHu422zwPyrxjXifxaA=;
        b=gPVWfhe8QM1lQsZ2T06Ph0f+fC0sW3/4x7ELsU6/zZLcT0y7ap1KBi45pu3cTctavA
         F0BtaAMfgp6LHuIVnxiCSVwBo9kC2Dp8JPa3AIvsOn2t7dlnZ4U4QHl4x67UcheQEqEN
         S+aVqxVyhhU0/+7o6sY6IKafl9DBEmBsdv1RKwpp02y+HJUt9IqbvbNjEwmkh0ID98Ki
         ME+I89VVAhjet/AYr/Z6NabdeWcjcpk3agUHwqao9uAHrOFA5ONmxvmHMo7haqOeUexq
         CabkRz51ViWgJdevwg/8Jm4x4gaszWqdVZPl67gwOQxZJ0N3+dJ5+WP7C2RrSe0sl6uW
         ekYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822887; x=1788427687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qrwc6Xz/CYbvmM6conJxWTpLEHu422zwPyrxjXifxaA=;
        b=PGkX+rStEC2f5DcERCPBthnl0drOkADScRlsN/n5GqMx7JQUMEj2k0Mm9V+iccsUIt
         DCEhlShdhik/Xo+izYpk3gyzjRv+3kfWiKg0Z8viUn5j5ytPDTygukxTmZXfLiTLBSYY
         XajOg0sZX10o+4UMXHa8KGT7UwtquibgLciKnzQAABk9Xa9rldYUGScuAYroge5dF+Z3
         BlflWETp237uy0pfa1Xc4N8gXM2BqEcCqlE6kikCONJnP8LYYIpWkmMkXYE4LVxM3VMf
         P5o9Lb36sx764/0suCPOIlafKg3AdHW1d0Ttc7UQ+amtagqNSUMLP2+NhNUG/Fk6DSuz
         firA==
X-Gm-Message-State: AFuF++lBRYdv7EFyNwgRZ4jY7sd5pRg6IQS+f0jA0xwZd3Z5xU4ve9Om
	gKsaM4YMFyJkC/ozoOVvV1+dddJktueoT5KCQg2wR77ggnFCxneE0C2YH3ilbJzUPTg2PVWV3XU
	mY1rPVn5+GpwGUWtSTHDAj7zVig5v8VS+fYqdVStC0PItB17JppOx+YchNsT5OYojLL4olysd6A
	==
X-Gm-Gg: AR+sD130UDEDBMdvBEW6cp9FIOh42u/SA1nUy62COz0Ci9jLrRFy2boJNYHZnqEaN8g
	Zqpf5629oD5+LI0Ze5ZNUlIlm4OaZqXyd3SK3f962Sk4mdEbnvj4oZvuj7hCFJDzDY1sWyx1veO
	OgD0MrM2wL7dlXFKxsrL8iCPCixX+P53iO0BpMnKXnhkV6gl9j0k6nKqLd8BXAHH0hFQdJW5roV
	fI5N9QjPnAdjlJJwcgxBMte+eq246HsHN509TSfhZ85N24CRecV+TBRimZKcQA9DvZ55dKVpdqL
	gTU5r02Bn8PWPo8CKsoFLVVZwOMaRSoI8bnCxNcs0LUv9FnN0gqVd01dBZd8K0lZtCz9Lg==
X-Received: by 2002:a17:90b:54cb:b0:380:f389:447b with SMTP id 98e67ed59e1d1-3966d40becdmr29145823a91.11.1787822887059;
        Thu, 27 Aug 2026 02:28:07 -0700 (PDT)
X-Received: by 2002:a17:90b:54cb:b0:380:f389:447b with SMTP id 98e67ed59e1d1-3966d40becdmr29145737a91.11.1787822886586;
        Thu, 27 Aug 2026 02:28:06 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm13829081c88.10.2026.08.27.02.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:28:05 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2,0/2] ceph: keep the inode, not the name, when a dentry lease expires
Date: Thu, 27 Aug 2026 09:27:58 +0000
Message-Id: <20260827092758.2741748-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825-b4-b4-ceph-dentry-caps-v2-0-41201d7a4868@clyso.com>
References: <20260825-b4-b4-ceph-dentry-caps-v2-0-41201d7a4868@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please send a v3.

  1. fs/ceph/inode.c:828: Missing fscrypt eviction in the new ->drop_inode() path
     Xiubo, `ceph_drop_inode()` can now return 0, but it never asks
     `fscrypt_drop_inode()`.
     After `inode_generic_drop()`, call `fscrypt_drop_inode(inode)` the
     same way ext4, f2fs, and ubifs do.

-- 
Alex Markuze

