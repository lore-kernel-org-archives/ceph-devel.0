From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: OSD and MON memory usage
Date: Wed, 28 Nov 2012 21:30:32 +0000
Message-ID: <20121128213032.183913c7e662741850918f32@ist.utl.pt>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
	<50AFA848.4050109@inktank.com>
	<20121127172350.b6d21634.ctpm@ist.utl.pt>
	<CA+4uBUYv49DmX0EC5QovOtpgR5=TFM1xK4LPjp0M-8bM9B_0iA@mail.gmail.com>
	<20121128210501.cefc7b4c2877410803d81c7f@ist.utl.pt>
	<CA+4uBUZ4+vZt-BErOeBBFMunwQBsiJURaoPEFpJ5FDrXUmQ2jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:58577 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab2K1Vaf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 16:30:35 -0500
In-Reply-To: <CA+4uBUZ4+vZt-BErOeBBFMunwQBsiJURaoPEFpJ5FDrXUmQ2jQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 28 Nov 2012 13:08:08 -0800 Samuel Just <sam.just@inktank.com> w=
rote:
> Can you post the output of ceph -s?

 'ceph -s' right now gives

   health HEALTH_WARN 923 pgs degraded; 8666 pgs down; 9606 pgs peering=
; 7 pgs recovering; 406 pgs recovery_wait; 3769 pgs stale; 9606 pgs stu=
ck inactive; 3769 pgs stuck stale; 11052 pgs stuck unclean; recovery 12=
1068/902868 degraded (13.409%); 4824/300956 unfound (1.603%); 2/18 in o=
sds are down
   monmap e1: 1 mons at {0=3D193.136.128.202:6789/0}, election epoch 1,=
 quorum 0 0
   osdmap e7669: 62 osds: 16 up, 18 in
    pgmap v47643: 12480 pgs: 35 active, 1223 active+clean, 129 stale+ac=
tive, 321 active+recovery_wait, 198 stale+active+clean, 236 peering, 2 =
active+remapped, 2 stale+active+recovery_wait, 6126 down+peering, 249 a=
ctive+degraded, 2 stale+active+recovering+degraded, 598 stale+peering, =
7 active+clean+scrubbing, 29 active+recovery_wait+remapped, 2067 stale+=
down+peering, 618 stale+active+degraded, 52 active+recovery_wait+degrad=
ed, 61 remapped+peering, 365 down+remapped+peering, 2 stale+active+reco=
very_wait+degraded, 45 stale+remapped+peering, 108 stale+down+remapped+=
peering, 5 active+recovering; 1175 GB data, 1794 GB used, 25969 GB / 27=
764 GB avail; 121068/902868 degraded (13.409%); 4824/300956 unfound (1.=
603%)
   mdsmap e1: 0/0/1 up



 The cluster has been in this state since the last attempt to get it
going. I added about 100GB of swap on each machine to avoid the OOM
killer. Running like this resulted in the machines trashing wildly and
getting to ~2000 load avg, and after a while the osds started
dying/commited suicide, but *not* from OOM. Some of the few that remain
have bloated to around 1.9GB of mem usage.

 If you want, I can try to restart the whole thing tomorrow and collect
fresh log output from the dying OSDs, or any other action or debug info
that you might find useful.


Thanks!

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
