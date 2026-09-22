Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689E53A39F
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075745; cv=none; b=A74swz+LWiNuZp1/O2jrfGCa+30azGzTj25RFQXVQvT9q/6AN4+ERcSqb+mVO5KRJCkEzJCPNIZqSfl9uZBvwR1v1x0IDoFRhWzRNbH4V0p39XrbkEEfQwY4Xg3QuZhbk2RzA65pcvO4RN+vM/NUJLwLy6TZOA+qnbpXrkD2ylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075745; c=relaxed/simple;
	bh=pDG+LUYfWE/lg9GV3EwC7bNAC2luO8YmosElSYurcVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jfuk+PqfyJ2tKb6a0EeEPB4O8qrADxLyiEsYydMaf0vhLZaY6BESNupDZr/9I8Kq18Z1vTwql9FKfE8agSaP97IiXZr2u2qFZ7X+0StsF2Y+CXIZ8Yr4fPoHK3MOvbrMog9sEYj/6cZGICopestbxOi2/4PNc87dOY3/tQehQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo3JGThy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnsUbmbN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo3JGThy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnsUbmbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
	b=Yo3JGThyblxYiEEIJxyylwIoEMxra+JbhjcXXs1m9E+ZDc+wc2dovtQwsAgpZ16CfaMbak
	Az2lr59B0AL98JiITihqC6ewE9DjJ1QYE4FS2HYPFgYzgokWbLbk2fJdG7t3gjslMZfG/X
	4oBlLaLiZE/LDZiw/c1AxFfQXCpu+bg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-p3suYqkVMpy47TTyujAErg-1; Tue, 22 Sep 2026 07:15:41 -0400
X-MC-Unique: p3suYqkVMpy47TTyujAErg-1
X-Mimecast-MFC-AGG-ID: p3suYqkVMpy47TTyujAErg_1790075740
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53000c06184so115222581cf.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075740; x=1790680540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=VnsUbmbN1P1CASaWV2BAZLlz+IKewKdgMSyPH0LpURvZQulPxhP+GMYnhdFXiIY9+r
         KTOxobGjSW6H7K6lKaAumiIqU9ZnyYVGLCmj45rK5sKwXR3GJa623GBDGYCuQgzhuYcx
         zAm3WdA41qaYgSZg3K+2jJyilEfH9d4nup3YK/vTD3+LjYHtCbCMmWjnxMBR6uCBx+nu
         5jpncASa1QGqsgrq9PrvaIiPfQevdZfdIpjMwywmpMHuRMxUltcw82Dc/gTTBTIhriLo
         J4I4NSo1FofNxeeRBbVBhGpYNYI3GJ9K1pzIdAGAcciGDrY5nj28FSzDBTQwzV1WKOex
         zvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075740; x=1790680540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=e8sMVpQccmUhrGY4KvxOD3oO3kuiD25RGUNAPyInYviRDYoYkawgpuT2Sn92XYSHew
         RWjEpCE0sl3lTKkOxi9nrmh3fg/3gWYx7bjZnNnJH1Az9SO+hUdtwHU+29/AqGLNhBBB
         cqzdmYkDl26hTrSRv3f9V+1O6TawZEDIJ6QdzOPbdX11gDlJARlVat8Hf7+9gP2E+OXB
         IyTLJLRNPvEx+S1heTKP6kX9AxPJSyJNlI/fVr61BmdklY2smaeu3fgisKYGPwK920ow
         OcLwRmne/gDHH7WSy7rmTlZOqGe+AqoNpf55YS6Iw8Esp1ICnU/54I142aTAY0j4OJSd
         pBxA==
X-Forwarded-Encrypted: i=1; AKwUvByq3U37Rl88oaOZ20aV2TFEYiVWdo2pZUYgYnFj5O2z6SusESCWy3NtLtlc42OdAYbY5DZmMUeK6N8c@vger.kernel.org
X-Gm-Message-State: AFuF++kaOw+NSl1hpmeG1BPZgrA7PhO8piE9THM6NBTKuUaUKAkVX8LQ
	DnPbcWO6ClJYQiAjWK3vMxspnAsnPZZqKPK8FxIldXxlvdxSKxAkGKRUH4m8Oh5Jw97XXiLaMOv
	QqMh8FylaLdxHdoUnrgElM20KW5IrOXq32YpYiefhDMP46wzSwwBibt64l0u+EdE=
X-Gm-Gg: AYBFou2k80dgdqAg/AXXIG+ogaOqDWEXXF+NT6es9dNeja/vQHPMPIHpzxTTummRPZE
	qssgbk9EdLXVfpZSFfkzSkOCbDYs5N7nZB/mALBq06etsqtr74ltBbyklQdA+AY4rgJp9T/pZKz
	ypsyCwBB+dtC7+rk9wp7PehO7zxJ2cwGkI+6GGK3+VEdPuk6ftRpYj00NUACGQeUrwKUH/oHEkw
	GPE8ynzBW5M2xjv4BTeStoE0K7qerafpKf0vMjYQfqRsRHyLQ162Z/ppCUygXsxi9BT3G9qGn4C
	fP4ps4zB14CA5CUY5+RXM5vO6K7sqlMRGf2DkvV8SFfcCqrlENmFGpaDZZJQMp3+4aYA8zYk+6q
	493aeFFxd1fCrJbPxYVXtV0g3EZHwJ2Tv8aLK5KvEqbx2K2Sb1axYhpbvFmK4hUhmtPHG4DtVUu
	FhPYfy2sTGqH0KtA==
X-Received: by 2002:a05:622a:11d5:b0:530:42d4:4c97 with SMTP id d75a77b69052e-532d8e38364mr47296731cf.41.1790075740503;
        Tue, 22 Sep 2026 04:15:40 -0700 (PDT)
X-Received: by 2002:a05:622a:11d5:b0:530:42d4:4c97 with SMTP id d75a77b69052e-532d8e38364mr47296311cf.41.1790075740091;
        Tue, 22 Sep 2026 04:15:40 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e188b2e6sm10235991cf.9.2026.09.22.04.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:39 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [net] libceph: bound mon_command ack decode to front len
Date: Tue, 22 Sep 2026 11:15:37 +0000
Message-Id: <20260922111537.767447-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915014243.355592-1-xmei5@asu.edu>
References: <20260915014243.355592-1-xmei5@asu.edu>
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

