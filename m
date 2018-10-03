From: Goktug YILDIRIM <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mimic offline problem
Date: Wed, 3 Oct 2018 21:01:41 +0200
Message-ID: <CACz15iKdK47N0mBJrRyDeEx7BH-uRKmvZ+OJ6Cc6u6-qxTeA6w@mail.gmail.com>
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
 <F58B4646-D64C-469E-BA46-4ED6B5C96F8A@gmail.com>
 <alpine.DEB.2.11.1810031443440.31802@piezo.novalocal>
 <8C3EC489-68A9-4622-A283-CCAB9AE68D93@gmail.com>
 <alpine.DEB.2.11.1810031543160.31802@piezo.novalocal>
 <C10AD823-76D4-4E2B-BE2E-BF434373C81B@gmail.com>
 <alpine.DEB.2.11.1810031641390.31802@piezo.novalocal>
 <7C03273B-DC38-40CC-99F4-AFECE672D80A@usishi.com>
 <alpine.DEB.2.11.1810031826290.31802@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4060417470885039349=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1810031826290.31802-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, by morphin <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?R8O2a3R1xJ8gWcSxbGTEsXLEsW0=?= <goktug.yildirim-DtrUWsE0is3QT0dZR+AlfA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4060417470885039349==
Content-Type: multipart/alternative; boundary="000000000000dc5d28057757abef"

--000000000000dc5d28057757abef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I changed the file name to make it clear.
When I use your command with "+decode"  I'm getting an error like this:

ceph-dencoder type creating_pgs_t import DUMPFILE decode dump_json
error: buffer::malformed_input: void
creating_pgs_t::decode(ceph::buffer::list::iterator&) no longer understand
old encoding version 2 < 111

My ceph version: 13.2.2

3 Eki 2018 =C3=87ar, saat 20:46 tarihinde Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> =C5=
=9Funu
yazd=C4=B1:

