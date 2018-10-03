From: Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mimic offline problem
Date: Wed, 3 Oct 2018 15:43:07 +0200
Message-ID: <F58B4646-D64C-469E-BA46-4ED6B5C96F8A@gmail.com>
References: <4C31C6EC-573D-42AD-BC6C-F7F103DBEC16@gmail.com>
 <CAE-AtHrjekCcLmO7MUB86XG7VH+bBt6yJH+ZRe7Wnh3tKB8JWw@mail.gmail.com>
 <CANrNMwUaER4e97schGN+KnB_6aNF6SYpPEFvLD=qcpp1eeWEJg@mail.gmail.com>
 <44698713-3F6C-451D-B67B-2053D1B30557@gmail.com>
 <CANrNMwW-RiVxtUnjTrZpiRXi6k06LxaeqRCqbXiuwwjTStWBhA@mail.gmail.com>
 <F96A1781-7767-40A4-B814-C59C0CDD5E68@gmail.com>
 <E516BA34-165C-4542-B53D-B022B913874A@gmail.com>
 <alpine.DEB.2.11.1810030311230.31802@piezo.novalocal>
 <683EC5EE-8112-4D9F-B4A8-DBCDE46A7AD8@gmail.com>
 <CANrNMwVcE=Zyp6YbAk-1MB0zYYUt9_tqZSxkTBF5QVShjGqPZg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Content-Type: multipart/mixed; boundary="===============3777573898495920805=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANrNMwVcE=Zyp6YbAk-1MB0zYYUt9_tqZSxkTBF5QVShjGqPZg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?utf-8?Q?Darius_Kasparavi=C4=8Dius?= <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============3777573898495920805==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_B4A2D909-429B-4B23-843B-323CB81644DA"


--Apple-Mail=_B4A2D909-429B-4B23-843B-323CB81644DA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,

It seems nothing has changed.

OSD config: https://paste.ubuntu.com/p/MtvTr5HYW4/ =
<https://paste.ubuntu.com/p/MtvTr5HYW4/>
OSD debug log: https://paste.ubuntu.com/p/7Sx64xGzkR/ =
<https://paste.ubuntu.com/p/7Sx64xGzkR/>


