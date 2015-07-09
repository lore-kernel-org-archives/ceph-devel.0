From: Owen Synge <osynge@suse.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy
 is bad practice?
Date: Thu, 09 Jul 2015 18:36:44 +0200
Message-ID: <559EA31C.1050000@suse.com>
References: <559E4814.8030007@suse.com> <559E50F2.7030801@redhat.com> <559EA147.8090201@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:38174 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbGIQiS (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 12:38:18 -0400
In-Reply-To: <559EA147.8090201@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org, Loic Dachary <loic@dachary.org>, Travis Rhoden <trhoden@redhat.com>

Small correction due to not proof reading enough.

On 07/09/2015 06:28 PM, Owen Synge wrote:
> Dear all,
>=20
> Lets put a positive spin on this thread and set all misunderstandings=
 on
> my side :)
>=20
> I propose that John clarified and I misunderstood the others in upstr=
eam
> ceph-deploy's position, the style guide includes:
>=20
> (0) Opposes duplication of code.
> (1) Opposes duplication of code for each platform making up more than=
 a
> minimum of code.
> (2) Allowing the use of objects in python.
> (3) Allowing the use of objects with properties.
> (4) Allowing the use of some standard design patterns not already in
> ceph-deploy.

(5) Allow changes to be made in one part of ceph-deploy without having
to change all parts of ceph-deploy at the same time, when making an
implementation of some thing "similar" but not the "same" in a better
way. (such as use of 3 objects in a facade, and not binding it to the
"single fa=C3=A7ade" that can exist in ceph-deploy)

> Hopefully this can be agreed.
>=20
> On 07/09/2015 12:46 PM, John Spray wrote:
>=20
>> I had not seen your wip_services_abstraction branch before, I've jus=
t
>> taken a quick look now.  More comments would probably have made it
>> easier to read, as would following PEP8.  I don't think there's anyt=
hing
>> problematic about having a class that knows how to start and stop a
>> service, but I don't know what comments you've received elsewhere (t=
here
>> aren't any on the PR).
>=20
> If this is not agreeable to all, please speak up.
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
