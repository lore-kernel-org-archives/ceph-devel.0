Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5F46C4D0
	for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152940; cv=none; b=nuweEFbxJOQLfZf1yNZ2V+70kXilRTqswe4uGDDRaluEwty+hhSjG7p1ZyNS1Pdj/t8GeyAQ/XPKelvQew9EB8K+pWX3EiGstgN0QdfFHh1LsLB+N4XSlQcvxh3wjYsRKsc6f5L3AQ4zcOiUcmE9YODNY15u+jBcm6Z5Owa4bXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152940; c=relaxed/simple;
	bh=FmX/krm3ZxJzVxlvZK909Y74vB0gcWGmPe6CRT3EdVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8OWyTh2QDdBANTZfKam08X77wccQyyYsQIphpPoBfdgE48Wdb2qOjNolAsv79R7WY88rKOHYBDyPyqCT+17KQ2gNlkz90hHFg8lKSp0/s1y9iJSqEAolW2tfnNel6Zh+MpOKYrOz0LAqFUoYkOEmIIvPQP2uucLdGEQCFmaYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EP9Y2Coi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtiHvM5a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EP9Y2Coi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtiHvM5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790152931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
	b=EP9Y2Coi/06fCgkvhzn0TTj6MXVL15Q5OnA8/pNJVkvwGcJD9Mbq71uYv2VIJhYEXA/Zkv
	JHWTSgh4KGGZowHSuou2fQCzL4AwBvfpTs1LYEWOG3DN969sdjiMn1lbOmQFwjgIrXqC6Y
	Cv9LQtMi6A2p4Kl01h2QX3ndcaWx6mQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-Xe6K_CXSMNiWrswo4lLMZA-1; Wed, 23 Sep 2026 04:42:09 -0400
X-MC-Unique: Xe6K_CXSMNiWrswo4lLMZA-1
X-Mimecast-MFC-AGG-ID: Xe6K_CXSMNiWrswo4lLMZA_1790152929
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6aa734a7228so809790a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790152929; x=1790757729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
        b=VtiHvM5a9IMLo2o34YTp0CJbg4g3Jl/ZCdxfLcL7oLcoUk5+xHexCe7A/Udc5laLHy
         T6n/5e0I3WF+rt6+TL53MVIlk9wC2HIMWuK2KK+HiMHNRIf336wedZFZe0Qamycy+BjG
         pEuS3yG9d15RtzJ84S+6IBRndQ3KoXF9Ja09r3DRPweZoYXDXl7EG7Lfq3k0hWVKo3Zk
         PjGuINibY3uctH67Mc40vnZSp0RfmrDBLKntzZ/eLMor8UfN47NxHp5SeCvdvJyPDq/L
         5uaX4lzMEruV5MkCPrnQj6taSTxFyQCsuedyRbC/BzTDfSi5Bg2ZS06Xflo33mDqXW5L
         rbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152929; x=1790757729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
        b=RI3xBi0hwHMWdEuIkS/uK7AO7Jmq8ILJVbHtB5mVp5nAS9oI3kUSHkWr0HghJ6VO4K
         F8MyiXq5sHkgbcM/2MkOxP0qQ4+cQLBbIaiwpde2OJgNjqzjKEcigRkWX3vrChoY450b
         YkeiU9hWoszwwgm/bRmpp6/oCqT8gVDrwT2IFSj906OgO0iK1nQ30Kmt6Dc4J6lPghbX
         BOyn1SoznP8vJiuYV5tr4HRrleJV/q0QQgSXB5rfaXOqTcNwIHxs3z0hxWL98XzC2o0h
         ePmNf413clNz2yu/F7R4KSLgxsPfOAorfJa2ABKTHdAFi5ICVshDk3YHVId+bCmYbGAE
         ulww==
X-Gm-Message-State: AFuF++mldmGY87p1GEawgXjbh8tzRU96dLitEeEZIACakNF+a+baESc7
	qJrhJjwvOFfymdDNTenI9WBbmAAyvmXs4BNUUM6CZrHJndkuNayL22yuJ9TvQRcVe7rdI0BVoAA
	Bvr6Zi76fKuSC0IRrepS5C3jtBJS+ZOhWWii2s/yonqL5mPrhWdQVlkmflJ7a48o=
X-Gm-Gg: AYBFou2jGdlJzswwdCwFMtqacVLSLOFMDD+GlukvrQ8QtMCMhwgPwpG4V4wjVuPjHq/
	G2jk6htmkW7snwwnlMEgWO46OTFokNBxGZpNpKyQbX9AldRuLbskSXDmq8zIFxiSV8IneuOVfoy
	VT/Wcny4np+u2tW6HOBi80skSnJNCar9iJNjKH0jQ0vJ2i0Q/4EnKlBA+ttgQEoaFKTrBuWIkv6
	/VonkK9lrAdY+451zkewMM+X23/cD1iUgNben16pNYGJIZ3zn5P/iVtEgdbC9Xx2VsWdq+W3roE
	e0XJP9Pjk002YMuFJF0W3Cxdk2o77nh0S9NHIiynYuXr6sBiIIjPk9L63H+iTSVJKfSiNJyNBPz
	hIdvES1GYPIfCxRYvcItZiqOz8fKK62pwsCJTalDtRLxlXb6FQb1ZOwq/AD2Y/E4WmJ/BGm1Urg
	kk3hDFJLTMq3QMCQ==
X-Received: by 2002:a05:6402:3509:b0:6a9:864c:9d94 with SMTP id 4fb4d7f45d1cf-6aab3b4e8f3mr1675944a12.28.1790152928719;
        Wed, 23 Sep 2026 01:42:08 -0700 (PDT)
X-Received: by 2002:a05:6402:3509:b0:6a9:864c:9d94 with SMTP id 4fb4d7f45d1cf-6aab3b4e8f3mr1675932a12.28.1790152928368;
        Wed, 23 Sep 2026 01:42:08 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38b2fc5sm1113183a12.27.2026.09.23.01.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:42:08 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: vulab@iscas.ac.cn
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: Fix xattr buffer leak in __send_cap()
Date: Wed, 23 Sep 2026 08:42:05 +0000
Message-Id: <20260923084205.853643-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917162704.2162206-1-vulab@iscas.ac.cn>
References: <20260917162704.2162206-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wentao,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

