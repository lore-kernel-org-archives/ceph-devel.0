From: Owen Synge <osynge@suse.com>
Subject: Re: Pentagon Orange redefined in ceph-deploy
Date: Fri, 10 Jul 2015 10:57:39 +0200
Message-ID: <559F8903.3000200@suse.com>
References: <559E4814.8030007@suse.com> <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com> <559ECD70.9080700@suse.com> <559ECF4E.6040705@suse.com> <1DC6F8CB-2A8D-4541-A974-1871A313BF03@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:40611 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbbGJI7e (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 10 Jul 2015 04:59:34 -0400
In-Reply-To: <1DC6F8CB-2A8D-4541-A974-1871A313BF03@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@redhat.com>
Cc: ceph-devel@vger.kernel.org

Dear Travis,

I think we are building up a ground work upon where we can find much
agreement.

I think their is a lot of misunderstanding and we are beginning to
resolve which I believe is essential that we complete before I return t=
o
up streaming work.

I want to leave time for people who strongly object to the compromises
and what looks like eventual agreement to have their time to speak.

More importantly to give a fair answer that wont potentially lead to
more misunderstanding I simply cant schedule time today.

(I am late with my back port (as I have already forward ported) of our
"ceph-deploy rgw" product suitable to go out the door. I want to make
one further change after the last mkdir fix, which is add a flag to
disable install and configuring apache for fastcgi and use just civetwe=
b.)

When I get back to this thread I strongly suspect we can close at least
4 major subjects covered in this thread.

I would love to continue chat but its work time (releasing).

Hopefully then you can look at my solution and see it work for your sel=
f
on opensuse (its not working on rhel atm for reasons I explained before
as well as systemd being used for ceph in SUSE and not in redhat)

Best regards

Owen






On 07/10/2015 07:03 AM, Travis Rhoden wrote:
>=20
>> On Jul 9, 2015, at 12:45 PM, Owen Synge <osynge@suse.com> wrote:
>>
>> Typo:
>>
>> On 07/09/2015 09:37 PM, Owen Synge wrote:
>>> Dear all,
>>>
>>> Their are other details to be discussed, and hopefully lead to
>>> agreement, but lets get to issue #1. The style issues still apply t=
o
>>> ceph and ceph-deploy.
>>>
>>> From what you said, in my opinion the "boat anchor" in ceph-deploy =
is
>>> redefined, as coupling of facade pattern, where all data is availab=
le,
>>> to the ssh loop in a connection. This is probably the biggest singl=
e
>>> architectural issue in ceph-deploy.
>>>
>>> Travis Rhoden stated that the modules are imported as objects as th=
ey
>>> are "instantiated", I should check this, this is very good news and
>>> removes many objections to the outcome.
>=20
> I went back through my previous messages to make sure I knew what I s=
aid.  What I found was:
>=20
>> Furthermore, I don=E2=80=99t think it=E2=80=99s the facade paradigm =
that would limit you to one host at a time at all.  It=E2=80=99s one ho=
st module (facade) instantiated per host.  You could do many of these a=
t once =E2=80=94 I don=E2=80=99t see any reason why you couldn=E2=80=99=
t.  I=E2=80=99ve never tried it out, and I don=E2=80=99t know if python=
-remoto handles concurrency, but I don=E2=80=99t think the facade parad=
igm prevents it.
>=20
> As you say, it would be very good news if things were indeed instanti=
ated, but I am afraid it is not good news and that I was wrong. As I=E2=
=80=99ve started to re-familiarize myself with this bit of the code bas=
e (it has been a while), I=E2=80=99m starting to better understand your=
 points.  Each remote connection is indeed handled by a direct assignme=
nt of the needed module (be it CentOS, Debian, etc), and the module is =
used directly.  It is not an instance of a class.
>=20
> This does have the drawbacks that you=E2=80=99ve mentioned =E2=80=94 =
that you can only do one at a time, that variables would not be thread =
safe, etc.  This has not been an issue thusfar since adding concurrency=
 to ceph-deploy hasn=E2=80=99t really been on the road map.  As far as =
being an =E2=80=9Carchitectural issue=E2=80=9D, it depends on where cep=
h-deploy is going.  When the current host module paradigm was put in pl=
ace, it was a *vast* improvement of what was there before, but that doe=
s not mean it now always has to be that way.
>=20
> I would be against making any major changes in the current 1.5.x seri=
es, but we could start to talk about an improved 1.6.x series.  There a=
re other non-backwards compatible changes that I=E2=80=99ve been consid=
ering as well, in addition to wanting to remove some deprecated code.
>=20
>>>
>>> The discussion of point=20
>>
>> 	2) fa=C3=A7ade requires code layout inflexibility.
>>
>>> is still worth continuing though in a
>>> separate thread as it is still important enough to require discussi=
on,
>>> but it is of a style and good practice discussion rather than Boat
>>> Anchor problem level.
>>>
>>> Many other topics are unaffected.
>=20
> I think the biggest challenge that you and I may run into is an imped=
ance mismatch on priority for getting architectural changes into ceph-d=
eploy. It=E2=80=99s pretty low priority for me, job-wise, and would be =
something that would happen over the course of a few months, with a few=
 changes here and there.  Getting bug fixes in, keeping pace with new f=
eatures in upstream Ceph, and improving usability in the 1.5.x series d=
oes get much more attention from me since we have community users (and =
downstream products) using it every day.
>=20
>>>
>>> On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>>>>> (1A) You have to close one facade to start anouther, eg in ceph-d=
eploy
>>>>>> you have to close each connection before connecting to the next =
server
>>>>>> so making it slow to use as all state has to be gathered.
>>>> concurrency has come up before in ceph-deploy.  It has been our ex=
plicit goal to make ceph-deploy as simple and *clear* as possible for u=
sers, with one of the main purposes to be extremely verbose and essenti=
ally *teach* a user how to deploy a Ceph cluster.  That=E2=80=99s why i=
t prints everything it does by default, shows every remote command, and=
 prints the output back in order.  Concurrency would muddy those waters=
, though we do all want things to go faster.
>>>>
>>>> It is not necessarily the facade pattern that is the limitation th=
ere =E2=80=94 it is the implementation within ceph-deploy.  We simply d=
o a =E2=80=9Cfor host is hostnames=E2=80=A6=E2=80=9D loop everywhere =E2=
=80=94 it doesn=E2=80=99t matter what we are using underneath, we are d=
oing one SSH connection at a time.
>>>
>>> Best regards
>>>
>>> Owen
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --=20
>> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rff=
er, HRB
>> 21284 (AG
>> N=C3=BCrnberg)
>>
>> Maxfeldstra=C3=9Fe 5
>>
>> 90409 N=C3=BCrnberg
>>
>> Germany
>=20
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
