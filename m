From: Ian Colle <ian.colle@inktank.com>
Subject: Re: Slow request problem - help please.
Date: Wed, 16 Apr 2014 09:05:23 -0700
Message-ID: <CF73F814.2C6E5%ian.colle@inktank.com>
References: <941FC8BE87ADE64D90E4EB6CD5545177460F4D61@EPBYMINSA0032.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34684 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaDPQFd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Apr 2014 12:05:33 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so11032803pab.22
        for <ceph-devel@vger.kernel.org>; Wed, 16 Apr 2014 09:05:33 -0700 (PDT)
In-Reply-To: <941FC8BE87ADE64D90E4EB6CD5545177460F4D61@EPBYMINSA0032.epam.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Andrey Kuznetsov <Andrey_Kuznetsov@epam.com>, ceph-users@lists.ceph.com

Moving to ceph-users.

Ian R. Colle
Director of Engineering
Inktank
Delivering the Future of Storage
http://www.linkedin.com/in/ircolle
http://www.twitter.com/ircolle
Cell: +1.303.601.7713
Email: ian@inktank.com



On 4/16/14, 7:52 AM, "Ilya Storozhilov" <Ilya_Storozhilov@epam.com> wro=
te:

>Hello Ceph developers,
>
>we encountered a problem with 3 OSDs/3 MONs Ceph cluster (CentOS 6.5. =
64
>bit, Ceph "Emperor", v0.72.2 from RPM), which causes errors on RGW-nod=
e.
>A respective RGW output is:
>
>2014-04-15 09:50:03.906527 7fcd4c5e6700  1 =3D=3D=3D=3D=3D=3D starting=
 new request
>req=3D0x1811b20 =3D=3D=3D=3D=3D
>2014-04-15 09:50:03.908509 7fcd64dfa700  1 Executing get_obj operation
>2014-04-15 09:50:03.909138 7fcd64dfa700  0 ERROR: s->cio->print()
>returned err=3D-1
>2014-04-15 09:50:03.909164 7fcd64dfa700  0 ERROR: s->cio->print()
>returned err=3D-1
>2014-04-15 09:50:03.909168 7fcd64dfa700  0 ERROR: s->cio->print()
>returned err=3D-1
>2014-04-15 09:50:03.909171 7fcd64dfa700  0 ERROR: s->cio->print()
>returned err=3D-1
>2014-04-15 09:50:03.909401 7fcd64dfa700  1 =3D=3D=3D=3D=3D=3D req done=
 req=3D0x16f4c10
>http_status=3D403 =3D=3D=3D=3D=3D=3D
>2014-04-15 09:50:03.909444 7fcd64dfa700  1 =3D=3D=3D=3D=3D=3D starting=
 new request
>req=3D0x1816610 =3D=3D=3D=3D=3D
>2014-04-15 09:50:07.444606 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd66bfd700' had timed out after 600
>2014-04-15 09:50:07.444628 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd245a6700' had timed out after 600
>2014-04-15 09:50:07.444634 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd263a9700' had timed out after 600
>2014-04-15 09:50:07.444639 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd28bad700' had timed out after 600
>2014-04-15 09:50:07.444642 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd2a9b0700' had timed out after 600
>2014-04-15 09:50:07.444649 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd349c0700' had timed out after 600
>2014-04-15 09:50:07.444652 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd367c3700' had timed out after 600
>2014-04-15 09:50:07.444668 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd385c6700' had timed out after 600
>2014-04-15 09:50:07.444673 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd3adca700' had timed out after 600
>2014-04-15 09:50:07.444676 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd3b7cb700' had timed out after 600
>2014-04-15 09:50:07.444681 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd3e9d0700' had timed out after 600
>2014-04-15 09:50:07.444685 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd3fdd2700' had timed out after 600
>2014-04-15 09:50:07.444689 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd411d4700' had timed out after 600
>2014-04-15 09:50:07.444694 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd475de700' had timed out after 600
>2014-04-15 09:50:07.444699 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd4a7e3700' had timed out after 600
>2014-04-15 09:50:07.444703 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd4bbe5700' had timed out after 600
>2014-04-15 09:50:07.444708 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd4cfe7700' had timed out after 600
>2014-04-15 09:50:07.444713 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd533f1700' had timed out after 600
>2014-04-15 09:50:07.444717 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd547f3700' had timed out after 600
>2014-04-15 09:50:07.444728 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd55bf5700' had timed out after 600
>2014-04-15 09:50:07.444734 7fce4f6f8700  1 heartbeat_map is_healthy
>'RGWProcess::m_tp thread 0x7fcd579f8700' had timed out after 600
>2014-04-15 09:50:10.155239 7fcd2a9b0700  1 =3D=3D=3D=3D=3D=3D req done=
 req=3D0x15831f0
