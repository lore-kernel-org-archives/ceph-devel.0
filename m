Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F2495040
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950042; cv=pass; b=ocEUyV30mg9u+A8bv8reP/Qqg8pFghWoL2WE05t2LwoNtb+hKGmt1vqMRIc4q2EUCQizg5tK903GVnOXx/1wwyZnfyFm5fWrwtFF6VdNBSQhNU2lm0dy2imqYi7VBb1OjQCiJTdpV9s/WCg2hRTZiS4jTV6VAaFO6FXCkL1COtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950042; c=relaxed/simple;
	bh=yfDvPO4H/mIRlRzgF1ehHxShRFO4ABWe5fq0yL3+cMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJTwHWXAjRxvy6hfByyDn31D+HuwG6z+Sc2zSUz5baoFwvVaXP0Mh41jyGm16z/KDMQuoT4DqlTQgHRoVR1aWEkxG0RVfnukVZNQiKPXJhomAVPeNe3sRDJDeNQdo1m72rm1XdWsDkasBTDbUWxcPNvqixluMIUaiVW8gyVquec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4ilMBUv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGWOl5js; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4ilMBUv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGWOl5js"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790950040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
	b=X4ilMBUv2LH3EHTtRTfnh7pEpxBsXw57PH/oFhAQMxzULOgK5K6J3viywYtIrY22XQxUZs
	GjBzRjgx6FuwiW6hlV72lv/lve989u6veQs4mT8prt7JMmjqoyl7ZW3438276uszDAiJEg
	hsMsQI2ksvupQ8ppD/mk3s6sIE62JP0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-EPjZVizvMn2ZgFn1ewDifw-1; Fri, 02 Oct 2026 10:07:15 -0400
X-MC-Unique: EPjZVizvMn2ZgFn1ewDifw-1
X-Mimecast-MFC-AGG-ID: EPjZVizvMn2ZgFn1ewDifw_1790950034
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-39b1a8b8bb1so693551fa.2
        for <ceph-devel@vger.kernel.org>; Fri, 02 Oct 2026 07:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790950034; cv=none;
        d=google.com; s=arc-20260327;
        b=iqLoc8Cz1ldUsrBoaIOMojCoZrCjaZNcZ2KWm0IgGcKmRS+G0OzFVk/VHxpszkDJsn
         CEmWMvt+qix1nXdj9E/npziCjFcv8xaB9nBR2d7+0N9354z85OibSL6/Cn/nCNfO/qs9
         hFzKnhgNBSWkdCMnHsacAvjhqOYgvghlvu9dAHpIL5p0mDYBZLIu7wC4RaWqV6I+MPD3
         oZ8iMM4Kh30ZEh3SJaCInHeodle78T7J7O89SIhy8Td7t6u80a7XmT63NE8Y58gkSHDd
         BN3NHmJnaMS9O4FGTWyupjQsAd6xixpfo0dFpr0OkZAcXLX/n2IpE9n1RUJOLvJqvP/k
         Vqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        fh=eiQ1Lossyl5UkNmOZ6rAdaMgpWJaYdrzsofRT5Eclmg=;
        b=qvgbpBY9f88pgaGzSAJqq8GnUZLpOkCt4jH89BK4iHSClIRiTcg7s4agrBeAoaQnZH
         7J6RLUyiu9DzhjfBoK6dtG53Rv8lmOZ0UWg/2B4C73QCBixjOkyc2Qnzj1E/mtLSJmAl
         ZlTUg2jp8lgMDknu2aMknWxSWujOnmEPYmRKBO0wt/LMNSvhm05Il88b6tOpGMeBQQSz
         uflXCZyCtOY+rADxTA52f6rEZrWZRkdHDN0U/FJTx0SFUxQX3q5Hjrs3dfQMiWU6EZYf
         ZkAVoAPKif1JQ0Fvbz56goD9CZZOh59bVF1bcfJ2iPeDUN7GMVZ/LWts9ZOSSvM02yqk
         SJwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790950034; x=1791554834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=KGWOl5jsE8QQb4D8FZHcRRf3lRLbD4irayVANcnlm/qIwAMXnpXYCr5QJieryHqkoR
         v8CifHXoKNYHPgb8wwYE8PE3JvUUxGLoJGMuIuuXimaP+vSCt4DZvhTkRoE0aPZ36cOg
         cDvxMLqNnDpny0iv0KhmN6FkPKmYAgCTQjwzbJG4/S+UhFW3/QiJViXFXpN/aqhmuQiD
         RIT/SSGL1YkAbAxc3Sj3C7IXPjBH+SUjKGKT46M7E92U0iYhOY3jNO/djKP63ET9H2N+
         ucb667glPv00LkhYIybgLn34YJt3hzpP9MyqdZQrg97ckmkkBIsmhxEoSZUaCSmbaTBz
         KEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950034; x=1791554834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=N/oFAz5yAmwB9saFJZHsSNIItRFthEC/k3FfhQfA315bf9TOh5spJkqW+olGL83/7A
         zHIYhwfY41fbqyCSaNY/uHge+ZPKxQwlv7vh0gtu8OsQ9reoYZUCvPLS56iI7WpuS3fA
         qEZUDEBUz3SfaGRdH55ASyVay+5gqXas96Z94czpTjoo18/4XJWsFpSxqUp5IqA21ROh
         +SjRhp+upvCg1CFtWRu3DUsioP7qJXtEa3t+TpZrgz4Dv29JJxWS7Dq/dZfW/ZOBYN3T
         K1ogURAyaTn2hWau7ozspwlFcJAK/pztAaDog5jzQ5zQwwQCcHAmW2dvXRWF7o0XOJCW
         Iy+A==
