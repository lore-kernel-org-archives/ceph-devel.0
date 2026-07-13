Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F51376481
	for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981359; cv=none; b=hDh0ib1BF78Veb5ex5dl8umhu6u+Sju+6FGwOJHGdbERGR9xkU5hbxVXuA+CXS0uSE3eKrEd88KQQ1M7UV0qZAvG+Xmk6YzvJBFM0yc4OwF2oHIuWDz1jktxgPSNnoAEgKe3rWO0RuAY99MJRaGS60fwn8rPjmpNBYjMxpXWCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981359; c=relaxed/simple;
	bh=0nkRg+yGBX2KyDmifQ52n3jZZ0WvpalWWXKsAaN8hKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vgs3XnUUgm38ThxrCWG6OtESRjyjiqf7FIOEVvplqQ29YfoqyvZwkO+n16lwHCJKrmHi16FxZtyqKeRBjgZxf56i6YluPlQ0mbtIvJjx9d3hkHOra2h+MO6rBeALOhxq+2+cTX/Pd9hhML3czvz0Oef4bcW62PElVWMxMvnulVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=DFbJ/jXs; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="DFbJ/jXs"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dbcb505578so3971327b3.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 15:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783981357; x=1784586157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0nkRg+yGBX2KyDmifQ52n3jZZ0WvpalWWXKsAaN8hKg=;
        b=DFbJ/jXsUi+MwE8IPjqJvqOG7ntTdJ94XZkENB0C2OktKjeFUcBpSkIutvwlIDfb8a
         NdbWrdK8or3F18DeCNXO9OFFgKf6z1WO0SwvTVJmTZYTimhPxP0+2SrCqCzFOiW+ZOJK
         NtJoBab3J58EigSBhswjCTG4bFBTfY3faw7R6be8eWhvS006WMuzaR9kFZnhVdpY39Fj
         xqrhiJQ1hFuKA7VNUDoK/4zXdx3k5muBozTWA189acsCmBXQsyrdlwnPGPNxkJnOYwiT
         K8nR7k8B5/fIl7+Byll2ea4PLMKdLli2ghChlcatuS1lsSRrQf5m+WWFQxy+GbfUZ/Ri
         HKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981357; x=1784586157;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0nkRg+yGBX2KyDmifQ52n3jZZ0WvpalWWXKsAaN8hKg=;
        b=BqfIE4y4rqKgi0uaeM3Npacel+eS0XZmsDdPP1xqL/cInAF8ZCNN3t3xwBPJ3X0obw
         v3IFEE6UhBsypikgP1G/AXCdvzIi2A0AxrOZWEU/5dqI5pYqlQRoP27JMfmzoAnKs0lZ
         kBJFYeosaW0CE6IpYZq0qZWpFeAmjBiYWWchuZgEI9R+Wb5et/7sJ9CUTW/KZJGk5gaS
         EJPCCrkHJO7SNCsAD52JlNNPR1dfknzcRfSaEjnGacBjrOOa9TU9hiGhj5MMsEUrAvoi
         kbxemuPyHk5U1pFZxV39FrVTre5vFTOsKY7RxribLWLZxGKbtT+9SU+nltI+ALZD0dcU
         IKUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4Ei/zqFnSAX9EgWqNMXGJUgcxhMnAlw+ekxrvuE2E8ND65b46V5ukkIQYeqrMBp/iU6s0TqCShDLR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqjvtujfs1qWjYJARI3MB8A5ng0/9KN3ugND+w5jWBc0x8jcMn
	Sr/MuRPbQ2CFqc1gZ8CiccAPXXaaCxynzqgc5VfIXoMOFrF4Ky13AthF0wpSwYm7dxI=
X-Gm-Gg: AfdE7clqH0Or7Cs3JmeRt2YJEOqeTpzNkMLIWDEPiitY/YHIa+kq6uKQOXeEqQSqZxB
	QoOfxzGxgkU2/72X9m+hvk/HDsDbO60gew7McMHu7zy7tNEjU5VznQD4/WVKZOgLB6wlnpt3nZ9
	QADErUuyEAqlxvT4F+9K1S+Ve0WcqEIt8CInPf27ORmtpUrArAjOQOijxj/VXoMAU4J4L3zLrhs
	AIlkkd6GCvFmE6+H2Vp4b7nKJvVqTqZygZwNN8kDTDiWbH7KX+T6blPENZOguY46KZZBQslLpW6
	6V5REqk7CArT4l5SjOt+jJAWNES0nrbeWOapKzP7UUhtdUCkMZknB1fSRhOzin9/QW84E0zJntX
	ckjj2lBDYNFPjo1oWpn3qsbWpl0tGEkqcGmx3JYaETQ8B+f+IlhaCpZr2r0b2xTAXa3CABEeFJu
	3KigzBAjCpxEAUSjtxpFocTu2Y/UVaasnh3Uso2BjuXMxYGqq1NBEihg+cheR+52ijCIr4DcbD+
	Z9LHZpx7UDgJp5mFVWpjqP+SdYBG7MoyBX8fytP0DlHrQ==
X-Received: by 2002:a05:690c:6e88:b0:81e:3eba:b10 with SMTP id 00721157ae682-81e90139b71mr83411667b3.43.1783981357059;
        Mon, 13 Jul 2026 15:22:37 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:e472:ff2d:20b0:742d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c22441csm127429897b3.43.2026.07.13.15.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:22:36 -0700 (PDT)