> On Wed, 3 Oct 2018, G=C3=B6ktu=C4=9F Y=C4=B1ld=C4=B1r=C4=B1m wrote:
> > If I didn't do it wrong, I got the output as below.
> >
> > ceph-kvstore-tool rocksdb /var/lib/ceph/mon/ceph-SRV-SBKUARK14/store.db=
/
> get osd_pg_creating creating > dump
> > 2018-10-03 20:08:52.070 7f07f5659b80  1 rocksdb: do_open column
> families: [default]
> >
> > ceph-dencoder type creating_pgs_t import dump dump_json
>
> Sorry, should be
>
> ceph-dencoder type creating_pgs_t import dump decode dump_json
>
> s
>
> > {
> >     "last_scan_epoch": 0,
> >     "creating_pgs": [],
> >     "queue": [],
> >     "created_pools": []
> > }
> >
> > You can find the "dump" link below.
> >
> > dump:
> https://drive.google.com/file/d/1ZLUiQyotQ4-778wM9UNWK_TLDAROg0yN/view?us=
p=3Dsharing
> >
> >
> > Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> =C5=9Funlar=C4=B1 yazd=C4=B1 (3 Eki 2018 =
18:45):
> >
> > >> On Wed, 3 Oct 2018, Goktug Yildirim wrote:
> > >> We are starting to work on it. First step is getting the structure
> out and dumping the current value as you say.
> > >>
> > >> And you were correct we did not run force_create_pg.
> > >
> > > Great.
> > >
> > > So, eager to see what the current structure is... please attach once
> you
> > > have it.
> > >
> > > The new replacement one should look like this (when hexdump -C'd):
> > >
> > > 00000000  02 01 18 00 00 00 10 00  00 00 00 00 00 00 01 00
> |................|
> > > 00000010  00 00 42 00 00 00 00 00  00 00 00 00 00 00
> |..B...........|
> > > 0000001e
> > >
> > > ...except that from byte 6 you want to put in a recent OSDMap epoch,
> in
> > > hex, little endian (least significant byte first), in place of the
> 0x10
> > > that is there now.  It should dump like this:
> > >
> > > $ ceph-dencoder type creating_pgs_t import myfile decode dump_json
> > > {
> > >    "last_scan_epoch": 16,   <--- but with a recent epoch here
> > >    "creating_pgs": [],
> > >    "queue": [],
> > >    "created_pools": [
> > >        66
> > >    ]
> > > }
> > >
> > > sage
> > >
> > >
> > >>
> > >>> On 3 Oct 2018, at 17:52, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > >>>
> > >>> On Wed, 3 Oct 2018, Goktug Yildirim wrote:
> > >>>> Sage,
> > >>>>
> > >>>> Pool 66 is the only pool it shows right now. This a pool created
> months ago.
> > >>>> ceph osd lspools
> > >>>> 66 mypool
> > >>>>
> > >>>> As we recreated mon db from OSDs, the pools for MDS was unusable.
> So we deleted them.
> > >>>> After we create another cephfs fs and pools we started MDS and it
> stucked on creation. So we stopped MDS and removed fs and fs pools. Right
> now we do not have MDS running nor we have cephfs related things.
> > >>>>
> > >>>> ceph fs dump
> > >>>> dumped fsmap epoch 1 e1
> > >>>> enable_multiple, ever_enabled_multiple: 0,0
> > >>>> compat: compat=3D{},rocompat=3D{},incompat=3D{1=3Dbase v0.20,2=3Dc=
lient
> writeable ranges,3=3Ddefault file layouts on dirs,4=3Ddir inode in separa=
te
> object,5=3Dmds uses versioned encoding,6=3Ddirfrag is stored in omap,8=3D=
no
> anchor table,9=3Dfile layout v2,10=3Dsnaprealm v2}
> > >>>> legacy client fscid: -1
> > >>>>
> > >>>> No filesystems configured
> > >>>>
> > >>>> ceph fs ls
> > >>>> No filesystems enabled
> > >>>>
> > >>>> Now pool 66 seems to only pool we have and it has been created
> months ago. Then I guess there is something hidden out there.
> > >>>>
> > >>>> Is there any way to find and delete it?
> > >>>
> > >>> Ok, I'm concerned that the creating pg is in there if this is an ol=
d
> > >>> pool... did you perhaps run force_create_pg at some point?  Assumin=
g
> you
> > >>> didn't, I think this is a bug in the process for rebuilding the mon
> > >>> store.. one that doesn't normally come up because the impact is thi=
s
> > >>> osdmap scan that is cheap in our test scenarios but clearly not
> cheap for
> > >>> your aged cluster.
> > >>>
> > >>> In any case, there is a way to clear those out of the mon, but it's
> a bit
> > >>> dicey.
> > >>>
> > >>> 1. stop all mons
> > >>> 2. make a backup of all mons
> > >>> 3. use ceph-kvstore-tool to extract the prefix=3Dosd_pg_creating
> > >>> key=3Dcreating key on one of the mons
> > >>> 4. dump the object with ceph-dencoder type creating_pgs_t import
> FILE dump_json
> > >>> 5. hex edit the structure to remove all of the creating pgs, and
> adds pool
> > >>> 66 to the created_pgs member.
> > >>> 6. verify with ceph-dencoder dump that the edit was correct...
> > >>> 7. inject the updated structure into all of the mons
> > >>> 8. start all mons
> > >>>
> > >>> 4-6 will probably be an iterative process... let's start by getting
> the
> > >>> structure out and dumping the current value?
> > >>>
> > >>> The code to refer to to understand the structure is
> src/mon/CreatingPGs.h
> > >>> encode/decode methods.
> > >>>
> > >>> sage
> > >>>
> > >>>
> > >>>>
> > >>>>
> > >>>>> On 3 Oct 2018, at 16:46, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > >>>>>
> > >>>>> Oh... I think this is the problem:
> > >>>>>
> > >>>>> 2018-10-03 16:37:04.284 7efef2ae0700 20 slow op
> osd_pg_create(e72883
> > >>>>> 66.af:60196 66.ba:60196 66.be:60196 66.d8:60196 66.f8:60196
> 66.124:60196
> > >>>>> 66.14c:60196 66.1ac:60196 66.223:60196 66.248:60196 66.271:60196
> > >>>>> 66.2d1:60196 66.47a:68641) initiated 2018-10-03 16:20:01.915916
> > >>>>>
> > >>>>> You are in the midst of creating new pgs, and unfortunately pg
> create is
> > >>>>> one of the last remaining places where the OSDs need to look at a
> full
> > >>>>> history of map changes between then and the current map epoch.  I=
n
> this
> > >>>>> case, the pool was created in 60196 and it is now 72883, ~12k
> epochs
> > >>>>> later.
> > >>>>>
> > >>>>> What is this new pool for?  Is it still empty, and if so, can we
> delete
> > >>>>> it? If yes, I'm ~70% sure that will then get cleaned out at the
> mon end
> > >>>>> and restarting the OSDs will make these pg_creates go away.
> > >>>>>
> > >>>>> s
> > >>>>>
> > >>>>>> On Wed, 3 Oct 2018, Goktug Yildirim wrote:
> > >>>>>>
> > >>>>>> Hello,
> > >>>>>>
> > >>>>>> It seems nothing has changed.
> > >>>>>>
> > >>>>>> OSD config: https://paste.ubuntu.com/p/MtvTr5HYW4/ <
> https://paste.ubuntu.com/p/MtvTr5HYW4/>
> > >>>>>> OSD debug log: https://paste.ubuntu.com/p/7Sx64xGzkR/ <
> https://paste.ubuntu.com/p/7Sx64xGzkR/>
> > >>>>>>
> > >>>>>>
> > >>>>>>> On 3 Oct 2018, at 14:27, Darius Kasparavi=C4=8Dius <daznis@gmai=
l.com>
> wrote:
> > >>>>>>>
> > >>>>>>> Hello,
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> You can also reduce the osd map updates by adding this to your
> ceph
> > >>>>>>> config file. "osd crush update on start =3D false". This should
> remove
> > >>>>>>> and update that is generated when osd starts.
> > >>>>>>>
> > >>>>>>> 2018-10-03 14:03:21.534 7fe15eddb700  0 mon.SRV-SBKUARK14@0
> (leader)
> > >>>>>>> e14 handle_command mon_command({"prefix": "osd crush
> > >>>>>>> set-device-class", "class": "hdd", "ids": ["47"]} v 0) v1
> > >>>>>>> 2018-10-03 14:03:21.534 7fe15eddb700  0 log_channel(audit) log
> [INF] :
> > >>>>>>> from=3D'osd.47 10.10.112.17:6803/64652' entity=3D'osd.47'
> cmd=3D[{"prefix":
> > >>>>>>> "osd crush set-device-class", "class": "hdd", "ids": ["47"]}]:
> > >>>>>>> dispatch
> > >>>>>>> 2018-10-03 14:03:21.538 7fe15eddb700  0 mon.SRV-SBKUARK14@0
> (leader)
> > >>>>>>> e14 handle_command mon_command({"prefix": "osd crush
> create-or-move",
> > >>>>>>> "id": 47, "weight":3.6396, "args": ["host=3DSRV-SEKUARK8",
> > >>>>>>> "root=3Ddefault"]} v 0) v1
> > >>>>>>> 2018-10-03 14:03:21.538 7fe15eddb700  0 log_channel(audit) log
> [INF] :
> > >>>>>>> from=3D'osd.47 10.10.112.17:6803/64652' entity=3D'osd.47'
> cmd=3D[{"prefix":
> > >>>>>>> "osd crush create-or-move", "id": 47, "weight":3.6396, "args":
> > >>>>>>> ["host=3DSRV-SEKUARK8", "root=3Ddefault"]}]: dispatch
> > >>>>>>> 2018-10-03 14:03:21.538 7fe15eddb700  0
> > >>>>>>> mon.SRV-SBKUARK14@0(leader).osd e72601 create-or-move crush
> item name
> > >>>>>>> 'osd.47' initial_weight 3.6396 at location
> > >>>>>>> {host=3DSRV-SEKUARK8,root=3Ddefault}
> > >>>>>>> 2018-10-03 14:03:22.250 7fe1615e0700  1
> > >>>>>>> mon.SRV-SBKUARK14@0(leader).osd e72601 do_prune osdmap full
> prune
> > >>>>>>> enabled
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> On Wed, Oct 3, 2018 at 3:16 PM Goktug Yildirim
> > >>>>>>> <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>>
> > >>>>>>>> Hi Sage,
> > >>>>>>>>
> > >>>>>>>> Thank you for your response. Now I am sure this incident is
> going to be resolved.
> > >>>>>>>>
> > >>>>>>>> The problem started when 7 server crashed same time and they
> came back after ~5 minutes.
> > >>>>>>>>
> > >>>>>>>> Two of our 3 mon services were restarted in this crash. Since
> mon services are enabled they should be started nearly at the same time. =
I
> dont know if this makes any difference but some of the guys on IRC told i=
t
> is required that they start in order not at the same time. Otherwise it
> could break things badly.
> > >>>>>>>>
> > >>>>>>>> After 9 days we still see 3400-3500 active+clear PG. But in th=
e
> end we have so many STUCK request and our cluster can not heal itself.
> > >>>>>>>>
> > >>>>>>>> When we set noup flag, OSDs can catch up epoch easily. But whe=
n
> we unset the flag we see so many STUCKS and SLOW OPS in 1 hour.
> > >>>>>>>> I/O load on all of my OSD disks are at around %95 utilization
> and never ends. CPU and RAM usage are OK.
> > >>>>>>>> OSDs get stuck that we even can't run =E2=80=9Cceph pg osd.0 q=
uery=E2=80=9D.
> > >>>>>>>>
> > >>>>>>>> Also we tried to change RBD pool replication size 2 to 1. Our
> goal was the eliminate older PG's and leaving cluster with good ones.
> > >>>>>>>> With replication size=3D1 we saw "%13 PGS not active=E2=80=9D.=
 But it
> didn=E2=80=99t solve our problem.
> > >>>>>>>>
> > >>>>>>>> Of course we have to save %100 of data. But we feel like even
> saving %50 of our data will be make us very happy right now.
> > >>>>>>>>
> > >>>>>>>> This is what happens when the cluster starts. I believe it
> explains the whole story very nicely.
> > >>>>>>>>
> https://drive.google.com/file/d/1-HHuACyXkYt7e0soafQwAbWJP1qs8-u1/view?us=
p=3Dsharing
> > >>>>>>>>
> > >>>>>>>> This is our ceph.conf:
> > >>>>>>>> https://paste.ubuntu.com/p/8sQhfPDXnW/
> > >>>>>>>>
> > >>>>>>>> This is the output of "osd stat && osd epochs && ceph -s &&
> ceph health=E2=80=9D:
> > >>>>>>>> https://paste.ubuntu.com/p/g5t8xnrjjZ/
> > >>>>>>>>
> > >>>>>>>> This is pg dump:
> > >>>>>>>> https://paste.ubuntu.com/p/zYqsN5T95h/
> > >>>>>>>>
> > >>>>>>>> This is iostat & perf top:
> > >>>>>>>> https://paste.ubuntu.com/p/Pgf3mcXXX8/
> > >>>>>>>>
> > >>>>>>>> This strace output of ceph-osd:
> > >>>>>>>> https://paste.ubuntu.com/p/YCdtfh5qX8/
> > >>>>>>>>
> > >>>>>>>> This is OSD log (default debug):
> > >>>>>>>> https://paste.ubuntu.com/p/Z2JrrBzzkM/
> > >>>>>>>>
> > >>>>>>>> This is leader MON log (default debug):
> > >>>>>>>> https://paste.ubuntu.com/p/RcGmsVKmzG/
> > >>>>>>>>
> > >>>>>>>> These are OSDs failed to start. Total number is 58.
> > >>>>>>>> https://paste.ubuntu.com/p/ZfRD5ZtvpS/
> > >>>>>>>> https://paste.ubuntu.com/p/pkRdVjCH4D/
> > >>>>>>>> https://paste.ubuntu.com/p/zJTf2fzSj9/
> > >>>>>>>> https://paste.ubuntu.com/p/xpJRK6YhRX/
> > >>>>>>>> https://paste.ubuntu.com/p/SY3576dNbJ/
> > >>>>>>>> https://paste.ubuntu.com/p/smyT6Y976b/
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> This is OSD video with debug osd =3D 20 and debug ms =3D 1 and
> debug_filestore =3D 20.
> > >>>>>>>>
> https://drive.google.com/file/d/1UHHocK3Wy8pVpgZ4jV8Rl1z7rqK3bcJi/view?us=
p=3Dsharing
> > >>>>>>>>
> > >>>>>>>> This is OSD logfile with debug osd =3D 20 and debug ms =3D 1 a=
nd
> debug_filestore =3D 20.
> > >>>>>>>>
> https://drive.google.com/file/d/1gH5Z0dUe36jM8FaulahEL36sxXrhORWI/view?us=
p=3Dsharing
> > >>>>>>>>
> > >>>>>>>> As far as I understand OSD catchs up with the mon epoch and
> exceeds mon epoch somehow??
> > >>>>>>>>
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66c0bf9700 20 osd.150 72642 mkpg
> 66.f8 e60196@2018-09-28 23:57:08.251119
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66c0bf9700 10 osd.150 72642
> build_initial_pg_history 66.f8 created 60196
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66c0bf9700 20 osd.150 72642 get_map
> 60196 - loading and decoding 0x19da8400
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1)
> _process 66.d8 to_process <> waiting <> waiting_peering {}
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1)
> _process OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642
> epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642) que=
ued
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1)
> _process 66.d8 to_process <OpQueueItem(66.d8 PGPeeringEvent(epoch_sent:
> 72642 epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10
> e72642)> waiting <> waiting_peering {}
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1)
> _process OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642
> epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642) pg
> 0xb579400
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 osd.150 pg_epoch: 7264=
2
> pg[66.d8( v 39934'8971934 (38146'8968839,39934'8971934]
> local-lis/les=3D72206/72212 n=3D2206 ec=3D50786/50786 lis/c 72206/72206 l=
es/c/f
> 72212/72212/0 72642/72642/72642) [150] r=3D0 lpr=3D72642 pi=3D[72206,7264=
2)/1
> crt=3D39934'8971934 lcod 0'0 mlcod 0'0 peering mbc=3D{} ps=3D[1~11]]
> do_peering_event: epoch_sent: 72642 epoch_requested: 72642 NullEvt
> +create_info
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 log is not dirty
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 osd.150 72642
> queue_want_up_thru want 72642 <=3D queued 72642, currently 72206
> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1)
> _process empty q, waiting
> > >>>>>>>> 2018-10-03 14:55:08.665 7f66c0bf9700 10 osd.150 72642
> add_map_bl 60196 50012 bytes
> > >>>>>>>> 2018-10-03 14:55:08.665 7f66c0bf9700 20 osd.150 72642 get_map
> 60197 - loading and decoding 0x19da8880
> > >>>>>>>> 2018-10-03 14:55:08.669 7f66c0bf9700 10 osd.150 72642
> add_map_bl 60197 50012 bytes
> > >>>>>>>> 2018-10-03 14:55:08.669 7f66c0bf9700 20 osd.150 72642 get_map
> 60198 - loading and decoding 0x19da9180
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 3 Oct 2018, at 05:14, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > >>>>>>>>
> > >>>>>>>> osd_find_best_info_ignore_history_les is a dangerous option an=
d
> you should
> > >>>>>>>> only use it in very specific circumstances when directed by a
> developer.
> > >>>>>>>> In such cases it will allow a stuck PG to peer.  But you're no=
t
> getting to
> > >>>>>>>> that point...you're seeing some sort of resource exhaustion.
> > >>>>>>>>
> > >>>>>>>> The noup trick works when OSDs are way behind on maps and all
> need to
> > >>>>>>>> catch up.  The way to tell if they are behind is by looking at
> the 'ceph
> > >>>>>>>> daemon osd.NNN status' output and comparing to the latest
> OSDMap epoch tha
> > >>>>>>>> t the mons have.  Were they really caught up when you unset
> noup?
> > >>>>>>>>
> > >>>>>>>> I'm just catching up and haven't read the whole thread but I
> haven't seen
> > >>>>>>>> anything that explains why teh OSDs are dong lots of disk IO.
> Catching up
> > >>>>>>>> on maps could explain it but not why they wouldn't peer once
> they were all
> > >>>>>>>> marked up...
> > >>>>>>>>
> > >>>>>>>> sage
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On Tue, 2 Oct 2018, G=C3=B6ktu=C4=9F Y=C4=B1ld=C4=B1r=C4=B1m w=
rote:
> > >>>>>>>>
> > >>>>>>>> Anyone heart about osd_find_best_info_ignore_history_les =3D t=
rue
> ?
> > >>>>>>>> Is that be usefull here? There is such a less information abou=
t
> it.
> > >>>>>>>>
> > >>>>>>>> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =C5=9Funlar=C4=B1 =
yazd=C4=B1 (2
> Eki 2018 22:11):
> > >>>>>>>>
> > >>>>>>>> Hi,
> > >>>>>>>>
> > >>>>>>>> Indeed I left ceph-disk to decide the wal and db partitions
> when I read somewhere that that will do the proper sizing.
> > >>>>>>>> For the blustore cache size I have plenty of RAM. I will
> increase 8GB for each and decide a more calculated number    after cluste=
r
> settles.
> > >>>>>>>>
> > >>>>>>>> For the osd map loading I=E2=80=99ve also figured it out. And =
it is in
> loop. For that reason I started cluster with noup flag and waited OSDs to
> reach the uptodate epoch number. After that I unset noup. But I did not p=
ay
> attention to manager logs. Let me check it, thank you!
> > >>>>>>>>
> > >>>>>>>> I am not forcing jmellac or anything else really. I have a ver=
y
> standard installation and no tweaks or tunings. All we ask for the
> stability versus speed from the begining. And here we are :/
> > >>>>>>>>
> > >>>>>>>> On 2 Oct 2018, at 21:53, Darius Kasparavi=C4=8Dius <daznis@gma=
il.com>
> wrote:
> > >>>>>>>>
> > >>>>>>>> Hi,
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> I can see some issues from the osd log file. You have an
> extremely low
> > >>>>>>>> size db and wal partitions. Only 1GB for DB and 576MB for wal.
> I would
> > >>>>>>>> recommend cranking up rocksdb cache size as much as possible.
> If you
> > >>>>>>>> have RAM you can also increase bluestores cache size for hdd.
> Default
> > >>>>>>>> is 1GB be as liberal as you can without getting OOM kills. You
> also
> > >>>>>>>> have lots of osd map loading and decoding in the log. Are you
> sure all
> > >>>>>>>> monitors/managers/osds are up to date? Plus make sure you aren=
't
> > >>>>>>>> forcing jemalloc loading. I had a funny interaction after
> upgrading to
> > >>>>>>>> mimic.
> > >>>>>>>> On Tue, Oct 2, 2018 at 9:02 PM Goktug Yildirim
> > >>>>>>>> <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> Hello Darius,
> > >>>>>>>>
> > >>>>>>>> Thanks for reply!
> > >>>>>>>>
> > >>>>>>>> The main problem is we can not query PGs. =E2=80=9Cceph pg 67.=
54f
> query=E2=80=9D does stucks and wait forever since OSD is unresponsive.
> > >>>>>>>> We are certain that OSD gets unresponsive as soon as it UP. An=
d
> we are certain that OSD responds again after its disk utilization stops.
> > >>>>>>>>
> > >>>>>>>> So we have a small test like that:
> > >>>>>>>> * Stop all OSDs (168 of them)
> > >>>>>>>> * Start OSD1. %95 osd disk utilization immediately starts. It
> takes 8 mins to finish. Only after that =E2=80=9Cceph pg 67.54f query=E2=
=80=9D works!
> > >>>>>>>> * While OSD1 is =E2=80=9Cup" start OSD2. As soon as OSD2 start=
s OSD1 &
> OSD2 starts %95 disk utilization. This takes 17 minutes to finish.
> > >>>>>>>> * Now start OSD3 and it is the same. All OSDs start high I/O
> and it takes 25 mins to settle.
> > >>>>>>>> * If you happen to start 5 of them at the same all of the OSDs
> start high I/O again. And it takes 1 hour to finish.
> > >>>>>>>>
> > >>>>>>>> So in the light of these findings we flagged noup, started all
> OSDs. At first there was no I/O. After 10 minutes we unset noup. All of 1=
68
> OSD started to make high I/O. And we thought that if we wait long enough =
it
> will finish & OSDs will be responsive again. After 24hours they did not
> because I/O did not finish or even slowed down.
> > >>>>>>>> One can think that is a lot of data there to scan. But it is
> just 33TB.
> > >>>>>>>>
> > >>>>>>>> So at short we dont know which PG is stuck so we can remove it=
.
> > >>>>>>>>
> > >>>>>>>> However we met an weird thing half an hour ago. We exported th=
e
> same PG from two different OSDs. One was 4.2GB and the other is 500KB! So
> we decided to export all OSDs for backup. Then we will delete strange siz=
ed
> ones and start the cluster all over. Maybe then we could solve the stucke=
d
> or unfound PGs as you advise.
> > >>>>>>>>
> > >>>>>>>> Any thought would be greatly appreciated.
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 2 Oct 2018, at 18:16, Darius Kasparavi=C4=8Dius <daznis@gma=
il.com>
> wrote:
> > >>>>>>>>
> > >>>>>>>> Hello,
> > >>>>>>>>
> > >>>>>>>> Currently you have 15 objects missing. I would recommend
> finding them
> > >>>>>>>> and making backups of them. Ditch all other osds that are
> failing to
> > >>>>>>>> start and concentrate on bringing online those that have missi=
ng
> > >>>>>>>> objects. Then slowly turn off nodown and noout on the cluster
> and see
> > >>>>>>>> if it stabilises. If it stabilises leave these setting if not
> turn
> > >>>>>>>> them back on.
> > >>>>>>>> Now get some of the pg's that are blocked and querry the pgs t=
o
> check
> > >>>>>>>> why they are blocked. Try removing as much blocks as possible
> and then
> > >>>>>>>> remove the norebalance/norecovery flags and see if it starts t=
o
> fix
> > >>>>>>>> itself. On Tue, Oct 2, 2018 at 5:14 PM by morphin
> > >>>>>>>> <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> One of ceph experts indicated that bluestore is somewhat
> preview tech
> > >>>>>>>> (as for Redhat).
> > >>>>>>>> So it could be best to checkout bluestore and rocksdb. There
> are some
> > >>>>>>>> tools to check health and also repair. But there are limited
> > >>>>>>>> documentation.
> > >>>>>>>> Anyone who has experince with it?
> > >>>>>>>> Anyone lead/help to a proper check would be great.
> > >>>>>>>> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 1 Eki 2018 Pzt,
> 22:55
> > >>>>>>>> tarihinde =C5=9Funu yazd=C4=B1:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> Hi all,
> > >>>>>>>>
> > >>>>>>>> We have recently upgraded from luminous to mimic. It=E2=80=99s=
 been 6
