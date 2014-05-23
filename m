From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: collectd / graphite / grafana .. calamari?
Date: Fri, 23 May 2014 08:38:59 +0200 (CEST)
Message-ID: <f5e6ac24-05aa-4a19-8177-6ddad702cdbc@mailpro>
References: <CA+xPSVCDxfPNATq2_jZPACxPrp_fB=URRQC9AZRexe5UatA5=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:43224 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbaEWGjI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 May 2014 02:39:08 -0400
In-Reply-To: <CA+xPSVCDxfPNATq2_jZPACxPrp_fB=URRQC9AZRexe5UatA5=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Rocha <rocha.porto@gmail.com>
Cc: "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

>>https://github.com/rochaporto/collectd-ceph=20
>>
>>It has a set of collectd plugins pushing metrics which mostly map wha=
t=20
>>the ceph commands return. In the setup we have it pushes them to=20
>>graphite and the displays rely on grafana (check for a screenshot in=20
>>the link above).=20


Thanks for sharing ricardo !

I was looking to create a dashboard for grafana too, yours seem very go=
od :)



----- Mail original -----=20

De: "Ricardo Rocha" <rocha.porto@gmail.com>=20
=C3=80: "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph=
-users@lists.ceph.com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 23 Mai 2014 02:58:04=20
Objet: collectd / graphite / grafana .. calamari?=20

Hi.=20

I saw the thread a couple days ago on ceph-users regarding collectd...=20
and yes, i've been working on something similar for the last few days=20
:)=20

https://github.com/rochaporto/collectd-ceph=20

It has a set of collectd plugins pushing metrics which mostly map what=20
the ceph commands return. In the setup we have it pushes them to=20
graphite and the displays rely on grafana (check for a screenshot in=20
the link above).=20

As it relies on common building blocks, it's easily extensible and=20
we'll come up with new dashboards soon - things like plotting osd data=20
against the metrics from the collectd disk plugin, which we also=20
deploy.=20

This email is mostly to share the work, but also to check on Calamari?=20
I asked Patrick after the RedHat/Inktank news and have no idea what it=20
provides, but i'm sure it comes with lots of extra sauce - he=20
suggested to ask in the list.=20

What's the timeline to have it open sourced? It would be great to have=20
a look at it, and as there's work from different people in this area=20
maybe start working together on some fancier monitoring tools.=20

Regards,=20
Ricardo=20
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
