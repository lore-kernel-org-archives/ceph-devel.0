Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795681308;
	b=mSlaafmbbI+fNFCpm+orFOMaURWgDv2sX8o56Yh3mPFbzB3b+CNhnFwMG+XyokOxcOI+
	 ngq2QRCkfw8g1hLmYQvNzI5XsGLFq2oN6oPlc0WsW/vgS/GZgds7soRoSnED1v1H75UjJ
	 GoLK8EN7x/n6Up5Y9az2pcrhwIaJT7ZQXbo0UcVWqazm8TPZyBRAA7A3K9u8ZxRh4MekA
	 AZhVu0RLEb2nInBxd+TdXMraitslz7X/aqBBEGXQyuLafKMqZGKBjVLWpGUq8j08ljgUf
	 VOl16dXGqqb/OqBZxBJB2+lgHNeDgK2SUsXitwxlL/gveuS58badWJfN49It7Y1hpTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NZUUDlK21QbpfmhVJS4mqW4ooCEC0s8E+OILSSqFgxs=;
	b=5TloKdtKwhPtn0ToJrWfAKPoemgs2N79BLRnVvPl/Gvb4smjXEiJz0+yBJ0f9PWNlst5
	 OxG4Sh/X7RmW0n5w1ndq2mVRsWCr5SOBnVx/TuZJU6+86ptchefdURz36H15VQsT7pJqq
	 qIKKWJ02a7XC7N1iJ8TXLFG74xhAIj+yDc59ycu4NvLnx13o1cT2nqqyO8PCQ2wvbbqe5
	 3iR4z0cNUKCQJSyVa2SD8nz8sfXfXHEz1A4tQ/kaHPz1Vl2cYQ/bmPWdmVvJGRUma6ThB
	 /ztebrJE5ONfTrkPseab8BO7sCi8/5cfXbBoGsNh4Ro2xrG8uFzG3NXkkM4UCQbvQvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=YwuZI6Zp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C2606A692
	for <ceph-devel@vger.kernel.org>; Thu, 26 Nov 2026 08:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F0C2606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=YwuZI6Zp
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c51a14bd405so258452566b.2
        for <ceph-devel@vger.kernel.org>; Thu, 26 Nov 2026 00:21:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795681305; cv=none;
        d=google.com; s=arc-20260327;
        b=qvR5EvrReC9s8BxfWmY/LersSHjFc4PeXXFRoioKSkqZuAEnriGHGmUJhC7ZiXZG1W
         OamsdH4Cq5tQWRWO1HZokGDxY4MZ1ztqVh7kmijpurSlj+ufR+u3AMM5KRG10/KH98rh
         CpjhbsvAYtHsg2da3ayfHoI5QunRbUVrWyUPbc8nXiNp5OYMKRSgLnEFaW/TUuWRgiKK
         v2h+G1gZAt+IveoE+BcU2S5ybSb0ErpTbv3yFVsyRh8L4lQhW5nh5evQR1yvOzYqBxPg
         J3etY3AV4lDnQhZYCy7sRdFO5smK+2fJiZ8qwArTXz5DrvSmRfb6bq72CeWaji2mxFpt
         E+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NZUUDlK21QbpfmhVJS4mqW4ooCEC0s8E+OILSSqFgxs=;
        fh=COW2bIJ+EZviW5e5DaPhdeiL1qNMYq/WsSiFLmw3rRk=;
        b=C5m3Maq9AuMp9SnozYZrG1J/Gdc5HSm3Lspey00rqpIT17mNeeOh85lAs/EgcxXNkp
         QeuEwEvHpqBdcYZZWRWCTyFcQ6nNNYQZP5rORMCFt/mpfRJmIOSPlRyw/TcuuLbAYKl9
         ncIv1axAW5TGzsduIqAQbvDKR239BAyBvFTTvC6vcqnT37xz/Gmt9VUVmZS6bfGzRGEe
         djVv4Y6FBfO2bVtUfBojw13nZXReYyaOQ4KgCPGIPVbcixbgX3kP6BRd4dXN6k6js9M7
         XNvUN4+36qXCaCNcj2gtO8d9aX4ZytkPWsVWszBleW/1RDRX3E2k98MStDoon1iYlMJU
         rUMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1795681305; x=1796286105; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZUUDlK21QbpfmhVJS4mqW4ooCEC0s8E+OILSSqFgxs=;
        b=YwuZI6ZpM919k6nH2v2fVUb3FDPQKFxhdDJI+1AxCwRcgaW9//87lnnbpPyKYBS+Af
         r357thmGpj33LeE6ujpc7Jjzzrw0fQV82HhOX1rWMBtsvQbkth5gncGqptf8PkMVzsTw
         IRVRiNJZigGHDTTj9EHYZCM/5a00PrxegsGtWSjxHrU3KytZQrneT1Hs68fIkfNxot4R
         pW7luhTKTUvAihxTMsSMIHK0jN69R/pyZWsOQsHLrtJ16OnBiXopb6Thlict3Jr4aBCk
         pB3AKHU9RNy2sLBQc0GPIXfbnHjYoyjcOCSNfYcMc1xYbzoeTCxnF9xlf7Dsh8LqoqlD
         D61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681305; x=1796286105;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NZUUDlK21QbpfmhVJS4mqW4ooCEC0s8E+OILSSqFgxs=;
        b=FLSOS9/W/u1CPP7/pC8FZ5636ML8nnijYdzuxQbF+VsJ+mhalasotdmOrsg2mC0ZR4
         EBIgUZj2j2czzsroh56v8UzXU+5yXsIjANCQn6vH4SKB0Yxr//BrScqCoDJZ4up5hl3p
         6W/DtkANppAqqIlQ6CHVT0wuG4dzb1ePduPTWSHGowgrxsS98eifECWkQNpkPA88H/+5
         lXFvVfMIr1evkBv4ugJ7XVSnBZqNnlxGFD1EgiF5lKR6q7LEo8YyIvmWxfsw5k3XDf2I
         VIYYDW7XPdoUdVVxNe7q/VoyziwG2Momq6UgaoBtblU1Ec72njToBu+LrFNqhVyS0tpn
         wkSQ==
