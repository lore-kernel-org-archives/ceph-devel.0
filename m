From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Analyzing the nightlies
Date: Sun, 10 May 2015 14:52:13 -0400 (EDT)
Message-ID: <66830824.16753637.1431283933813.JavaMail.zimbra@redhat.com>
References: <554DD3D7.7090407@dachary.org> <950294072.16669358.1431217671812.JavaMail.zimbra@redhat.com> <554F15DE.40401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:42798 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbEJSxT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 May 2015 14:53:19 -0400
In-Reply-To: <554F15DE.40401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

See inline

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Sunday, May 10, 2015 1:25:02 AM
Subject: Re: Analyzing the nightlies

Hi Yuri,

On 10/05/2015 02:27, Yuri Weinstein wrote:
> Loic=20
>=20
> You description on high level is correct.  There are, of cause, more =
details when someone actually goes thru the nightlies results.
>=20
> As far as you question "Is there a time like bug scrubbing or sprint =
planning when developers say "Let's analyze QA results and dig bugs" ?"=
 - I surely hope so and do see updates and triages on bugs in the track=
er, but not 100% sure what exactly our process is, so Sage and developm=
ent leads are better persons to ask this.
>=20
> Also when you say "What I'm not sure about is if it's best effort ? "=
  - do you have something in mind instead or in addition to what we do =
now?
> ( I hope something that can lighten the burden :) )

It would make sense for the "Stable releases and backports" team to mon=
itor the nightlies. Not on a daily basis because it would be too much w=
ork (there are only a few of us right now). But after merges to the sta=
ble branch, I think we should monitor the nightlies that could be impac=
ted. Here is an example:

* 20 pull requests from rgw, rbd, fs, rados are merged in the integrati=
on branch (the nightlies don't see it)
* the rgw, rbd, fs, rados suites run on the integration branch and succ=
eed
* the 20 pull requests are merged (after approval by the original devel=
oper and the lead if it was backported by someone from the "Stable rele=
ases and backports" team). This typically happens withink two or three =
days.
* the nightlies will run on a stable branch in which 20 pull requests h=
ave been merged
* if a jobs fails because of on of these 20 pull requests, the person i=
n charge of the stable branch is likely to be in a good position to fig=
ure out where it comes from

I keep an eye on your comments on a daily basis, but I think I should p=
ay attention more closely. I guess the amount of output is intimidating=
 and it's difficult to figure out how to contribute usefully when you o=
nly have one or two hours a week to devote to this.=20

What do you think ?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I Think it's a good idea.

Two points for consideration:

- we need to coordinate those activities in such a way so we use our la=
bs resources very conservatively
- (related go the point above) - we tend to have "stable" related sched=
uled in the Octo lab, how will that work out for the "Stable releases a=
nd backports" team?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =20

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, May 9, 2015 2:31:03 AM
> Subject: Analyzing the nightlies
>=20
> Hi Yuri,
>=20
> It would be useful to add more information bout how the nightlies are=
 analyzed at
>=20
>    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_monitor_=
the_automated_tests_AKA_nightlies
>=20
> At this point my understanding is that you look over all of them and =
you carry the burden of=20
>=20
> * sorting out the environmental noise
> * creating new bugs for errors for which there is no match in the tra=
cker
> * add a link to the failed job in pre-existing issues found in the tr=
acker (useful to figure out the frequency and helps with debug when the=
re are multiple outputs / logs)
>=20
> You do so by using tools such as https://github.com/jcsp/scrape/blob/=
master/scrape.py and maybe others and you also format your mail message=
s so that they can be parsed by a program (although such a program does=
 not exist yet, it could go over all your messages and build a database=
 from the mails you sent).
>=20
> In the http://lists.ceph.com/private.cgi/ceph-qa-ceph.com/ archives, =
I see that Greg also regularly goes over the errors and other developer=
s also do. What I'm not sure about is if it's best effort ? Is there a =
time like bug scrubbing or sprint planning when developers say "Let's a=
nalyze QA results and dig bugs" ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
