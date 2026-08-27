Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025F2D9796
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823073; cv=none; b=GdU0dq12+9/HaS+qpXAuzotUZ7FltFO0TrkccFPTv/Ci8+1u5aBOvKmd853qrFXt/ZlqFRRJXX6pZK72v+yEBzcLqaRJqEpINuVwOZVOGNK5mktYF0Nwq3ArCHAfvq9hhrJ/6JpqkoIDtI/BjqWFUuMDeday7GJwWbA85hmz3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823073; c=relaxed/simple;
	bh=hLVQ1ftq7EVejCnHot1sW/PcbtMmvC6zm8K/x3ZhQa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6SW8liVLGn3v+CPn0G0JmmVMtzdNWDT0DuLlPGRfg9oHZIYwPmoBg6tt6X2Lxbnh5Wz7iT8yEswjjNRx6NDEaWOtTzilOTbVIx6Q+LxL+XsOYStM74eU804U86iQcaF67lVpo+tXARnPjrrApSw8iCvOvklsxIn4ea1fK+iriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zud6MBPB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gyemwtws; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zud6MBPB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gyemwtws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787823070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=Zud6MBPBvu8whwAJUTB+BXxvSIlx54/L0G6NXhn065W0wfnu+6kDqtPRELtaGQV1vSkrKM
	6MisiG35sjPn+q5JtAWCfACpLnlA/So+M9M8DWILeOPSEHs+ZqH8CvhqmQ0aoMInMgnd+c
	H/Bw0+7rm0YNyrzrftSewWHa3ZWMZ2I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-beUNJtB1NgOO9wEz6ol-cQ-1; Thu, 27 Aug 2026 05:31:09 -0400
X-MC-Unique: beUNJtB1NgOO9wEz6ol-cQ-1
X-Mimecast-MFC-AGG-ID: beUNJtB1NgOO9wEz6ol-cQ_1787823067
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so3315510a91.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787823067; x=1788427867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=GyemwtwsDk0RpR3KWqFwQZ68zypOgOh2w5E8P9EBTyB7vQ0+4vdw2LpgrRosFbXUaa
         jCt/0iN8WkYroZG1CNMHtJSRdGQ/Sy11/Jl+7SeRpcAISUsnirKv3ef08JKmcfhNCwKV
         Sb1PBQMJp07biyqW2oaKXv242cPPD8QNHMBJMXRoAuKSJiUhqYNhz2iCWQXQJB24W2G7
         GifaRtr/Kod5Cx918M6dyONZDuluoH8qMjb+tTjB4V9TVdojr+5yqxpDXpT8ZRu3LdMJ
         ro42Mw0tKbnN128cTGeBz82smpHqCWqRCadK2Be6V91PAHAUNn+mJLfvGGxoK/4+bHl8
         srZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823067; x=1788427867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=jAAz+YMThjzBggp3UhTMtgwMUGYZi/V0j76LdYwzBkq6c+cYJOxII/Rr8KUoTkb7Ry
         gSV7Usq/do0fdwMoU7y+YynD1mE60FposzI5kBl599GDkEqu5iygaozD3O3oumhuQlxY
         P9fBeE+vIUcrxqYiP+NFasnXFitW3KPjBFg7bCTiYZiEyeA16b2DifaLC+u2OAXnA9+v
         oLyec4wJrNrX+LSdnDZaZ+vzKVeiiWCZGoWdUUWqmSvy31+2NGsGZTQnAz8s/nOqMT7k
         rTlvUrS7IVoS9ckv+TwPn5HqWWYjWSB0EKkLe2jKT5tFs1Yr0VQV5hpfLrownLEvLfBt
         PsPg==
X-Gm-Message-State: AFuF++k3v6L/SnM7BwaPzvH3nqsVshqJm0Vig+lv7sk9twgwMDLo/Hw2
	wZzJACQDWAIog56yX3PGAyrNhroIbAGKPmMd1cG4u1Q+lM2COpTINcwAFS7wQYe4WuhWhOwp1B9
	Hh552MKPjwrirZ8742yHxCeCyWfIGPr99Ni8475Ah/98MnNhYGwK5v2h3cxcsdnY=
X-Gm-Gg: AR+sD12enq9dCb12UO3zt/9L2wx+n1+lNDmJEtRZLqr7y6LeNgjDVcP7XwlmsAkSGlV
	M6DaaEAyQw23z42LHZwtJCZ9PsxMuNjMuq4hsW0e4yRfF0bGuxSHtqpmGzxfyThyVsifhWfSAgR
	sJviazhFr0zfg3hKCBkwF0IzEI4aJyMStbXIdmvqopJp+nB8WHOSSgQxRZDiIYOJBCt8HctJIni
	HLzptosdRTUXOyEgphuDNhJKO7lta7WSY0AtxkMpusGJmTZBdejD+zcEzwj3epKqWcrN6ZK4cW3
	47tk0mcdEFdzXgrs8ugJHnOV8tvmp6n0wn/GFY1ITH3i5Dn1TXTuEuvhlcfQk1ytsp/k5g==
X-Received: by 2002:a05:6300:6cce:20b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3d139e9b38amr5348359637.3.1787823067194;
        Thu, 27 Aug 2026 02:31:07 -0700 (PDT)
X-Received: by 2002:a05:6300:6cce:20b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3d139e9b38amr5348300637.3.1787823066721;
        Thu, 27 Aug 2026 02:31:06 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8c4e56sm15429427eec.22.2026.08.27.02.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:31:06 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v3] ceph: remove the inline data support
Date: Thu, 27 Aug 2026 09:30:58 +0000
Message-Id: <20260827093058.2741942-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825-b4-ceph-remove-inline-data-v3-1-235b6890d7b7@clyso.com>
References: <20260825-b4-ceph-remove-inline-data-v3-1-235b6890d7b7@clyso.com>
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