> On 3 Oct 2018, at 14:27, Darius Kasparavi=C4=8Dius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>=20
> Hello,
>=20
>=20
> You can also reduce the osd map updates by adding this to your ceph
> config file. "osd crush update on start =3D false". This should remove
> and update that is generated when osd starts.
>=20
> 2018-10-03 14:03:21.534 7fe15eddb700  0 mon.SRV-SBKUARK14@0(leader)
> e14 handle_command mon_command({"prefix": "osd crush
> set-device-class", "class": "hdd", "ids": ["47"]} v 0) v1
> 2018-10-03 14:03:21.534 7fe15eddb700  0 log_channel(audit) log [INF] :
> from=3D'osd.47 10.10.112.17:6803/64652' entity=3D'osd.47' =
cmd=3D[{"prefix":
> "osd crush set-device-class", "class": "hdd", "ids": ["47"]}]:
> dispatch
> 2018-10-03 14:03:21.538 7fe15eddb700  0 mon.SRV-SBKUARK14@0(leader)
> e14 handle_command mon_command({"prefix": "osd crush create-or-move",
> "id": 47, "weight":3.6396, "args": ["host=3DSRV-SEKUARK8",
> "root=3Ddefault"]} v 0) v1
> 2018-10-03 14:03:21.538 7fe15eddb700  0 log_channel(audit) log [INF] :
> from=3D'osd.47 10.10.112.17:6803/64652' entity=3D'osd.47' =
cmd=3D[{"prefix":
> "osd crush create-or-move", "id": 47, "weight":3.6396, "args":
> ["host=3DSRV-SEKUARK8", "root=3Ddefault"]}]: dispatch
> 2018-10-03 14:03:21.538 7fe15eddb700  0
> mon.SRV-SBKUARK14@0(leader).osd e72601 create-or-move crush item name
> 'osd.47' initial_weight 3.6396 at location
> {host=3DSRV-SEKUARK8,root=3Ddefault}
> 2018-10-03 14:03:22.250 7fe1615e0700  1
> mon.SRV-SBKUARK14@0(leader).osd e72601 do_prune osdmap full prune
> enabled
>=20
>=20
> On Wed, Oct 3, 2018 at 3:16 PM Goktug Yildirim
> <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>=20
>> Hi Sage,
>>=20
>> Thank you for your response. Now I am sure this incident is going to =
be resolved.
>>=20
>> The problem started when 7 server crashed same time and they came =
back after ~5 minutes.
>>=20
>> Two of our 3 mon services were restarted in this crash. Since mon =
services are enabled they should be started nearly at the same time. I =
dont know if this makes any difference but some of the guys on IRC told =
it is required that they start in order not at the same time. Otherwise =
it could break things badly.
>>=20
>> After 9 days we still see 3400-3500 active+clear PG. But in the end =
we have so many STUCK request and our cluster can not heal itself.
>>=20
>> When we set noup flag, OSDs can catch up epoch easily. But when we =
unset the flag we see so many STUCKS and SLOW OPS in 1 hour.
>> I/O load on all of my OSD disks are at around %95 utilization and =
never ends. CPU and RAM usage are OK.
>> OSDs get stuck that we even can't run =E2=80=9Cceph pg osd.0 =
query=E2=80=9D.
>>=20
>> Also we tried to change RBD pool replication size 2 to 1. Our goal =
was the eliminate older PG's and leaving cluster with good ones.
>> With replication size=3D1 we saw "%13 PGS not active=E2=80=9D. But it =
didn=E2=80=99t solve our problem.
>>=20
>> Of course we have to save %100 of data. But we feel like even saving =
%50 of our data will be make us very happy right now.
>>=20
>> This is what happens when the cluster starts. I believe it explains =
the whole story very nicely.
>> =
https://drive.google.com/file/d/1-HHuACyXkYt7e0soafQwAbWJP1qs8-u1/view?usp=
=3Dsharing
>>=20
>> This is our ceph.conf:
>> https://paste.ubuntu.com/p/8sQhfPDXnW/
>>=20
>> This is the output of "osd stat && osd epochs && ceph -s && ceph =
health=E2=80=9D:
>> https://paste.ubuntu.com/p/g5t8xnrjjZ/
>>=20
>> This is pg dump:
>> https://paste.ubuntu.com/p/zYqsN5T95h/
>>=20
>> This is iostat & perf top:
>> https://paste.ubuntu.com/p/Pgf3mcXXX8/
>>=20
>> This strace output of ceph-osd:
>> https://paste.ubuntu.com/p/YCdtfh5qX8/
>>=20
>> This is OSD log (default debug):
>> https://paste.ubuntu.com/p/Z2JrrBzzkM/
>>=20
>> This is leader MON log (default debug):
>> https://paste.ubuntu.com/p/RcGmsVKmzG/
>>=20
>> These are OSDs failed to start. Total number is 58.
>> https://paste.ubuntu.com/p/ZfRD5ZtvpS/
>> https://paste.ubuntu.com/p/pkRdVjCH4D/
>> https://paste.ubuntu.com/p/zJTf2fzSj9/
>> https://paste.ubuntu.com/p/xpJRK6YhRX/
>> https://paste.ubuntu.com/p/SY3576dNbJ/
>> https://paste.ubuntu.com/p/smyT6Y976b/
>>=20
>>=20
>> This is OSD video with debug osd =3D 20 and debug ms =3D 1 and =
debug_filestore =3D 20.
>> =
https://drive.google.com/file/d/1UHHocK3Wy8pVpgZ4jV8Rl1z7rqK3bcJi/view?usp=
=3Dsharing
>>=20
>> This is OSD logfile with debug osd =3D 20 and debug ms =3D 1 and =
debug_filestore =3D 20.
>> =
https://drive.google.com/file/d/1gH5Z0dUe36jM8FaulahEL36sxXrhORWI/view?usp=
=3Dsharing
>>=20
>> As far as I understand OSD catchs up with the mon epoch and exceeds =
mon epoch somehow??
>>=20
>> 2018-10-03 14:55:08.653 7f66c0bf9700 20 osd.150 72642 mkpg 66.f8 =
e60196@2018-09-28 23:57:08.251119
>> 2018-10-03 14:55:08.653 7f66c0bf9700 10 osd.150 72642 =
build_initial_pg_history 66.f8 created 60196
>> 2018-10-03 14:55:08.653 7f66c0bf9700 20 osd.150 72642 get_map 60196 - =
loading and decoding 0x19da8400
>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process =
66.d8 to_process <> waiting <> waiting_peering {}
>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process =
OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642 epoch_requested: =
72642 NullEvt +create_info) prio 255 cost 10 e72642) queued
>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process =
66.d8 to_process <OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642 =
epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642)> =
waiting <> waiting_peering {}
>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process =
OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642 epoch_requested: =
72642 NullEvt +create_info) prio 255 cost 10 e72642) pg 0xb579400
>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 osd.150 pg_epoch: 72642 =
pg[66.d8( v 39934'8971934 (38146'8968839,39934'8971934] =
local-lis/les=3D72206/72212 n=3D2206 ec=3D50786/50786 lis/c 72206/72206 =
les/c/f 72212/72212/0 72642/72642/72642) [150] r=3D0 lpr=3D72642 =
pi=3D[72206,72642)/1 crt=3D39934'8971934 lcod 0'0 mlcod 0'0 peering =
mbc=3D{} ps=3D[1~11]] do_peering_event: epoch_sent: 72642 =
epoch_requested: 72642 NullEvt +create_info
>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 log is not dirty
>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 osd.150 72642 =
queue_want_up_thru want 72642 <=3D queued 72642, currently 72206
>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process =
empty q, waiting
>> 2018-10-03 14:55:08.665 7f66c0bf9700 10 osd.150 72642 add_map_bl =
60196 50012 bytes
>> 2018-10-03 14:55:08.665 7f66c0bf9700 20 osd.150 72642 get_map 60197 - =
loading and decoding 0x19da8880
>> 2018-10-03 14:55:08.669 7f66c0bf9700 10 osd.150 72642 add_map_bl =
60197 50012 bytes
>> 2018-10-03 14:55:08.669 7f66c0bf9700 20 osd.150 72642 get_map 60198 - =
loading and decoding 0x19da9180
>>=20
>>=20
>> On 3 Oct 2018, at 05:14, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
>>=20
>> osd_find_best_info_ignore_history_les is a dangerous option and you =
should
>> only use it in very specific circumstances when directed by a =
developer.
>> In such cases it will allow a stuck PG to peer.  But you're not =
getting to
>> that point...you're seeing some sort of resource exhaustion.
>>=20
>> The noup trick works when OSDs are way behind on maps and all need to
>> catch up.  The way to tell if they are behind is by looking at the =
'ceph
>> daemon osd.NNN status' output and comparing to the latest OSDMap =
epoch tha
>> t the mons have.  Were they really caught up when you unset noup?
>>=20
>> I'm just catching up and haven't read the whole thread but I haven't =
seen
>> anything that explains why teh OSDs are dong lots of disk IO.  =
Catching up
>> on maps could explain it but not why they wouldn't peer once they =
were all
>> marked up...
>>=20
>> sage
>>=20
>>=20
>> On Tue, 2 Oct 2018, G=C3=B6ktu=C4=9F Y=C4=B1ld=C4=B1r=C4=B1m wrote:
>>=20
>> Anyone heart about osd_find_best_info_ignore_history_les =3D true ?
>> Is that be usefull here? There is such a less information about it.
>>=20
>> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =C5=9Funlar=C4=B1 yazd=C4=B1=
 (2 Eki 2018 22:11):
