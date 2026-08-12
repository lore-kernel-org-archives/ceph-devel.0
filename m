Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD7450406
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541798; cv=none; b=cclFWY3pmRADUiqgfVtaNn2SDtKhxloXHpOcV/xcm71l5D1Zb/mIcKBao+F4q5JGGPjaw12I/A8WeGt7eE3PG2mGj6cQQhN/wNnW18mVChZ0Hb7L7VjiiPnHycLxhn44kkp3+Nw0XNGWCyh0XpOkXTiLXPUIazSirYcHnmYyP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541798; c=relaxed/simple;
	bh=6n57GkRo/H9SjcMNPgrx8CXq34nGdpZlNBfaopD3VHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPZlF5hZBDPNnP21kF9DBWm3Se95zjNe0sDLJ+FW0zhLLTOWE/peFEkkdoi9odx4m1hTqNNbmWFrm2xWp0RUJEBaWsRWI1MbzJ2GzEMuDGocK5mMWPPjRHYknnZXwZz6uds/uMiuuWY8GXOzYa4gQ8jgsk5UadiE9ODNDjwb0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6hH5L3/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMwIAa06; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6hH5L3/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMwIAa06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786541787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6n57GkRo/H9SjcMNPgrx8CXq34nGdpZlNBfaopD3VHI=;
	b=H6hH5L3/bYV9kxR0rfJkVHihmJO5U4dYIcMvDc6y7n5sFR1DoIqUiE2Gfqcc3RXMSsdDhF
	3sk1ZdvHHhoYwlw83fDVvL9YSdVvWsXRoIx/Zu8B4+0mtSLnePnU+vIkreG3q5HirPIcGo
	rtWspk6aW0yk8kZaY8KKrgF+R7Z7yOk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-3foOMUU2NYy1zdn3s6LlkQ-1; Wed, 12 Aug 2026 09:36:23 -0400
X-MC-Unique: 3foOMUU2NYy1zdn3s6LlkQ-1
X-Mimecast-MFC-AGG-ID: 3foOMUU2NYy1zdn3s6LlkQ_1786541782
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1686e23b9cso70762066b.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786541782; x=1787146582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6n57GkRo/H9SjcMNPgrx8CXq34nGdpZlNBfaopD3VHI=;
        b=QMwIAa06T6KKo3eq4LbEV9bk6D+fXg20NLf6L/kGyvLgSAf7fy1Fv+xt5KxCRS8N4q
         6spWq/1oXF8QYgBzV8OBxtp7nBrIIE5nKvMfMMEF7+gFjzqnT8lLX2lL8IG9y30imRDV
         8K40Bw5YHQ8tz413CrANhaOXi1VeQHXNeJqELwfT/DmCQpImehABEb4F/pfzmRzug1so
         kruaK5+i0u+TkDAZx/cW3Hk+QovfefnuZvAT3Bo1txLki4UN1m0v9T24DTJC8oxZK0Om
         NyDX+NsP7RFIUif2oqrk2O7icO82ors8T8ms1YHAYvdKwjr5reBfh5rsAP69kWr0OHFc
         Ulhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541782; x=1787146582;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6n57GkRo/H9SjcMNPgrx8CXq34nGdpZlNBfaopD3VHI=;
        b=rcPdS970JBVi1I0gkCgjVQnMYCbZB8w3FoSfbiXZpHQzH5RdnWGRWuaFrkRgwvKicK
         z5mBayUl68URSf8SkDXjNWpysgNNOiq5er1+G+o8CLYlo6lGAvhrxKBydZcM4bpczVsq
         F7cpg3CJgTaq2fHiW2UPiPXGEtm+ihwH5Ft+euleqdJ72IDOFSxA0gYwZvlq6BgkmpYG
         0lAO2zxtftv31GNXr6zvBSv20dpyy65zXaQAnSak53dmnQe/kxgeybzTh2dKGqbgt4Gu
         OPEw/ScRg2BMHEZK0ZlX7mCdH1BLm2Exl4g2995syXynugAlZdgdMlz8R/rzqCLqTkOX
         ZgFw==
X-Gm-Message-State: AOJu0YzP6qcQ6BLd4jGwVj4C7CRqunj49MY45F/nchhirkfOE3OvWnax
	m33SvwbF+s4hPqXZCwytUwqOqFgmhoXvQ7twVz4Hvh1XRoODEWatVtjQLJDonomYY/v8XmYoS46
	P6iEUhvEgku8kNNyI9sTOynxXMsYzEdibyXoaxKSAFPGkec2XEdsZ+2mo8gIGwfNDwI1jr3uiYA
	==
X-Gm-Gg: AR+sD12acs/gEq1hH0zX7NuGgPzg07euVHaxzOcikTNTJoGj2AUM3ljJkuVBZ/m/XeR
	m3AKKH+xAQjqIcSv9ChHF0Dq0sLATZMG3C/jVgBCxYcJLIEix/p/Z4er6MCa4YLHTonDVGnbtEW
	Z4rh7Hd9ZNbaloEzklgMU/HUHjcO5ez5SpevxjlxJo2mLyE/bTrS2Wx7+f/G7xmyC9Q/Gg7mVLi
	i6Vhg/yhE4jHOgL9j4dDI2RCsyj8clqxryVn+fIP4IDwAukKp8Tbzh3O15o+elIsICD/fb+2oyr
	ise9XfQNLezW5tAREaXUoRFyYZxyBJ+GsvTaDY6/nevgsee86Yf4XY8BZvXK9iRJoZNmGVufYUk
	8Wvop8dLo5GiJC6+y58mdFbCGWm4jSbCbaA==
X-Received: by 2002:a17:907:8dcd:b0:c1f:b883:ed3b with SMTP id a640c23a62f3a-c20f2e3d704mr223321666b.4.1786541781738;
        Wed, 12 Aug 2026 06:36:21 -0700 (PDT)
X-Received: by 2002:a17:907:8dcd:b0:c1f:b883:ed3b with SMTP id a640c23a62f3a-c20f2e3d704mr223319766b.4.1786541781331;
        Wed, 12 Aug 2026 06:36:21 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20f074548fsm92330666b.1.2026.08.12.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:36:20 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: tz2294@columbia.edu
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: remove the dead dirty path in ceph_put_page_vector()
Date: Wed, 12 Aug 2026 13:36:19 +0000
Message-Id: <20260812133619.3296509-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu>
References: <20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tal,

Good catch — the `dirty` parameter has never been true in any caller. Looks good.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

