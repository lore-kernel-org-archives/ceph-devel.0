From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: pgs stuck inactive
Date: Wed, 4 Apr 2012 13:51:53 -0700
Message-ID: <CACLRD_2yhpoUGoivHQpp-LyO82MdTz5SpD0MN5b_vEoqSGBzgg@mail.gmail.com>
References: <CAFtEh-dcEKQ2AzcVmu1G5i-zFHgim5SLZvEmNtDsvkHt+JnzLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47482 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab2DDUvy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Apr 2012 16:51:54 -0400
Received: by wejx9 with SMTP id x9so437998wej.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Apr 2012 13:51:53 -0700 (PDT)
In-Reply-To: <CAFtEh-dcEKQ2AzcVmu1G5i-zFHgim5SLZvEmNtDsvkHt+JnzLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Can you post a copy of your osd map and the output of 'ceph pg dump' ?
 You can get the osdmap via 'ceph osd getmap -o <filename>'.
-Sam

On Wed, Apr 4, 2012 at 1:12 AM, Damien Churchill <damoxc@gmail.com> wro=
te:
> Hi,
>
> I'm having some trouble getting some pgs to stop being inactive. The
> cluster is running 0.44.1 and the kernel version is 3.2.x.
>
> ceph -s reports:
> 2012-04-04 09:08:57.816029 =C2=A0 =C2=A0pg v188540: 990 pgs: 223 inac=
tive, 767
> active+clean; 205 GB data, 1013 GB used, 8204 GB / 9315 GB avail
> 2012-04-04 09:08:57.817970 =C2=A0 mds e2198: 1/1/1 up {0=3Dnode24=3Du=
p:active},
> 4 up:standby
> 2012-04-04 09:08:57.818024 =C2=A0 osd e5910: 5 osds: 5 up, 5 in
> 2012-04-04 09:08:57.818201 =C2=A0 log 2012-04-04 09:04:03.838358 osd.=
3
> 172.22.10.24:6801/30000 159 : [INF] 0.13d scrub ok
> 2012-04-04 09:08:57.818280 =C2=A0 mon e7: 3 mons at
> {node21=3D172.22.10.21:6789/0,node22=3D172.22.10.22:6789/0,node23=3D1=
72.22.10.23:6789/0}
>
> ceph health says:
> 2012-04-04 09:09:01.651053 mon <- [health]
> 2012-04-04 09:09:01.666585 mon.1 -> 'HEALTH_WARN 223 pgs stuck
> inactive; 223 pgs stuck unclean' (0)
>
> I was wondering if anyone has any suggestions about how to resolve
> this, or things to look for. I've tried restarted the ceph daemons on
> the various nodes a few times to no-avail. I don't think that there i=
s
> anything wrong with any of the nodes either.
>
> Thanks in advance,
> Damien
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
