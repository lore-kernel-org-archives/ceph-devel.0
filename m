Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B393BAD9A
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210685; cv=none; b=VBbRjnfk2cGIQzaXVXLt0jSavwOlGTVqc2R8ZFGBORQ4KIcs2xMCapvn+ZCXYbGdp5BtCZuhBiZ++RgRLGI5yB1GeMinWCPIY+xL63lhDb/KtVH3v8UY1V0B36QtGHaAfPYmDZMg5Gs29K1DwFWp9yKxVc6pIZ08lCvsvVGIyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210685; c=relaxed/simple;
	bh=BVCRWmyylpRsbb4w3BbuvThQBHDjvtzDko5drSgPEoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmDJc4bwb7/y+SDbpjEChzEiNHf33ywxmUG7k9wWAcTjZCAsX1NAylgqMhLb87Q5RJxJAdGd3K/SIFWf+vwJwBpi5EYuwHKrzfUsQoGZ0L2PNl5gSi8nkBoZ1iyICR2vKGiKjDsXvAyDKuaV9/4AOZZZZvAjYmp5Y/sJaNCBecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFtmNhEI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1yyro+T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFtmNhEI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1yyro+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787210680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVCRWmyylpRsbb4w3BbuvThQBHDjvtzDko5drSgPEoM=;
	b=HFtmNhEIe+uWvjOsp90hvyd8p5pAzldmyk/YvNNidojsEkhKbgpEhnZLH3Kr4IEkBm70SI
	Hfen0d+BaDaew6F0oNNbNayNroPa5LmDFECEWfYUNXn8IwOJtTP378xFflDo7ZidkfKM+H
	MeksFiBqMir0k/sNHpoobhyZN2PnuG0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-B8OYbwOhPeiDHsBztYgvfw-1; Thu, 20 Aug 2026 03:24:38 -0400
X-MC-Unique: B8OYbwOhPeiDHsBztYgvfw-1
X-Mimecast-MFC-AGG-ID: B8OYbwOhPeiDHsBztYgvfw_1787210677
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a1188c8948so1893751a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 00:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787210677; x=1787815477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVCRWmyylpRsbb4w3BbuvThQBHDjvtzDko5drSgPEoM=;
        b=i1yyro+TTTGj2JYNWs4xPNt24q6OqviasC76BkJZCROcPaLjUyfPfGXdaxJJk/5BW5
         l0VDRiTEZb2Mdv7AArrddI/2UfFVwPrnTi4uVjvy8lyvgVxxuLbNY0jnBFccelzs+Zvv
         tsXWS8vZ49hDK9ffysQm3vWecG70tW0AeaHK2n2Ml0T+6Fjk8+hfwnxx+AQtYZsNUdL0
         O0aBU+BB3ZJKhKwFkJhu/+HW86S3w8sHwFYLh0jYKdHPmNqaBPY0OZ6FE5M+VXhVVdXe
         KQxmftTyR+HKqBstBTZCHa/1gj8TcoQCwOnP8gc5fu0JHzt44CgsTJJOhf9LnOW7Fi5q
         Arhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787210677; x=1787815477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVCRWmyylpRsbb4w3BbuvThQBHDjvtzDko5drSgPEoM=;
        b=aKLh2vFAWubVvrP6aPYlJfG+gJ6jV95mlZZ6cjJ0V+QRxa1W5PTc81DJ1Xu1xBsvDt
         6rxgdNyiVYUaVU+WM15prDmGHqzhPGr6C4+3lYKqsszYW52PS8jDg99px4Zl9X06imz6
         XJfC3FFK1AV+F1Gzp9lVPhi6oyo6wUY2oY54Q0Kc1HnL/6W4srntaak8qG6W1DoE5oqr
         1YV9/HI+9UtrwU58HHw4RqsahPyn4iiSs1qQ2dHnIOSTp9CTlJWE8IA1VdEekNZXjx2W
         rVFmAsnwuGzUbTOi4k29RHYUJnqFUE8EwZrm75Za6krSyuEaYTJ+FVJ9ZBRhOW9xcp+O
         f33w==
X-Gm-Message-State: AFuF++nK0ndyqeot4kH/c0JdxAVsWe5nvoZj9fODJKCMPTw3h9ia/xSJ
	eDp31zaj6sZYcZNn6dyLFXpWLsHzwXVZ7VdUVZ+VNLRwWDNfXiGJ8oxplh6kpktP+tWmSbtFPH2
	dj8ySxq9IBHbYe8CFmcpnAx3BXgw1RsMKkCW+4mBq1d+uT9q64SYZwG6wpPpCHS8=
X-Gm-Gg: AR+sD13PC7j/OfjoYLiQyPrtq2dLRem/SjzYz+4I6AujqaEecqC225Fnhykl/Gh45EM
	K8S3x6wkVV9ROO8iscSZCHa7xRTEQkf/Mm1ciXgw3cG/8zlh5BXncSo9Mcnn4DlyrJy18ZU7uo/
	ZCVyyk9XWxMPv9NJeZZXDEtYaZL/KY0Rty+JI/JrjglCHoIwq6fPRvXotDbXsEGDDQRJKExHD7l
	tlsI0/id2icO5b/GCm9fiLBzqHxEhKXH+DHbpKb3qPqOqm5Yaa2bjiBIq/lr7JGzqUYO0j206uC
	7PFuJ+SQVSMxzC6Dm+b+JUIn5sIKRaGlM6clZUc6GKv6YwYOQh5vJrx96I5m7HRimcmFgBovk7s
	TmCUEImyqE7UpC/XpR/suc9aTamw0nIG8iA==
X-Received: by 2002:a05:6402:43cb:b0:6a1:f95b:8cff with SMTP id 4fb4d7f45d1cf-6a4032a4565mr7295330a12.1.1787210677154;
        Thu, 20 Aug 2026 00:24:37 -0700 (PDT)
X-Received: by 2002:a05:6402:43cb:b0:6a1:f95b:8cff with SMTP id 4fb4d7f45d1cf-6a4032a4565mr7295288a12.1.1787210676701;
        Thu, 20 Aug 2026 00:24:36 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff1565fesm1981892a12.17.2026.08.20.00.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:24:36 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v3] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Thu, 20 Aug 2026 07:24:35 +0000
Message-Id: <20260820072435.2181126-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818184005.3549924-1-max.kellermann@ionos.com>
References: <20260818184005.3549924-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

Thanks for the respin. Looks good.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

