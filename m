Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CC3ACF04
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542061; cv=none; b=IqdINo8GozguEBfFNx4HSvPJRNhx1Ncdf+MKB3qRj9vIQ/Ao/NeBAbA4zQZB5vfxvxri411kzfUWNaAJnRgsEzEmnl26rjo/76RFeyKJSOIoLfvMshKy3V/FzuRmLlNZg+84Mz6djAxpKm/mh8PsucsXdSjkrcdmvv7rMQZ/avE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542061; c=relaxed/simple;
	bh=IYSfZ7H+b0WGK/Fj70iB14Fv09MxJ068awrxolH6w5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAUIqo/qJgOElol1++C1vy8HBzYB3Lak+x9DHcM3L4U3DNX+t6qA9sJ6exM/XtLwm/IqKM0HtN45YYwUUxVAtF5QBmqRSQBF1R4Fg9QN7BP7sAgDJ4PcO9K2TTXqKuu1cAICyQHERHE9SF+YIAlmVIXjeQWM4Q0zqWzGT3dw/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENxCYhnq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcdnVP75; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENxCYhnq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcdnVP75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786542054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYSfZ7H+b0WGK/Fj70iB14Fv09MxJ068awrxolH6w5A=;
	b=ENxCYhnqP4Y+Euy2xSOY94fwjSQ36o1ojFrbUrSMXRpA94xcHdwG5uiEEODSIOTAi+4uyQ
	WKx5mLPKFutG+PeqkLpVOdsXU/MPc+xoZoPPf5fCg4YSlBsZ+eQZpsLlLoyTtcfRWmig6g
	qMf2cLVkHnqj+QVrd9wiCrvKYkffKqQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-aaISn86dMjW3jNcuH5XjhA-1; Wed, 12 Aug 2026 09:40:53 -0400
X-MC-Unique: aaISn86dMjW3jNcuH5XjhA-1
X-Mimecast-MFC-AGG-ID: aaISn86dMjW3jNcuH5XjhA_1786542052
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a18f14a076so1199027a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786542052; x=1787146852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYSfZ7H+b0WGK/Fj70iB14Fv09MxJ068awrxolH6w5A=;
        b=YcdnVP75Z49I5P1/i2IjQnT02HUQqNu3/hibGTePN9FJWJyRcNTyKPbsNNffk0532Q
         Imuo4TWYxXE46Kjt7iyBMXSciVzCce0p1n26x+B+Nj3c73CkBE7MnoNxTWY8p8o+MOkS
         bdoSGLvhGntAzo6QVAjrlfymia9+uLWjTTcVSwQXM9Hz2zV9avsE5sO8OqB4YhN37dyK
         k/qg1Z55+NuQC+F1H+P5vnh4rahxVSwtF26DhmkizYlqQHn3ius6aH5GZIrJVlB92i8b
         fpGfS4SJZH/n42z/M6gIdlzMER2fRltY8YPCslmik1LyVAlEa5zkQzeiCLbc2Dg41fmV
         +JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542052; x=1787146852;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYSfZ7H+b0WGK/Fj70iB14Fv09MxJ068awrxolH6w5A=;
        b=eGKcEwNrA0Chj3x/OjpprImfODhFVBXVgS8GPZhoOwdE25mPyLzBF7gqOJWKdBthaX
         e1LaYarXNCHpA9ZkVFxhNxmAz3e10+h7ADE4QBx+JKIWJShigCjz7/TEO5YN89QjYXP/
         IJCPw+q9qA+VJNFK6ZmwByCzWxv/p0wzCZusGZpw5uq7du7SuSTJHYgE5fiSOAT3Q2HK
         cJVh51GspAlbSk5bitxaei9RMffLsPEsFWJZp9f/tGbsuM+AF4/w8aWmJP7PPYEg9VBr
         0dzuZl4tvmEtD1NOsK6KqBaa1DGm0Ff/IUxfqyVPUVbWiRiZy2VrcTQi6oNhvIgh7+oU
         1XpQ==
X-Gm-Message-State: AOJu0Yx3fRVqRh4muqvcpWpYx09eOJ9mGhVZxqX1MNm79PPtD7Nw6tjJ
	YrlAIqvOzYn/1NSMYxaooHSe01pam5mvPVWXEkN6E4/Gi2ZXVpzzwTMsvImRCGHVbEXbxGIt8Yq
	12tI6u6WVEHhU8QI0SyXVG4jCU2hOHOkxov3Q7PLfRMFkiQt1RAraVBKcVsP8r6k=
X-Gm-Gg: AR+sD13ljhEW7xCZoRfhwCA8YWISYv2XmSFQ8B5V1d+1t2h+vK+4hnP5RW2MdeDRRkI
	PH5BfSFmiypkOe45lrsFGQ7GMVCavopCbfzQzzH9XTXbJiJCJVDt5H9KCQyIp2F2LiEqlofmHe6
	6INYWrBqnlP/mF4zkrBSn8qovnQbXGDfs/SMfM7B/qDXHaVPLyhi+AQcGuQCd1fkNA7soqcvqK/
	89hgj6Rqzeh4494HJQ0G8Z2dfaOJ+suI61EOIx64yjAbPfQ8yFvONSor/tUYmD8QJ2ka94+B6Dt
	35RUkpvSmtehZtdTaq6Ubc8XWtvZaK8g3thmZEqYRRxey3pkvEqMKQk0YVMRpvn+vpGbi/WIA2x
	eaeLnw1MkmB1ZBntgweJ6FhnURx72SXIsmw==
X-Received: by 2002:a05:6402:538b:b0:6a3:6c99:a5b6 with SMTP id 4fb4d7f45d1cf-6a375f66b58mr2140983a12.14.1786542052197;
        Wed, 12 Aug 2026 06:40:52 -0700 (PDT)
X-Received: by 2002:a05:6402:538b:b0:6a3:6c99:a5b6 with SMTP id 4fb4d7f45d1cf-6a375f66b58mr2140899a12.14.1786542050418;
        Wed, 12 Aug 2026 06:40:50 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3768b93cfsm707170a12.8.2026.08.12.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:40:50 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: zhanxusheng1024@gmail.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: use the mount idmap for the owner checks in the SET_LAYOUT ioctls
Date: Wed, 12 Aug 2026 13:40:48 +0000
Message-Id: <20260812134048.3304731-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Zhan Xusheng,

Good catch — the raw `current_fsuid()` check is indeed wrong on idmapped
mounts. The fix looks correct.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

