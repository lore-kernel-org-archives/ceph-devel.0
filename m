Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D630C147
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466261; cv=none; b=g6McBLX/GS8oDNDtuT1KIsIzFGqZq+ExHLWDShVQW5i7D83wi+GlVo6u1hRrzIWrrgqdFEe3KjoQHXowMM+JfbBXA8xyyRO1ZQPcfHE8SHl5qVppD/wih8QwNoXc33qWP4Tpik7OJglMTQPS5yeYpQb1QNxixGbqNVYkSPjKOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466261; c=relaxed/simple;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1ij4IrC3SsmXA5bcPWsV/J+DNZGPUBTyUgzNB6RBpwbsmTiqiVYRcpr86ovPyIN0Ze6gJKiheCo8ZnAsVZKO/cPnIsEcstQRZ0p4XOzvjvQy/Y4vhm0gXLde2p5oQPRuZFENZhTqFJjPX0FFMnp4ZChpMn8z4+DFL+np5ve45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=go/cE9wz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yk4oJFNP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go/cE9wz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yk4oJFNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786466259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	b=go/cE9wzC08uhkH03qr4gRajvqkhAcQhJHMtzRLg83BlgY30QnWw7/jRmA9YvgujYfRiVU
	+6eMa1BtN2gp5s7rQUUe17uAJC6HPTfVboNwdnH+n3SE2Z63jD2fXNNBw01CijEc0geav1
	TfqCdKJ2cHPbM8FpYZNOfOJQCazvVCc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-CrlKiEqNPqelFZXIXsdqvA-1; Tue, 11 Aug 2026 12:37:32 -0400
X-MC-Unique: CrlKiEqNPqelFZXIXsdqvA-1
X-Mimecast-MFC-AGG-ID: CrlKiEqNPqelFZXIXsdqvA_1786466252
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9f6f0240eso89977a34.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786466252; x=1787071052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=Yk4oJFNPMB6QXtj+62WO1LaQkAGt1gMZTEgrD4C6NGukM52efX/6uWgAEpO6LkTNme
         /NfT3dBh2hD9dQTRK/C2ET8Z4Bacu5aqHPtaAApWkSKBh1mCXmGNgsfT7dUMj74QXP1C
         JX7POGhV/5EhNiJMDFqTka5gOkmFaMJmscJ1yJHQ9fm0GSjXNNG1BoIHiOnpiYvOuslD
         khhRVqNNBxtuDYyzdR6ZwYajejwXgpznnyhaCrjFK0obeZdkF4HvJ+Q3gCxoT3mQvoms
         imt/C6H54+NGTrQQdO3tWVNeE+V/oyvuPt8lxJxAqndJtU7dCfM3abhFtHpxh43DkfWA
         DqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466252; x=1787071052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=G7SbUkIUbPFC9KuQwNu6N7BnWBebuK0agpxa5ySz6qOJqHqpeyaf2FDzCF7jcWIrar
         BL3nXc2rKdbdCmOPlLc7PxrI+grz3LtW+etlJXFXrdpq2ckFPRmjGaHTpHRZR4aejGrW
         WJV81rPdQWAOxaZ55p14kharTBUUJroDsZuOv3aDpnQCRUicI5HqZxlEP0s199WyZATe
         dlhMcQuwb0ZQ/V8I0euF/NrngIn6xlZtcR/UnTteMmK8Atq0iTiePP8dsdBJ/QjQafgK
         cB6PqH1oJEGkw8ktJw2JsDFbB4zEuwKuOuOViYv9K/7iEU6HZ8m+CDguYYC1bg51Gn5w
         Q2Iw==
X-Forwarded-Encrypted: i=1; AHgh+RqTTRBJIvlW4RRVefijHFmW5kBVJiuCLyy3cu2yDIfKgCCCl+22o19h64sYMiZJEEqJ2qWdw0BHGey7@vger.kernel.org
X-Gm-Message-State: AOJu0YykgovRRIP/IgAiDptTMtlmOEtTEs6uf0zSsk6DpEK3cpBnfqIg
	eQrUD47wp1GAz3n6Nk3OqZdp7MenM/OHeDSp7Caeew6/DS5JOhdxsDsEb1QNZLSodIXOtJCRoRg
	hJIWu0NV3OQ3EVHgVzXrryd7Afdh2k97tz0+eo++jw+HOrhkIG9SkoAf/bvkgQlIHy4jHont1kg
	==
X-Gm-Gg: AR+sD13Xf4k3hbL8Nu3/LbFrKazh94XBm2Hbc9a0VCZSMVWdWSky6P5n3GIJ/YnJXgg
	RaCLApaCgPufVsL4HjHLHhodnwnWohpfIFBetipVhhgljJ3MSoQ2Osuob9gKoZav5X7ywxwyz6j
	JlpVKCqjtgti19Yn7fYAByEzlqaffdRrJfLmfT++2URlDyUkMTFrPz7Hp/u5hKhdXypPE18eOWY
	R50ENwjdWs+yPpTzvpWQSekaLaqW+9qQHUcUWkbMUNKHhAOBXd91X1NEE4u6todSJ/XVcRUeB+g
	ME/GsPJ5YT3+Xhvuzxf41p3q2C224iPdyarEhN1EZjHV74irebe71bEmgoP4QhpyfDWEsg==
X-Received: by 2002:a05:6830:828e:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7f3a8111263mr3901033a34.1.1786466252169;
        Tue, 11 Aug 2026 09:37:32 -0700 (PDT)
X-Received: by 2002:a05:6830:828e:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7f3a8111263mr3900998a34.1.1786466251838;
        Tue, 11 Aug 2026 09:37:31 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b320d5b9sm254687a34.9.2026.08.11.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:37:31 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fs/ceph: add helper function ceph_cap_is_removed()
Date: Tue, 11 Aug 2026 16:37:24 +0000
Message-Id: <20260811163724.2759461-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706073812.3922732-2-max.kellermann@ionos.com>
References: <20260706073812.3922732-1-max.kellermann@ionos.com> <20260706073812.3922732-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

