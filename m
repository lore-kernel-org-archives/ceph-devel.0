From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: Re: deleting objects from a pool
Date: Wed, 24 Jun 2015 18:55:55 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB4C3F7250@ABGEX73E.FSC.NET>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:10351 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbFXQ4B convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 12:56:01 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Deneau, Tom
> Sent: Wednesday, June 24, 2015 6:44 PM
>=20
> I have benchmarking situations where I want to leave a pool around bu=
t
> delete a lot of objects from the pool.  Is there any really fast way =
to do that?
> I noticed rados rmpool is fast but I don't want to remove the pool.
>=20
> I have been spawning multiple threads, each deleting a subset of the =
objects
> (which I believe is what rados bench write does) but even that can be=
 very
> slow.

=46or now, apart from "rados -p <poolname> cleanup" (which doesn't purg=
e the pool, but merely removes objects written during last benchmark ru=
n), the only option is by brute force:

for i in $(rados -p <poolname> ls); do (rados -p <poolname> rm $i &>/de=
v/null &); done;

There's no "purge pool" command in rados -- not yet, at least. I was th=
inking about one, but never really had time to implement one.

With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
