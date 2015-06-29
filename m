From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: deleting objects from a pool
Date: Mon, 29 Jun 2015 08:19:46 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB4C4DC43B@ABGEX73E.FSC.NET>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com>
 <90559C83A9C7FA45B5846C975DFA612DDB4C3F7250@ABGEX73E.FSC.NET>
 <BC97738F8E7C8742BABED7F06FB9DF91669ACA7B@SATLEXDAG01.amd.com>
 <66EBB02ADA308B4F8273E99FC000126C6BEA0BD5C8@ABGEX70E.FSC.NET>
 <558CAEC1.3050204@redhat.com>
 <66EBB02ADA308B4F8273E99FC000126C6BEA0BDEFE@ABGEX70E.FSC.NET>
 <558D6DF2.5070302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:39784 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbF2GTx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 02:19:53 -0400
In-Reply-To: <558D6DF2.5070302@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: David Zafman [mailto:dzafman@redhat.com]
> Sent: Friday, June 26, 2015 5:21 PM
>=20
> This is a dangerous command because it can remove all your objects.

Well, that's the point of it, isn't it?

> At least
> it can only do one namespace at a time.  It was intended to cleanup r=
ados
> bench runs,

And sometimes you need to clean up failed or more than one run (when "c=
leanup" doesn't work).

> and is dangerous because it doesn't require extra hoops like
> rados rmpool does.

Actually, it does, because you need to know that you can specify empty =
prefix or run name, and that's not that common knowledge.
=20
> I'm tempted to disallow a usage this way with empty --prefix/--run-na=
me
> arguments.

One solution would be to have "purge" command with syntax similar to "r=
mpool".
Disallowing any kind of "purge" without replacement would be a serious =
PITA for many users, including developers.

With best regards / Pozdrawiam
Piotr Da=B3ek


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
