Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076853A39E
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075749; cv=none; b=ZdLJtDGwDaFZXRvRn7qe7CoPxbY1SR57Zr/gyUJSDC81dnkotqgQpbA/nrnXSVUbPC2rY2a95D2kOyy09c630XjOdnW2gUqZssW819xRahNvfHxs8ibA+u8+f2sH5ODU+rI+iCoxD5S44I5bhQYSwJ/9nXMAAyo3oLHejxDkSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075749; c=relaxed/simple;
	bh=LM48diW/csWlPKxxpquZN0R1hLdS/PWariqNxzet5Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYsMT4wkUrZ4383iMcvWp3E+1bk3JaUAb7ncpzxiyAqZweOL3K0dTBJ+I/KT4dlC8Hy03fnbohdgpXzMaEi6oHMC9/yhEnew4gA91jmKdX8f5FLLyQlMTne6xT4AL1YoAg9/51HtjlZz4v4oqr1lEYW4Kq9TM4SuVaS9tqrfh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKRxql8q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBLFItvZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKRxql8q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBLFItvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFF1yAs89Ifw/dwHF6brlDdvrr+Ltta11PTG8orVWFk=;
	b=cKRxql8qCGZo8UEEQt+IT6BQU8lpL+zP8KwziutTR5Kl8/yXMxBpo4BjTy2yP1yfBGPedD
	ACKJO6f46tullC1QzEjC49KmmIyKCtCTGqd9XzycJu9VFE7d+ysRGb9lEwm68YKGGr8PbV
	In/W41o8SR6BymClVjH2MES5ermVSuw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-mej08YZLNjSrmsu5lJ16XQ-1; Tue, 22 Sep 2026 07:15:44 -0400
X-MC-Unique: mej08YZLNjSrmsu5lJ16XQ-1
X-Mimecast-MFC-AGG-ID: mej08YZLNjSrmsu5lJ16XQ_1790075744
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-912348a0ffbso42996856d6.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075744; x=1790680544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFF1yAs89Ifw/dwHF6brlDdvrr+Ltta11PTG8orVWFk=;
        b=RBLFItvZoY8c2JaKbKj9fSV5hdGVyXr5XDJGB+N9V/Y0Uo7aCRQwX/bc724VDoPdBt
         7am1GwyZR0H0kMc4WnFpFNxFwBT5rfDvhkYP5SnCRzoYweedYmR1oxNue5LdFHsF4uJO
         FNF8EeYgOhd83fAY/JnJOtFhm0z5UNsCIC2o/ImOrm9Q91tXKwQSnTJuafeqvPdWS4ut
         1exJFYph89ArZYrLgmKAjfIItqk/aFpws6vj4v7/4D1s5PSKOl9clAz7PK/U/71nzjG0
         /dG1jabNIUce+eTFBRuzI/rZXDAFlRD9BcQiglZXO4g3qBY98FhK9I5UhhjmT5AunoLw
         tfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075744; x=1790680544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFF1yAs89Ifw/dwHF6brlDdvrr+Ltta11PTG8orVWFk=;
        b=dVD8O8pFQW7jbojTtRE7PvZmUEw8ZvnDI4b1Ueukyqjd3DT2ZjemZJAmrDR1/V9Nne
         lWoW298GJ2ZnAhOd7DJi0wlptA/QzDZIIz60qM7xiz0vfbXCoLVcj8N7qXCZ2k98c/+R
         yedJEdx1Ap6JrHNcEZ1A/Lab4Ro5pL5X/qK8WpLEooIgj9fGcw6dz08MylfcprO80cRt
         4gD90LYEBMSzOE6tnotY8cRgNJaSSWnMX+c3bPLQVoGKXxAm4kLgTlnqverCh/hLjgjc
         2JFEBAcoAy+Dlb7KZ+3gpfdDFH4nblfmpBz//lwy7bR5b+BdM6QWTRRIRSP9UmYoZBTW
         WYrg==
X-Forwarded-Encrypted: i=1; AKwUvByLsFJKyH9SeYTW3Xn6DlR4JX8vRG1H4KJLsIkomdUDC3dnfDwSfelHR9ABlkUvhsn05KZA1Zu/K3nZ@vger.kernel.org
X-Gm-Message-State: AFuF++lrpcBYw31P6vZzYFO21UZpJZ0OBUp3G199hxHJnzyEsPWlQbHW
	TvbSClx9MahG/DZpW1OHfR/PHk09zDw9ZvbmnA4HRe5pP8ywgGDafqsFUT7jS1aCfMlmxS5JBQE
	gYeukkzMIwu//EUvbQUytEAiN8/qokqLFvZRNB3pR1oaH/Mj7/ZN6RNp6jTq27XOvUVQ3y14F9g
	==
X-Gm-Gg: AYBFou1VfFtcBx/+ajCN0KLx+26BgHPp0QbjDNrlxilX+1mhsMkiO5Sdhj6kyCrwWkj
	dxgbxC2sr1UuIAicoj9D7Oc5tmcFZeO4O9oKi4TLS//gRYZq/1IMMgxBIuryEz1Z4Dbs6hFMYzC
	WB/iisYAxd2latTuNK9QsuVbGaHzxpfCp9U/CkMTGE9B1lp7C/zn+Eao0SQatOMHdEoGsptpKp/
	CaY4BTBaLadJnSgLYmTlXyY/uzbJNnLZAWh2FRML1BboPIrIJm4/LbakGn3MydhlUCwqR9gc03o
	G1Ls7VNcc01Vx+H2UrG7a/KK/AMjrFApIYQUtmPkknWgXAhEqmUwJHwMvbRR66jKotDZWlt2f6b
	lWe2UueUsQn/nzv2LD9/kwEyDEZjdiP/B6KbKBKLeGb7PhEoT70jPLIWPttK5VhR4zkiZS9CPIe
	7v10TkKPPiklFDgA==
X-Received: by 2002:a05:6214:21ec:b0:912:588d:55e8 with SMTP id 6a1803df08f44-913fc8a1402mr52386996d6.9.1790075743654;
        Tue, 22 Sep 2026 04:15:43 -0700 (PDT)
X-Received: by 2002:a05:6214:21ec:b0:912:588d:55e8 with SMTP id 6a1803df08f44-913fc8a1402mr52386166d6.9.1790075742988;
        Tue, 22 Sep 2026 04:15:42 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914024e9400sm13049226d6.29.2026.09.22.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:42 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: validate CRUSH bucket references before use
Date: Tue, 22 Sep 2026 11:15:40 +0000
Message-Id: <20260922111540.767467-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914235817.2201175-1-4ncienth@gmail.com>
References: <20260914235817.2201175-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Daehyeon,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

