Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E434040D
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458039; cv=none; b=cVasNHdTx6jGcDYcbTd8crvgwRdilwzLy6OMpb9DTSCuirfswcE6zi7IsxP/XLLpGYLGQ+mLTMRfUH2fxT0L5lXhmO8rTGXj4Rlui7ekuzzFM5Vc4zO/C7lShmZuoZgML040MxrW+f6PVqJ3sqfGjiN6Vtlk7O8CPA5h4fWFKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458039; c=relaxed/simple;
	bh=UE21QENttGnXanOXifbm4tLyAFZarH+ar9pZl/b+AfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwKsgX6iu7dIbxid4Po5CEyABNDy1IEnx1BdSF3fKbkuH33jrd6N+LMS29VvRWHw+uWxQzIEYtykvplbfkbLV75NzF+Hme84KzJSCPuhBkYdiBxoG/zPtyZafkztQjYYqlZBobO6fuWlVs4iPXFv0P3734LQg5KwgUgkddp8DqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZjNdXKs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHwX0v7f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZjNdXKs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHwX0v7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786458037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE21QENttGnXanOXifbm4tLyAFZarH+ar9pZl/b+AfA=;
	b=LZjNdXKsvQxvh21Zw+cQLGSJVgrTYBJB8YbGmV28Iv6FaG0iprWHL+ZyeUJ2Ww8+kgt6FM
	feV/0R0BOlfkCKcyk/+gluu7Gza7JYbxGHzTCZJuU6L5xfcPsfH2ODJ5gjjJL4xWv6iWkO
	lEhGkiDs9arY+I5AIR5WZvsHnJzIpYM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-hKdzFwFkOnak62FwYNlhiw-1; Tue, 11 Aug 2026 10:20:35 -0400
X-MC-Unique: hKdzFwFkOnak62FwYNlhiw-1
X-Mimecast-MFC-AGG-ID: hKdzFwFkOnak62FwYNlhiw_1786458034
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a19d668ba3so20140a12.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786458034; x=1787062834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UE21QENttGnXanOXifbm4tLyAFZarH+ar9pZl/b+AfA=;
        b=LHwX0v7fLw7Zdel4cFtymH7cTZ9/rTVfbTFn20UXl/tOwWHuk2EArIB499/sSgKY4d
         HwK3fgKwx+mU3exUPVAkJP6ripOIY41FEPtARM0+Vlc80kNsjd6py3Z+hqJ7+SvJPbTf
         cJb7hVn4dcILZTwKUIQVmHt8YRLiSECNcmYV8qBM667f9MGmQFfACBbozSQGQPT4wDbl
         ahR8wAd2czmnBle0FdKiaJkGvf/yKw/A9v6EGz+rOOPajRkylDwgD9GUws0FS0s4Mx7N
         wZtZ8mNvX/MV/ghQOqAiBThMbhbWEWeaOKF1Da2KmbC7G8X0Z4qMC/HJLE3T+Ow5TGp+
         li/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458034; x=1787062834;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UE21QENttGnXanOXifbm4tLyAFZarH+ar9pZl/b+AfA=;
        b=T/Mzin1LTN4lKsZqwYOciYF4CpxDuxpuvPwTDkkgqfcVFHvbU3jypLCN8vQZQxuK/Z
         Vc2VRgxOS86c5jEruzUIg0yfsvg58+DkEva+DSJ4ksf1p1lz2rwfO9f3spJ0hdIRIMWF
         g568BiAREd7+wTAyVwHhvJYcg0ktAK41tK2ykJrERu6fGWqBdl0pYmKpWdAcO74mMFmD
         MUkeW8nupX9qbhqvQwvZoV50AeXbzEBWbsdwIkLI5iV/QKTA6nZgd1ZKagmQEaF8Td+5
         llkXKhUNKmoy+S4CHrojyTXAneO5sL8DjPTCLSgijqpCdQ23dEFPTq00o7RkbfFESGxt
         e4tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq73JwNToPLUnCSv9gDJmz9UzYMzlyapk0mZPXOEXjBHJgowdECmj2safYQABXD7pcVP8Oj6O7J3N2D@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEVSDlAA4U4adXSJAuuyL3q8AvqKatmT7mGRTFmr/jFpLhtk/
	Gc218IsseDD+8UiSVWi4ZLLAoZ/x8/DTnpUuk0aVqRCNGIui0ooDn3q76ncfNd16WcLlYeMoPov
	O7IPQrMitwXyyHiwouCsuFv0k6hOHG2FEnBL8E5ZP5JoGXn/QODFEnvqV7Ag1KeU=
X-Gm-Gg: AR+sD112aW9HWJpcP5QOQxY7PDXW184azDFZffgb5/ac97wuU5y121DrOe/1tYlRhEp
	eL84I2/aTWrKFjtjl1wabDPOSBeN5PJ7OcEdAAXn5NBox1WmLz5qZfs7WLGd/vHRRDurUGVUpTh
	195Bd1DmtmnXa2+aacWoHg5GZrXvboEimHRugWqAVRH8tOWZRnGdftG4mI2/ryezyok7kEOlx5r
	cdfmsEIg3lU+45PCsN9nSzSqZj1c3iS/uT2E9IlJGWRmOw96Al/gJPaW8OYndM44xp+LW/nPwCd
	Ji1b0JECFs1eQpcsJIgNKPDjRrbvwPutTv5eCzkcxCn5xxo5dtEH0bfuBBy6Ksc+Oooh0mch0OX
	QQGthelqRbOAoAw0UUR2KxjRSjY9WqnJYrw==
X-Received: by 2002:a05:6402:1599:b0:699:728e:48c3 with SMTP id 4fb4d7f45d1cf-6a3644ddb47mr2679089a12.9.1786458034590;
        Tue, 11 Aug 2026 07:20:34 -0700 (PDT)
X-Received: by 2002:a05:6402:1599:b0:699:728e:48c3 with SMTP id 4fb4d7f45d1cf-6a3644ddb47mr2679064a12.9.1786458034230;
        Tue, 11 Aug 2026 07:20:34 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362efcfcbsm853481a12.31.2026.08.11.07.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:20:33 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 00/12] fs/ceph: optimize struct layouts
Date: Tue, 11 Aug 2026 14:20:32 +0000
Message-Id: <20260811142032.2700096-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

This series does not apply cleanly — patch 3 (convert pool_id to u32)
fails on both ceph-client/testing and linux/master after Ilya's latest
rebase. Patches 1 and 2 apply fine, but patch 3 can't build a fake
ancestor for fs/ceph/inode.c because the blob SHA has diverged.

Could you rebase and resend?

--
Alex Markuze