>http_status=3D200 =3D=3D=3D=3D=3D=3D
>
>
>An output of the =B3ceph -s=B2 command is:
>
>$ sudo ceph -s
>    cluster 5c6c95b8-8234-4b34-96a9-facc3c561b72
>     health HEALTH_WARN 88 requests are blocked > 32 sec
>     monmap e2: 3 mons at
>{ceph-81=3D10.44.1.81:6789/0,ceph-82=3D10.44.1.82:6789/0,ceph-83=3D10.=
44.1.83:67
>89/0}, election epoch 22, quorum 0,1,2 ceph-81,ceph-82,ceph-83
>     osdmap e519: 3 osds: 3 up, 3 in
>      pgmap v407538: 296 pgs, 32 pools, 64060 kB data, 280 objects
>            17388 MB used, 1058 GB / 1133 GB avail
>                 296 active+clean
>  client io 2148 B/s rd, 102 B/s wr, 3 op/s
>
>Ceph complains with following messages in OSD log-file:
>
>2014-04-16 02:21:18.065305 osd.0 [WRN] slow request 30.613493 seconds
>old, received at 2014-04-16 02:20:47.451757: osd_op(client.5793.0:1270
>default.5793.1__shadow__F0jnzwQRYyOtc-QfW0S2_M0ptLm-o-b_1 [write
>1572864~524288] 172.d7dc6717 e608) v4 currently commit sent
>2014-04-16 02:21:18.065309 osd.0 [WRN] slow request 30.611804 seconds
>old, received at 2014-04-16 02:20:47.453446: osd_op(client.5793.0:1272
>2014-04-16-02-default.5793.1-s3testqwer2 [append 0~276] 104.2973847e
>e608) v4 currently commit sent
>2014-04-16 02:21:18.065312 osd.0 [WRN] slow request 30.610639 seconds
>old, received at 2014-04-16 02:20:47.454611: osd_op(client.5793.0:1273
>default.5793.1__shadow__F0jnzwQRYyOtc-QfW0S2_M0ptLm-o-b_1 [write
>2097152~524288] 172.d7dc6717 e608) v4 currently commit sent
>2014-04-16 02:21:18.065316 osd.0 [WRN] slow request 30.608710 seconds
>old, received at 2014-04-16 02:20:47.456540: osd_op(client.5793.0:1274
>default.5793.1__shadow__F0jnzwQRYyOtc-QfW0S2_M0ptLm-o-b_1 [write
>2621440~524288] 172.d7dc6717 e608) v4 currently commit sent
>2014-04-16 02:21:18.065319 osd.0 [WRN] slow request 30.605942 seconds
>old, received at 2014-04-16 02:20:47.459308: osd_op(client.5793.0:1275
>default.5793.1__shadow__F0jnzwQRYyOtc-QfW0S2_M0ptLm-o-b_1 [write
>3145728~329984] 172.d7dc6717 e608) v4 currently commit sent
>
>After OSD log-verbosity increase we got the following messages from OS=
D:
>
>2014-04-16 03:23:32.337961 7ff93987a700  0 -- 10.44.1.82:6801/2050730 =
>>
>10.44.1.81:6805/1055074 pipe(0x72c0780 sd=3D54 :45949 s=3D2 pgs=3D1593=
0 cs=3D2649
>l=3D0 c=3D0x565a680).fault, initiating reconnect
>2014-04-16 03:23:32.338939 7ff93987a700  0 -- 10.44.1.82:6801/2050730 =
>>
>10.44.1.81:6805/1055074 pipe(0x72c0780 sd=3D54 :45950 s=3D2 pgs=3D1593=
1 cs=3D2651
>l=3D0 c=3D0x565a680).fault, initiating reconnect
>2014-04-16 03:23:32.339956 7ff93987a700  0 -- 10.44.1.82:6801/2050730 =
>>
>10.44.1.81:6805/1055074 pipe(0x72c0780 sd=3D54 :45951 s=3D2 pgs=3D1593=
2 cs=3D2653
>l=3D0 c=3D0x565a680).fault, initiating reconnect
>2014-04-16 03:23:32.341167 7ff93987a700  0 -- 10.44.1.82:6801/2050730 =
>>
>10.44.1.81:6805/1055074 pipe(0x72c0780 sd=3D54 :45952 s=3D2 pgs=3D1593=
3 cs=3D2655
>l=3D0 c=3D0x565a680).fault, initiating reconnect
>2014-04-16 03:23:32.342212 7ff93987a700  0 -- 10.44.1.82:6801/2050730 =
>>
>10.44.1.81:6805/1055074 pipe(0x72c0780 sd=3D54 :45953 s=3D2 pgs=3D1593=
4 cs=3D2657
>l=3D0 c=3D0x565a680).fault, initiating reconnect
>2014-04-16 03:23:32.343330 7ff93987a700  0 -- 10.44.1.82:6801/2050730 =
>>
>10.44.1.81:6805/1055074 pipe(0x72c0780 sd=3D54 :45954 s=3D2 pgs=3D1593=
5 cs=3D2659
>l=3D0 c=3D0x565a680).fault, initiating reconnect
>[14:26:33] Ilya Storozhilov: 2014-04-16 03:25:55.170361 7ff955f87700  =
0
>log [WRN] : 15 slow requests, 2 included below; oldest blocked for >
>33.673854 secs
>2014-04-16 03:25:55.170373 7ff955f87700  0 log [WRN] : slow request
>33.636609 seconds old, received at 2014-04-16 03:25:21.533670:
>osd_op(client.5793.0:5387
>default.5793.2__shadow__MMYl0ajXAfpaBMg55xl6ZVlD7U1lstn_3 [writefull
>0~87104] 172.12238d13 e617) v4 currently waiting for subops from [2]
>2014-04-16 03:25:55.170380 7ff955f87700  0 log [WRN] : slow request
>33.122809 seconds old, received at 2014-04-16 03:25:22.047470:
>osd_op(client.5793.0:5394 default.5793.2_myobjects_14 [cmpxattr
>user.rgw.idtag (17) op 1 mode 1,create 0~0,delete,setxattr user.rgw.id=
tag
>(17),writefull 0~524288,setxattr user.rgw.manifest (818),setxattr
>user.rgw.acl (185),setxattr user.rgw.content_type (25),setxattr
>user.rgw.etag (33)] 172.3a483fca e617) v4 currently waiting for subops
>from [2]
>
>This page=20
>http://ceph.com/docs/master/rados/troubleshooting/troubleshooting-osd/
>contains the following information about this problem:
>
>Possible causes include:
>=20
>    A bad drive (check dmesg output)
>    A bug in the kernel file system bug (check dmesg output)
>    An overloaded cluster (check system load, iostat, etc.)
>    A bug in the ceph-osd daemon.
>=20
>Possible solutions:
>=20
>    Remove VMs Cloud Solutions from Ceph Hosts
>    Upgrade Kernel
>    Upgrade Ceph
>    Restart OSDs
>
>We checked our environment for bad drive, kernel bug and system load a=
nd
>found that everything works fine but OSD consumes 100% of CPU when thi=
s
>error appears. OSD restart did not help.
>
>Can you help us in some way, e.g. give an advise where to dig or
>whatever? Thank you very much!
>
>Best Regards,=20
>
>Ilya Storozhilov
>
>Lead Software Engineer
>
>=20
>
>EPAM Systems=20
>
>Tver office, Russia
>
>GMT+4=20
>
>=20
>
>EPAM Internal ext.:  55529
>
>Office phone:        +7 (4822) 630-070 ext. 55529
>
>Office fax:          +7 (4822) 630-073
>
>Mobile phone:        +7 (904) 021-0763
>
>E-mail:              Ilya_Storozhilov@epam.com
>
>=20
>
>http://www.epam.com
>
>=20
>
>CONFIDENTIALITY CAUTION AND DISCLAIMER
>
>This message is intended only for the use of the individual(s) or
>entity(ies) to which it is addressed and contains information that is
>legally privileged and confidential. If you are not the intended
>recipient, or the person responsible for delivering the
> message to the intended recipient, you are hereby notified that any
>dissemination, distribution or copying of this communication is strict=
ly
>prohibited. All unintended recipients are obliged to delete this messa=
ge
>and destroy any printed copies.
>
>
>
>
>
>
>
>
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