> days since this cluster is offline. The long short story is here:
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/030078=
.html
> > >>>>>>>>
> > >>>>>>>> I=E2=80=99ve also CC=E2=80=99ed developers since I believe thi=
s is a bug. If
> this is not to correct way I apology and please let me know.
> > >>>>>>>>
> > >>>>>>>> For the 6 days lots of thing happened and there were some
> outcomes about the problem. Some of them was misjudged and some of them a=
re
> not looked deeper.
> > >>>>>>>> However the most certain diagnosis is this: each OSD causes
> very high disk I/O to its bluestore disk (WAL and DB are fine). After tha=
t
> OSDs become unresponsive or very very less responsive. For example "ceph
> tell osd.x version=E2=80=9D stucks like for ever.
> > >>>>>>>>
> > >>>>>>>> So due to unresponsive OSDs cluster does not settle. This is
> our problem!
> > >>>>>>>>
> > >>>>>>>> This is the one we are very sure of. But we are not sure of th=
e
> reason.
> > >>>>>>>>
> > >>>>>>>> Here is the latest ceph status:
> > >>>>>>>> https://paste.ubuntu.com/p/2DyZ5YqPjh/.
> > >>>>>>>>
> > >>>>>>>> This is the status after we started all of the OSDs 24 hours
> ago.
> > >>>>>>>> Some of the OSDs are not started. However it didnt make any
> difference when all of them was online.
> > >>>>>>>>
> > >>>>>>>> Here is the debug=3D20 log of an OSD which is same for all oth=
ers:
> > >>>>>>>> https://paste.ubuntu.com/p/8n2kTvwnG6/
> > >>>>>>>> As we figure out there is a loop pattern. I am sure it wont
> caught from eye.
> > >>>>>>>>
> > >>>>>>>> This the full log the same OSD.
> > >>>>>>>> https://www.dropbox.com/s/pwzqeajlsdwaoi1/ceph-osd.90.log?dl=
=3D0
> > >>>>>>>>
> > >>>>>>>> Here is the strace of the same OSD process:
> > >>>>>>>> https://paste.ubuntu.com/p/8n2kTvwnG6/
> > >>>>>>>>
> > >>>>>>>> Recently we hear more to uprade mimic. I hope none get hurts a=
s
> we do. I am sure we have done lots of mistakes to let this happening. And
> this situation may be a example for other user and could be a potential b=
ug
> for ceph developer.
> > >>>>>>>>
> > >>>>>>>> Any help to figure out what is going on would be great.
> > >>>>>>>>
> > >>>>>>>> Best Regards,
> > >>>>>>>> Goktug Yildirim
> > >>>>>>>>
> > >>>>>>>> _______________________________________________
> > >>>>>>>> ceph-users mailing list
> > >>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > >>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >>
> >
> >

