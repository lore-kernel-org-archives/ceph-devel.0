From: Wales Wang <wormwang@yahoo.com>
Subject: Re: [ceph-users] OSD state flipping when cluster-network in high utilization
Date: Wed, 15 May 2013 08:52:50 +0800
Message-ID: <BACB626D-7FF0-42C5-95EE-FE493828B1B1__35449.7203989469$1368579510$gmane$org@yahoo.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC0145EFF6@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm35.bullet.mail.sg3.yahoo.com ([106.10.151.30]:32359 "HELO
	nm35.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758286Ab3EOA6V convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 May 2013 20:58:21 -0400
In-Reply-To: <alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

My advice is leverage Linux cgroup to isolate some resource for critica=
l part of Ceph.
Such as state of heartbeat, replication of OSDs.
Even the timeout set to many minutes, there always are bigger heavy loa=
ding on Ceph.

Wales Wang

=D4=DA 2013-5-14=A3=AC=CF=C2=CE=E711:30=A3=ACSage Weil <sage@inktank.co=
m> =D0=B4=B5=C0=A3=BA

> On Tue, 14 May 2013, Chen, Xiaoxi wrote:
>>=20
>> Hi
>>=20
>>   We are suffering our OSD flipping between up and down ( OSD X be v=
oted to
>> down due to 3 missing ping, and after a while it tells the monitor ?=
map xxx
>> wrongly mark me down? ). Because we are running sequential write per=
formance
>> test on top of RBDs, and the cluster network nics is really in high
>> utilization (8Gb/s+ for a 10Gb network).
>>=20
>>          Is this a expected behavior ? or how can I prevent this hap=
pen?
>=20
> You an increase the heartbeat grace period.  The pings are handled by=
 a=20
> separate thread on the backside interface (if there is one).  If you =
are=20
> missing pings then the network or scheduler is preventing those (smal=
l)=20
> messages from being processed (there is almost no lock contention in =
that=20
> path).  Which means it really is taking ~20 seconds or wahtever to ha=
ndle=20
> those messages.  It's really a questin of how unresponsive you want t=
o=20
> permit the OSDs to be before you consider it a failure..
>=20
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
