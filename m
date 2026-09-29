Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A552940C
	for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2026 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688972; cv=none; b=fZG3vXMkxG+zbR/rv/SjrAOdP+Se8zCDxG18M4WooKWCo8Yox4sqGNFgUOsoEQhYdAiZzcFxe/1YBIM8nZgFzl1EGmNyFt+p6BQrhgaP+u5jb/KBlZTGvi30NeFMpTkPB8yX5hZ/+vMLKHHiMpaI2q5hRjLZhDRJeaj6DF7sglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688972; c=relaxed/simple;
	bh=MALsIQkWBc8oYjqtYr61DybGua6MQV6D+0TTQi5Zuik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGo3+39En2lFECd2sEdj+KyyjqFtWRFkawPVsnUmVeqkRI8Kqg6CP30Ky49Pht/qh7OmgjiAcW70qG4uh2vYwqdWV0A0TRV8UxKe+YECZEM9Xv6jy1VozLbndGTgINFFEKsAc6HOG87mQW9VHHspAHbuMt1tcEvp65kZMQ0gy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=evNZj1Ki; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="evNZj1Ki"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acae8342d2so1305565a12.3
        for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2026 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790688969; x=1791293769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=evNZj1Kin8t+8PEGTM0Yu12AnB8VzQBhjeW8uwrXPtg4/AMXzTdTs51rRSVhaMbqTK
         vBXuTC0N6C23zIp9NI/2PLxjEiegPiD4R6M8V1ucy9Ucjnz2MB82f5+ns47h7hvqZf3Q
         Vmv7XCSMy2aabHjSvOrlIskeqtjQy5pEuF8X70TSa1X0Pvo+SLM0Dn6tZa913E6AP/7G
         xvzJeCm7U6tlIaeFXPFZks/LeWt0HlIu7A9E2szSFdivXl7CvJ1se60QGHRDHXgSRk1W
         5jEoGy9NPhWE5zFGUuVkWLoHNeFS4BUlN+ZoXTVgNUQ7SW602Ap4cgjR8zFhwiqycrPb
         4VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688969; x=1791293769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=svExuOXpbMYoWFoQfD2eCkyyU3fyP+mpLul0ytB77Vzukc6fzce1Sxo7zSfnIZm8hD
         lyl/ZJCj06L6+8q1Izy8O3eehvMt2pDkLGhQ5dEHup7wQAJ2lWGjCaaFW5lv9X6+FYuP
         JM2ugznd5kUgAGvJdkBiNplk9fY3XR3N5BDqPZebS1uMGWj93sFyDEypojKUsY9RT8IJ
         lQbEhHVKWjnHWxS94/+SZZT4FdB+Mg4mGoMJLWkBmVBQ3578XPf3IYND0Fnc53LRvPWs
         UCldQM1JtFIhj3im02GV6fVW4pNa67bw89YIZChvTS9OKW3JCahptFP6ztLeL+Zsq05R
         5vJg==
X-Forwarded-Encrypted: i=1; AKwUvBw5V6q7hn8R7wtsNQc9WKYtPAuvXEgJmOeEz+AACIJMOGTw2Sx3vUKTjXTDr89ng9dzRCcOng4093m6@vger.kernel.org
X-Gm-Message-State: AFuF++lec+AINtYKmcuq/embNbzbshkmRTwMgQZ7FcoDqPe4xbWvK2bs
	vEx/8K7B2p0XOu112rHQLlOjt1qrs4pFI8D7FMhkn25Sj5p7hpWiF4+qf67SbSzfZeE=
X-Gm-Gg: AYBFou3dBnpDQxvJ5I/HZ4m+ZE3fz+oPDk4iuZY8c2V/0046X7kSHOnmR401OKwv9YG
	oEAS7+rIu8Xwb7ELfIE43xeSDSm/QRykjrJ/UfxXCLxTPfpr3ZmEm/aOgsy+d11tX/QQP1pJRu3
	Oe3HWysQlG7i9sdobR9cXb7QVk5EGqvsiBYnkv8urd018zOwjxzkEa8uGDUV+LXNy/UaOQwuFw3
	+rphL35dOZBBjl30Ag73YfCQy4JZKr+yqXtqSkbvYWWxHe5nIoOVfTe1mipi9I5BWmGBWe6ai/Z
	T1LE3kB3OhhdpMULwGovWZgZgpD6TW14FsCg3xU+agJSHh8LsrK28sy1wqUKi1ZjU83VvbJSEot
	KYiUMBpNKA1Lwpyzf5HH3DA4enyveHIl+/WQi47PcFEZ3HlgHmu1dSrn32KP0zxSxveCQlsOKnC
	NJL/UB+2Pskrh1dlgPehwefzNP7Rvq3tSJrUZai2jMkeweRgKNW9XjD9YIoLozmr1RONw4+t2/A
	+zs2DA7yoJkivb3vR5pu0A31ZA92AKaNzoKuh6V+WOE2MjqbooOJGzy4cpc1IQpWuM4sds/ZQ==
X-Received: by 2002:a17:906:6a14:b0:c2d:ca78:ea83 with SMTP id a640c23a62f3a-c2dca78ed66mr642618166b.38.1790688968778;
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Received: from [192.168.40.198] (093111099180.atmpu0044.highway.a1.net. [93.111.99.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2df76fad17sm107201466b.60.2026.09.29.06.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Message-ID: <3c683f06-4214-4e0c-b568-a2458fba0cd3@linbit.com>
Date: Tue, 29 Sep 2026 15:36:02 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 6/9] drbd: use sk_set_nospace()
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, edumazet@google.com,
 netdev@vger.kernel.org, Alexander Aring <aahringo@redhat.com>,
 David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, Allison Henderson <achender@kernel.org>,
 rds-devel@oss.oracle.com, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260929071743.23624-1-edumazet@kernel.org>
 <20260929071743.23624-7-edumazet@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260929071743.23624-7-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/26 09:17, Eric Dumazet wrote:
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
> 
> No functional change intended.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>   drivers/block/drbd/drbd_worker.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
