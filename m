Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25C380FDE
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756792; cv=none; b=NUfHsz6b1M1t9xResbcKSxtWJcc24DP37CHrB/gBXBr4TE5u8tneYr/VIKZOtPRQfgbc8e7qicDwtqUkiPeJy4KGMWzZ/g6r8FmMX3N3MTpit8/2pGs/lXyNI9BM8V9H0cDipIk8n2B2CCKUy5oHUKTgxyG/0wIKHxxhpIO2Zrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756792; c=relaxed/simple;
	bh=1Urt0KlkkUCNFIXX2SMeq8ob/I+W23dsau/MWlDtRxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QrQ9XNQsO+Qu5PQhtP3/MBBBOsWiLV7o2PzT8j+9lQelX2M3PcjlTUeJkFY8gh7a8FbxRPh2fpUx1Qqqg6SY7JKyc8Jdl/i01crRUSalPEw3E9qL3ZoIRTy4bsb39kWGqP5LfFLBYYO0URuMSEHOk/dQxIxSXqiBXaSzIOJbxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=wbuS4k1z; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="wbuS4k1z"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664c1cf7445so2033063d50.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782756790; x=1783361590; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Xk5917eDNawOHNAXep2M4wtk9i47DxkAHjv3jRATa0=;
        b=wbuS4k1zLQS2UEqx+WWNdR6lGJ+XD0UsJ952LY4K95rc7Q+BSoUWrDoAdSEpOIAMRd
         3oEFEsCEwBdrI8uL1XX3UEz7pYVL13d3EdAmZvMCLFVExeMDy5TtzRmBdTrSgsPr104U
         XRFuQpiAoG8bXajfXv8KqcJ1Dt7SInveWiCfKXL45NtmyIQQ0XEoed52wenx0mqZjaY+
         wi6Q+Nky4HwjK8pKbmE36O4L8GdFVNVgaW/3rngFGajNcMppRRKh0I4kXfkFjeJiJq9l
         KMo7oBADtnQfFdr69+jzapHG9hkKu8/t4r5hWilHzSi2NlnF7ockEVvV+SsnfBKuzt/D
         hICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756790; x=1783361590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xk5917eDNawOHNAXep2M4wtk9i47DxkAHjv3jRATa0=;
        b=Ygg91zgfBSEe75eECGxaAswNoSj0TqMr0XGUCjAV+YAaNjVAu7ymkYAU75mIVl7xWO
         42pr3bTDiKtJdrNP0kGsoJfiJxaRsArDjSwiLZRMIgzcm2weVc/QatSp7GhSUp0hbucd
         /SDy0GRelkiOH0wJ+knPznrSaLZiWAOk9O8IOvQKO3NNnY5ugkwYMcisocv0yrgK7RnR
         UhJCyJmfAqe8GUMnfZDOLIX8gI7Jee2DbuMiT85N+DRjTlBvvN+XpUcodM2KbwK82VLe
         /ArYsjOmDxMDrmTkQXAqUlXp696CwAZY22c6NLrksbxncXmqZWfTkdxdPK4o6uHtnC5B
         Hv2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpT4E5T+6aS9nxtZ37JhoazzSrBTuG0z8RDmj7Gwb0YEiQB+bWanqLQsoOSH/cwB/J4zNcAdbSw7tg9@vger.kernel.org
X-Gm-Message-State: AOJu0YxqgI8SB9nDTpMoZzpujEPG72hA9bbgEntM1whnUXxORiJ8tsaM
	b1xuDaSMM1c9pZDGlC80LmI5PPghN65F0PeIHyhgc4gny0URcWxHN/zfIxmrtb2yzRk=
X-Gm-Gg: AfdE7cmAzsRAhI+TtzuLkZe80zUAmVHlCZ4rp4TmewMJdbQVvb6eVJjKqdvCAI9uh4j
	kKEkiTqtzMqmtk2tXzGYX4g7FoPHWPe4VhxIATXu9pdYSet0MXTwhZgXAXirm71gBk/+d6FQYFp
	rTg1Pu/aIdeHJcxobixDXjdbddgJbv9dZuf6abOHnNhH1PPS3d1jbMeey66J5OFhmOkBrHFxKzF
	SZFKejZVLCXbns+g79IcjLAQqx0sJRoEnV2zO9Xcpk5/us8jZCZ3YLm/yxEBVDXC9P7YOtrxU1G
	eSBV6h93tJtzEFRC2w8idFO1O1VyggKeFr0SPWjbUE6sdbtL5qs+NxVQAghtfKI4k8VspafaRgT
	oyI84vupqn5l78gxqAo8u0B3MDkOTCWXJxqtmsM1JorpJr6AfGX18Sdc9JmzWteT7KVb7YxRKzn
	wu2xgqNYqBtVwEkbaBmXgTRdJp47uu8gOb/Ls9pa4CLeDjzk4br2Rbm2QgYgnDUQisptJQKUPx+
	IsRPAyaNOBNXT6hi25FJ5agvx8i+unso5ktyhSfhfeL/lfDoDZ/cXL8iRVRl3CyeArehkJQCVpu
	VqzeKKs=
X-Received: by 2002:a05:690c:c18:b0:80c:f6bb:566f with SMTP id 00721157ae682-810da20e3c9mr5822817b3.51.1782756789450;
        Mon, 29 Jun 2026 11:13:09 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e78731a7sm1145127b3.11.2026.06.29.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:13:09 -0700 (PDT)
Message-ID: <a8f035b7902fa05b77686ff4528df62203800af0.camel@dubeyko.com>
Subject: Re: [PATCH 1/1] libceph: debugfs: remove client files before
 teardown
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <n05ec@lzu.edu.cn>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@newdream.net, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	ldy3087146292@gmail.com
Date: Mon, 29 Jun 2026 11:13:05 -0700
In-Reply-To: <e346902d49608e030177ffb00423e776f4a916ee.1781280238.git.ldy3087146292@gmail.com>
References: <cover.1781280238.git.ldy3087146292@gmail.com>
	 <e346902d49608e030177ffb00423e776f4a916ee.1781280238.git.ldy3087146292@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-15 at 14:31 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> ceph_destroy_client() tears down the monitor client before removing
> the per-client debugfs files. A concurrent read of the monmap debugfs
> file can enter monmap_show() after ceph_monc_stop() has freed
> monc->monmap, triggering a use-after-free.
>=20
> Remove the debugfs files before stopping the OSD and monitor clients.
> debugfs_remove() drains active handlers and prevents new accesses, so
> the debugfs callbacks can no longer race the rest of client teardown.
>=20
> Fixes: 76aa844d5b2f ("ceph: debugfs")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> =C2=A0net/ceph/ceph_common.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 952121849..a797c7360 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -762,13 +762,13 @@ void ceph_destroy_client(struct ceph_client
> *client)
> =C2=A0
> =C2=A0	atomic_set(&client->msgr.stopping, 1);
> =C2=A0
> +	ceph_debugfs_client_cleanup(client);
> +
> =C2=A0	/* unmount */
> =C2=A0	ceph_osdc_stop(&client->osdc);
> =C2=A0	ceph_monc_stop(&client->monc);
> =C2=A0	ceph_messenger_fini(&client->msgr);
> =C2=A0
> -	ceph_debugfs_client_cleanup(client);
> -
> =C2=A0	ceph_destroy_options(client->options);
> =C2=A0
> =C2=A0	kfree(client);

Makes sense to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