--000000000000dc5d28057757abef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">I changed the file name to make it clear.</div><div =
dir=3D"auto">When I use your command with &quot;+decode&quot; =C2=A0I&#39;m=
 getting an error like this:</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">ceph-dencoder type creating_pgs_t import DUMPFILE decode dump_json</di=
v><div dir=3D"auto">error: buffer::malformed_input: void creating_pgs_t::de=
code(ceph::buffer::list::iterator&amp;) no longer understand old encoding v=
ersion 2 &lt; 111</div><div dir=3D"auto"><br></div><div dir=3D"auto">My cep=
h version: 13.2.2</div></div><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">3 Eki 2018 =C3=87ar, saat 20:46 tarihinde Sage Weil &lt;<a href=3D=
"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; =C5=9Funu yazd=C4=B1:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">On Wed, 3 Oct 2018, G=C3=B6ktu=C4=
=9F Y=C4=B1ld=C4=B1r=C4=B1m wrote:<br>
&gt; If I didn&#39;t do it wrong, I got the output as below.<br>
&gt; <br>
&gt; ceph-kvstore-tool rocksdb /var/lib/ceph/mon/ceph-SRV-SBKUARK14/store.d=
b/ get osd_pg_creating creating &gt; dump<br>
&gt; 2018-10-03 20:08:52.070 7f07f5659b80=C2=A0 1 rocksdb: do_open column f=
amilies: [default]<br>
&gt; <br>
&gt; ceph-dencoder type creating_pgs_t import dump dump_json<br>
<br>
Sorry, should be<br>
<br>
ceph-dencoder type creating_pgs_t import dump decode dump_json<br>
<br>
s<br>
<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;last_scan_epoch&quot;: 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;creating_pgs&quot;: [],<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;queue&quot;: [],<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;created_pools&quot;: []<br>
&gt; }<br>
&gt; <br>
&gt; You can find the &quot;dump&quot; link below.<br>
&gt; <br>
&gt; dump: <a href=3D"https://drive.google.com/file/d/1ZLUiQyotQ4-778wM9UNW=
K_TLDAROg0yN/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank">https=
://drive.google.com/file/d/1ZLUiQyotQ4-778wM9UNWK_TLDAROg0yN/view?usp=3Dsha=
ring</a><br>
&gt; <br>
&gt; <br>
&gt; Sage Weil &lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">s=
age-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; =C5=9Funlar=C4=B1 yazd=C4=B1 (3 Eki 2018 18:45):<b=
r>
&gt; <br>
&gt; &gt;&gt; On Wed, 3 Oct 2018, Goktug Yildirim wrote:<br>
&gt; &gt;&gt; We are starting to work on it. First step is getting the stru=
cture out and dumping the current value as you say.<br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt; And you were correct we did not run force_create_pg.<br>
&gt; &gt; <br>
&gt; &gt; Great.<br>
&gt; &gt; <br>
&gt; &gt; So, eager to see what the current structure is... please attach o=
nce you <br>
&gt; &gt; have it.<br>
&gt; &gt; <br>
&gt; &gt; The new replacement one should look like this (when hexdump -C&#3=
9;d):<br>
&gt; &gt; <br>
&gt; &gt; 00000000=C2=A0 02 01 18 00 00 00 10 00=C2=A0 00 00 00 00 00 00 01=
 00=C2=A0 |................|<br>
