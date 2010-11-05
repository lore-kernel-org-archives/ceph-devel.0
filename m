From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: mds getattr locked again
Date: Fri, 5 Nov 2010 18:16:21 +0800
Message-ID: <AANLkTimh=ENJFSHgq7fCLXRDs80jN_woh9vXi7jFhgDc@mail.gmail.com>
References: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
	<Pine.LNX.4.64.1010282151220.27485@cobra.newdream.net>
	<AANLkTinOOi4XjfnfxP8qL81sxzOTLaS4zPJYwY979J0L@mail.gmail.com>
	<Pine.LNX.4.64.1010290920220.13796@cobra.newdream.net>
	<AANLkTik25uL0B56porHb8u413nJ_kcEougHP5iWwe1Z6@mail.gmail.com>
	<Pine.LNX.4.64.1011041104270.15958@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34351 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab0KEKQX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Nov 2010 06:16:23 -0400
Received: by qyk10 with SMTP id 10so2450719qyk.19
        for <ceph-devel@vger.kernel.org>; Fri, 05 Nov 2010 03:16:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1011041104270.15958@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Leander Yu <leander.yu@gmail.com>, ceph-devel@vger.kernel.org

> Aha, okay. =C2=A0That's not the right fix, but points the way to the =
real
> problem. =C2=A0Basically, the rdcache_gen/rdcache_revoking behavior i=
s based on
> how things worked before we looked at i_data.nrpages. =C2=A0We should=
 never
> clear rdcache_gen (unless, perhaps, we're sure we don't hold the cap,=
 but
> there's no point), and it being zero no longer has any special meanin=
g.
>
> Can you try the below patch? =C2=A0I've done some light testing, but =
nothing
> serious yet.
>

Tried this patch. It's working well!

Thanks,
Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
