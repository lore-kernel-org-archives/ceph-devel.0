From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Tool for ceph performance analysis
Date: Tue, 24 Feb 2015 16:51:45 +0100 (CET)
Message-ID: <593379927.1852445.1424793105600.JavaMail.zimbra@oxygem.tv>
References: <CAONhiy7Bu1aqML80D_7Xu42qS1ZTSMwa_W3mZ+t4ivXdwE1szQ@mail.gmail.com> <54EC6714.3090604@redhat.com> <54EC6BA9.3070405@redhat.com> <54EC8758.6050405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46164 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbBXPvr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 10:51:47 -0500
In-Reply-To: <1780156480.1852442.1424793103509.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: John Spray <john.spray@redhat.com>, Alyona Kiselyova <akiselyova@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-calamari@lists.ceph.com

>>Perhaps part of this might be to just try to get a better idea of whi=
ch=20
>>tools folks are using to do performance monitoring on their existing=20
>>clusters (ceph or otherwise).  I've heard zabbix come up quite a bit=20
>>recently.

Hi, we are using graphite here with collectd to retreive host stats.

It's also eay to send custom stats to graphite. It's a simple write to =
an udp socket.
$conn =3D fsockopen("carbon.hostedgraphite.com", 2003);
fwrite($conn, "YOUR-API-KEY.foo 1.2\n");


And we use http://grafana.org/ , as frontend to manage graphs.



----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "John Spray" <john.spray@redhat.com>, "Alyona Kiselyova" <akise=
lyova@mirantis.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Cc: ceph-calamari@lists.ceph.com
Envoy=C3=A9: Mardi 24 F=C3=A9vrier 2015 15:14:48
Objet: Re: Tool for ceph performance analysis

On 02/24/2015 06:16 AM, John Spray wrote:=20
>=20
> On 24/02/2015 11:57, John Spray wrote:=20
>>> It would be great, if there will be internal possibility to collect=
=20
>>> info about whole cluster from one node. May be, something like=20
>>> extension for "tell" command, which can call any node directly and=20
>>> replace external network connections. Or improved version of "ceph =
osd=20
>>> perf" command, which would allow to get more info.=20
>>>=20
>> This pretty much already exists if someone chooses to deploy=20
>> diamond+graphite. Perhaps we need to talk about what's wrong with=20
>> that solution as it stands? I'm guessing the main problem is that=20
>> it's less highly available than ceph mons, and comparatively=20
>> heavyweight, especially if one is only interested in the latest valu=
es.=20
> Ah, I also forgot to mention: it is not very hard to make a cut-down=20
> version of calamari that doesn't require lots of heavyweight=20
> dependencies. I started building this a while back before switching=20
> tasks, but there's an old branch here:=20
> https://github.com/ceph/calamari/commits/wip-lite=20
>=20
> The key things there are that it doesn't require a postgres database,=
=20
> and the remote-execution is abstracted into a "Remote" interface so t=
hat=20
> you can implement alternatives to salt (e.g. SSH, or run locally on=20
> mon). It's all free software so borrow what you wish ;-) The point is=
=20
> that it isn't necessary to start from scratch in order to get somethi=
ng=20
> lightweight.=20

My personal vote is to try to get ourselves well integrated into a good=
=20
cross section of the existing tools that already do this kind of thing=20
(zabbix, collectd, collectl, etc). I'm slightly guilty of rolling my=20
own too since in cbt I gather up some of our daemon socket output from=20
all the hosts via ssh and just dump it in the output directory. There's=
=20
tons of other systems out there that do this kind of thing way better=20
though. I don't want to discourage anyone from making a new tool if=20
that's their preference, but I think a lot of folks would benefit if=20
they could just keep using their existing monitoring tools.=20

Perhaps part of this might be to just try to get a better idea of which=
=20
tools folks are using to do performance monitoring on their existing=20
clusters (ceph or otherwise). I've heard zabbix come up quite a bit=20
recently.=20

Mark=20

>=20
> Cheers,=20
> John=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
