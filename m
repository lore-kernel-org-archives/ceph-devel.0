Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289A3806B2
	for <ceph-devel@vger.kernel.org>; Mon,  6 Apr 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485738; cv=pass; b=P6goadhEVO0l+lfFIETeljXHZTnASk1sMpXMtj8vdoPEWJ1vNRaY6BN4TwOmlzn2kWeyStBwrCC3jKAtA1hOD4L7khq6FFJbQEmuqaeOK/JxugRF9An8XE16dcZoOHiEXbi4Uq5wuojkacEdhg+VOzx6o0IjPOo1OJi7W6HkIlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485738; c=relaxed/simple;
	bh=RN4e1YhDSg992awiDit4aQ/vN6UYLHpPa8oGR6pnBZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR2KuvoaDp2QdfqbMn/c6ajdEh/wHGdZj3fbOrNFqpjwVl0l81owMsveBW/yb6dmxYWQaaKmHx6ZqiNwBR+HmHQTV8rEZxtzKIASQkX6hiUfvLG3OREbObmpTp48fdCLO5cLH4zGNOUnKCklruO7DktxpU3HC4HGXnIUYXNBONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdGYgMut; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdGYgMut"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbd801138eso653335a34.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Apr 2026 07:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485736; cv=none;
        d=google.com; s=arc-20240605;
        b=SN1LySr/U8eShaiLUJq7aXTohB74BUk2iR20imI4QrcpLnHvKS1oFdOoyDDNy4FC8f
         rL5PWpObxvD+m1uNfZfam1iQuvV6U+U+0UFyzOv6ceaV5ubLJ86eN8s54aNKFUY66Zox
         onAu8Ws8wD/ciKifx2aM9rjqDGpm8T4ewBPdn2weR+xSQtEryANETu0tG73wQ5rSzzFg
         92HvtE3e9D1EpNgihD0mPkyG84W0mP6KozEB/SrffEFIKUFa4mELJjp96COX5svqDAW1
         CRDJDvgXu/1nx/jmuBQjl5kp0l4TxJ/esOeclb9osha9iWpzd/qeBq7HDokxMQtj8vjQ
         Gjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        fh=0VGIwFJKLpacIFCTUbLXi9nJCew8FrxhsjTPV0kCy4Q=;
        b=aqouNfNKCtyVmikOEXNu/ZYWzWfyvdIXj1Ds/BVO4kfU63R97jLMFMtz+eidlCeipB
         oFxME5zxGDK4q0q19CiHat3QySPj26F93luuvNbKNr2N7SLwzKidf/cWPm5PtfiC4NyO
         RKmtZe1hBAvN0eLOr5My4wMvf4Vtoe0Xjc6IeQ401kbxc/3o97KPvJvHdWaN/GTWrvAq
         B6O/CgbutyT/xjUXmhcSkKAk+6iYMrm8qexNy+z46Oo/qum+8aBanECk4brKeDesqeOk
         SkS11k04KobyaxQYR3Z2YYXdA4HBSd4msRMZbMVilhh4OdgLYfKep1IrnGVnrT1UrCKJ
         SnAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775485736; x=1776090536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=XdGYgMutbu3g/mpl/gEpiXrNbPBDV+odsxZL3o8drZUGowzubMADFDSWIXewhj8sHn
         TzV7wY9DGFtzPMZBWkSShrjaDJ/PVYjJRAgXbf/EfCPXJE9BWekaR0/4xoS752TmjwHh
         i3gIgkN3ebcqUw53Cnptdd0imdbSFVFGjZiSNPxZQinfJFxklQEYB9zAAcZwTHh5/L2k
         gzATHJysj74KzKE6lXqI5o9ljoAZaRTfhYkfR+fhohpow5uoUp5OpATFZdp5HVzFFtql
         vr9ECIupiSBNvXPvvOcp3MVtHNMgmRv3cYGFhBItr3vzSj1n5CB6kp7fi8hgmPEHW1Kp
         uTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485736; x=1776090536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=ranWcLiUBgHisUhVdiAhL5W6y/MVB7cl0E2O5SWJhTfxxJEFdQxo2OoBm+i3LEBdpp
         gR8trgjsX14xSojd4xLe6HAT9JaDHiOw17JKcb09zaermSs1pFekBIE/7yuI2JqzuZPI
         PXC2ZbsErf6545Ue5n5861XDFK5iG5zWY+M239xkeFdAtN/rm9tUYYrlwg68fF1I+ufh
         qHXzdV4Z5AkRQzJ2WGjtHoXYYNn6DBDeXCCyEdzR84GGG1hHls0aro6oCfWGywfkcPQV
         27F0smif6oIVLbCvY8rrsls/pjMddNkZfhgqcQ/46bBr12hQFkLL8nmQUKN6ObNdEXKR
         YPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOsPakdswA8Ruz//3moZiDSkQjbqDclrjobwSioz55aV1Yw2x+Gxaw1nzb1twHgljRMXdM1GY2+Phu@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHtLLjtUJlL57m+JEAngVgy8GnNTgsBruudmx2tqEMi/XZlV5
	5aBcRGCzJWcPGS8U54FZxhKyR0sHfChw/9EOBddCxs6+KEDHnJYSLLOkIoTZ2/+ersDBNbCwLbC
	/tevYVCRpysYY5/nS5c9qFtgIcnS5pqk=
