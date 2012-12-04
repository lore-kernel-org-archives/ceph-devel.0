From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD and MON memory usage
Date: Tue, 4 Dec 2012 11:29:14 -0800
Message-ID: <CAPYLRzgmKUh16+MiR9mit5FNYZwMEw-3i37QO_Ja+DOmTn=bLQ@mail.gmail.com>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
	<50AFA848.4050109@inktank.com>
	<20121127172350.b6d21634.ctpm@ist.utl.pt>
	<CA+4uBUYv49DmX0EC5QovOtpgR5=TFM1xK4LPjp0M-8bM9B_0iA@mail.gmail.com>
	<20121128210501.cefc7b4c2877410803d81c7f@ist.utl.pt>
	<CA+4uBUZ4+vZt-BErOeBBFMunwQBsiJURaoPEFpJ5FDrXUmQ2jQ@mail.gmail.com>
	<20121128213032.183913c7e662741850918f32@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:49267 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab2LDTez convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 14:34:55 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so6629842iea.36
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 11:34:55 -0800 (PST)
In-Reply-To: <20121128213032.183913c7e662741850918f32@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>
Cc: Samuel Just <sam.just@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 28, 2012 at 1:30 PM, Cl=E1udio Martins <ctpm@ist.utl.pt> wr=
ote:
>
> On Wed, 28 Nov 2012 13:08:08 -0800 Samuel Just <sam.just@inktank.com>=
 wrote:
>> Can you post the output of ceph -s?
>
>  'ceph -s' right now gives
>
>    health HEALTH_WARN 923 pgs degraded; 8666 pgs down; 9606 pgs peeri=
ng; 7 pgs recovering; 406 pgs recovery_wait; 3769 pgs stale; 9606 pgs s=
tuck inactive; 3769 pgs stuck stale; 11052 pgs stuck unclean; recovery =
121068/902868 degraded (13.409%); 4824/300956 unfound (1.603%); 2/18 in=
 osds are down
>    monmap e1: 1 mons at {0=3D193.136.128.202:6789/0}, election epoch =
1, quorum 0 0
>    osdmap e7669: 62 osds: 16 up, 18 in
>     pgmap v47643: 12480 pgs: 35 active, 1223 active+clean, 129 stale+=
active, 321 active+recovery_wait, 198 stale+active+clean, 236 peering, =
2 active+remapped, 2 stale+active+recovery_wait, 6126 down+peering, 249=
 active+degraded, 2 stale+active+recovering+degraded, 598 stale+peering=
, 7 active+clean+scrubbing, 29 active+recovery_wait+remapped, 2067 stal=
e+down+peering, 618 stale+active+degraded, 52 active+recovery_wait+degr=
aded, 61 remapped+peering, 365 down+remapped+peering, 2 stale+active+re=
covery_wait+degraded, 45 stale+remapped+peering, 108 stale+down+remappe=
d+peering, 5 active+recovering; 1175 GB data, 1794 GB used, 25969 GB / =
27764 GB avail; 121068/902868 degraded (13.409%); 4824/300956 unfound (=
1.603%)
>    mdsmap e1: 0/0/1 up
>
>
>
>  The cluster has been in this state since the last attempt to get it
> going. I added about 100GB of swap on each machine to avoid the OOM
> killer. Running like this resulted in the machines trashing wildly an=
d
> getting to ~2000 load avg, and after a while the osds started
> dying/commited suicide, but *not* from OOM. Some of the few that rema=
in
> have bloated to around 1.9GB of mem usage.
>
>  If you want, I can try to restart the whole thing tomorrow and colle=
ct
> fresh log output from the dying OSDs, or any other action or debug in=
fo
> that you might find useful.

Made any progress here? Given your RAM limitations I'd suggest doing
an incremental startup of the OSDs, maybe 4 per node, let me stabilize
as much as they can, then add another couple per node, let them
stabilize, etc.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
