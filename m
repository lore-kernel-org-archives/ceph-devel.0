Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C77442109
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018899; cv=none; b=RUhGEIbdH6qbp5GQ6VuBLeWb6oXPXV10+0VvNhxbWaTtqPvqDCQT66ncgBX/KBJ1cUgiVK5+Q86BESAaKt1Q6JrGCDJKEEufNl2uc16ZT2ufBZPWpyLiiC1gxXtEN+L9ITDj8yG80VaWKIWyP5v/U7tUZmFN4sjFNjqTQ4G7l+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018899; c=relaxed/simple;
	bh=TTiHlStxZcKVKrwqcuDMLj38rBSP7TpoZoQlRZGLyrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCP+h5G751szhRTwHZzpvyRSKO35GpSs0TluZPViUN3A5Ps47ptFjLtnqYR+A0C+NJeK7LkkcYWe6U+d88S0ukrn/hxvyV4Pgf0v6Ig7Unxt0mxx30mQxluOYhBWGVlliLwNn8caic0vsQILIJvdARsZinCyZSdbQEKQ18wFrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJn+DDkP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJn+DDkP"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe377a217so1424792f8f.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2026 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786018896; x=1786623696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfDlnjwEjqQiBft6//i9aWDA7+Wxp9IrqsB/3Fhaw40=;
        b=XJn+DDkPJjP/V2NYxQMNMiUSztdxL5BX3WbOePcGIWTdGsldovqU+YfLJCrgljR9wi
         Y7Zz1/sSG7RzzLYA2LPhGo+cnU6cJb9RbZpDL23FjZFb+K4qZGkYxZJToxsT0UUNh/da
         4gSd5ws2QvWA2bITT/VCjrmjCHJzcr07+p8KF1EhyRnckQU+Fjc8duNsPqwMsXZLrnJw
         8XeSVdu3KCL8RgMkdeKpLnPdI6TcVjzcqv11BdjCHvpdXY4YJW9NTiepW9CXB4dA8Ml1
         3OATNWEVAQ3M8+khX9YopaUgISPtmr84CTmTp5pvcKP+jJCJPvR7s8sU9HZX6DBjg+gs
         W/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018896; x=1786623696;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfDlnjwEjqQiBft6//i9aWDA7+Wxp9IrqsB/3Fhaw40=;
        b=P9l52LQ8QGI9C2bsK0AYpXXxCaKLyJhvLfAJEiHgVJYcGBmea+xtBltZg6MGLOua3L
         Vj4HCtFKd2YGCUn3VxCMrNeqfwv3cPq0SwdGB+6+tdBABJAJBAzph9FvxxhFMLodX9GY
         Lt3sd/eOKEyjtSQf9o3UtoBBNTdhMas9GwgeRhtDHTr65M0vOdSHTByaZJH+TVYr6d46
         GidudG2zPaUXPp3XxTEEBFzHxC3uXxmE0CW+akurP0ypJavsNmCv5vtv6aYwhmG+tIKe
         oKdrKLPJB2bzZAGYEzu6fw9kVcrKPJoidbIlqrSt82C0kFfjmtGiBNZROzjFFwsGZwLT
         yy2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpr/JL5dOgqHxpGlE78K3LY6kFmSI01MfHN4/6Vvbqsy8yzXxP/HhnoON0jcYwCyJhslj1vaDULpDT0@vger.kernel.org
X-Gm-Message-State: AOJu0YzeayVO8aLuYY8EnfcLIKith3mgyb/VyvOuWfW7s1PT6btT8Gub
	MZE5vjCWmMOBHibyF7F4ZhLOK5rZ2Cla/6Aim7tQ6nPO4gPzYLjpOqE5
X-Gm-Gg: AR+sD12ahAhpF6j1hVkjIouSwvp6jelJuJatULp0jnJ2runyA+2RqoShVfp2Y2nAGsv
	264RVBw3GEW3fOs5zsDggS9DysN5SByKwrvsfUF91btnROEPbkgbrJCeUSqMJd9H1D0IKWsneRd
	W2wVf0O68SVGDOm37XnxxRlcngPkuS619GHg5JDS/VzAzrK1met6UBwzwF//3vnY7Bxbs8MpEQw
	AK7uDgao3tLtfR1jGnHfkdqqjLbtDF8CsV859Q9s7LWIopcN6TO84Zxr65RGt5qUOyJJMswnMQo
	0Z5+yStCCOarDQZtVKEbYMKldsbzGkpjtjK+adFhSL//rWVdcpGv6DIKmUcdF2jxwWVhZWSSpjn
	K0Q3NCQOOavRBykWasTQ5EZ0WjMgN2td8rTrJsfrPyzvJ4fds5wSbt/E1G0w0M9ZBKFLHJ47iqX
	QHOng44h1Z1TN6XTgJNJZOqXtXO877mYIk5NEqXrLpDtDdT8caG/yri7XHZy0gYRdlfOzvTB9Gw
	S3r3VDsc/46zJV6134Unu7s1Lmy81PFzteHpn4ys2ueGrKbubxA+7xpDXJz/tGIyeKwGuzjLHOn
	Yt3oUGe2BzhxCRU4iwsGbR6YdMyJZBr//LMU6A==
X-Received: by 2002:a05:6000:290d:b0:47f:f42e:9715 with SMTP id ffacd0b85a97d-47ff42e974fmr10864047f8f.12.1786018896398;
        Thu, 06 Aug 2026 05:21:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b32492sm5927425f8f.35.2026.08.06.05.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 05:21:35 -0700 (PDT)
Message-ID: <f47ed617-5ee7-4259-9f5f-a6fd0f5aab24@gmail.com>
Date: Thu, 6 Aug 2026 13:21:38 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: rename bi_bvec_done
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Hannes Reinecke <hare@kernel.org>,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 13:19, Pavel Begunkov wrote:
> struct bvec_iter::bi_bvec_done is used an offset in the current bvec,
> let's rename it accordingly for better clarity. I also plan to use it
> for non-bvec based iteration in the future like dma-buf, so drop the
> "bvec" part.

I have this patch for the dma-buf patch set, but it's a very noisy
one, and I've got an impression that it'd be a good thing to do
regardless. Hence sending separately hoping it'd get into 7.3

-- 
Pavel Begunkov