X-Forwarded-Encrypted: i=1; AL+hErEGbqynmnEgyqxhSP8YY6N3kYMoguzfPiDcozXfeN0gMQ8yffKOfmp4JG2PdFh2WyGoY+zFVv+eoRlM@vger.kernel.org
X-Gm-Message-State: APuU4Z9YnkkGOVO1KB4AMAdw+GsU3Qp05T6Zj1dVLFH5J5mFUnWKP2gS
	BmnO9eLtonXUK7fp2fkqcq31aNHqLqEVlhaZRjhg7wUkNVbDh/v1zPsrplH/lX2ZgbZ6ah/yBRe
	1BZsI/5aGWtDAj/1iO0IIVHp6C+aPxJh9/eKVHK+tYQ==
X-Gm-Gg: AZFdTZejcdBzKucrSmez++yg8cw/635Ks3AQg6divJ+X/x6JlBIlzaz9IBp4MylLEqm
	kn3X3l7JQ7sn0kElolp3UQ0/dP97VXLMXZYGylNaiC8lIIG9yxcsC5Lq6PmLlpIViCHeRbUusUZ
	omiNmwPvRB3LY7/RW9elMzWhzxMg/CMi1CTEn8WYFbx9m0LxySTq71p/HiUC5lVOtK72a44GLw5
	tPJABiHmz2yEVpeoUAHo4IOwHeyQykmzZeANe21BNej3P1j5vE18tjANKIsxVi2cCPJ6MoqocVl
	S4Gxz+ugkN1+VNucEh2A1VzqxJbERMeGt5hn1YUPBNjD6WSmihedvLlCu48jxgQLuEIY63+crW7
	DKffwUAVOoLzfxjUvavs9cS9xnUF0mSuxbk1qqojuarNdtELiFxczfTfKSjkt+qRs/oAr
X-Received: by 2002:a17:906:3e1a:b0:c41:285a:46a9 with SMTP id
 a640c23a62f3a-c513ac9c0cemr1257993266b.46.1795681305384; Thu, 26 Nov 2026
 00:21:45 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
 <20261122183031.1299267-1-amarkuze@redhat.com>
In-Reply-To: <20261122183031.1299267-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 26 Nov 2026 10:21:34 +0200
X-Gm-Features: Aa3M54r-jUA4kRbzICmARrKNu4zgaRg9H00nhYxjp7KGsW56Rhnghts4qNSZFIg
Message-ID: <CAOJNxRJoSVBW25M5Pst7xxG5RYU1u6aXrH73FX91QXWGOLk6_g@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] ceph: reduce mdsc->mutex contention in the cephfs kclient
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks, both races are real.  I reproduced each on v7 (the replay
kworker hangs in wait_on_bit() holding s_mutex; the async create's
touch waits on its own CEPH_DENTRY_ASYNC_CREATE_BIT).

I will post v8 after the perf runs.

Thanks,
Xiubo

On Sun, 22 Nov 2026 at 19:30, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> Thanks for updating the replay path and snapshotting the send counters.
> I think two progress races remain:
>
> 1. Replay can miss a wake if dispatch ownership is taken again. Replay
>    selects an in-flight request for session A as busy and drops
>    mdsc->mutex. An already-dispatched forward sets RESEND, and replay
>    sets REPLAY_WAIT. The original sender can then clear DISPATCHING,
>    consume REPLAY_WAIT and wake the waiter, before restarting on an open
>    session B and reclaiming DISPATCHING. If replay enters wait_on_bit()
>    after that reclaim, the second release will not wake it because
>    REPLAY_WAIT is already clear. Replay stays blocked while holding A's
>    s_mutex.
>
> 2. A fast forward of an async create can make the submitting thread wait
>    for itself. If the forward arrives during the first send, the sender
>    consumes RESEND and restarts in ceph_mdsc_submit_request(). With an
>    already open or hung destination session, it sees the nonzero forward
>    count and waits on CEPH_DENTRY_ASYNC_CREATE_BIT. That bit is cleared
>    by ceph_finish_async_create(), which the same thread cannot reach
>    until ceph_mdsc_submit_request() returns.
>
> Could the replay waiter remain wakeable across a new dispatch claim, and
> could the async-create retry avoid waiting in the submitting thread before
> it has finished the local create?
>
> Thanks,
> Alex
>
