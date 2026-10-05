Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45147DD64
	for <ceph-devel@vger.kernel.org>; Mon,  5 Oct 2026 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201047; cv=none; b=thZigTXYK2NXnwkmr7e6LG2AMDkqw8G8GTM7e5hTAffaEldQb4+ibuQUk884qeLpp9IhKZ1oE6+F9Sv31VD43L5Y5JwfOFpDXGfVurTYMOPEoQMePjf6tTe6UiZ3cotIudyb651rbjG3soc5rX315AqeXYt/1sYfQu1BEoGT210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201047; c=relaxed/simple;
	bh=wYjnXXyCSAf3oW4Y5Nu3Q5yczEpyFnJxoUASGqY3J0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7t632P/GC77U9XHc/v4ThoZt+zNBaMOhUuOPm5c6WLOfdEgSZxaPyUIxFO7XnxFKBXBEskKikvg4hBTlysHRDM6I+2QRY55HQRi/JYEiLe6UVKTyi3pgWoSyCGM+iqVXD9yRCNnhK9DKOWBE97npr9onQxdbTh4I8TANN7zK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2kIGBFx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mz+sG5l6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2kIGBFx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mz+sG5l6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791201045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
	b=F2kIGBFxsY1m+Z8oHx7jfq1kdiufQkA0Hbl29PZOrzyF3eQqw/K2Wsz0gzQOT/so6J1p6H
	Y6dZSRWedXZ1liJMN7wnAjKwJD1vDrLoNGQyRwEIcRhsSNBp12zYL8lVA3AtSusQnKcLpJ
	b7X8DRdceR14C9wAI0RLu7i58NyzH2Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-oRyytYaCNAiY4DNKQ6pyRg-1; Mon, 05 Oct 2026 07:50:44 -0400
X-MC-Unique: oRyytYaCNAiY4DNKQ6pyRg-1
X-Mimecast-MFC-AGG-ID: oRyytYaCNAiY4DNKQ6pyRg_1791201043
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a5d57a8d51so2176170a12.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Oct 2026 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791201043; x=1791805843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
        b=mz+sG5l6ayI05KKcn4k0Txs3327g0TRMnXopO/IGhnLbiNNBLDcnhGmYldR1LYJyC0
         MRJlyQh29Echc5+HsUgagR9ZudSApVeP3QwZVocBz5xJdw/HJVl+2rccR7XGODgJ9T7h
         C2f4xnzA7qi01q1GDKtMz323MCw2JxqJW+MTbR9JKXiC0EmRilLsWMUHbLxap4WHReBe
         ueLOcG35BRnZt9wbMCQvGMDIP4dtlAKFTRt+iGeUd7Ev+tjPobwAeDDqb/WhktRoQKUC
         ii9fSJpod0+QL2z9Yi39S7i9nsgsz7IGt2KCUUl3BrlcE24ZK8zy00W+jPTLYLZ/xpUa
         NbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201043; x=1791805843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
        b=w8zfLI3GnJOLIoj8CbcFjFwd0sFkrOgwk0cS6wT5yiIKznhVNmm1wAZmOLROTwF4D1
         6btHtI8wRWvsbAiPixqIm+riWw6VJi9pvFgjvpSnJHpuidczMMX7D27xMerc++MeegwJ
         V+OKjPmAYoFCeXGxHTNBtGtlOikJ3uSoCmg44Lao6UedKSFeFc5FjIIaOsWjjlPq0mmZ
         y5sA+lHwkq93Y4zAwuTZco9AyjveM2sYWuGoR5ILLkzHmKxfYC9NRUeAD2+ZAXfTVjDG
         DorlK8tBn7FTMPUopQH48NsBX/mRpIN1ganmEUiIGnE4DoY867MUIc7CR239FoRdDKMd
         oM5w==
X-Forwarded-Encrypted: i=1; AKwUvBwUpkk1sfCDIw1G0DX4vtH3PeTEGi4CK3Ul3iVLtP3LIcQwFzrm88Yl1MJSaWqs8wXtMhMXhojhyCR8@vger.kernel.org
X-Gm-Message-State: AFq9FYLNhuihCfPW2t4aQBZLLrIuWI4LxPXvGUJVw24geFeO9GsJSI1G
	p4ucVWrK3RKtuQDjaqSiPf4ZWMBO1BZqUnNOajvQYaxzZzb3TZaJSe3MkE1QS+Ru71dYkwFD+7b
	HHv7mrd4Q1gK/ayO8yMM5jMf59B27POlaC9AbltDstU+5f6Gtotah4Z0iNKFsIV8=
X-Gm-Gg: AYBFou1xMUeTmHXrq/PKYZn9ZVpMN/2IBYiGNkhyD2gpELQpsV5fNAAwWevx4cpPaen
	o7UrEQCLB/kCzH4WWvLojzi+nYr3F2un9qF4/44UYjtW/tUm1Dr64DbNcJgV2FTKRBwtxnTO0pk
	uNxzMePxCDI3yscvbBCCOmcK5Uy6ghq5lEiS+QJB/3XkQUjUI5xn1lAONZS+Z4PIa0/ho4GQqqW
	wlX4pe9yqeXWv50afeJBa2rYjVYrBNJPHPsfKNSIwuKdb28J42KGDzkItbue2MXnmPg6lyKSCYH
	sa70dAiHYq4ZFQnx+rSXXv/PLEDQREglqtQsz9aHjCy38J8OcxUJbsILfQgoi595FOjQq4ZQH0i
	Jln5nP7k11HgbkMXCFS8eqZA2CicwtZZtRk2owy//kdQXQQpV2WbLAl2+ceiiMRkIW3L9ITKsnr
	igWAGyPbpWqusT0w==
X-Received: by 2002:a05:6402:5489:b0:6ae:1504:5ba with SMTP id 4fb4d7f45d1cf-6af9e3494e8mr7547767a12.30.1791201042900;
        Mon, 05 Oct 2026 04:50:42 -0700 (PDT)
X-Received: by 2002:a05:6402:5489:b0:6ae:1504:5ba with SMTP id 4fb4d7f45d1cf-6af9e3494e8mr7547755a12.30.1791201042608;
        Mon, 05 Oct 2026 04:50:42 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb0228600sm3394452a12.35.2026.10.05.04.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:50:42 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: ceph: fail readdir when the MDS reply carries no dirfrag
Date: Mon,  5 Oct 2026 11:50:41 +0000
Message-Id: <20261005115041.1906915-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <912FC30C-9C0A-4D68-A49C-A13CE6C9DE8E@stu.pku.edu.cn>
References: <912FC30C-9C0A-4D68-A49C-A13CE6C9DE8E@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yuanfu,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

