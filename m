From: Travis Rhoden <trhoden@redhat.com>
Subject: Re: Pentagon Orange redefined in ceph-deploy
Date: Thu, 9 Jul 2015 22:03:06 -0700
Message-ID: <1DC6F8CB-2A8D-4541-A974-1871A313BF03@redhat.com>
References: <559E4814.8030007@suse.com> <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com> <559ECD70.9080700@suse.com> <559ECF4E.6040705@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbbGJFDI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 01:03:08 -0400
In-Reply-To: <559ECF4E.6040705@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org


> On Jul 9, 2015, at 12:45 PM, Owen Synge <osynge@suse.com> wrote:
>=20
> Typo:
>=20
> On 07/09/2015 09:37 PM, Owen Synge wrote:
>> Dear all,
>>=20
>> Their are other details to be discussed, and hopefully lead to
>> agreement, but lets get to issue #1. The style issues still apply to
>> ceph and ceph-deploy.
>>=20
>> From what you said, in my opinion the "boat anchor" in ceph-deploy i=
s
>> redefined, as coupling of facade pattern, where all data is availabl=
e,
>> to the ssh loop in a connection. This is probably the biggest single
>> architectural issue in ceph-deploy.
>>=20
>> Travis Rhoden stated that the modules are imported as objects as the=
y
>> are "instantiated", I should check this, this is very good news and
>> removes many objections to the outcome.

I went back through my previous messages to make sure I knew what I sai=
d.  What I found was:

> Furthermore, I don=E2=80=99t think it=E2=80=99s the facade paradigm t=
hat would limit you to one host at a time at all.  It=E2=80=99s one hos=
t module (facade) instantiated per host.  You could do many of these at=
 once =E2=80=94 I don=E2=80=99t see any reason why you couldn=E2=80=99t=
=2E  I=E2=80=99ve never tried it out, and I don=E2=80=99t know if pytho=
n-remoto handles concurrency, but I don=E2=80=99t think the facade para=
digm prevents it.

As you say, it would be very good news if things were indeed instantiat=
ed, but I am afraid it is not good news and that I was wrong. As I=E2=80=
=99ve started to re-familiarize myself with this bit of the code base (=
it has been a while), I=E2=80=99m starting to better understand your po=
ints.  Each remote connection is indeed handled by a direct assignment =
of the needed module (be it CentOS, Debian, etc), and the module is use=
d directly.  It is not an instance of a class.

This does have the drawbacks that you=E2=80=99ve mentioned =E2=80=94 th=
at you can only do one at a time, that variables would not be thread sa=
fe, etc.  This has not been an issue thusfar since adding concurrency t=
o ceph-deploy hasn=E2=80=99t really been on the road map.  As far as be=
ing an =E2=80=9Carchitectural issue=E2=80=9D, it depends on where ceph-=
deploy is going.  When the current host module paradigm was put in plac=
e, it was a *vast* improvement of what was there before, but that does =
not mean it now always has to be that way.

I would be against making any major changes in the current 1.5.x series=
, but we could start to talk about an improved 1.6.x series.  There are=
 other non-backwards compatible changes that I=E2=80=99ve been consider=
ing as well, in addition to wanting to remove some deprecated code.

>>=20
>> The discussion of point=20
>=20
> 	2) fa=C3=A7ade requires code layout inflexibility.
>=20
>> is still worth continuing though in a
>> separate thread as it is still important enough to require discussio=
n,
>> but it is of a style and good practice discussion rather than Boat
>> Anchor problem level.
>>=20
>> Many other topics are unaffected.

I think the biggest challenge that you and I may run into is an impedan=
ce mismatch on priority for getting architectural changes into ceph-dep=
loy. It=E2=80=99s pretty low priority for me, job-wise, and would be so=
mething that would happen over the course of a few months, with a few c=
hanges here and there.  Getting bug fixes in, keeping pace with new fea=
tures in upstream Ceph, and improving usability in the 1.5.x series doe=
s get much more attention from me since we have community users (and do=
wnstream products) using it every day.

>>=20
>> On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>>>> (1A) You have to close one facade to start anouther, eg in ceph-de=
ploy
>>>>> you have to close each connection before connecting to the next s=
erver
>>>>> so making it slow to use as all state has to be gathered.
>>> concurrency has come up before in ceph-deploy.  It has been our exp=
licit goal to make ceph-deploy as simple and *clear* as possible for us=
ers, with one of the main purposes to be extremely verbose and essentia=
lly *teach* a user how to deploy a Ceph cluster.  That=E2=80=99s why it=
 prints everything it does by default, shows every remote command, and =
prints the output back in order.  Concurrency would muddy those waters,=
 though we do all want things to go faster.
>>>=20
>>> It is not necessarily the facade pattern that is the limitation the=
re =E2=80=94 it is the implementation within ceph-deploy.  We simply do=
 a =E2=80=9Cfor host is hostnames=E2=80=A6=E2=80=9D loop everywhere =E2=
=80=94 it doesn=E2=80=99t matter what we are using underneath, we are d=
oing one SSH connection at a time.
>>=20
>> Best regards
>>=20
>> Owen
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>=20
> --=20
> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffe=
r, HRB
> 21284 (AG
> N=C3=BCrnberg)
>=20
> Maxfeldstra=C3=9Fe 5
>=20
> 90409 N=C3=BCrnberg
>=20
> Germany

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
