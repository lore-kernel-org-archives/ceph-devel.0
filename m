Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50453A3A8
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075743; cv=none; b=nR0/nJSHuKNME4HhUwXHq0UUMjPYfg+3Ozp0BdEgQhdtI0ptFNFvb+tPbxmmg4lKAXLAxk4pMvJ5hGEetBOC4/CiphnhwkrdntM8SahCDBMK7Cvm5K1/6ovultTb9E7qfyartvFzq1DYlLwZ9F24Eh4NH5HAk0DJuwaOjTPz+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075743; c=relaxed/simple;
	bh=fGAN6y0J/ivsXBMSi0JM+3rTBxpLy2DDN9BBdIno2zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EINRhycA7LIyob5zEvQ3yyC4KT7M3kjMSXzt8KLN3/yB2UbRVO4oQkrA1Q7rNZ+g/QBxksJPTHfnVh7bLZF0HON1dKIiOsb3GrKE1EhI9AQo47jjcNvI49YGEKx8qSYHk4VR7lc9Fih/wqJMohV9IaEaCKxpIS61EU2aVfcIQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX/VwDJE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0Ft9fq+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX/VwDJE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0Ft9fq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HXeTZrX39uIA1x0aMdTVE3FKoqd0hnOwCnHw6XL+7E=;
	b=JX/VwDJEz8a2fELzF9PlirtcOa13jZLInTmCyJ0BS2Qqj7UWvpsTwEZnrC2JDoxl3xY/GG
	kiIIKns6aqIzeoA+0N0w5Nc/d/D16emi+uPV6eY+ebPccy5x/5hRorl4mY9EHk0eosBbTf
	MkyS2DgCuPNGpzs1QzPAbw0qpKBAirM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-BIp_-BdENaOSWTslaDGYRg-1; Tue, 22 Sep 2026 07:15:38 -0400
X-MC-Unique: BIp_-BdENaOSWTslaDGYRg-1
X-Mimecast-MFC-AGG-ID: BIp_-BdENaOSWTslaDGYRg_1790075737
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91049eac948so63135396d6.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075737; x=1790680537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7HXeTZrX39uIA1x0aMdTVE3FKoqd0hnOwCnHw6XL+7E=;
        b=X0Ft9fq+eA1mM5uX8bOlFsvhLxucXsnDrLS6E7qK9JlK5Xgtl/bJNhRWciuyKYe8nw
         X6P6QifxUu//BO0pWCqDYFUyJpI+BhtzPk132zK38TA8FQ9J0RDJL4K5R+KY44mKHozD
         7SPz+MeZRJaAA3E6GkEA75poSQwd2TW32MByEXJBCA4RA0aBafxELcF0LcuHsQO7aIvH
         CBeRGP77A1SuNCgFh9rbl4ivwITuvJJzkiA1jIeyWqeOp0zZkQi/tdRvdWhg2abHiNl/
         3jPNqs1FGkPmMELEV5IIHH0zo4qX0nsvo4Wy65Qw8M+J02iW+iYnvM17jqgUMIKOMHtv
         3gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075737; x=1790680537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7HXeTZrX39uIA1x0aMdTVE3FKoqd0hnOwCnHw6XL+7E=;
        b=qNWWRh6L1DcFjTWaL6K5wP5GDf7QITrmVY8w6cED+s9UmW/bf/3wiY6MnDgHprjTIB
         1qKr5bDT6UfQ/RpbM8MrqY1nqoukBX74LEc0KAOjnu52I9YdVeq45h5KN8TD6TU1CgNJ
         CkfBOCSLInaywXN+dKGv7MsitDzzSVQ91N8oa0sL3B0NRG8tTntXGTIGb1xjwaplUE2t
         cVSsMig+abibr6GiSyTV9yO2DjL++2xIox88Fc+5A00rz8JGliklX8EXXz1EBRdfRYCa
         pUlgp2vbERoIN/zg3FZEwbfKsQLHxociGuyqg+GvU+IVybd0Z9GodhH+s0lz3OpVWwUV
         IoBA==
X-Forwarded-Encrypted: i=1; AKwUvBwn9sGukim/qY/I4ZCfBChHKstJt2w255xJcPYniER0UA5mhdvz5o4VXnQfJTLpxx5Z+9UDygXJFrwD@vger.kernel.org
X-Gm-Message-State: AFuF++k8TIu7J92Jh7IP6+LQF/glmLNaA3JLt16UdRSKeRRxXr+f941h
	TYoVd8XQ5AlpEiVHZiJ7k4k0UqC1t6DR0SrNPVsv9hVzkMnA4jrAbuE9zPojbINK6h4XKxPGMqL
	0OQauNR4cchp2bkAmFm/6hCpCBnL+4uTFWoJ2G5ICXvSles/ThC7aqvxcejeGvnk=
X-Gm-Gg: AYBFou1e8lEtI2PNNBsmj2OvGqamyXGa28l36njnyI1FZjLqALCzZsCZYMx5qqY1/DZ
	93lqP193IDy54yh9hKxXLPU3pFBN6tDRXabRHEmAcz4RYgn2/kiIIR9BSdN9JtvrZpZ6gxlNZRh
	TYRTEsxAr3W5vT/SVm5utZuWtDIuw0nsudbp8Ll5HbyK8JauoYeuHU4D/Hua/oT1TWIKIA/wnUJ
	2qDOLxYbucVwiqzwBBovLGaFC6MG81tOTF5XcSrxT689nL86JmD76MoLlokhUFITY+jWxlzMWza
	tb3plskbUCF1yNGoiiHVtSK+4vd99zQUG91obZoDK0bQGe2TEPFXFup0UlkAuz+IaeUqJ0ZlDi+
	tA+hADWPIlp+4DVwXGO3YkQsjbQPoNkIAETbuWK6BAuG1fl4UpfA3ckJSjJM/iAywYD1WtPtdWF
	66+gyaRDtsbfOEZA==
X-Received: by 2002:a05:620a:1990:b0:93b:d7a2:83cf with SMTP id af79cd13be357-93c15edbe70mr470575585a.62.1790075737550;
        Tue, 22 Sep 2026 04:15:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1990:b0:93b:d7a2:83cf with SMTP id af79cd13be357-93c15edbe70mr470572685a.62.1790075737190;
        Tue, 22 Sep 2026 04:15:37 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c224ddec0sm1079185a.24.2026.09.22.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:36 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] ceph: remove two users of __page_cache_alloc()
Date: Tue, 22 Sep 2026 11:15:34 +0000
Message-Id: <20260922111534.767433-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260913-ceph-alloc-page-v1-0-c436f2f4c068@columbia.edu>
References: <20260913-ceph-alloc-page-v1-0-c436f2f4c068@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tal,

Thanks for the series.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

