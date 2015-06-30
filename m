From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: Inline dedup/compression
Date: Tue, 30 Jun 2015 08:50:15 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB4C4DCA50@ABGEX73E.FSC.NET>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:6134 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbF3GuT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 02:50:19 -0400
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of James (Fei) Liu-SSI
> Sent: Friday, June 26, 2015 12:01 AM
>=20
> Hi Cephers,
>     It is not easy to ask when Ceph is going to support inline
> dedup/compression across OSDs in RADOS because it is not easy task an=
d
> answered. Ceph is providing replication and EC for performance and fa=
ilure
> recovery. But we also lose the efficiency  of storage store and cost =
associate
> with it. It is kind of contradicted with each other. But I am curious=
 how other
> Cephers think about this question.
>    Any plan for Cephers to do anything regarding to inline
> dedupe/compression except the features brought by local node itself l=
ike
> BRTFS?

Actually, I was considering some kind of simple compression (think RLE =
or some fast variant of Huffman/LZW), but for data payloads in messenge=
r. That would help in inter-datacenter configurations (where fast, low-=
latency links are prohibitively expensive or even not an option at all,=
 so any extra MB/s counts and latency is already high), and with slow i=
nternal networks (1gbit Ethernet, and so on), but never had time to do =
some proper research on that matter.


With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