>>=20
>> Hi,
>>=20
>> Indeed I left ceph-disk to decide the wal and db partitions when I =
read somewhere that that will do the proper sizing.
>> For the blustore cache size I have plenty of RAM. I will increase 8GB =
for each and decide a more calculated number    after cluster settles.
>>=20
>> For the osd map loading I=E2=80=99ve also figured it out. And it is =
in loop. For that reason I started cluster with noup flag and waited =
OSDs to reach the uptodate epoch number. After that I unset noup. But I =
did not pay attention to manager logs. Let me check it, thank you!
>>=20
>> I am not forcing jmellac or anything else really. I have a very =
standard installation and no tweaks or tunings. All we ask for the =
stability versus speed from the begining. And here we are :/
>>=20
>> On 2 Oct 2018, at 21:53, Darius Kasparavi=C4=8Dius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>>=20
>> Hi,
>>=20
>>=20
>> I can see some issues from the osd log file. You have an extremely =
low
>> size db and wal partitions. Only 1GB for DB and 576MB for wal. I =
would
>> recommend cranking up rocksdb cache size as much as possible. If you
>> have RAM you can also increase bluestores cache size for hdd. Default
>> is 1GB be as liberal as you can without getting OOM kills. You also
>> have lots of osd map loading and decoding in the log. Are you sure =
all
>> monitors/managers/osds are up to date? Plus make sure you aren't
>> forcing jemalloc loading. I had a funny interaction after upgrading =
to
>> mimic.
>> On Tue, Oct 2, 2018 at 9:02 PM Goktug Yildirim
>> <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>=20
>>=20
>> Hello Darius,
>>=20
>> Thanks for reply!
>>=20
>> The main problem is we can not query PGs. =E2=80=9Cceph pg 67.54f =
query=E2=80=9D does stucks and wait forever since OSD is unresponsive.
>> We are certain that OSD gets unresponsive as soon as it UP. And we =
are certain that OSD responds again after its disk utilization stops.
>>=20
>> So we have a small test like that:
>> * Stop all OSDs (168 of them)
>> * Start OSD1. %95 osd disk utilization immediately starts. It takes 8 =
mins to finish. Only after that =E2=80=9Cceph pg 67.54f query=E2=80=9D =
works!
>> * While OSD1 is =E2=80=9Cup" start OSD2. As soon as OSD2 starts OSD1 =
& OSD2 starts %95 disk utilization. This takes 17 minutes to finish.
>> * Now start OSD3 and it is the same. All OSDs start high I/O and it =
takes 25 mins to settle.
>> * If you happen to start 5 of them at the same all of the OSDs start =
high I/O again. And it takes 1 hour to finish.
>>=20
>> So in the light of these findings we flagged noup, started all OSDs. =
At first there was no I/O. After 10 minutes we unset noup. All of 168 =
OSD started to make high I/O. And we thought that if we wait long enough =
it will finish & OSDs will be responsive again. After 24hours they did =
not because I/O did not finish or even slowed down.
>> One can think that is a lot of data there to scan. But it is just =
33TB.
>>=20
>> So at short we dont know which PG is stuck so we can remove it.
>>=20
>> However we met an weird thing half an hour ago. We exported the same =
PG from two different OSDs. One was 4.2GB and the other is 500KB! So we =
decided to export all OSDs for backup. Then we will delete strange sized =
ones and start the cluster all over. Maybe then we could solve the =
stucked or unfound PGs as you advise.
>>=20
>> Any thought would be greatly appreciated.
>>=20
>>=20
>> On 2 Oct 2018, at 18:16, Darius Kasparavi=C4=8Dius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>>=20
>> Hello,
>>=20
>> Currently you have 15 objects missing. I would recommend finding them
>> and making backups of them. Ditch all other osds that are failing to
>> start and concentrate on bringing online those that have missing
>> objects. Then slowly turn off nodown and noout on the cluster and see
>> if it stabilises. If it stabilises leave these setting if not turn
>> them back on.
>> Now get some of the pg's that are blocked and querry the pgs to check
>> why they are blocked. Try removing as much blocks as possible and =
then
>> remove the norebalance/norecovery flags and see if it starts to fix
>> itself. On Tue, Oct 2, 2018 at 5:14 PM by morphin
>> <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>=20
>>=20
>> One of ceph experts indicated that bluestore is somewhat preview tech
>> (as for Redhat).
>> So it could be best to checkout bluestore and rocksdb. There are some
>> tools to check health and also repair. But there are limited
>> documentation.
>> Anyone who has experince with it?
>> Anyone lead/help to a proper check would be great.
>> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 1 Eki 2018 Pzt, 22:55
>> tarihinde =C5=9Funu yazd=C4=B1:
>>=20
>>=20
>> Hi all,
>>=20
>> We have recently upgraded from luminous to mimic. It=E2=80=99s been 6 =
days since this cluster is offline. The long short story is here: =
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/030078.=
html
>>=20
>> I=E2=80=99ve also CC=E2=80=99ed developers since I believe this is a =
bug. If this is not to correct way I apology and please let me know.
>>=20
>> For the 6 days lots of thing happened and there were some outcomes =
about the problem. Some of them was misjudged and some of them are not =
looked deeper.
>> However the most certain diagnosis is this: each OSD causes very high =
disk I/O to its bluestore disk (WAL and DB are fine). After that OSDs =
become unresponsive or very very less responsive. For example "ceph tell =
osd.x version=E2=80=9D stucks like for ever.
>>=20
>> So due to unresponsive OSDs cluster does not settle. This is our =
problem!
>>=20
>> This is the one we are very sure of. But we are not sure of the =
reason.
>>=20
>> Here is the latest ceph status:
>> https://paste.ubuntu.com/p/2DyZ5YqPjh/.
>>=20
>> This is the status after we started all of the OSDs 24 hours ago.
>> Some of the OSDs are not started. However it didnt make any =
difference when all of them was online.
>>=20
>> Here is the debug=3D20 log of an OSD which is same for all others:
>> https://paste.ubuntu.com/p/8n2kTvwnG6/
>> As we figure out there is a loop pattern. I am sure it wont caught =
from eye.
>>=20
>> This the full log the same OSD.
>> https://www.dropbox.com/s/pwzqeajlsdwaoi1/ceph-osd.90.log?dl=3D0
>>=20
>> Here is the strace of the same OSD process:
>> https://paste.ubuntu.com/p/8n2kTvwnG6/
>>=20
>> Recently we hear more to uprade mimic. I hope none get hurts as we =
do. I am sure we have done lots of mistakes to let this happening. And =
this situation may be a example for other user and could be a potential =
bug for ceph developer.
>>=20
>> Any help to figure out what is going on would be great.
>>=20
>> Best Regards,
>> Goktug Yildirim
>>=20
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20
>>=20
>>=20
>>=20
>>=20


