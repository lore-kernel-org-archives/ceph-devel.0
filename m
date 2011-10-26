From: <Eric_YH_Chen@wistron.com>
Subject: Some question about Ceph system (release 0.37)
Date: Wed, 26 Oct 2011 10:11:00 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D56EFA7@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:49775 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab1JZCLo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2011 22:11:44 -0400
Received: from twnhufe3.whq.wistron (unverified [10.37.31.103]) by TWNHUMSW3.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta04c2088e3c0a8167110dc@TWNHUMSW3.wistron.com> for <ceph-devel@vger.kernel.org>;
 Wed, 26 Oct 2011 10:12:47 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, everyone

Nice to meet you. I would like to do some experience on ceph system.

After I installed the latest release 0.37, the ceph system seems work w=
ell. (type ceph -s )

However, I found some error messages in "dmesg" that I never saw it in =
release 0.34.

My environment is ubuntu 11.04 with linux kernel 2.6.38.

Would you please give me some hint where is the problem? Maybe it is ju=
st configuration issue. Thanks!

Message from "dmesg"

[2304674.857044] libceph: mon0 172.16.33.5:6789 session established
[2304677.935334] libceph: auth method 'x' error -1
[2304697.923903] libceph: auth method 'x' error -1
[2304709.822745] libceph:=A0 tid 154730 timed out on osd0, will reset o=
sd
[2304717.912381] libceph: auth method 'x' error -1
[2304737.900906] libceph: auth method 'x' error -1
[2304757.889406] libceph: auth method 'x' error -1
[2304769.788260] libceph:=A0 tid 154730 timed out on osd0, will reset o=
sd
[2304777.877900] libceph: auth method 'x' error -1
[2304797.866390] libceph: auth method 'x' error -1


And in mon.a.log

2011-10-26 09:48:11.297463 7f7cb8560700 -- 172.16.33.5:6789/0 >> 172.16=
=2E33.5:0/325292109 pipe(0x28e2c80 sd=3D12 pgs=3D0 cs=3D0 l=3D0).accept=
 peer addr is really 172.16.33.5:0/325292109 (socket is 172.16.33.5:399=
94/0)
2011-10-26 09:48:11.297952 7f7cb9d6a700 cephx server client.admin:=A0 u=
nexpected key: req.key=3D9366eb4b71c5f40d expected_key=3Ddc17c2ee925c81=
34
2011-10-26 09:48:16.412964 7f7cb9d6a700 cephx server client.admin:=A0 u=
nexpected key: req.key=3Dbd7776ed4b075d7b expected_key=3Db2b0f2b114bed0=
67
2011-10-26 09:48:36.453005 7f7cb9d6a700 cephx server client.admin:=A0 u=
nexpected key: req.key=3D8b03356c9af2d0f8 expected_key=3D83a1d2af732040=
29
2011-10-26 09:48:56.492979 7f7cb9d6a700 cephx server client.admin:=A0 u=
nexpected key: req.key=3Dc09d0833fe6b4819 expected_key=3Dcb1e41b59fd229=
66

Text by "ceph -s"

2011-10-26 09:51:33.846500=A0=A0=A0 pg v433: 396 pgs: 345 active, 51 ac=
tive+clean+degraded; 40985 KB data, 84016 KB used, 395 GB / 400 GB avai=
l; 4/64 degraded (6.250%)
2011-10-26 09:51:33.847231=A0=A0 mds e4: 1/1/1 up {0=3Da=3Dup:active}
2011-10-26 09:51:33.847253=A0=A0 osd e22: 2 osds: 2 up, 2 in
2011-10-26 09:51:33.847431=A0=A0 log 2011-10-25 17:29:29.924855 osd.0 1=
72.16.33.6:6800/22812 475 : [INF] 2.6f scrub ok
2011-10-26 09:51:33.847473=A0=A0 mon e1: 1 mons at {a=3D172.16.33.5:678=
9/0}

Text by "ceph auth list"

2011-10-26 09:51:58.966092 mon <- [auth,list]
2011-10-26 09:51:58.966678 mon.0 -> 'installed auth entries:
mon.
=A0=A0=A0=A0=A0=A0=A0 key: AQAq559O8IroBRAAOkS/pDrdo5jNFvemZenGGg=3D=3D
mds.a
=A0=A0=A0=A0=A0=A0=A0 key: AQAq559OkPp5ABAAHgj9X0lesN5OrnjgTdv4QQ=3D=3D
=A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
osd.0
=A0=A0=A0=A0=A0=A0=A0 key: AQAu559O0GPAFRAAJ6XaaFsc7AXBypxAGcmYbA=3D=3D
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
osd.1
=A0=A0=A0=A0=A0=A0=A0 key: AQAb559OWKdAKRAA69ho1SgvmNYbBXXgzJYn2g=3D=3D
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
osd.2
=A0=A0=A0=A0=A0=A0=A0 key: AQDQ659OQN6aIxAAprfrLDYFmS+XR/+aoRxqmA=3D=3D
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow rwx
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *
client.admin
=A0=A0=A0=A0=A0=A0=A0 key: AQAq559OsFC0BBAABpVi56Uvr0H1qBck7dHhbg=3D=3D
=A0=A0=A0=A0=A0=A0=A0 caps: [mds] allow
=A0=A0=A0=A0=A0=A0=A0 caps: [mon] allow *
=A0=A0=A0=A0=A0=A0=A0 caps: [osd] allow *


regards,

Eric/Pjack


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
