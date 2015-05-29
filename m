From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: Re: rados bench throughput with no disk or network activity
Date: Fri, 29 May 2015 08:33:55 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB4AECFF5E@ABGEX73E.FSC.NET>
References: <BC97738F8E7C8742BABED7F06FB9DF9166995A9B@satlexdag04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:42832 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbE2Gnu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 May 2015 02:43:50 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166995A9B@satlexdag04.amd.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Deneau, Tom
> Sent: Friday, May 29, 2015 1:10 AM
> To: ceph-devel
> Subject: rados bench throughput with no disk or network activity
>=20
> I've noticed that
>    * with a single node cluster with 4 osds
>    * and running rados bench rand on that same node so no network tra=
ffic
>    * with a number of objects small enough so that everything is in t=
he cache
> so no disk traffic
>=20
> we still peak out at about 1600 MB/sec.
>=20
> And the cpu is 40% idle. (and a good chunk of the cpu activity is the=
 rados
> benchmark itself)
>=20
> What is likely causing the throttling here?

You may want to try this: https://github.com/ceph/ceph/pull/4690
This one will help too: https://github.com/ceph/ceph/pull/4728

I ran into similar problem (rados bench peaking at 2300MB/s when no rad=
os
i/o was taking place; in fact, I ripped out every call to librados in t=
he benchmark=20
loop) and those two were solutions for me.

With best regards / Pozdrawiam
Piotr Da=B3ek


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