--Apple-Mail=_B4A2D909-429B-4B23-843B-323CB81644DA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D"">Hello,<div class=3D""><br class=3D""></div><div class=3D"">It =
seems nothing has changed.</div><div class=3D""><br class=3D""></div><div =
class=3D"">OSD config:&nbsp;<a =
href=3D"https://paste.ubuntu.com/p/MtvTr5HYW4/" =
class=3D"">https://paste.ubuntu.com/p/MtvTr5HYW4/</a></div><div =
class=3D"">OSD debug log:&nbsp;<a =
href=3D"https://paste.ubuntu.com/p/7Sx64xGzkR/" =
class=3D"">https://paste.ubuntu.com/p/7Sx64xGzkR/</a></div><div =
class=3D""><br class=3D""><div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D"">On 3 Oct 2018, at 14:27, Darius =
Kasparavi=C4=8Dius &lt;<a href=3D"mailto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
class=3D"">daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D"">Hello,<br class=3D""><br class=3D""><br class=3D"">You can =
also reduce the osd map updates by adding this to your ceph<br =
class=3D"">config file. "osd crush update on start =3D false". This =
should remove<br class=3D"">and update that is generated when osd =
starts.<br class=3D""><br class=3D"">2018-10-03 14:03:21.534 =
7fe15eddb700 &nbsp;0 mon.SRV-SBKUARK14@0(leader)<br class=3D"">e14 =
handle_command mon_command({"prefix": "osd crush<br =
class=3D"">set-device-class", "class": "hdd", "ids": ["47"]} v 0) v1<br =
class=3D"">2018-10-03 14:03:21.534 7fe15eddb700 &nbsp;0 =
log_channel(audit) log [INF] :<br class=3D"">from=3D'osd.47 =
10.10.112.17:6803/64652' entity=3D'osd.47' cmd=3D[{"prefix":<br =
class=3D"">"osd crush set-device-class", "class": "hdd", "ids": =
["47"]}]:<br class=3D"">dispatch<br class=3D"">2018-10-03 14:03:21.538 =
7fe15eddb700 &nbsp;0 mon.SRV-SBKUARK14@0(leader)<br class=3D"">e14 =
handle_command mon_command({"prefix": "osd crush create-or-move",<br =
class=3D"">"id": 47, "weight":3.6396, "args": ["host=3DSRV-SEKUARK8",<br =
class=3D"">"root=3Ddefault"]} v 0) v1<br class=3D"">2018-10-03 =
14:03:21.538 7fe15eddb700 &nbsp;0 log_channel(audit) log [INF] :<br =
class=3D"">from=3D'osd.47 10.10.112.17:6803/64652' entity=3D'osd.47' =
cmd=3D[{"prefix":<br class=3D"">"osd crush create-or-move", "id": 47, =
"weight":3.6396, "args":<br class=3D"">["host=3DSRV-SEKUARK8", =
"root=3Ddefault"]}]: dispatch<br class=3D"">2018-10-03 14:03:21.538 =
7fe15eddb700 &nbsp;0<br class=3D"">mon.SRV-SBKUARK14@0(leader).osd =
e72601 create-or-move crush item name<br class=3D"">'osd.47' =
initial_weight 3.6396 at location<br =
class=3D"">{host=3DSRV-SEKUARK8,root=3Ddefault}<br class=3D"">2018-10-03 =
14:03:22.250 7fe1615e0700 &nbsp;1<br =
class=3D"">mon.SRV-SBKUARK14@0(leader).osd e72601 do_prune osdmap full =
prune<br class=3D"">enabled<br class=3D""><br class=3D""><br class=3D"">On=
 Wed, Oct 3, 2018 at 3:16 PM Goktug Yildirim<br class=3D"">&lt;<a =