Message-ID: <ee478394c5d2ec19dd0b5ce39adb9476c826cf39.camel@dubeyko.com>
Subject: Re: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yong Wang <edragain@163.com>, Viacheslav Dubeyko
 <Slava.Dubeyko@ibm.com>,  "ceph-devel@vger.kernel.org"	
 <ceph-devel@vger.kernel.org>, "enjou1224z@gmail.com" <enjou1224z@gmail.com>
Cc: "sage@newdream.net" <sage@newdream.net>, "idryomov@gmail.com"	
 <idryomov@gmail.com>, "dstsmallbird@foxmail.com"
 <dstsmallbird@foxmail.com>,  Alex Markuze <amarkuze@redhat.com>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>
Date: Mon, 13 Jul 2026 15:22:34 -0700
In-Reply-To: <7a71431b-4c39-47cb-baac-0cbad03e13c9@163.com>
References: <cover.1783423648.git.edragain@163.com>
	 <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
	 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
	 <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
	 <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com>
	 <7a71431b-4c39-47cb-baac-0cbad03e13c9@163.com>
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

On Sun, 2026-07-12 at 14:28 +0800, Yong Wang wrote:
>=20
>=20
> =E5=9C=A8 2026/7/11 0:33, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > On Fri, 2026-07-10 at 10:16 +0800, Yong Wang wrote:
> > >=20
> > > =E5=9C=A8 2026/7/9 6:43, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > > > On Wed, 2026-07-08 at 11:03 +0800, Ren Wei wrote:
> > > > > From: Yong Wang <edragain@163.com>
> > > > >=20
> > > > > ceph_compare_options() checks whether a new mount shares any
> > > > > monitor
> > > > > address with an existing client by walking client-
> > > > > >monc.monmap via
> > > > > ceph_monmap_contains().=C2=A0 That comparison can run under
> > > > > sb_lock or
> > > > > rbd_client_list_lock, so it cannot take monc->mutex.
> > > > >=20
> > > > > Meanwhile, monmap update handling replaces monc->monmap under
> > > > > monc->mutex and frees the old map immediately.=C2=A0 A concurrent
> > > > > shared-
> > > > > mount comparison can therefore dereference a freed monmap and
> > > > > walk
> > > > > stale mon_inst[] entries, triggering a use-after-free.
> > > > >=20
> > > > > Protect the compare path with RCU and publish/free monitor
> > > > > maps with
> > > > > rcu_assign_pointer() and kfree_rcu().=C2=A0 Annotate monc->monmap
> > > > > as an
> > > > > RCU pointer and use rcu_dereference_protected() in mutex-
> > > > > protected
> > > > > paths to keep the accesses consistent with the new pointer
> > > > > contract.
> > > > >=20
> > > > > This keeps the existing non-blocking comparison semantics
> > > > > while
> > > > > ensuring that replaced monmaps remain alive until readers are
> > > > > done.
> > > >=20
> > > > The approach makes sense to me. However, I have some concern.
> > > > If the replaced
> > > > monmap(s) could be in use with newly allocated one(s), then are
> > > > we safe here?
> > >=20
> > > The new monmap is fully allocated and initialized before
> > > publication, then
> > > installed with rcu_assign_pointer() under monc->mutex. Readers
> > > only dereference
> > > an RCU snapshot and treat the monmap as immutable, while the
> > > replaced monmap is
> > > freed with kfree_rcu(), which means the old map is not reclaimed
> > > immediately,=20
> > > but is delayed until all readers that are still accessing it have
> > > exited the=20
> > > read-side critical section.Readers only see either the old map or
> > > the new map.
> > >=20
> > > So it is safe to use.
> > >=20
> > > > Have you tried to run xfstests for the patch?
> > >=20
> > > I ran the ceph xfstests in QEMU on the patched kernel, and all
> > > ceph-
> > > specific tests in the current tree passed: ceph/001-006.
> > >=20
> > >=20
> >=20
> > The running only Ceph specific test-cases is not enough. The patch
> > should
> > survive the auto group of xfstests.
> >=20
> I reran the tests on a baseline kernel before the RCU patch.
>=20
> Excluding the notrun cases, the following tests failed both before
> and after the patch:
>=20
> - generic/363: fsx reported READ BAD DATA
> - generic/429: encrypted dentry/key revalidation behavior did not
> match expectations
> - generic/440: encrypted name/key cache consistency behavior did not
> match expectations
> - generic/580: encrypted files became inaccessible after key
> removal/re-addition
> - generic/593: filesystem-level/provisioning-key encryption flow
> failed
> - generic/595: encrypted file remained inaccessible after key
> eviction/re-addition
> - generic/631: overlayfs-on-Ceph scratch mount path failed
>=20
> generic/650 and generic/777 could not be completed reliably in my
> local environment because=20
> they caused the terminal to become unresponsive, so I do not have a
> meaningful=20
> before/after comparison for them.
>=20
> So from this comparison, I do not have evidence that the above
> failures were introduced=20
> by the RCU patch.
>=20
> Kernel(net) commit tested before the patch:
> =C2=A0 6d27e29a90bc6a717b97c6ddcd866db7bd8e4adc
>=20
> xfstests commit:
> =C2=A0 ffc8bad17e5b2f56e48dbac43f7c5ae8ac368fe5
>=20
>=20

It's interesting that you can reproduce more failures that I can
reproduce in my environment. :) Usually, I can see around 3 failed
xfstests. I've already shared fixes for several ones. But my fixes
haven't been accepted. We still need to fix some xfstests failures. :)

The patch makes sense to me and it looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
