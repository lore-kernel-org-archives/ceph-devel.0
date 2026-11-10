Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299835;
	b=PWVsQra3KrqlZBKNuoX8MQBeWCoOqInSXYGG8qz20QD+woecbnP7PvSO9L9urCCoc76B
	 ZspFnI8kU0P/TXZxwWrfzwfTbZJ0uU+cfX82MQa03KCscBx34l5djNlSqEdmxiq+QfAqz
	 bfxfgOTw5EyxKqwl4GRr0jJzDWBHhU1pj/bOYVYU1/AUZkjETWQ/gncGruYmqfrcA6bZb
	 rP/qSM4yCNw7YXYX8vcnF8+vb2eJpa8ADH//07miXde0dRmU5jZ6TUHWeHwQRVXy1Fq4G
	 6GVDM3fOyNgPEkoXnAOIxqfmt/wVP/SMIau3CxAFGgDmY87NXK9Vbu1wZTpI4kWfzfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=30+obonAEECMlB7hWjzhOPzq7Y/PwqLRXpVq19+W4VuxFZ2P1bqKCF1LJgv1JzhJhVia
	 BoH8HFl21gvx+wFvCYJVTlK8AezfG4M9FUUQ2BdAa8LfhOMOWow1if8CkHjgkXAQM1Unr
	 XKkKnp4PS0JYbvJekNZ3L5EnuFfYmhDAO7EsCr+558quUzk67Ta2x1zLjy0zXkmTcq6Rs
	 8+P9gfTgNDqkJfgoBs1hLPaszVr1HxOMwfhp0ZGE7ydlUB8g/f/rJ6Fl/LLxOmdN+Bxif
	 H5zBJeo9dZew7btS18IVt8DuYnPECq1hwcsV9XIDEgFitFZoZnVsAKeNLwEz+ejSHfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="bh/8lJke";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pzfYZC2t;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313E606A321
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 08:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E313E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bh/8lJke;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pzfYZC2t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794299833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=bh/8lJke27ObZyzCeyWHLNbcBpEeJphihL3ZwHMuLp8MrDwB+68dQapARgaRykjOMg398P
	tqLEJQVP27VbVmXmPmLjETfb2axxsBTQ+Q+wLidbdCI3g9DacSfCkiWWn9AFMGssw1SoKN
	pO5fljKhxhXj0COAyzq6UFTnUWSh1PM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-uLYYupkMNTiB5jtk2f3lSQ-1; Tue, 10 Nov 2026 03:37:11 -0500
X-MC-Unique: uLYYupkMNTiB5jtk2f3lSQ-1
X-Mimecast-MFC-AGG-ID: uLYYupkMNTiB5jtk2f3lSQ_1794299831
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so333915285a.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 00:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794299831; x=1794904631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=pzfYZC2tgEIP0UADEtRtlfFu6KnHO+zoCpcligYSlRfVe9vbUDyIFq/fsvRmgS/6Zg
         y/5U2da93rqebo/zvWaWt6OLrXCs6GYy02x7FRJ+8edUNLXvTvHw5F20XqZduH2NiL+f
         vyoXzqBN9C0NPn8MeUn3F0YO17Vyt2RriWsdHU9U4FoDwbJT5rbpOXJMPgb0KZZjM036
         QMHpq9AhlGKtS/DHxnCv6aMb0wSFP71pEi3F1fU9w1Um7cZ9RT532UmbhDmrHuVHDrYB
         9abxHjdNQYVljXNSA2ey4ShGqMx5aVe4MCTUkCNjyRvqdHLvu/mQQwAbazUjWf76/mSd
         9gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794299831; x=1794904631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=XMFXR2tyhP92oy7P99RU91xeiOusokFOxgeE4q9w1JEOWAqPjdyivdpEKLNFvq+U7s
         9YOcxPfiWbbc3sMafbxrYIFNWVX5oTj66rL631zhoyMceClf4d975IL1t/Egwjd1sDoX
         04RFOr2Ni1g6XQvrj+rUQhdDx2eKeSlbw7EAIH0rXHrjQ6Wd4gHAs6RyJbKBAbTwsSU6
         RNLbRSaZYnTb+gbmP558WJK7ClThHOa0PDR2f0PgexfyuBGc1sMLE9fgoMm6H0goAxln
         jXXmrupePWYgLstw7wkIrA9ARhFafEr2OUA0llJFTvRytGOU0hw5RfmnHmpccIL+jT+T
         hfPg==
X-Gm-Message-State: APuU4Z943djF6EXV+9yJLJ1ET+Gb5EHXJAjkF2pbWA+8EqN7VsW+hToZ
	AUcGqdX6ZfRuiC0G2gIQ18H4TUAXrfShjL5TJrVLAey8Lepg3Mv4F8uN7kEMUI0bXvPeNTdyB47
	tA0SoPlCQL/vjWWt9mZHoPupQy7vTD3I4NDOCUniy+NTYJmhACokmXk49ri178oI=
X-Gm-Gg: AYBFou3LfjcXb50ejyIXCSit1LHVMxZk0f/0bSrj/YWx4jR1Z822zGB8+EpdHOYTWNM
	+bdWz/PXGhJWsnakkNQ0+Fsi3rIjRFOhk34waTC8/wyAwCtYf/yMLTpHw3kkwwJRLfxAC3p8Fb1
	CMrJ6M7UvN88UTKlNOcYJTSkH8DZu3E1YKxuc1Tv6ZuUcL2s+mCJxwxweaW4kLJ34HxziaOTQrL
	IicAhhvLjClYc45PGzYpcuN6RXt1tmk0A2hcX6ndocezimITZuGYwf5H478uxq8WleXf9Lozpo9
	ZxH6sCDwfABZgL0aYK8jLEXCbzKQnZpU+A2n8CYZ5yMOZ32vV578Qy30xG8yOAWumrShU1BQat1
	caklYl8P8eSkw1Mwl18SAWRcLlinY35R7xPjQbbOu32M+oVDwr/izEl9jhM5mjrzORvnL/0wpep
	N3R7uE7hrvihbajJI6kigVd3nLKGAXxGW1c6KKnRG3AEXByIH3a1+Pk4saTok5zfqbelnpXR0gv
	cxK1bsF2KFp
X-Received: by 2002:a05:620a:458a:b0:93f:3163:3e25 with SMTP id af79cd13be357-9479f301c25mr311416585a.24.1794299831158;
        Tue, 10 Nov 2026 00:37:11 -0800 (PST)
X-Received: by 2002:a05:620a:458a:b0:93f:3163:3e25 with SMTP id af79cd13be357-9479f301c25mr311415185a.24.1794299830772;
        Tue, 10 Nov 2026 00:37:10 -0800 (PST)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7d6964sm173107785a.34.2026.11.10.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 00:37:10 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: write back a cap snap's dirty pages as soon as it is finished
Date: Tue, 10 Nov 2026 08:37:04 +0000
Message-Id: <20261110083704.3181507-1-amarkuze@redhat.com>
In-Reply-To: <20261109-ceph-capsnap-writeback-v1-1-d2130bce504b@clyso.com>
References: <20261109-ceph-capsnap-writeback-v1-1-d2130bce504b@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