&gt; &gt; 00000010=C2=A0 00 00 42 00 00 00 00 00=C2=A0 00 00 00 00 00 00=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |..B...........|<br>
&gt; &gt; 0000001e<br>
&gt; &gt; <br>
&gt; &gt; ...except that from byte 6 you want to put in a recent OSDMap epo=
ch, in <br>
&gt; &gt; hex, little endian (least significant byte first), in place of th=
e 0x10 <br>
&gt; &gt; that is there now.=C2=A0 It should dump like this:<br>
&gt; &gt; <br>
&gt; &gt; $ ceph-dencoder type creating_pgs_t import myfile decode dump_jso=
n<br>
&gt; &gt; {<br>
&gt; &gt;=C2=A0 =C2=A0 &quot;last_scan_epoch&quot;: 16,=C2=A0 =C2=A0&lt;---=
 but with a recent epoch here<br>
&gt; &gt;=C2=A0 =C2=A0 &quot;creating_pgs&quot;: [],<br>
&gt; &gt;=C2=A0 =C2=A0 &quot;queue&quot;: [],<br>
&gt; &gt;=C2=A0 =C2=A0 &quot;created_pools&quot;: [<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 66<br>
&gt; &gt;=C2=A0 =C2=A0 ]<br>
&gt; &gt; }<br>
&gt; &gt; <br>
&gt; &gt; sage<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt;&gt; <br>
&gt; &gt;&gt;&gt; On 3 Oct 2018, at 17:52, Sage Weil &lt;<a href=3D"mailto:=
sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; On Wed, 3 Oct 2018, Goktug Yildirim wrote:<br>
&gt; &gt;&gt;&gt;&gt; Sage,<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; Pool 66 is the only pool it shows right now. This a p=
ool created months ago.<br>
&gt; &gt;&gt;&gt;&gt; ceph osd lspools<br>
&gt; &gt;&gt;&gt;&gt; 66 mypool<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; As we recreated mon db from OSDs, the pools for MDS w=
as unusable. So we deleted them.<br>
&gt; &gt;&gt;&gt;&gt; After we create another cephfs fs and pools we starte=
d MDS and it stucked on creation. So we stopped MDS and removed fs and fs p=
ools. Right now we do not have MDS running nor we have cephfs related thing=
s.<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; ceph fs dump<br>
&gt; &gt;&gt;&gt;&gt; dumped fsmap epoch 1 e1<br>
&gt; &gt;&gt;&gt;&gt; enable_multiple, ever_enabled_multiple: 0,0<br>
&gt; &gt;&gt;&gt;&gt; compat: compat=3D{},rocompat=3D{},incompat=3D{1=3Dbas=
e v0.20,2=3Dclient writeable ranges,3=3Ddefault file layouts on dirs,4=3Ddi=
r inode in separate object,5=3Dmds uses versioned encoding,6=3Ddirfrag is s=
tored in omap,8=3Dno anchor table,9=3Dfile layout v2,10=3Dsnaprealm v2}<br>
&gt; &gt;&gt;&gt;&gt; legacy client fscid: -1<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; No filesystems configured<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; ceph fs ls<br>
&gt; &gt;&gt;&gt;&gt; No filesystems enabled<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; Now pool 66 seems to only pool we have and it has bee=
n created months ago. Then I guess there is something hidden out there.<br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; Is there any way to find and delete it?<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; Ok, I&#39;m concerned that the creating pg is in there if=
 this is an old <br>
&gt; &gt;&gt;&gt; pool... did you perhaps run force_create_pg at some point=
?=C2=A0 Assuming you <br>
&gt; &gt;&gt;&gt; didn&#39;t, I think this is a bug in the process for rebu=
ilding the mon <br>
&gt; &gt;&gt;&gt; store.. one that doesn&#39;t normally come up because the=
 impact is this <br>
&gt; &gt;&gt;&gt; osdmap scan that is cheap in our test scenarios but clear=
ly not cheap for <br>
&gt; &gt;&gt;&gt; your aged cluster.<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; In any case, there is a way to clear those out of the mon=
, but it&#39;s a bit <br>
&gt; &gt;&gt;&gt; dicey. <br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; 1. stop all mons<br>
&gt; &gt;&gt;&gt; 2. make a backup of all mons<br>
&gt; &gt;&gt;&gt; 3. use ceph-kvstore-tool to extract the prefix=3Dosd_pg_c=
reating <br>
&gt; &gt;&gt;&gt; key=3Dcreating key on one of the mons<br>
&gt; &gt;&gt;&gt; 4. dump the object with ceph-dencoder type creating_pgs_t=
 import FILE dump_json<br>
