Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792516572;
	b=VLif9Ls6tND06MUo9TQWNVwl6Wv/7VPVUq0GsaKkaVyw/Wck7fYZE1Vm/yBnb/OjALxn
	 j2y1un+aiBhhxt3VD80/Qcmt9QGOiPMAElVWjMEbsJzsf7YKMRsgB4nWmoTpUo1jEGUzh
	 9gbhhUff90n8YzHk7CWePTw8efCtGXZTI2oXR4EgF+VlTB5F7mDYwKmcGOG4jA43F2sde
	 lpfyLNKHheetpxzWxwEoJ6onpG1BFa1CnGW0gxsBJ5k1Q64W4petHgfZiEGh0lbJLt5B+
	 94KqO9+CNUMyxhgaO7sUQ+GmypowSdyacfnQdieulujdebzOfeBtXlPXh7JIcTcn/Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516572;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
	b=CeuyWDDV0ig74uovoBCvMh44LYcxFF8qyjw6Qo6CxesaSoQburi/gnc8nI9CPr3HLZjQ
	 6JSaQAr8xra3twfBNTiLPqbGETUB63Vz5iPz1ExiqYFNfhMynYj4FFTENK72gKto1or+i
	 4lPn+btTy/jLbIsCd/w6Vqloi8LWIJ7aNZaoppPUUCj5re2B51aXSZnVh68ph+venn0fv
	 xN5dOdq42k+qoQ93Yd3MDnYYAqKc97sUxwibcwhx2XGLVM2GO7q4wXUvnNmMWvyOgTk21
	 6m1yFBB6Pa12klFfb6akNjWPzE81xmdNt8viF6SMnPdAwB5Rl/SUlzAYavcDLDalUsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MBY0gtpX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RTR1tuVd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AE606B51F
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 17:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D78AE606B51F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MBY0gtpX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RTR1tuVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792516570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
	b=MBY0gtpX5imWRG66RW2rcZ445GSWpvIu60jkZK+s+Qo36ftFdLEP84K1fpVRRuMCSn2QvL
	RhePCQBn10Fr5wl1th4ja2OnATL0KHYmx46U1mE8Iuin1wApPzTUtxmeAIZuOhL1rh6nur
	ItXACyTJSF70OzzTSEz9kFj/LFjLnfg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-9zSh5hEXOz6RF1r_c455_w-1; Tue, 20 Oct 2026 17:16:08 +0000
X-MC-Unique: 9zSh5hEXOz6RF1r_c455_w-1
X-Mimecast-MFC-AGG-ID: 9zSh5hEXOz6RF1r_c455_w_1792516568
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9806756ea40so3004897241.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 10:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792516568; cv=none;
        d=google.com; s=arc-20260327;
        b=L8Sk5wsmq8lcKjKKBsKkbnj5mFgIQ7Dlg8rZ7RYQa9AgS+FXx4Ow44HA/ecUffAvN8
         RwJigSN9EZ53nZh4kRWYvMLFPtC8o0pwDGG9PRtbFDYQZcHnyclI1+3B10BO4dSVW/fc
         lqe+cvBJCAjp8qTYw05YOBJVycfcmNEh0kc/YQaibKWrhZtuYBPb4Xelws2sOL98Wegf
         Q7+8Qb7iplIw31YilnL2opl7nmh5IES4n7yroRoLgdUo7hGTzBeiQdgJtEuNVDbdwGSL
         rIhCq4PZMAr3jsFrX+jhkRSgJXDgjIFYR4ZclGUYnEedQJezdWBv/VQqOTCMcU3bX8J+
         e2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
        fh=94D0/I82lUO3xUdAsr+yb7ONBr8L+RFIJAUnLgD+zZc=;
        b=aQT73kr+YYd3p/1UEyQMu6W2D7RhHbNpJdvRo0JZKysQrsGpDrss59gYrgqrZireAJ
         bOgIianJTRq5fpAz0LQC6sGeNjiOIxdFCY3R0PVWpkzwrwfmFsyM38Y8auwNj/y5Bym4
         0mJ8wX08DYgduQjFgKnDYVfLBR+VZ8pMEWwMpQx23jOTuJQP9E+D/htdaxV7+cX3RJLc
         bfVdpDFmhkBJaVcZzuzUr0JcKFqyN4+eqiCS1ct32xVdT/OJXQa8gz7lOH/PA0T40oUf
         Nc6wV81m+lxVC1hvgoronCuZsGrfNYOa8rpyP09qnEHyCB7gtE4kuRbSiS6l+5oz+DY4
         v+pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792516568; x=1793121368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
        b=RTR1tuVdDUHEn2ze9H0ohlkt3ebd/D9SNxeKWODVXZQhpsFgpYk6JwWTN7hONZN1By
         ilI4c70pSxdaJAD8xOn2Tij9xfPC3yZf264U8QH18P2oaXTYQV1Df0UnpJbAwBQj3scN
         KsNZ9qxMAD5WISFxDRN9lhW4g7WcpnSt24ilP5OOpGpr9tIwm6LI4G3rY4E8L4m8Ywam
         +miLtYZNvR7evgHh4FH3sgCgNx0tjkEGtoYSabCtdfYQg5FwSFyXWtijwKwVGB9mYLSx
         UbBoGu4Y3qufmKbf+VOdR0+k255Uq2ab8Dnj2JkqEi3w1LF1E8zW8y2/Tb7qyEsG3iOh
         aqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516568; x=1793121368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dqa81DbmEVosVhZIeXDqyDww6DzKrf466i3qKtWkyUc=;
        b=2m0TRPTyUHI9kNVJ7+xuafHuE7pPernICk9VvI1sGJ1GfzNVKBx2wugWa0atxnsrfl
         dJC2NcSnSmfbn9b6KkMOrgFmJ6BjfmGhMtNIILyhJkXKi4vB31ULY72KqI/9RidgwnSJ
         qqsSqxdoSKlJyQPCWkqpbkFDj29IIZLFRnVOWr7mVJRHmrbfsuBi8+NVseMcIb50RoWB
         iPzf/u0sHAHPBdyoQTSwaXWLk8SFF2hW+J49bLWqWxKUlSEhLdod/6FH+RACDUf8u2h7
         u6v5VsAUu4Iec3i5UmJ2d7UKXvOlS6enydG3fiMKM608SbXA+jOE0M1IYmTvVdUlJU3U
         xtaw==
