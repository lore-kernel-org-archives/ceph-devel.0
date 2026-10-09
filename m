Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1144DAF96
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553271; cv=none; b=qRlkCPLTFT0MzF+N0oUq4bB3Hkmwv57RuhUsJTY+mIrrf2/ncVUvmMsq5zKFSpqw2ItTG63E5csmxhG3+kRJwQhAfQSyA0nd0SiydFM059S+piTFlrbNrRbrse98aFliB4+hHplCrxFx5IJpKBs/lHNP/fc3Xd9R8uqr2qYFjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553271; c=relaxed/simple;
	bh=hLVQ1ftq7EVejCnHot1sW/PcbtMmvC6zm8K/x3ZhQa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODeApiRSQJd3cX9PEmqU7tbXsXYFH6BC+HfLSc4U4zuQerinYYy23MIdLGzRAYTHpeozYwjShBVyNmdCF2mqzOIWJK46Ru5AztqLLA0iUJWQtdYdmoSxkqebWub/X50j5hvb2lpQdw9dZzPGc1Cn+vgQZh0T0ELb0mJpsrYBUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzBkxRco; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=biXnsxok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzBkxRco";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="biXnsxok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791553266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=MzBkxRcolo0A1qf3vrN4AhgT4sZM+tNPL+8OfF2qAusCi8pz1YCaDTjT2gEfAppBqMRIev
	F6PdFcpTCL5mFTAmlvxCwLl5zWVyLDTu+NmxbBb3I0iOpEdY9pO8yJLVW+9n6bUHoMcB31
	jHmm4zRKRJz1MTdsQqx2bvJokrNWPmk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-S-aZGm5JP9ieFJsJ9xV3sA-1; Fri, 9 Oct 2026 13:40:58 +0000
X-MC-Unique: S-aZGm5JP9ieFJsJ9xV3sA-1
X-Mimecast-MFC-AGG-ID: S-aZGm5JP9ieFJsJ9xV3sA_1791553258
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2d93b92937so639685566b.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791553258; x=1792158058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=biXnsxokZEIgi9IeG6qSRDyGo2DpjJzhcqTWT89RUlS4F1l9okYh7jhEokk4Edp9/Q
         utaBjJ48pjpD5nsPtaX36Br4KbQnPrPAw5/O7WTmRyBr4EpHAMJZTdFdpIj2pYTNEAOq
         wWEJkp3sUWXFegDfn/FbYDl8qPZXagammajw/W+VuD5aJVhM3O7eT1zLR/7DUn/CyD6a
         CCIeic0ytxvpw4BFLN6WoMBjRPwXbPeLcdXjRsndJ2A0BSR6txbCEisH6xlD8vgUvGP6
         V9CSIopgIuKGWqJaaU3UeUyn/gYym09Kwj0FuPSiUrYWxsQn/7GIfwgBi/+uN9gwbkVC
         fNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553258; x=1792158058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=xmRs/cpfmAfw1mXM23PMpOjO2G0P039emFItM6Kf/bxgREQ37HmY55Ej2qddFFLdqO
         zu5h5y6V431xDVv671/zte3m0KZ7hTOAW6ZX+es1lkrgnrwo9KfQdv9tAwrgCwWKCYDV
         gRP90R/dki4N8NhkR9VWeNrKg6pmWqF82l+D7WK3rdFTfTFMvV5dbCHHr3uNqiqKir0z
         xiA6ti1ukCqjsqyx2BrLgYuXA7ks3uFXLEVRzygRmoxOFFsKx/fA9D0NEs+kV/6VMCwO
         +smiFbtNGqy+klLnstWSQk5E19WT+h3Za+r05xd85RxfYfrr1thPJdTFmd2FteeaSzip
         oWKQ==
X-Gm-Message-State: AFq9FYJS+LyRr/1aU+vbzgJl5dPKwpWpP4RuaG+pbLljXW/4c5vqyVHF
	qF5gxV3W2MS2zqlLECqwmv7KI+EClBEjNAE58OUYXlKKeQj6BJX17KagT5SXOYydrdHOoYGPpmC
	CkTDAfCECexSAKl3TlYo8nMwVmnhQ0wQ1H9vyhUF/zVfjJPb1iki84XSfVN5zvvf07giZF3M=
X-Gm-Gg: AYBFou1GR+8WYl6iLBtxs/KEiHz/HkO54a5MTsIqDIM5ZB5il6sl5oT/nQOzumYGYDu
	YoViLkG/37TblUkYznxG3kn8U+L4zqxsHWdEC5VL82di8Vbj18NTw/MwPNls+lNcIuBiJMFbd17
	KbgcWMIJMRqP7EWfoh4WNjLnUG8IloCnj/z+9Ik0xmGZpRlHry6veSIsEI2037IozAJhpu6Cyy3
	ibxFsIhV4G9ZcKiKZ8PhLlPATrPYj7KJf4uxpHHhankRU1ZIx0pdGfSmLLW+007A5UqBr4H/2Ja
	I6XdMBCc8yul++9Dmqya1ubiusL2gBMtJupLlEJJAJ74jYlQooGTTdWHZcP3CbLIyXNOxiPTT7j
	rGuB6vfuyZFTWI0oQzh0lA3cPsvWfCRHjUD4uyVbc2QtSPo8siA==
X-Received: by 2002:a17:907:3e1e:b0:c2e:411c:c617 with SMTP id a640c23a62f3a-c31a9a0528amr213253866b.5.1791553257560;
        Fri, 09 Oct 2026 06:40:57 -0700 (PDT)
X-Received: by 2002:a17:907:3e1e:b0:c2e:411c:c617 with SMTP id a640c23a62f3a-c31a9a0528amr213252566b.5.1791553257179;
        Fri, 09 Oct 2026 06:40:57 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa1302sm92171466b.51.2026.10.09.06.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:40:56 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: MAINTAINERS: update ceph and libceph maintainers
Date: Fri,  9 Oct 2026 13:40:53 +0000
Message-Id: <20261009134053.2372249-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009-ceph-maintainers-v1-1-298e8158087f@clyso.com>
References: <20261009-ceph-maintainers-v1-1-298e8158087f@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

