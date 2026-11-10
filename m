Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293567;
	b=MuguE9na/qT3Sse+2/GgH0KRc3UDrmQQtqHzpYRn0bOt2foyKe7b8HS7jLjPh01qnZDg
	 sFQ82V80BGDhspCGEERDlv3H90tLwp5gDHP8er6d13oHH5+1QpMEe2hoyRpPR0x3WSsqa
	 KEcYVMRk0xBbOG+sqog3hfR1i+lOgMjA/CsopWuiEoC0+Mv/vGqDsAuFLIGt025ouwc3Z
	 zAYmGq6sfHdyyxqDhi19G+ICxFdYzULwCHUbwgI0IXkaIEeXNh6MR8X0rE533RlsvUPGe
	 K1QBzqQ6FKFtB3SsPGh2jQi+G0tjbxTSiEVSf5XgqUicXgBesl5k5Lf+LxI1lP3+CRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293567;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=xfP3Lpeh1GIBUXxSeR2b+4iZE05pfDlZcowuZ3Qgvqtu9+z84eFXAK8/JrUhq2qv99V2
	 tiPbeWQvRsRdrcdeB3OzJCW7O7wfuFLJoolSq3qXGg5mdmP9uGMCbgdrl60XgXDhWKgzb
	 iptb3r/niXu5zUMtzFK9kLSMdUUTTTNpakUJG8xj4sDvlyhdW4Q+e6QQjsxRpvVtx3cPT
	 q2dW2JWGadINSD42cCV1YySmj64bw2Ca2fdoYSgLSB9VUThPfuTV4OdhEkRt9DCGIgZLn
	 oZZdzflOdJlPOVmUrMbk/AtqejVgUdSVHCKawtS1cHTugt+13uxg/S+/HW//U0orOsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JZrBjlHk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gfD1a7V8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF478606A31C
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 06:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF478606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JZrBjlHk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gfD1a7V8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794293565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=JZrBjlHkaKRfCu41TTtJLWk6xvlsUz79EGtgsMIu0q2xQ/b0ylqtmOJ0XWiSf5fwtpsNxh
	9PbMxV2ARGb4dAUbiWntTsszpfzLVxqc+MiSP4K0lBhrdXVQd0Kag4IgE+ZUHPZGTWROl7
	zYtrVR6Gim+IbyLrPBAV1GUWOJvk/Rw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-wuUImKWTNpWXnskepTpbRA-1; Tue, 10 Nov 2026 01:52:44 -0500
X-MC-Unique: wuUImKWTNpWXnskepTpbRA-1
X-Mimecast-MFC-AGG-ID: wuUImKWTNpWXnskepTpbRA_1794293563
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0ea6so1976598a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2026 22:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794293563; x=1794898363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=gfD1a7V8Gooi4gqECHR87sR/UEDN5xStfr3hVrTOxrD5HrPw9/i5DYX265XlCZpu6C
         Myt7CRNCmtqtawOsHWZHcuXAt5jgQ0hCYrblCRH7vbp2h+4EYihlOWGG61+NkVHVif/e
         YkgfBZIaob029TwpibTHFZFlesfcb+Eudnjl2eSlRJ/uQMamknmgNEO1qmcX4hcp9lgb
         uCUdzXFJ2N0/ORUVpHPB2pKluDgfEQY7EOQ32MBZiq0zuoBP3OvQmW8of5dR8RNmekJd
         q0n0cg8R4vNPcN1SCgbzYuQ5HZckWta7vJlXh380heF+KhwUeDFIzVtMweqPMXUORs70
         OzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794293563; x=1794898363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=1sz4hy3mMKjdN2W+neYTvkVS8ZaTbfKUM8uxcT7GXrXeI++6jSLOuqMz3swaBVbQZL
         OSuLgeLajmrC8kOjsFOSgveiuZfF1j+yzlCj0UAOMIVrfsHdVzm525QSP+GoMbb03ylH
         54cyj0orAYZobszaNIl6lF9hzpnTtj3RNTqC6zF0XAsMFeFq4hPIzC7+NRFOrwBk2aJZ
         N7QaPnmh/K5Q+ZWtrzYESyGzi/61qoIHIFDtfRIJNQBef30WNBZgip7a049xAGhEehSf
         JZl5AkWmQNIGn91rPAWQcy+I+v6n10btAzy5HDmw+YjuWhzB6xXVa4jHG6XYYwHVKOpC
         gvpg==
X-Gm-Message-State: APuU4Z/zpRJ9G6rujvMJ1RNM/l/8ark3U+wRjWt0FBmB+Hc2ZRJeDzYc
	cEyat37AEB2N3Cy+VfgbkcSa2aWtkUaXcGSz6fHS+DO1IruiEINJP3W65XtcHhY6WxDhfkzhWhj
	PAscbv3RUpLjvjD42kRsA3ziRQi8nHUxlV1yt2ve2fGHZTi0ue06lALBOpxPDzCk/zRad5Pk=
X-Gm-Gg: AYBFou1RL9SnEcndHWmHqJK2lK2iGqEqw33IDNq7MTAtbEuoASe1fj2fj5+BI5YVs+k
	/r4b7L9MT+DF18Qhl67qbUpVolr9KoqDiViQE7kC4qP6bJwZ/L7F2Yg7XQ/3mDMEqlhomSKPmM7
	eiBOD7T3cO09wGjl9r8ByR7jnRTZlbgwMXO3gW8CFx24v8e4O8Yt7dWb/1SRxuy9Py8CyZdxnE2
	p7blSJvtKBzG0LLN0S9nNkUWQz3jBQIdRscq108SvB26MN/gbR5MSbWqj49IqcYBgWIThsgRAZ8
	i6rx0DfYYWaEwrThQzyYy8nXhYz9PkrjAbuSZnvvT8ARlc3IxxkCH1Qaepgh4w70iCPsoMymGtb
	/BuuJTKks0IU9A8SE/SWDjYb9Bx8u7YJEXH+YyAjrss+X03ZEzzsPKSUsbJod9cxQbJYtfWEPE0
	poKQTaEPSir4mfu3eVALSA1pID4v7h7AKQSTWp2/TxjHhHUe0JqQdSiX6X0Pc8+ccoNNF/ijnHW
	k200VDlaQgRXE6TeE5ONEras+Um2GQvzrgZtmpMDNch8KzE8e6j
X-Received: by 2002:a05:6402:13d4:b0:6b7:182c:5d4e with SMTP id 4fb4d7f45d1cf-6b755e6c44cmr1550930a12.5.1794293562797;
        Mon, 09 Nov 2026 22:52:42 -0800 (PST)
X-Received: by 2002:a05:6402:13d4:b0:6b7:182c:5d4e with SMTP id 4fb4d7f45d1cf-6b755e6c44cmr1550923a12.5.1794293562420;
        Mon, 09 Nov 2026 22:52:42 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b75791d210sm706409a12.37.2026.11.09.22.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:52:41 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: flush the caps ceph_write_inode() queues from the delayed work
Date: Tue, 10 Nov 2026 06:52:40 +0000
Message-Id: <20261110065240.3170288-1-amarkuze@redhat.com>
In-Reply-To: <20261107-ceph-write-inode-flush-v1-1-6d414faf9ccd@clyso.com>
References: <20261107-ceph-write-inode-flush-v1-1-6d414faf9ccd@clyso.com>
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