X-Gm-Message-State: AFq9FYJ9Jixe+OBx2Hm3zXgrB479LXB0dlG8qy6090BmufoQw7WNVA+b
	tOTf2Z8RnMzNqhICQWoT6XaQoYmxgYmv6pSef1oRsFnEEc8bXwTsgFY+ux/h5KQ1OIqaVradfQM
	eQK2QxqG4a8ZxOpAdbpxsaAJbUrGMmIfVi11huVk703laKB56HoOcEkLVJCux9PCqAZ3v88nOYl
	BoU6p4v+AdKiv2IeWKTu+2zkApuvvQO8kzN6x4w/PUZ4ctbAlZ
X-Gm-Gg: AYBFou0RIyo0BpHyeYCwp5h5y2yIAOzTp/yzSBzLCv5agLTrlsSM2X/4WNWel9dCBwD
	Gw4JFffKJxnfWcHNKGxMEM2G/GHftkND+NzZFUdzXebqGAm3mO1SdnKKfcd1Bw5pB3R/+/9FzpB
	0fIua5bM0sV71UYRkrZaSI4oDSvVYest5sSlD5pMpcsBab4GQj4V8f8+avy78fR8lA35IRPt0Rt
	gZp0Z7H9DBjLzutEzDDk3ZP4lu7h0vfG8RwR/gN2z4x80f1EeAD0HYwiflcRE34poiXmwD3kTa1
	XmIp4tS3n+qi+kcQkRC5gQQxvA==
X-Received: by 2002:a05:6102:358d:b0:7c3:b15:a981 with SMTP id ada2fe7eead31-7cc3695de87mr3672342137.15.1792516567807;
        Tue, 20 Oct 2026 10:16:07 -0700 (PDT)
X-Received: by 2002:a05:6102:358d:b0:7c3:b15:a981 with SMTP id
 ada2fe7eead31-7cc3695de87mr3672333137.15.1792516567403; Tue, 20 Oct 2026
 10:16:07 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792498351.git.amarkuze@redhat.com> <20261020160537.GD699485@google.com>
In-Reply-To: <20261020160537.GD699485@google.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 20 Oct 2026 20:15:56 +0300
X-Gm-Features: AclHuK8IZ3rN_Kb2MqxIXzdba8gBbiLwQmfRP__gRggxXmiCnqZNpSqi1Sf_34w
Message-ID: <CAO8a2SjWStsoCQ7eeoBb5oY3nSUQVFVMT9Rvj1ZcFGNBctuEvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ceph: support subvolume quarantine
To: Eric Biggers <ebiggers@kernel.org>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, xiubo.li@clyso.com, 
	slava@dubeyko.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, tytso@mit.edu, 
	jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My bad, resending.

On Tue, Oct 20, 2026 at 7:05=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Oct 20, 2026 at 12:52:32PM +0000, Alex Markuze wrote:
> > CephFS subvolume quarantine isolates a subvolume while allowing recover=
y
> > clients with q/Q MDS auth caps to access it. Advertise support only aft=
er
> > cached data and metadata access paths can enforce quarantine.
>
> No base-commit given, and this fails to apply to current mainline,
> current linux-next, and also to the current default branch of
> https://github.com/ceph/ceph-client.git which MAINTAINERS lists for
> fs/ceph/.  So it isn't possible to review this.
>
> Note that Sashiko was unable to apply it too, so no reviews from Sashiko
> are available either.
>
> It's getting to the point where I should just immediately delete all
> patches that don't have a base-commit.  It's a waste of time to even
> bother trying to look at them.
>
> - Eric
>