X-Gm-Gg: AeBDiesUqbFjkiF+lgV9vznRMxMDYPVMBfLQlZdVxEvM1zVH02EqhORyJGg4bW5qUuf
	3YBBII+t1tllapSmlBIu61kKSy98KuTY/KaKlqs+LPMX6HL96OkMH1laTG0Z7u4h03tfbIrrwO4
	xmpypBj3KxmcoKegRuuSfSxImtznMrOyZc1vf5pM25xf7dKwtFjbYlA378qTQsfftBgTF6+xEIz
	zXSmDYc6lJkBrhMPEhbDy07eoEc5s8nIfzTieDw3Om2XP4LlDhTujhrq1/9XdfTjIjyIjPBYt0n
	1lfqyGcCMNWZ8cZTppKD4d22iFontlrSL7dg6w==
X-Received: by 2002:a05:6820:8318:b0:683:6dbf:c6d4 with SMTP id
 006d021491bc7-6836dbfcb7bmr3030718eaf.22.1775485736189; Mon, 06 Apr 2026
 07:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com> <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
In-Reply-To: <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 6 Apr 2026 15:28:42 +0100
X-Gm-Features: AQROBzCw7pv9Q_nhcb2cp7aOThL8Ubn1v1x8P2vXHbgAOxV1wipCcpu51-53q2E
Message-ID: <CA+XhMqxNzaXZRd0co=_gaJsN4zS9L_4OVqhC174EPxA-pzEUgA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, mptcp@lists.linux.dev, dev@openvswitch.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu yes this is indeed a valid point, will address is for next
time. Cheers

On Mon, 6 Apr 2026 at 15:13, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 05/04/2026 17:48, David Carlier wrote:
> > Use the typed random integer helpers instead of
> > get_random_bytes() when filling a single integer variable.
> > The helpers return the value directly, require no pointer
> > or size argument, and better express intent.
>
> Regarding the modifications in net/mptcp, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org> # net/mptcp
>
> > Skipped sites writing into __be16 fields (netdevsim) where
> > a direct assignment would trigger sparse endianness warnings.
>
> Note that the AI reviews are mentioning that auth->client_challenge from
> net/ceph/auth_x.c is declared as __le64, and it might then also cause
> sparse warnings:
>
>   https://sashiko.dev/#/patchset/20260405154816.4774-1-devnexen%40gmail.com
>
>
> It looks like they are right:
>
>   $ make C=1 net/ceph/auth_x.o
>   net/ceph/auth_x.c:574:40: warning: incorrect type in assignment (different base types)
>   net/ceph/auth_x.c:574:40:    expected restricted __le64 [usertype] client_challenge
>   net/ceph/auth_x.c:574:40:    got unsigned long long
>
>
> Note that the Netdev CI currently doesn't check sparse warnings:
>
>   https://github.com/linux-netdev/nipa/issues/76
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
