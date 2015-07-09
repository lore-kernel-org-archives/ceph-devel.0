From: Owen Synge <osynge@suse.com>
Subject: Re: Pentagon Orange redefined in ceph-deploy
Date: Thu, 09 Jul 2015 21:45:18 +0200
Message-ID: <559ECF4E.6040705@suse.com>
References: <559E4814.8030007@suse.com> <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com> <559ECD70.9080700@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:39882 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbGITrO (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 15:47:14 -0400
In-Reply-To: <559ECD70.9080700@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@redhat.com>
Cc: ceph-devel@vger.kernel.org

Typo:

On 07/09/2015 09:37 PM, Owen Synge wrote:
> Dear all,
>=20
> Their are other details to be discussed, and hopefully lead to
> agreement, but lets get to issue #1. The style issues still apply to
> ceph and ceph-deploy.
>=20
> From what you said, in my opinion the "boat anchor" in ceph-deploy is
> redefined, as coupling of facade pattern, where all data is available=
,
> to the ssh loop in a connection. This is probably the biggest single
> architectural issue in ceph-deploy.
>=20
> Travis Rhoden stated that the modules are imported as objects as they
> are "instantiated", I should check this, this is very good news and
> removes many objections to the outcome.
>=20
> The discussion of point=20

	2) fa=C3=A7ade requires code layout inflexibility.

> is still worth continuing though in a
> separate thread as it is still important enough to require discussion=
,
> but it is of a style and good practice discussion rather than Boat
> Anchor problem level.
>=20
> Many other topics are unaffected.
>=20
> On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>>> (1A) You have to close one facade to start anouther, eg in ceph-dep=
loy
>>>> you have to close each connection before connecting to the next se=
rver
>>>> so making it slow to use as all state has to be gathered.
>> concurrency has come up before in ceph-deploy.  It has been our expl=
icit goal to make ceph-deploy as simple and *clear* as possible for use=
rs, with one of the main purposes to be extremely verbose and essential=
ly *teach* a user how to deploy a Ceph cluster.  That=E2=80=99s why it =
prints everything it does by default, shows every remote command, and p=
rints the output back in order.  Concurrency would muddy those waters, =
though we do all want things to go faster.
>>
>> It is not necessarily the facade pattern that is the limitation ther=
e =E2=80=94 it is the implementation within ceph-deploy.  We simply do =
a =E2=80=9Cfor host is hostnames=E2=80=A6=E2=80=9D loop everywhere =E2=80=
=94 it doesn=E2=80=99t matter what we are using underneath, we are doin=
g one SSH connection at a time.
>=20
> Best regards
>=20
> Owen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