&gt; &gt;&gt;&gt; 5. hex edit the structure to remove all of the creating p=
gs, and adds pool <br>
&gt; &gt;&gt;&gt; 66 to the created_pgs member.<br>
&gt; &gt;&gt;&gt; 6. verify with ceph-dencoder dump that the edit was corre=
ct...<br>
&gt; &gt;&gt;&gt; 7. inject the updated structure into all of the mons<br>
&gt; &gt;&gt;&gt; 8. start all mons<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; 4-6 will probably be an iterative process... let&#39;s st=
art by getting the <br>
&gt; &gt;&gt;&gt; structure out and dumping the current value?=C2=A0 <br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; The code to refer to to understand the structure is src/m=
on/CreatingPGs.h <br>
&gt; &gt;&gt;&gt; encode/decode methods.<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; sage<br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; On 3 Oct 2018, at 16:46, Sage Weil &lt;<a href=3D=
"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrot=
e:<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; Oh... I think this is the problem:<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; 2018-10-03 16:37:04.284 7efef2ae0700 20 slow op o=
sd_pg_create(e72883 <br>
&gt; &gt;&gt;&gt;&gt;&gt; <a href=3D"http://66.af:60196" rel=3D"noreferrer"=
 target=3D"_blank">66.af:60196</a> <a href=3D"http://66.ba:60196" rel=3D"no=
referrer" target=3D"_blank">66.ba:60196</a> <a href=3D"http://66.be:60196" =
rel=3D"noreferrer" target=3D"_blank">66.be:60196</a> 66.d8:60196 66.f8:6019=
6 66.124:60196 <br>
&gt; &gt;&gt;&gt;&gt;&gt; 66.14c:60196 66.1ac:60196 66.223:60196 66.248:601=
96 66.271:60196 <br>
&gt; &gt;&gt;&gt;&gt;&gt; 66.2d1:60196 66.47a:68641) initiated 2018-10-03 1=
6:20:01.915916<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; You are in the midst of creating new pgs, and unf=
ortunately pg create is <br>
&gt; &gt;&gt;&gt;&gt;&gt; one of the last remaining places where the OSDs n=
eed to look at a full <br>
&gt; &gt;&gt;&gt;&gt;&gt; history of map changes between then and the curre=
nt map epoch.=C2=A0 In this <br>
&gt; &gt;&gt;&gt;&gt;&gt; case, the pool was created in 60196 and it is now=
 72883, ~12k epochs <br>
&gt; &gt;&gt;&gt;&gt;&gt; later.<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; What is this new pool for?=C2=A0 Is it still empt=
y, and if so, can we delete <br>
&gt; &gt;&gt;&gt;&gt;&gt; it? If yes, I&#39;m ~70% sure that will then get =
cleaned out at the mon end <br>
&gt; &gt;&gt;&gt;&gt;&gt; and restarting the OSDs will make these pg_create=
s go away.<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt; s<br>
&gt; &gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; On Wed, 3 Oct 2018, Goktug Yildirim wrote:<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Hello,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; It seems nothing has changed.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; OSD config: <a href=3D"https://paste.ubuntu.c=
om/p/MtvTr5HYW4/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu=
.com/p/MtvTr5HYW4/</a> &lt;<a href=3D"https://paste.ubuntu.com/p/MtvTr5HYW4=
/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com/p/MtvTr5HY=
W4/</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; OSD debug log: <a href=3D"https://paste.ubunt=
u.com/p/7Sx64xGzkR/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubu=
ntu.com/p/7Sx64xGzkR/</a> &lt;<a href=3D"https://paste.ubuntu.com/p/7Sx64xG=
zkR/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com/p/7Sx64=
xGzkR/</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On 3 Oct 2018, at 14:27, Darius Kasparavi=
=C4=8Dius &lt;<a href=3D"mailto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">daznis@=
gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; You can also reduce the osd map updates b=
y adding this to your ceph<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; config file. &quot;osd crush update on st=
art =3D false&quot;. This should remove<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; and update that is generated when osd sta=
rts.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:03:21.534 7fe15eddb700=C2=
=A0 0 mon.SRV-SBKUARK14@0(leader)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; e14 handle_command mon_command({&quot;pre=
fix&quot;: &quot;osd crush<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; set-device-class&quot;, &quot;class&quot;=
: &quot;hdd&quot;, &quot;ids&quot;: [&quot;47&quot;]} v 0) v1<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:03:21.534 7fe15eddb700=C2=
=A0 0 log_channel(audit) log [INF] :<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; from=3D&#39;osd.47 <a href=3D"http://10.1=
0.112.17:6803/64652" rel=3D"noreferrer" target=3D"_blank">10.10.112.17:6803=
/64652</a>&#39; entity=3D&#39;osd.47&#39; cmd=3D[{&quot;prefix&quot;:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;osd crush set-device-class&quot;, &=
quot;class&quot;: &quot;hdd&quot;, &quot;ids&quot;: [&quot;47&quot;]}]:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; dispatch<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:03:21.538 7fe15eddb700=C2=
=A0 0 mon.SRV-SBKUARK14@0(leader)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; e14 handle_command mon_command({&quot;pre=
fix&quot;: &quot;osd crush create-or-move&quot;,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;id&quot;: 47, &quot;weight&quot;:3.=
6396, &quot;args&quot;: [&quot;host=3DSRV-SEKUARK8&quot;,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;root=3Ddefault&quot;]} v 0) v1<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:03:21.538 7fe15eddb700=C2=
=A0 0 log_channel(audit) log [INF] :<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; from=3D&#39;osd.47 <a href=3D"http://10.1=
0.112.17:6803/64652" rel=3D"noreferrer" target=3D"_blank">10.10.112.17:6803=
/64652</a>&#39; entity=3D&#39;osd.47&#39; cmd=3D[{&quot;prefix&quot;:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &quot;osd crush create-or-move&quot;, &qu=
ot;id&quot;: 47, &quot;weight&quot;:3.6396, &quot;args&quot;:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; [&quot;host=3DSRV-SEKUARK8&quot;, &quot;r=
oot=3Ddefault&quot;]}]: dispatch<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:03:21.538 7fe15eddb700=C2=
=A0 0<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; mon.SRV-SBKUARK14@0(leader).osd e72601 cr=
eate-or-move crush item name<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &#39;osd.47&#39; initial_weight 3.6396 at=
 location<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; {host=3DSRV-SEKUARK8,root=3Ddefault}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:03:22.250 7fe1615e0700=C2=
=A0 1<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; mon.SRV-SBKUARK14@0(leader).osd e72601 do=
_prune osdmap full prune<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; enabled<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Oct 3, 2018 at 3:16 PM Goktug Yil=
dirim<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:goktug.yildirim@gma=
il.com" target=3D"_blank">goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi Sage,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thank you for your response. Now I am=
 sure this incident is going to be resolved.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The problem started when 7 server cra=
shed same time and they came back after ~5 minutes.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Two of our 3 mon services were restar=
ted in this crash. Since mon services are enabled they should be started ne=
arly at the same time. I dont know if this makes any difference but some of=
 the guys on IRC told it is required that they start in order not at the sa=
