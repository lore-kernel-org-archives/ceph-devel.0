Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEE5452A0
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954640; cv=none; b=MY8fXXApPpkagbPnYQIASkC5lLSdEKX7+h5GKftNvmlK+7A+rJQwrs50DTl5aHR1L0Z244TLTk8gJpBnU9TOLEg0uoTYAuc553RtFfRGIrApV0DwoEUfe/RT3p5YKWQmPJkQEF5jTN2nXdTVhU14+1yGIiQh8+G+1MexhNmmt3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954640; c=relaxed/simple;
	bh=VMSZ7qH7HoWdVPE0THfP9XHBst6JaWXaHeoEuR2C18E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0sR7A2hPqQT9uRp2q9QnAwlrZYdw20wbrpxdWtA2ToI8k4pM/8SGCTwZbJxL+TN82kjkV0zRYhE1CYVyjpyqs7aJBsW3Mvz1o+UHz1dtq178VQoKz5/qjvaMr/fitcgj0yMmUjO7xEPV3VIwehIJ573JBHw6vNUJfT9BEa/exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqQN8fJk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoDcrzSl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqQN8fJk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoDcrzSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788954637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zck/kpIww9Zg0DNhq43KllR6FT1zUO2dDZJYFzGBYI=;
	b=HqQN8fJkMihKKc+2zACIPoNx0yxEL0h5E2jouoMmMslF9m+GtpOi1e+2KUlSv0WdKY3Y9x
	LpK8kEaErWg3kwBZBg2pUeHc+e9Rl4MXk6IcaOBI14K36qzqK3JG7PYa0Lh29QcFIHhjm0
	vf+4WhXB4oIxxKy2biHQ2X9ZujeuQVU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-BD7ENSarMWKIt-mWNwYOCw-1; Wed, 09 Sep 2026 07:50:36 -0400
X-MC-Unique: BD7ENSarMWKIt-mWNwYOCw-1
X-Mimecast-MFC-AGG-ID: BD7ENSarMWKIt-mWNwYOCw_1788954636
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e7f98bcb9so77660826d6.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788954636; x=1789559436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Zck/kpIww9Zg0DNhq43KllR6FT1zUO2dDZJYFzGBYI=;
        b=SoDcrzSlDW7L/R+rcReDQcp8n7fFu5umIc1KNTqdntMwEQ98H0qj+QJG3gTXlycL2h
         5Kbz4HsI/90NUGk8USoIEA+p1EA0MYnJXOReCHLxZmccPCYk0Toput9Mh3NK+PzErw9d
         Y+Ek4xotXkV4029PzrvYAxHuaI/rHK5KR6dAHhp2xfR/L6xapyiptxijgSQfhRNJ1WIs
         kZc5TtBYGTi+kHySPAqJ6T78t/8edSJgtDa9CgosgmWdd+mN+Xz2VIkyeqoLCupbImhx
         QQCN+nmgn7YWIJDHxh+3RK05yyceL27zRDr4u2AZjL1DwCb15Cj+zG24FrvupHVYtXLX
         xi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954636; x=1789559436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Zck/kpIww9Zg0DNhq43KllR6FT1zUO2dDZJYFzGBYI=;
        b=iNBjRnk3jkYKwsx8CTg5viXsGSd6pCPrgwl+wcvy/Ypcxz3RVQI8OrTUY+LiXJQyBl
         QlP44+hng3/kbsKFYgeRzrRdk76a4ksRhL1wNeLH1PPKLV54YMgKpmwXAbqiHVKDHZrd
         9WyAdlbhLgeai7DQwEZ5aRY+waUMSnB9+6JAEwu4/4217s7nrCcxs17ge4M5MwQ41LuE
         8nN67ePDLFfdwusOo9y0cLMc/RYUfLW3zD4Seh1XQixl27ST4CZQXjz3g2b26LPHmY7m
         8SYDEqP0IUNJMU0ZVxNWGBR7yxNO46gRyxEsjviyLaYs62uZ9Lt9gxde2StyLBbsKXQu
         v9eg==
X-Gm-Message-State: AFuF++mH/88EdqqnHXT9bpJUOVtgBy/TexUnmjScaH7cukRxKtxlAfQZ
	nSuNuXES5Fn+wbEYt5XsTK/8F4x5VyN/s9lJExx3OMpbxmEdkxorrlhaOjaWfisslseoMzfN5Rj
	GRcuXwX3gVdfhICU1jVEgQHAeX5XIuBqdXIh2+FgwKL6k7CrDibj4G3ctTIhasytsXQIeQgjDjg
	==
X-Gm-Gg: AYBFou11L6vtGNDZ4Qut/y5XrvtrTRhUseV3jyozuLGSBS0ZyBf3X+iO+YfNxJetp/F
	6Mg3xSFaUHePXQHYxF/ee4O7sTxVScIJ27Z5sKeZEnMt93F8bhOp030EVUle8kp0xoxjSFdjRmm
	ezF75TiCwcfkIwcMPXkxPhxctwQDAe7Y6FSTMG9J5HY12Rk+MyaSs99y7K9hYDF+iKUdG2+X8Qg
	eWUNVBXofyABGtB3uWGn0M0+ERbadcc83rlHcJU3L7KwC7sYfXp0FqyWucff1uhLwZGj9F+e2Ih
	MAo8vXqbCP0H+zmsRp65e/e0FCdBMn6FQKNsivZj2tPO0aJSKXDaulaaebS+xwDNKDh6Q1SXEl6
	l1p5PySBQ62cNMnumUg74q9ZhsyT07EtJlsvu/O75+le+wIaJcFXhbIaait9+8ZF/9TqyTPde40
	7uEitEjAX/HLfwSQ==
X-Received: by 2002:ad4:5ecb:0:b0:910:2f02:8c39 with SMTP id 6a1803df08f44-910c45570c0mr5745266d6.7.1788954636080;
        Wed, 09 Sep 2026 04:50:36 -0700 (PDT)
X-Received: by 2002:ad4:5ecb:0:b0:910:2f02:8c39 with SMTP id 6a1803df08f44-910c45570c0mr5744806d6.7.1788954635664;
        Wed, 09 Sep 2026 04:50:35 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91041fa4d65sm135483196d6.15.2026.09.09.04.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:50:35 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Wed,  9 Sep 2026 11:50:33 +0000
Message-Id: <20260909115033.3962847-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908031823.204166-1-yijiangshan@kylinos.cn>
References: <20260908031823.204166-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiangshan,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

