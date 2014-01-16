From: Guang <yguang11@outlook.com>
Subject: Re: Ceph cluster is unreachable because of authentication failure
Date: Thu, 16 Jan 2014 16:26:38 +0800
Message-ID: <BLU0-SMTP14487458FBE42B33537BD4EDFB90@phx.gbl>
References: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0@phx.gbl> <alpine.DEB.2.00.1401140654500.10628@cobra.newdream.net> <016D7F31-523E-4EC1-8222-7D4084BA400F@outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu0-omc4-s18.blu0.hotmail.com ([65.55.111.157]:27519 "EHLO
	blu0-omc4-s18.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836AbaAPI0r convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jan 2014 03:26:47 -0500
In-Reply-To: <016D7F31-523E-4EC1-8222-7D4084BA400F@outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

I still have bad the luck to figure out what is the problem making auth=
entication failure, so in order to get the cluster back, I tried:
  1. stop all daemons (mon & osd)
  2. change the configuration to disable cephx
  3. start mon daemons (3 in total)
  4. start osd daemon one by one

After finishing step 3, the cluster can be reachable ('ceph -s' give re=
sults):
-bash-4.1$ sudo ceph -s
  cluster b9cb3ea9-e1de-48b4-9e86-6921e2c537d2
   health HEALTH_WARN 2797 pgs degraded; 107 pgs down; 7503 pgs peering=
; 917 pgs recovering; 6079 pgs recovery_wait; 2957 pgs stale; 7771 pgs =
stuck inactive; 2957 pgs stuck stale; 16567 pgs stuck unclean; recovery=
 54346804/779462977 degraded (6.972%); 9/259724199 unfound (0.000%); 2 =
near full osd(s); 57/751 in osds are down; noout,nobackfill,norecover,n=
oscrub,nodeep-scrub flag(s) set
   monmap e1: 3 mons at {osd151=3D10.194.0.68:6789/0,osd152=3D10.193.20=
7.130:6789/0,osd153=3D10.193.207.131:6789/0}, election epoch 106022, qu=
orum 0,1,2 osd151,osd152,osd153
   osdmap e134893: 781 osds: 694 up, 751 in
    pgmap v2388518: 22203 pgs: 26 inactive, 14 active, 79 stale+active+=
recovering, 5020 active+clean, 242 stale, 4352 active+recovery_wait, 61=
6 stale+active+clean, 177 active+recovering+degraded, 6714 peering, 925=
 stale+active+recovery_wait, 86 down+peering, 1547 active+degraded, 32 =
stale+active+recovering+degraded, 648 stale+peering, 21 stale+down+peer=
ing, 239 stale+active+degraded, 651 active+recovery_wait+degraded, 30 r=
emapped+peering, 151 stale+active+recovery_wait+degraded, 4 stale+remap=
ped+peering, 629 active+recovering; 79656 GB data, 363 TB used, 697 TB =
/ 1061 TB avail; 54346804/779462977 degraded (6.972%); 9/259724199 unfo=
und (0.000%)
   mdsmap e1: 0/0/1 up
(at this point, all OSDs should be down).

When I tried to start OSD daemon, the starting script got hang, and the=
 process hang is:
root      80497  80496  0 08:18 pts/0    00:00:00 python /usr/bin/ceph =
--name=3Dosd.22 --keyring=3D/var/lib/ceph/osd/ceph-22/keyring osd crush=
 create-or-move -- 22 0.40 root=3Ddefault host=3Dosd173

When I strace the starting script, I got the following traces (process =
75873 is the above process), it failed with futex and then do a infinit=
e loop:
   select(0, NULL, NULL, NULL, {0, 16000}) =3D 0 (Timeout)
Any idea what might trigger this?

=3D=3D=3D=3D=3D=3D=3D STRACE (PARTIAL) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
[pid 75873] futex(0xf707a0, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...=
>
[pid 75878] mmap(NULL, 134217728, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|=
MAP_NORESERVE, -1, 0) =3D 0x7f5da6529000
[pid 75878] munmap(0x7f5da6529000, 28143616) =3D 0
[pid 75878] munmap(0x7f5dac000000, 38965248) =3D 0
[pid 75878] mprotect(0x7f5da8000000, 135168, PROT_READ|PROT_WRITE) =3D =
0
[pid 75878] futex(0xf707a0, FUTEX_WAKE_PRIVATE, 1) =3D 1
[pid 75873] <... futex resumed> )       =3D 0
[pid 75873] futex(0xdd3cb0, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...=
>
[pid 75878] futex(0xdd3cb0, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
[pid 75873] <... futex resumed> )       =3D -1 EAGAIN (Resource tempora=
rily unavailable)
[pid 75878] <... futex resumed> )       =3D 0
[pid 75873] select(0, NULL, NULL, NULL, {0, 1000} <unfinished ...>
[pid 75878] rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) =3D 0
[pid 75878] mmap(NULL, 10489856, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_=
ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7f5dadb28000
[pid 75878] mprotect(0x7f5dadb28000, 4096, PROT_NONE) =3D 0
[ omit some entries=85]
[pid 75873] select(0, NULL, NULL, NULL, {0, 16000}) =3D 0 (Timeout)
[pid 75873] select(0, NULL, NULL, NULL, {0, 32000}) =3D 0 (Timeout)
[pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 (Timeout)
[pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 (Timeout)
[pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 (Timeout)
[pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 (Timeout)
[pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 (Timeout)


Thanks,
Guang

On Jan 15, 2014, at 5:54 AM, Guang <yguang11@outlook.com> wrote:

> Thanks Sage.
>=20
> -bash-4.1$ sudo ceph --admin-daemon /var/run/ceph/ceph-mon.osd151.aso=
k mon_status
> { "name": "osd151",
>  "rank": 2,
>  "state": "electing",
>  "election_epoch": 85469,
>  "quorum": [],
>  "outside_quorum": [],
>  "extra_probe_peers": [],
>  "sync_provider": [],
>  "monmap": { "epoch": 1,
>      "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
>      "modified": "0.000000",
>      "created": "0.000000",
>      "mons": [
>            { "rank": 0,
>              "name": "osd152",
>              "addr": "10.193.207.130:6789\/0"},
>            { "rank": 1,
>              "name": "osd153",
>              "addr": "10.193.207.131:6789\/0"},
>            { "rank": 2,
>              "name": "osd151",
>              "addr": "10.194.0.68:6789\/0"}]}}
>=20
> And:
>=20
> -bash-4.1$ sudo ceph --admin-daemon /var/run/ceph/ceph-mon.osd151.aso=
k quorum_status
> { "election_epoch": 85480,
>  "quorum": [
>        0,
>        1,
>        2],
>  "quorum_names": [
>        "osd151",
>        "osd152",
>        "osd153"],
>  "quorum_leader_name": "osd152",
>  "monmap": { "epoch": 1,
>      "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
>      "modified": "0.000000",
>      "created": "0.000000",
>      "mons": [
>            { "rank": 0,
>              "name": "osd152",
>              "addr": "10.193.207.130:6789\/0"},
>            { "rank": 1,
>              "name": "osd153",
>              "addr": "10.193.207.131:6789\/0"},
>            { "rank": 2,
>              "name": "osd151",
>              "addr": "10.194.0.68:6789\/0"}]}}
>=20
>=20
> The election has been finished with leader selected from the above st=
atus.
>=20
> Thanks,
> Guang
>=20
> On Jan 14, 2014, at 10:55 PM, Sage Weil <sage@inktank.com> wrote:
>=20
>> On Tue, 14 Jan 2014, GuangYang wrote:
>>> Hi ceph-users and ceph-devel,
>>> I came across an issue after restarting monitors of the cluster, th=
at authentication fails which prevents running any ceph command.
>>>=20
>>> After we did some maintenance work, I restart OSD, however, I found=
 that the OSD would not join the cluster automatically after being rest=
arted, though TCP dump showed it had already sent messenger to monitor =
telling add me into the cluster.
>>>=20
>>> So that I suspected there might be some issues of monitor and I res=
tarted monitor one by one (3 in total), however, after restarting monit=
ors, all ceph command would fail saying authentication timeout?
>>>=20
>>> 2014-01-14 12:00:30.499397 7fc7f195e700  0 monclient(hunting): auth=
enticate timed out after 300
>>> 2014-01-14 12:00:30.499440 7fc7f195e700  0 librados: client.admin a=
uthentication error (110) Connection timed out
>>> Error connecting to cluster: Error
>>>=20
>>> Any idea why such error happened (restarting OSD would result in th=
e same error)?
>>>=20
>>> I am thinking the authentication information is persisted in mon lo=
cal disk and is there a chance those data got corrupted?
>>=20
>> That sounds unlikely, but you're right that the core problem is with=
 the=20
>> mons.  What does=20
>>=20
>> ceph daemon mon.`hostname` mon_status
>>=20
>> say?  Perhaps they are not forming a quorum and that is what is prev=
enting=20
>> authentication.
>>=20
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