me time. Otherwise it could break things badly.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; After 9 days we still see 3400-3500 a=
ctive+clear PG. But in the end we have so many STUCK request and our cluste=
r can not heal itself.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; When we set noup flag, OSDs can catch=
 up epoch easily. But when we unset the flag we see so many STUCKS and SLOW=
 OPS in 1 hour.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I/O load on all of my OSD disks are a=
t around %95 utilization and never ends. CPU and RAM usage are OK.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; OSDs get stuck that we even can&#39;t=
 run =E2=80=9Cceph pg osd.0 query=E2=80=9D.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Also we tried to change RBD pool repl=
ication size 2 to 1. Our goal was the eliminate older PG&#39;s and leaving =
cluster with good ones.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; With replication size=3D1 we saw &quo=
t;%13 PGS not active=E2=80=9D. But it didn=E2=80=99t solve our problem.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Of course we have to save %100 of dat=
a. But we feel like even saving %50 of our data will be make us very happy =
right now.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is what happens when the cluster=
 starts. I believe it explains the whole story very nicely.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://drive.google.com/f=
ile/d/1-HHuACyXkYt7e0soafQwAbWJP1qs8-u1/view?usp=3Dsharing" rel=3D"noreferr=
er" target=3D"_blank">https://drive.google.com/file/d/1-HHuACyXkYt7e0soafQw=
AbWJP1qs8-u1/view?usp=3Dsharing</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is our ceph.conf:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/8sQhfPDXnW/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/8sQhfPDXnW/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is the output of &quot;osd stat =
&amp;&amp; osd epochs &amp;&amp; ceph -s &amp;&amp; ceph health=E2=80=9D:<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/g5t8xnrjjZ/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/g5t8xnrjjZ/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is pg dump:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/zYqsN5T95h/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/zYqsN5T95h/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is iostat &amp; perf top:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/Pgf3mcXXX8/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/Pgf3mcXXX8/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This strace output of ceph-osd:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/YCdtfh5qX8/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/YCdtfh5qX8/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is OSD log (default debug):<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/Z2JrrBzzkM/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/Z2JrrBzzkM/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is leader MON log (default debug=
):<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/RcGmsVKmzG/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/RcGmsVKmzG/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; These are OSDs failed to start. Total=
 number is 58.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/ZfRD5ZtvpS/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/ZfRD5ZtvpS/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/pkRdVjCH4D/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/pkRdVjCH4D/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/zJTf2fzSj9/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/zJTf2fzSj9/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/xpJRK6YhRX/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/xpJRK6YhRX/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/SY3576dNbJ/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/SY3576dNbJ/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/smyT6Y976b/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/smyT6Y976b/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is OSD video with debug osd =3D =
20 and debug ms =3D 1 and debug_filestore =3D 20.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://drive.google.com/f=
ile/d/1UHHocK3Wy8pVpgZ4jV8Rl1z7rqK3bcJi/view?usp=3Dsharing" rel=3D"noreferr=
er" target=3D"_blank">https://drive.google.com/file/d/1UHHocK3Wy8pVpgZ4jV8R=
l1z7rqK3bcJi/view?usp=3Dsharing</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is OSD logfile with debug osd =
=3D 20 and debug ms =3D 1 and debug_filestore =3D 20.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://drive.google.com/f=
ile/d/1gH5Z0dUe36jM8FaulahEL36sxXrhORWI/view?usp=3Dsharing" rel=3D"noreferr=
er" target=3D"_blank">https://drive.google.com/file/d/1gH5Z0dUe36jM8FaulahE=
L36sxXrhORWI/view?usp=3Dsharing</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; As far as I understand OSD catchs up =
with the mon epoch and exceeds mon epoch somehow??<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66c0bf9700 =
20 osd.150 72642 mkpg 66.f8 e60196@2018-09-28 23:57:08.251119<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66c0bf9700 =
10 osd.150 72642 build_initial_pg_history 66.f8 created 60196<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66c0bf9700 =
20 osd.150 72642 get_map 60196 - loading and decoding 0x19da8400<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
20 osd.150 op_wq(1) _process 66.d8 to_process &lt;&gt; waiting &lt;&gt; wai=
ting_peering {}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
20 osd.150 op_wq(1) _process OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 7=
2642 epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642) =
queued<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
20 osd.150 op_wq(1) _process 66.d8 to_process &lt;OpQueueItem(66.d8 PGPeeri=
ngEvent(epoch_sent: 72642 epoch_requested: 72642 NullEvt +create_info) prio=
 255 cost 10 e72642)&gt; waiting &lt;&gt; waiting_peering {}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
