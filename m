Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6B4749ED
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324524; cv=none; b=tCwvfakaBh7EYTS/vc1jt14AHO8hntojGJuIQsJsZrpLO2NJmtam/x5xjw82rzNW11k/jocXYfksxRQAPFKl69uENKKPDPfAtzFD7tSFW9+EhTrE3hw59s2x+cvALyKRhLn3mIRpJA6jFsA1JAQbuM7kVlZpNGGZVsnL92u+dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324524; c=relaxed/simple;
	bh=c8bXkSao9MJ4kDOqs6oXQ3HhNP8HUICfRxyNML/BlEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnzOQVwAiPxX5vYiBYDRxjw6+Qqj37WJ7nW+W3M4v2xRMO+cJyuvzBb4+tBBaNrCJKc/KGEg/KBd2f0vwu0Q04+nhaSJ3Dpp0kCFpZYTsydR8tmNSdzKlQiKNXUafxLGFRtkObnwiww0Cuo29QB2x6orDoQndZ60hSuu+n0LzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vkg4Roxn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkg4Roxn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15f020a223so130717566b.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785324520; x=1785929320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
        b=Vkg4RoxnL7SMMdhAff6n/vIOD+Pc3C/D2bzK4+xOfQr5JJzbu2Nzj2OteytHhygSU2
         2qcOxRr0/unoHvtpi8ruamO7pvP0unzfVF4THkhrNVNBt6nFOzGNIYDPJ4CTyn30aDTx
         ArH3rJa2/Si5ZeDm3EDHg/8cbytqnImUoP6J5guGPJXGEvkKppTDiJaSYm72tJN4N6y8
         niAVdf9dPY5QCiHcVDYsVReWc0cxc5kw5zlKF2EcyZBHMw7FBIdLDuScoqXWL2thfpGq
         bP1JNt9kscBaNxWdYTTaQNDzBwA6z6f4BIecLNChO0Nth/vp8MRI8U88JbxmPS936owP
         giMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324520; x=1785929320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
        b=OzIh+zeulvFIJSc0wSTriZcwJVd3/4ps91XHWFM5M4Slh5pjkrGWVQdi5h+ZEcnbxC
         6S0Jh2AgmeQ+G3AC+s1xPPaZa+BQY++cwg2BKh+S4Jh23dUSeJHVeqHh68YVYktvVVyq
         sFCt8rm00rpSjxiDVvLG6vkQFvWojbvN6F0DIa381cBXzTd34cLXwj+uauhQj2UXaRD6
         +SIzA1xzZ1Vhk5cu+2RpglBqggCCivHBwU6WyTMKhv1ZqHesos1eCW+h+J0A/4KodXnc
         WHhoI0tMH46aKba9kkyLrs7kXH60pKDSzVcOdWNvsmk6go/4wP1AdBUwVbh4suOM3bkn
         e9LA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3socw4s5aHRBweyAGF3Qk6mUE0V1WIFJ9xeDMmb5RSHC4VVwOG5bB87zHsTnB1bHnIjM75esNtOa9@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNFOsxxcI6MHL//sRzG5j5L5bz3f2D3GlLjeV727CDPH/Kd64
	93Q8UAsCPTSZCPkrtW7GCOL+1WfOYd4zzazIMoWMwswBhK0wFajQZ3H3
X-Gm-Gg: AR+sD13QlTHCt2b0Z7TSBGJ3zfud/Mrvb2cDXIqqxn9dbO7dS96PU0/CwhGa17vJijl
	QOkOX+GNFkkfaVEA0EwfU7rfrn7nQpEsUQ0kOD01QqfuswD2cjNyL6pN+RWZ/OycAHhoNF9H1Ux
	Fu7CZlaTs1CEENDP5M/TK020pZTxR+uiW87hAZj7KFkPv8g5ygYBzYXmLJvTCNiZ457gmb2NdQQ
	Cf4JuKo5QktHPtnWHV7J9iUmUpEjFsLqdeHQaDzesM1q5GCHBJLOePOAKHpe3I+zjnmnyX683UE
	ZyKc8bvhXuTQjMAvesuRsOEmkMtOKvlm/LiKwRYge43AIBTg+goSugBgvr4BvH3WlE1cmGopNAV
	IVTJHEl88J1CIhI0AUD/nvMHiov21PSxjbBFcsBZCmFHVRu42XDswPbnwIUjFcHjo880wQCkYB2
	+2Pv9Zsv3rkDp6wKLdyAeiyWqx4raJTLSjxux8VxmVv37bldS7zKIc5pNbtsjyn/Td85A8oFVrA
	4vioscAHumImUiGUmHnFMAw39SjDoYmM4CsgAWKqKHBykP5rWgf5PwwqNsdzypZeUTOWrCiUB4y
	+db0
X-Received: by 2002:a17:907:842:b0:c16:5b3f:52e0 with SMTP id a640c23a62f3a-c1f72147104mr346195966b.38.1785324520387;
        Wed, 29 Jul 2026 04:28:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cea5f8sm100629666b.24.2026.07.29.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:28:39 -0700 (PDT)
Message-ID: <872e7a5e-011e-4415-98dc-96c9066b0614@gmail.com>
Date: Wed, 29 Jul 2026 12:28:30 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <20260729065421.GA9468@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065421.GA9468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 07:54, Christoph Hellwig wrote:
> Might help to say this applies to Jens' for-next branch for those trying
> to apply the patches..

Ah yes, and there is a branch as well:
git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

-- 
Pavel Begunkov