href=3D"mailto:goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
class=3D"">goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Hi =
Sage,<br class=3D""><br class=3D"">Thank you for your response. Now I am =
sure this incident is going to be resolved.<br class=3D""><br =
class=3D"">The problem started when 7 server crashed same time and they =
came back after ~5 minutes.<br class=3D""><br class=3D"">Two of our 3 =
mon services were restarted in this crash. Since mon services are =
enabled they should be started nearly at the same time. I dont know if =
this makes any difference but some of the guys on IRC told it is =
required that they start in order not at the same time. Otherwise it =
could break things badly.<br class=3D""><br class=3D"">After 9 days we =
still see 3400-3500 active+clear PG. But in the end we have so many =
STUCK request and our cluster can not heal itself.<br class=3D""><br =
class=3D"">When we set noup flag, OSDs can catch up epoch easily. But =
when we unset the flag we see so many STUCKS and SLOW OPS in 1 hour.<br =
class=3D"">I/O load on all of my OSD disks are at around %95 utilization =
and never ends. CPU and RAM usage are OK.<br class=3D"">OSDs get stuck =
that we even can't run =E2=80=9Cceph pg osd.0 query=E2=80=9D.<br =
class=3D""><br class=3D"">Also we tried to change RBD pool replication =
size 2 to 1. Our goal was the eliminate older PG's and leaving cluster =
with good ones.<br class=3D"">With replication size=3D1 we saw "%13 PGS =
not active=E2=80=9D. But it didn=E2=80=99t solve our problem.<br =
class=3D""><br class=3D"">Of course we have to save %100 of data. But we =
feel like even saving %50 of our data will be make us very happy right =
now.<br class=3D""><br class=3D"">This is what happens when the cluster =
starts. I believe it explains the whole story very nicely.<br =
class=3D""><a =
href=3D"https://drive.google.com/file/d/1-HHuACyXkYt7e0soafQwAbWJP1qs8-u1/=
view?usp=3Dsharing" =
class=3D"">https://drive.google.com/file/d/1-HHuACyXkYt7e0soafQwAbWJP1qs8-=
u1/view?usp=3Dsharing</a><br class=3D""><br class=3D"">This is our =
ceph.conf:<br class=3D"">https://paste.ubuntu.com/p/8sQhfPDXnW/<br =
class=3D""><br class=3D"">This is the output of "osd stat &amp;&amp; osd =
epochs &amp;&amp; ceph -s &amp;&amp; ceph health=E2=80=9D:<br =
class=3D"">https://paste.ubuntu.com/p/g5t8xnrjjZ/<br class=3D""><br =
class=3D"">This is pg dump:<br =
class=3D"">https://paste.ubuntu.com/p/zYqsN5T95h/<br class=3D""><br =
class=3D"">This is iostat &amp; perf top:<br =
class=3D"">https://paste.ubuntu.com/p/Pgf3mcXXX8/<br class=3D""><br =
class=3D"">This strace output of ceph-osd:<br =
class=3D"">https://paste.ubuntu.com/p/YCdtfh5qX8/<br class=3D""><br =
class=3D"">This is OSD log (default debug):<br =
class=3D"">https://paste.ubuntu.com/p/Z2JrrBzzkM/<br class=3D""><br =
class=3D"">This is leader MON log (default debug):<br =
class=3D"">https://paste.ubuntu.com/p/RcGmsVKmzG/<br class=3D""><br =
class=3D"">These are OSDs failed to start. Total number is 58.<br =
class=3D"">https://paste.ubuntu.com/p/ZfRD5ZtvpS/<br =
class=3D"">https://paste.ubuntu.com/p/pkRdVjCH4D/<br =
class=3D"">https://paste.ubuntu.com/p/zJTf2fzSj9/<br =
class=3D"">https://paste.ubuntu.com/p/xpJRK6YhRX/<br =
class=3D"">https://paste.ubuntu.com/p/SY3576dNbJ/<br =
class=3D"">https://paste.ubuntu.com/p/smyT6Y976b/<br class=3D""><br =
class=3D""><br class=3D"">This is OSD video with debug osd =3D 20 and =
debug ms =3D 1 and debug_filestore =3D 20.<br =
class=3D"">https://drive.google.com/file/d/1UHHocK3Wy8pVpgZ4jV8Rl1z7rqK3bc=
Ji/view?usp=3Dsharing<br class=3D""><br class=3D"">This is OSD logfile =
with debug osd =3D 20 and debug ms =3D 1 and debug_filestore =3D 20.<br =
class=3D"">https://drive.google.com/file/d/1gH5Z0dUe36jM8FaulahEL36sxXrhOR=
WI/view?usp=3Dsharing<br class=3D""><br class=3D"">As far as I =
understand OSD catchs up with the mon epoch and exceeds mon epoch =
somehow??<br class=3D""><br class=3D"">2018-10-03 14:55:08.653 =
7f66c0bf9700 20 osd.150 72642 mkpg 66.f8 e60196@2018-09-28 =
23:57:08.251119<br class=3D"">2018-10-03 14:55:08.653 7f66c0bf9700 10 =
osd.150 72642 build_initial_pg_history 66.f8 created 60196<br =
class=3D"">2018-10-03 14:55:08.653 7f66c0bf9700 20 osd.150 72642 get_map =
60196 - loading and decoding 0x19da8400<br class=3D"">2018-10-03 =
14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process 66.d8 to_process =
&lt;&gt; waiting &lt;&gt; waiting_peering {}<br class=3D"">2018-10-03 =
14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process OpQueueItem(66.d8 =
PGPeeringEvent(epoch_sent: 72642 epoch_requested: 72642 NullEvt =
+create_info) prio 255 cost 10 e72642) queued<br class=3D"">2018-10-03 =
14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process 66.d8 to_process =
&lt;OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642 epoch_requested: =
72642 NullEvt +create_info) prio 255 cost 10 e72642)&gt; waiting =
&lt;&gt; waiting_peering {}<br class=3D"">2018-10-03 14:55:08.653 =
7f66a6bc5700 20 osd.150 op_wq(1) _process OpQueueItem(66.d8 =
PGPeeringEvent(epoch_sent: 72642 epoch_requested: 72642 NullEvt =
+create_info) prio 255 cost 10 e72642) pg 0xb579400<br =
class=3D"">2018-10-03 14:55:08.653 7f66a6bc5700 10 osd.150 pg_epoch: =
72642 pg[66.d8( v 39934'8971934 (38146'8968839,39934'8971934] =
local-lis/les=3D72206/72212 n=3D2206 ec=3D50786/50786 lis/c 72206/72206 =
les/c/f 72212/72212/0 72642/72642/72642) [150] r=3D0 lpr=3D72642 =
pi=3D[72206,72642)/1 crt=3D39934'8971934 lcod 0'0 mlcod 0'0 peering =
mbc=3D{} ps=3D[1~11]] do_peering_event: epoch_sent: 72642 =
epoch_requested: 72642 NullEvt +create_info<br class=3D"">2018-10-03 =
14:55:08.653 7f66a6bc5700 10 log is not dirty<br class=3D"">2018-10-03 =
14:55:08.653 7f66a6bc5700 10 osd.150 72642 queue_want_up_thru want 72642 =
&lt;=3D queued 72642, currently 72206<br class=3D"">2018-10-03 =
14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process empty q, =
waiting<br class=3D"">2018-10-03 14:55:08.665 7f66c0bf9700 10 osd.150 =
72642 add_map_bl 60196 50012 bytes<br class=3D"">2018-10-03 14:55:08.665 =
7f66c0bf9700 20 osd.150 72642 get_map 60197 - loading and decoding =
0x19da8880<br class=3D"">2018-10-03 14:55:08.669 7f66c0bf9700 10 osd.150 =
72642 add_map_bl 60197 50012 bytes<br class=3D"">2018-10-03 14:55:08.669 =
7f66c0bf9700 20 osd.150 72642 get_map 60198 - loading and decoding =
0x19da9180<br class=3D""><br class=3D""><br class=3D"">On 3 Oct 2018, at =
05:14, Sage Weil &lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt; wrote:<br class=3D""><br =
class=3D"">osd_find_best_info_ignore_history_les is a dangerous option =
and you should<br class=3D"">only use it in very specific circumstances =
when directed by a developer.<br class=3D"">In such cases it will allow =
a stuck PG to peer. &nbsp;But you're not getting to<br class=3D"">that =
point...you're seeing some sort of resource exhaustion.<br class=3D""><br =
class=3D"">The noup trick works when OSDs are way behind on maps and all =
need to<br class=3D"">catch up. &nbsp;The way to tell if they are behind =
is by looking at the 'ceph<br class=3D"">daemon osd.NNN status' output =
and comparing to the latest OSDMap epoch tha<br class=3D"">t the mons =
have. &nbsp;Were they really caught up when you unset noup?<br =
class=3D""><br class=3D"">I'm just catching up and haven't read the =
whole thread but I haven't seen<br class=3D"">anything that explains why =
teh OSDs are dong lots of disk IO. &nbsp;Catching up<br class=3D"">on =
maps could explain it but not why they wouldn't peer once they were =
all<br class=3D"">marked up...<br class=3D""><br class=3D"">sage<br =
class=3D""><br class=3D""><br class=3D"">On Tue, 2 Oct 2018, G=C3=B6ktu=C4=
=9F Y=C4=B1ld=C4=B1r=C4=B1m wrote:<br class=3D""><br class=3D"">Anyone =
heart about osd_find_best_info_ignore_history_les =3D true ?<br =
class=3D"">Is that be usefull here? There is such a less information =
about it.<br class=3D""><br class=3D"">Goktug Yildirim =
&lt;goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; =C5=9Funlar=C4=B1 yazd=C4=B1 (2 Eki =
2018 22:11):<br class=3D""><br class=3D"">Hi,<br class=3D""><br =
class=3D"">Indeed I left ceph-disk to decide the wal and db partitions =
when I read somewhere that that will do the proper sizing.<br =
class=3D"">For the blustore cache size I have plenty of RAM. I will =
increase 8GB for each and decide a more calculated number =
&nbsp;&nbsp;&nbsp;after cluster settles.<br class=3D""><br class=3D"">For =
the osd map loading I=E2=80=99ve also figured it out. And it is in loop. =
For that reason I started cluster with noup flag and waited OSDs to =
reach the uptodate epoch number. After that I unset noup. But I did not =
pay attention to manager logs. Let me check it, thank you!<br =
class=3D""><br class=3D"">I am not forcing jmellac or anything else =
really. I have a very standard installation and no tweaks or tunings. =
All we ask for the stability versus speed from the begining. And here we =
are :/<br class=3D""><br class=3D"">On 2 Oct 2018, at 21:53, Darius =
Kasparavi=C4=8Dius &lt;daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br class=3D""><br =
class=3D"">Hi,<br class=3D""><br class=3D""><br class=3D"">I can see =
some issues from the osd log file. You have an extremely low<br =
class=3D"">size db and wal partitions. Only 1GB for DB and 576MB for =
wal. I would<br class=3D"">recommend cranking up rocksdb cache size as =
much as possible. If you<br class=3D"">have RAM you can also increase =
bluestores cache size for hdd. Default<br class=3D"">is 1GB be as =
liberal as you can without getting OOM kills. You also<br class=3D"">have =
lots of osd map loading and decoding in the log. Are you sure all<br =
class=3D"">monitors/managers/osds are up to date? Plus make sure you =
aren't<br class=3D"">forcing jemalloc loading. I had a funny interaction =
after upgrading to<br class=3D"">mimic.<br class=3D"">On Tue, Oct 2, =
2018 at 9:02 PM Goktug Yildirim<br =
class=3D"">&lt;goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br class=3D""><br =
class=3D""><br class=3D"">Hello Darius,<br class=3D""><br =
class=3D"">Thanks for reply!<br class=3D""><br class=3D"">The main =
problem is we can not query PGs. =E2=80=9Cceph pg 67.54f query=E2=80=9D =
does stucks and wait forever since OSD is unresponsive.<br class=3D"">We =
are certain that OSD gets unresponsive as soon as it UP. And we are =
certain that OSD responds again after its disk utilization stops.<br =
class=3D""><br class=3D"">So we have a small test like that:<br =
class=3D"">* Stop all OSDs (168 of them)<br class=3D"">* Start OSD1. %95 =
osd disk utilization immediately starts. It takes 8 mins to finish. Only =
after that =E2=80=9Cceph pg 67.54f query=E2=80=9D works!<br class=3D"">* =
While OSD1 is =E2=80=9Cup" start OSD2. As soon as OSD2 starts OSD1 &amp; =
OSD2 starts %95 disk utilization. This takes 17 minutes to finish.<br =
class=3D"">* Now start OSD3 and it is the same. All OSDs start high I/O =
and it takes 25 mins to settle.<br class=3D"">* If you happen to start 5 =
of them at the same all of the OSDs start high I/O again. And it takes 1 =
hour to finish.<br class=3D""><br class=3D"">So in the light of these =
findings we flagged noup, started all OSDs. At first there was no I/O. =
After 10 minutes we unset noup. All of 168 OSD started to make high I/O. =
And we thought that if we wait long enough it will finish &amp; OSDs =
will be responsive again. After 24hours they did not because I/O did not =
finish or even slowed down.<br class=3D"">One can think that is a lot of =
data there to scan. But it is just 33TB.<br class=3D""><br class=3D"">So =
at short we dont know which PG is stuck so we can remove it.<br =
class=3D""><br class=3D"">However we met an weird thing half an hour =
ago. We exported the same PG from two different OSDs. One was 4.2GB and =
the other is 500KB! So we decided to export all OSDs for backup. Then we =
will delete strange sized ones and start the cluster all over. Maybe =
then we could solve the stucked or unfound PGs as you advise.<br =
class=3D""><br class=3D"">Any thought would be greatly appreciated.<br =
class=3D""><br class=3D""><br class=3D"">On 2 Oct 2018, at 18:16, Darius =
Kasparavi=C4=8Dius &lt;daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br class=3D""><br =
class=3D"">Hello,<br class=3D""><br class=3D"">Currently you have 15 =
objects missing. I would recommend finding them<br class=3D"">and making =
backups of them. Ditch all other osds that are failing to<br =
class=3D"">start and concentrate on bringing online those that have =
missing<br class=3D"">objects. Then slowly turn off nodown and noout on =
the cluster and see<br class=3D"">if it stabilises. If it stabilises =
leave these setting if not turn<br class=3D"">them back on.<br =
class=3D"">Now get some of the pg's that are blocked and querry the pgs =
to check<br class=3D"">why they are blocked. Try removing as much blocks =
as possible and then<br class=3D"">remove the norebalance/norecovery =
flags and see if it starts to fix<br class=3D"">itself. On Tue, Oct 2, =
2018 at 5:14 PM by morphin<br class=3D"">&lt;morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; =
wrote:<br class=3D""><br class=3D""><br class=3D"">One of ceph experts =
indicated that bluestore is somewhat preview tech<br class=3D"">(as for =
Redhat).<br class=3D"">So it could be best to checkout bluestore and =
rocksdb. There are some<br class=3D"">tools to check health and also =
repair. But there are limited<br class=3D"">documentation.<br =
class=3D"">Anyone who has experince with it?<br class=3D"">Anyone =
lead/help to a proper check would be great.<br class=3D"">Goktug =
Yildirim &lt;goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;, 1 Eki 2018 Pzt, 22:55<br =
class=3D"">tarihinde =C5=9Funu yazd=C4=B1:<br class=3D""><br =
class=3D""><br class=3D"">Hi all,<br class=3D""><br class=3D"">We have =
recently upgraded from luminous to mimic. It=E2=80=99s been 6 days since =
this cluster is offline. The long short story is here: =
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/030078.=
html<br class=3D""><br class=3D"">I=E2=80=99ve also CC=E2=80=99ed =
developers since I believe this is a bug. If this is not to correct way =
I apology and please let me know.<br class=3D""><br class=3D"">For the 6 =
days lots of thing happened and there were some outcomes about the =
problem. Some of them was misjudged and some of them are not looked =
deeper.<br class=3D"">However the most certain diagnosis is this: each =
OSD causes very high disk I/O to its bluestore disk (WAL and DB are =
fine). After that OSDs become unresponsive or very very less responsive. =
For example "ceph tell osd.x version=E2=80=9D stucks like for ever.<br =
class=3D""><br class=3D"">So due to unresponsive OSDs cluster does not =
settle. This is our problem!<br class=3D""><br class=3D"">This is the =
one we are very sure of. But we are not sure of the reason.<br =
class=3D""><br class=3D"">Here is the latest ceph status:<br =
class=3D"">https://paste.ubuntu.com/p/2DyZ5YqPjh/.<br class=3D""><br =
class=3D"">This is the status after we started all of the OSDs 24 hours =
ago.<br class=3D"">Some of the OSDs are not started. However it didnt =
make any difference when all of them was online.<br class=3D""><br =
class=3D"">Here is the debug=3D20 log of an OSD which is same for all =
others:<br class=3D"">https://paste.ubuntu.com/p/8n2kTvwnG6/<br =
class=3D"">As we figure out there is a loop pattern. I am sure it wont =
caught from eye.<br class=3D""><br class=3D"">This the full log the same =
OSD.<br =
class=3D"">https://www.dropbox.com/s/pwzqeajlsdwaoi1/ceph-osd.90.log?dl=3D=
0<br class=3D""><br class=3D"">Here is the strace of the same OSD =
process:<br class=3D"">https://paste.ubuntu.com/p/8n2kTvwnG6/<br =
class=3D""><br class=3D"">Recently we hear more to uprade mimic. I hope =
none get hurts as we do. I am sure we have done lots of mistakes to let =
this happening. And this situation may be a example for other user and =
could be a potential bug for ceph developer.<br class=3D""><br =
class=3D"">Any help to figure out what is going on would be great.<br =
class=3D""><br class=3D"">Best Regards,<br class=3D"">Goktug Yildirim<br =
class=3D""><br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""><br class=3D""><br class=3D""><br class=3D""><br class=3D""><br=
 class=3D""></blockquote></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_B4A2D909-429B-4B23-843B-323CB81644DA--

--===============3777573898495920805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3777573898495920805==--
