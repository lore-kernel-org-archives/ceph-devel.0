Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0246AEFA
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992465; cv=none; b=QR03l7Vos8SkY6xe2rZk6JOGwWRrU59ycDxS0zQAuBO00xEMcW0I+azONZg/HdXV561bLot/MrERQP2enaolF9nT0uoZFNU9ertE5uPLJBtUnaSFu67c9ETMZh4IpLLwMyW+7X4JRGqnWtg2FfMwKvec6geYnqkwjBmKx/uBVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992465; c=relaxed/simple;
	bh=Tj3TOn9tIgnM/oY1Ihjy0oeRZzZoITeT0EJy21D7RUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fL60EeFHJ4c0sV+gveEbEYgN+et9ezbXbCsVaThg81o3ejDEbFbLs9mSbCi03AJ7s3dGx9wFDqLqVeYsM8sakHruy+ubPhBRlfMF7RgTc6J6+7CoWYrx67SHr33Y7Jz3S5Az+yCH9i3dqiWk9m4GjYSLLH+qH33Hh+DV96LYuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ac1gdUoy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9aZnvqb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ac1gdUoy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9aZnvqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUhAaFeUiq5wN0FRCa6VaRWY2/u/UZnqNNBXo0CwUww=;
	b=ac1gdUoy+EoT1vueyZ3HLzpkN7hQvKTWr8aRzgHf6d3PxRUEz3Gp0GXoQl7vGALYdxsHd+
	OBi2X2CQaAvNIljsjxeckUieMiw5+jhfkHZYgOQtSkZiuDiN2M3Zk4cLYDQhuVfR08Y3bF
	W8a4EPEv5rowl0wEDYSJggiVWHV1Nfw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-D00zfP0QPI69_8ILiYax4g-1; Thu, 02 Jul 2026 07:41:02 -0400
X-MC-Unique: D00zfP0QPI69_8ILiYax4g-1
X-Mimecast-MFC-AGG-ID: D00zfP0QPI69_8ILiYax4g_1782992461
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9fec69475so2291170a34.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992461; x=1783597261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUhAaFeUiq5wN0FRCa6VaRWY2/u/UZnqNNBXo0CwUww=;
        b=S9aZnvqb6qMV6j/F8hMHubT/zGYP7mi+KE+eZr2qISN8S7kdnf2UhxUEUn35HfTYSv
         7spNrxCq+Shd57wj5hNhzdoI5VDCdnFGd1T6hGpLAgIRy7q6J2668RROr/pB36U51Vhu
         GwCcodj7K2PfBdx7VEmqYzXSSDgZssudFIDTHaZrX9rPu6oQLWrk9Usf3jrdUwQlZrbE
         8Ujma/4UiG6RqbMUdloyXjtI3HftTN1Cm6RakgRBi00RSKiQyp4lTE0PV6OTpSnoofQd
         ZwQao8PrO3tJsZBVKaQvss3nrKhmL5dQqRfnVXw7Anb1xBpv4kgltFSXNvxzt2oaCQta
         KPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992461; x=1783597261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUhAaFeUiq5wN0FRCa6VaRWY2/u/UZnqNNBXo0CwUww=;
        b=L81x9LdYp/8u+PZ2CqSVlmmnx9hK54kbTmgJY4kzkVz0qLyXRvJceDCjufNGggWYMu
         fpCSkcPTTbDl48Bkt2wh9NkQ2Lv/nDq2kVBpPsi27tBGpP7wEm/3zdZ3XwMxqdLfq/3Z
         2ydc5wIthJd+UscLxVR2kcN/78SiQExB3BVgZxW/UG5Nw5ZsPTHXy8LXUcH+ChtBhCFX
         s3sVNJ1ljds8mn59Zc9kQEPZWZ1OFAOc6McaAusYonjH0iSDi47PxTDexzj66yMscbxN
         XBGqUr7sV+sJLVzB3xh5c5jQqLiOiycFKnamAXEiEZwOFClNrAsRrnuX8r4zNEG1Xr0N
         jiRA==
X-Forwarded-Encrypted: i=1; AFNElJ+WNzAXTrIk/HdjdnfWbiW5IlPJbgc07a6o7ooQ+f8wgqOPGih4uK+18+LjF/vH43Ip4cIXxVYmW8mI@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2L4iJUE2nEW33vapqZvVyAugx6fryqZhx7UXk9NoKhgrbiNY
	eZPpBtF8Ogg3eyPQfwAPw8+Ow3ZqTaahQnHD0X54XXzulYM8FiJptEYQXcSeDRWPmm+vP8Jxeff
	fNN5Yy9rNNOLW2qwdHr0CZmKHfitX/kQqrd+PgLeD+aphw1dTiyTgngAC67lF6YZYM4EKc36McA
	==
X-Gm-Gg: AfdE7cko8R+XGt0vo7264f2Gx6Lj9QWZE38iWLkIG68b+OY3+m8z4TfKzcbZkngqA9I
	Nll8wmfuftgUPBBMr6K8P3e80HMVhIRsA7AMC+nrFg/99St1GPAIsR+fdUyhlxlrhnUZ09UTZEK
	Q9rZehpphDE/MFsnOq6jLnAru0sMxWRcFDC0N1Zju3X6IC2hyyx/l1YDEKgKDsSeIfd3sDmJEMv
	5bPJ91lNIrcU8lrrTxqKEUQyB5qhCm7cr8MalIlMLLSSoIn2DVUOsi4ekYyT+0PnpKmZ+j19LTf
	RnDu4KdMAdbnzXTLNZSlp295YoWrzrNUPfa+XZiosGpQdWKE8lSxv7pd6p35na9LgMieRqfpGpd
	hAns5
X-Received: by 2002:a05:6830:439e:b0:7e9:d634:77b8 with SMTP id 46e09a7af769-7eb50322367mr3224612a34.2.1782992461516;
        Thu, 02 Jul 2026 04:41:01 -0700 (PDT)
X-Received: by 2002:a05:6830:439e:b0:7e9:d634:77b8 with SMTP id 46e09a7af769-7eb50322367mr3224600a34.2.1782992461137;
        Thu, 02 Jul 2026 04:41:01 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:41:00 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: jhapavitra98@gmail.com
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v3] ceph: fix OOB read in ceph_osdc_list_watchers via uncapped outdata_len
Date: Thu,  2 Jul 2026 11:40:34 +0000
Message-Id: <20260702114034.917507-13-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050042.1436568-1-jhapavitra98@gmail.com>
References: <20260609050042.1436568-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pavitra,

NACK for now: this patch does not apply cleanly to the current
testing branch or linux/master. Please rebase and resend a new
version.

I tested it with `git am -3` against both trees, and both attempts
failed.

-- 
Alex Markuze