20 osd.150 op_wq(1) _process OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 7=
2642 epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642) =
pg 0xb579400<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
10 osd.150 pg_epoch: 72642 pg[66.d8( v 39934&#39;8971934 (38146&#39;8968839=
,39934&#39;8971934] local-lis/les=3D72206/72212 n=3D2206 ec=3D50786/50786 l=
is/c 72206/72206 les/c/f 72212/72212/0 72642/72642/72642) [150] r=3D0 lpr=
=3D72642 pi=3D[72206,72642)/1 crt=3D39934&#39;8971934 lcod 0&#39;0 mlcod 0&=
#39;0 peering mbc=3D{} ps=3D[1~11]] do_peering_event: epoch_sent: 72642 epo=
ch_requested: 72642 NullEvt +create_info<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
10 log is not dirty<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
10 osd.150 72642 queue_want_up_thru want 72642 &lt;=3D queued 72642, curren=
tly 72206<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.653 7f66a6bc5700 =
20 osd.150 op_wq(1) _process empty q, waiting<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.665 7f66c0bf9700 =
10 osd.150 72642 add_map_bl 60196 50012 bytes<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.665 7f66c0bf9700 =
20 osd.150 72642 get_map 60197 - loading and decoding 0x19da8880<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.669 7f66c0bf9700 =
10 osd.150 72642 add_map_bl 60197 50012 bytes<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2018-10-03 14:55:08.669 7f66c0bf9700 =
20 osd.150 72642 get_map 60198 - loading and decoding 0x19da9180<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 3 Oct 2018, at 05:14, Sage Weil &l=
t;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org<=
/a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; osd_find_best_info_ignore_history_les=
 is a dangerous option and you should<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; only use it in very specific circumst=
ances when directed by a developer.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In such cases it will allow a stuck P=
G to peer.=C2=A0 But you&#39;re not getting to<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; that point...you&#39;re seeing some s=
ort of resource exhaustion.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The noup trick works when OSDs are wa=
y behind on maps and all need to<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; catch up.=C2=A0 The way to tell if th=
ey are behind is by looking at the &#39;ceph<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; daemon osd.NNN status&#39; output and=
 comparing to the latest OSDMap epoch tha<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; t the mons have.=C2=A0 Were they real=
ly caught up when you unset noup?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m just catching up and haven&#3=
9;t read the whole thread but I haven&#39;t seen<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; anything that explains why teh OSDs a=
re dong lots of disk IO.=C2=A0 Catching up<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; on maps could explain it but not why =
they wouldn&#39;t peer once they were all<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; marked up...<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sage<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, 2 Oct 2018, G=C3=B6ktu=C4=9F =
Y=C4=B1ld=C4=B1r=C4=B1m wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Anyone heart about osd_find_best_info=
_ignore_history_les =3D true ?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is that be usefull here? There is suc=
h a less information about it.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Goktug Yildirim &lt;<a href=3D"mailto=
:goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>=
&gt; =C5=9Funlar=C4=B1 yazd=C4=B1 (2 Eki 2018 22:11):<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Indeed I left ceph-disk to decide the=
 wal and db partitions when I read somewhere that that will do the proper s=
izing.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; For the blustore cache size I have pl=
enty of RAM. I will increase 8GB for each and decide a more calculated numb=
er=C2=A0 =C2=A0 after cluster settles.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; For the osd map loading I=E2=80=99ve =
also figured it out. And it is in loop. For that reason I started cluster w=
ith noup flag and waited OSDs to reach the uptodate epoch number. After tha=
t I unset noup. But I did not pay attention to manager logs. Let me check i=
t, thank you!<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I am not forcing jmellac or anything =
else really. I have a very standard installation and no tweaks or tunings. =
All we ask for the stability versus speed from the begining. And here we ar=
e :/<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2 Oct 2018, at 21:53, Darius Kaspa=
ravi=C4=8Dius &lt;<a href=3D"mailto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">daz=
nis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I can see some issues from the osd lo=
g file. You have an extremely low<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; size db and wal partitions. Only 1GB =
for DB and 576MB for wal. I would<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; recommend cranking up rocksdb cache s=
ize as much as possible. If you<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; have RAM you can also increase bluest=
ores cache size for hdd. Default<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is 1GB be as liberal as you can witho=
ut getting OOM kills. You also<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; have lots of osd map loading and deco=
ding in the log. Are you sure all<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; monitors/managers/osds are up to date=
? Plus make sure you aren&#39;t<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; forcing jemalloc loading. I had a fun=
ny interaction after upgrading to<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; mimic.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Oct 2, 2018 at 9:02 PM Goktug=
 Yildirim<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:goktug.yildirim=
@gmail.com" target=3D"_blank">goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello Darius,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks for reply!<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The main problem is we can not query =
PGs. =E2=80=9Cceph pg 67.54f query=E2=80=9D does stucks and wait forever si=
nce OSD is unresponsive.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; We are certain that OSD gets unrespon=
sive as soon as it UP. And we are certain that OSD responds again after its=
 disk utilization stops.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So we have a small test like that:<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; * Stop all OSDs (168 of them)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; * Start OSD1. %95 osd disk utilizatio=
n immediately starts. It takes 8 mins to finish. Only after that =E2=80=9Cc=
eph pg 67.54f query=E2=80=9D works!<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; * While OSD1 is =E2=80=9Cup&quot; sta=
rt OSD2. As soon as OSD2 starts OSD1 &amp; OSD2 starts %95 disk utilization=
. This takes 17 minutes to finish.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; * Now start OSD3 and it is the same. =
All OSDs start high I/O and it takes 25 mins to settle.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; * If you happen to start 5 of them at=
 the same all of the OSDs start high I/O again. And it takes 1 hour to fini=
sh.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So in the light of these findings we =
flagged noup, started all OSDs. At first there was no I/O. After 10 minutes=
 we unset noup. All of 168 OSD started to make high I/O. And we thought tha=
t if we wait long enough it will finish &amp; OSDs will be responsive again=
. After 24hours they did not because I/O did not finish or even slowed down=
.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; One can think that is a lot of data t=
here to scan. But it is just 33TB.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So at short we dont know which PG is =
stuck so we can remove it.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; However we met an weird thing half an=
 hour ago. We exported the same PG from two different OSDs. One was 4.2GB a=
nd the other is 500KB! So we decided to export all OSDs for backup. Then we=
 will delete strange sized ones and start the cluster all over. Maybe then =
we could solve the stucked or unfound PGs as you advise.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Any thought would be greatly apprecia=
ted.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2 Oct 2018, at 18:16, Darius Kaspa=
ravi=C4=8Dius &lt;<a href=3D"mailto:daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">daz=
nis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Currently you have 15 objects missing=
. I would recommend finding them<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; and making backups of them. Ditch all=
 other osds that are failing to<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; start and concentrate on bringing onl=
ine those that have missing<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; objects. Then slowly turn off nodown =
and noout on the cluster and see<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; if it stabilises. If it stabilises le=
ave these setting if not turn<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; them back on.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Now get some of the pg&#39;s that are=
 blocked and querry the pgs to check<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; why they are blocked. Try removing as=
 much blocks as possible and then<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; remove the norebalance/norecovery fla=
gs and see if it starts to fix<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; itself. On Tue, Oct 2, 2018 at 5:14 P=
M by morphin<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:morphinwithyou@=
gmail.com" target=3D"_blank">morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; One of ceph experts indicated that bl=
uestore is somewhat preview tech<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (as for Redhat).<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So it could be best to checkout blues=
tore and rocksdb. There are some<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; tools to check health and also repair=
. But there are limited<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; documentation.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Anyone who has experince with it?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Anyone lead/help to a proper check wo=
uld be great.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Goktug Yildirim &lt;<a href=3D"mailto=
:goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>=
&gt;, 1 Eki 2018 Pzt, 22:55<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; tarihinde =C5=9Funu yazd=C4=B1:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi all,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; We have recently upgraded from lumino=
us to mimic. It=E2=80=99s been 6 days since this cluster is offline. The lo=
ng short story is here: <a href=3D"http://lists.ceph.com/pipermail/ceph-use=
rs-ceph.com/2018-September/030078.html" rel=3D"noreferrer" target=3D"_blank=
">http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/030078=
.html</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I=E2=80=99ve also CC=E2=80=99ed devel=
opers since I believe this is a bug. If this is not to correct way I apolog=
y and please let me know.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; For the 6 days lots of thing happened=
 and there were some outcomes about the problem. Some of them was misjudged=
 and some of them are not looked deeper.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; However the most certain diagnosis is=
 this: each OSD causes very high disk I/O to its bluestore disk (WAL and DB=
 are fine). After that OSDs become unresponsive or very very less responsiv=
e. For example &quot;ceph tell osd.x version=E2=80=9D stucks like for ever.=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So due to unresponsive OSDs cluster d=
oes not settle. This is our problem!<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is the one we are very sure of. =
But we are not sure of the reason.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Here is the latest ceph status:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/2DyZ5YqPjh/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/2DyZ5YqPjh/</a>.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is the status after we started a=
ll of the OSDs 24 hours ago.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Some of the OSDs are not started. How=
ever it didnt make any difference when all of them was online.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Here is the debug=3D20 log of an OSD =
which is same for all others:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/8n2kTvwnG6/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/8n2kTvwnG6/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; As we figure out there is a loop patt=
ern. I am sure it wont caught from eye.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This the full log the same OSD.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://www.dropbox.com/s/=
pwzqeajlsdwaoi1/ceph-osd.90.log?dl=3D0" rel=3D"noreferrer" target=3D"_blank=
">https://www.dropbox.com/s/pwzqeajlsdwaoi1/ceph-osd.90.log?dl=3D0</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Here is the strace of the same OSD pr=
ocess:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://paste.ubuntu.com/p=
/8n2kTvwnG6/" rel=3D"noreferrer" target=3D"_blank">https://paste.ubuntu.com=
/p/8n2kTvwnG6/</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Recently we hear more to uprade mimic=
. I hope none get hurts as we do. I am sure we have done lots of mistakes t=
o let this happening. And this situation may be a example for other user an=
d could be a potential bug for ceph developer.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Any help to figure out what is going =
on would be great.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Best Regards,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Goktug Yildirim<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; _____________________________________=
__________<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/list=
info.cgi/ceph-users-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://l=
ists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; &gt;&gt; <br>
&gt; <br>
&gt; </blockquote></div></div>

--000000000000dc5d28057757abef--

--===============4060417470885039349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4060417470885039349==--