X-Forwarded-Encrypted: i=1; AKwUvBzEflbpip3U56qrpi/apS7x8tWzg73gK/g6LOzn1GLjcC7H4ndaNCV5QmqRX8lHxcS3M0WJcDfpa3+M@vger.kernel.org
X-Gm-Message-State: AFq9FYLhzgm7anjCb9ArYERbjbbxGh3QkuShEgVnliTi7OUxugBItTfL
	weg2J4kFdy3OyyIv1kE7hNbTHyIZ1bEG43ryQfzd17ueZ5kadkvHauewS0pQn6Cv3KBQNnGjF29
	eKvTUaliO68KvfHAwkPlRi/uSOpda571tWvkkN8DNRTmuTqgdXvdUAg+vxr0rWIR2CTUjM7uYgG
	TGCvzFNGWUEkm8tfMuG8dOQ9VCxUUGhoYq0EHl2w==
X-Gm-Gg: AYBFou14Pb4KsqUTj0+jpYpuCoz8SekDm5f0LkIhhlXPqZyOEriik5aGwb/IUUBvPgO
	KpyhzFRJwokm2MG915aBut+qGmOgzkf18XaNy9msLUaMNbSRmj3Xv5AnX4TQD7IeMdROuiEAlQJ
	1GmcwiI+YwdrGmuU38jiq51PAEW63KedBM9tV6FB708kvtULioi1rWTSWX
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3a8877b72d8mr7514191fa.20.1790950033895;
        Fri, 02 Oct 2026 07:07:13 -0700 (PDT)
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id
 38308e7fff4ca-3a8877b72d8mr7514081fa.20.1790950033516; Fri, 02 Oct 2026
 07:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
 <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
In-Reply-To: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Oct 2026 10:07:01 -0400
X-Gm-Features: AclHuK_sfowi4LPKpSWl8IXP3uRNzWbqORQfvYROS9BqQto16BFcN8kPZWF14yQ
Message-ID: <CAK-6q+ga-MNEXgENToB2hLB9jzpsGMrz-1sOo7WQP5M-scnAxg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	edumazet@google.com, netdev@vger.kernel.org, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 4:33=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] A TCP reset or TCP timeout while the connection is waiting for
> >   send space can stall the dlm connection permanently.
>
> I dunno if I want to spend time fixing all dlm bugs.
>
> It seems TCP changes are now stuck because ood pre-existing bugs in
> in-kernel-users.
>
> Sad.

I will take a look into it and cc netdev people.

Thanks.

- Alex

