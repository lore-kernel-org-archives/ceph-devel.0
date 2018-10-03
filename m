From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Mimic offline problem
Date: Wed, 3 Oct 2018 19:37:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1810031936110.31802@piezo.novalocal>
References: <4C31C6EC-573D-42AD-BC6C-F7F103DBEC16@gmail.com>
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
 <CACz15iKdK47N0mBJrRyDeEx7BH-uRKmvZ+OJ6Cc6u6-qxTeA6w@mail.gmail.com>
 <f9cf0773-cce5-4989-8f78-de3a01080450@email.android.com>
 <5FBAA21A-8B48-4B22-9FE8-0E0766C363D9@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1887172461-1538595471=:31802"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5FBAA21A-8B48-4B22-9FE8-0E0766C363D9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?Q?G=C3=B6ktu=C4=9F_Y=C4=B1ld=C4=B1r=C4=B1m?= <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, by morphin <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?G=C3=B6ktu=C4=9F_Y=C4=B1ld=C4=B1r=C4=B1m?= <goktug.yildirim-DtrUWsE0is3QT0dZR+AlfA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1887172461-1538595471=:31802
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 3 Oct 2018, Göktuğ Yıldırım wrote:
> I'm so sorry about that I missed "out" parameter. My bad..
> This is the output: https://paste.ubuntu.com/p/KwT9c8F6TF/

Excellent, thanks.  That looks like it confirms the problem is that teh 
recovery tool didn't repopulate the creating pgs properly.

If you take that 30 byte file I sent earlier (as hex) and update the 
osdmap epoch to the latest on the mon, confirm it decodes and dumps 
properly, and then inject it on the 3 mons, that should get you past this 
hump (and hopefully back up!).

sage


> 
> Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> şunları yazdı (3 Eki 2018 21:13):
> 
> > I bet the kvstore output it in a hexdump format?  There is another option to get the raw data iirc
> > 
> > 
> > 
> >> On October 3, 2018 3:01:41 PM EDT, Goktug YILDIRIM <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> I changed the file name to make it clear.
> >> When I use your command with "+decode"  I'm getting an error like this:
> >> 
> >> ceph-dencoder type creating_pgs_t import DUMPFILE decode dump_json
> >> error: buffer::malformed_input: void creating_pgs_t::decode(ceph::buffer::list::iterator&) no longer understand old encoding version 2 < 111
> >> 
> >> My ceph version: 13.2.2
> >> 
> >> 3 Eki 2018 Çar, saat 20:46 tarihinde Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> şunu yazdı:
> >>> On Wed, 3 Oct 2018, Göktuğ Yıldırım wrote:
> >>> > If I didn't do it wrong, I got the output as below.
> >>> > 
> >>> > ceph-kvstore-tool rocksdb /var/lib/ceph/mon/ceph-SRV-SBKUARK14/store.db/ get osd_pg_creating creating > dump
> >>> > 2018-10-03 20:08:52.070 7f07f5659b80  1 rocksdb: do_open column families: [default]
> >>> > 
> >>> > ceph-dencoder type creating_pgs_t import dump dump_json
> >>> 
> >>> Sorry, should be
> >>> 
> >>> ceph-dencoder type creating_pgs_t import dump decode dump_json
> >>> 
> >>> s
> >>> 
> >>> > {
> >>> >     "last_scan_epoch": 0,
> >>> >     "creating_pgs": [],
> >>> >     "queue": [],
> >>> >     "created_pools": []
> >>> > }
> >>> > 
> >>> > You can find the "dump" link below.
> >>> > 
> >>> > dump: https://drive.google.com/file/d/1ZLUiQyotQ4-778wM9UNWK_TLDAROg0yN/view?usp=sharing
> >>> > 
> >>> > 
> >>> > Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> şunları yazdı (3 Eki 2018 18:45):
> >>> > 
> >>> > >> On Wed, 3 Oct 2018, Goktug Yildirim wrote:
> >>> > >> We are starting to work on it. First step is getting the structure out and dumping the current value as you say.
> >>> > >> 
> >>> > >> And you were correct we did not run force_create_pg.
> >>> > > 
> >>> > > Great.
> >>> > > 
> >>> > > So, eager to see what the current structure is... please attach once you 
> >>> > > have it.
> >>> > > 
> >>> > > The new replacement one should look like this (when hexdump -C'd):
> >>> > > 
> >>> > > 00000000  02 01 18 00 00 00 10 00  00 00 00 00 00 00 01 00  |................|
> >>> > > 00000010  00 00 42 00 00 00 00 00  00 00 00 00 00 00        |..B...........|
> >>> > > 0000001e
> >>> > > 
> >>> > > ...except that from byte 6 you want to put in a recent OSDMap epoch, in 
> >>> > > hex, little endian (least significant byte first), in place of the 0x10 
> >>> > > that is there now.  It should dump like this:
> >>> > > 
> >>> > > $ ceph-dencoder type creating_pgs_t import myfile decode dump_json
> >>> > > {
> >>> > >    "last_scan_epoch": 16,   <--- but with a recent epoch here
> >>> > >    "creating_pgs": [],
> >>> > >    "queue": [],
> >>> > >    "created_pools": [
> >>> > >        66
> >>> > >    ]
> >>> > > }
> >>> > > 
> >>> > > sage
> >>> > > 
> >>> > > 
> >>> > >> 
> >>> > >>> On 3 Oct 2018, at 17:52, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> >>> > >>> 
> >>> > >>> On Wed, 3 Oct 2018, Goktug Yildirim wrote:
> >>> > >>>> Sage,
> >>> > >>>> 
> >>> > >>>> Pool 66 is the only pool it shows right now. This a pool created months ago.
> >>> > >>>> ceph osd lspools
> >>> > >>>> 66 mypool
> >>> > >>>> 
> >>> > >>>> As we recreated mon db from OSDs, the pools for MDS was unusable. So we deleted them.
> >>> > >>>> After we create another cephfs fs and pools we started MDS and it stucked on creation. So we stopped MDS and removed fs and fs pools. Right now we do not have MDS running nor we have cephfs related things.
> >>> > >>>> 
> >>> > >>>> ceph fs dump
> >>> > >>>> dumped fsmap epoch 1 e1
> >>> > >>>> enable_multiple, ever_enabled_multiple: 0,0
> >>> > >>>> compat: compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding,6=dirfrag is stored in omap,8=no anchor table,9=file layout v2,10=snaprealm v2}
> >>> > >>>> legacy client fscid: -1
> >>> > >>>> 
> >>> > >>>> No filesystems configured
> >>> > >>>> 
> >>> > >>>> ceph fs ls
> >>> > >>>> No filesystems enabled
> >>> > >>>> 
> >>> > >>>> Now pool 66 seems to only pool we have and it has been created months ago. Then I guess there is something hidden out there.
> >>> > >>>> 
> >>> > >>>> Is there any way to find and delete it?
> >>> > >>> 
> >>> > >>> Ok, I'm concerned that the creating pg is in there if this is an old 
> >>> > >>> pool... did you perhaps run force_create_pg at some point?  Assuming you 
> >>> > >>> didn't, I think this is a bug in the process for rebuilding the mon 
> >>> > >>> store.. one that doesn't normally come up because the impact is this 
> >>> > >>> osdmap scan that is cheap in our test scenarios but clearly not cheap for 
> >>> > >>> your aged cluster.
> >>> > >>> 
> >>> > >>> In any case, there is a way to clear those out of the mon, but it's a bit 
> >>> > >>> dicey. 
> >>> > >>> 
> >>> > >>> 1. stop all mons
> >>> > >>> 2. make a backup of all mons
> >>> > >>> 3. use ceph-kvstore-tool to extract the prefix=osd_pg_creating 
> >>> > >>> key=creating key on one of the mons
> >>> > >>> 4. dump the object with ceph-dencoder type creating_pgs_t import FILE dump_json
> >>> > >>> 5. hex edit the structure to remove all of the creating pgs, and adds pool 
> >>> > >>> 66 to the created_pgs member.
> >>> > >>> 6. verify with ceph-dencoder dump that the edit was correct...
> >>> > >>> 7. inject the updated structure into all of the mons
> >>> > >>> 8. start all mons
> >>> > >>> 
> >>> > >>> 4-6 will probably be an iterative process... let's start by getting the 
> >>> > >>> structure out and dumping the current value?  
> >>> > >>> 
> >>> > >>> The code to refer to to understand the structure is src/mon/CreatingPGs.h 
> >>> > >>> encode/decode methods.
> >>> > >>> 
> >>> > >>> sage
> >>> > >>> 
> >>> > >>> 
> >>> > >>>> 
> >>> > >>>> 
> >>> > >>>>> On 3 Oct 2018, at 16:46, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> >>> > >>>>> 
> >>> > >>>>> Oh... I think this is the problem:
> >>> > >>>>> 
> >>> > >>>>> 2018-10-03 16:37:04.284 7efef2ae0700 20 slow op osd_pg_create(e72883 
> >>> > >>>>> 66.af:60196 66.ba:60196 66.be:60196 66.d8:60196 66.f8:60196 66.124:60196 
> >>> > >>>>> 66.14c:60196 66.1ac:60196 66.223:60196 66.248:60196 66.271:60196 
> >>> > >>>>> 66.2d1:60196 66.47a:68641) initiated 2018-10-03 16:20:01.915916
> >>> > >>>>> 
> >>> > >>>>> You are in the midst of creating new pgs, and unfortunately pg create is 
> >>> > >>>>> one of the last remaining places where the OSDs need to look at a full 
> >>> > >>>>> history of map changes between then and the current map epoch.  In this 
> >>> > >>>>> case, the pool was created in 60196 and it is now 72883, ~12k epochs 
> >>> > >>>>> later.
> >>> > >>>>> 
> >>> > >>>>> What is this new pool for?  Is it still empty, and if so, can we delete 
> >>> > >>>>> it? If yes, I'm ~70% sure that will then get cleaned out at the mon end 
> >>> > >>>>> and restarting the OSDs will make these pg_creates go away.
> >>> > >>>>> 
> >>> > >>>>> s
> >>> > >>>>> 
> >>> > >>>>>> On Wed, 3 Oct 2018, Goktug Yildirim wrote:
> >>> > >>>>>> 
> >>> > >>>>>> Hello,
> >>> > >>>>>> 
> >>> > >>>>>> It seems nothing has changed.
> >>> > >>>>>> 
> >>> > >>>>>> OSD config: https://paste.ubuntu.com/p/MtvTr5HYW4/ <https://paste.ubuntu.com/p/MtvTr5HYW4/>
> >>> > >>>>>> OSD debug log: https://paste.ubuntu.com/p/7Sx64xGzkR/ <https://paste.ubuntu.com/p/7Sx64xGzkR/>
> >>> > >>>>>> 
> >>> > >>>>>> 
> >>> > >>>>>>> On 3 Oct 2018, at 14:27, Darius Kasparavičius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> > >>>>>>> 
> >>> > >>>>>>> Hello,
> >>> > >>>>>>> 
> >>> > >>>>>>> 
> >>> > >>>>>>> You can also reduce the osd map updates by adding this to your ceph
> >>> > >>>>>>> config file. "osd crush update on start = false". This should remove
> >>> > >>>>>>> and update that is generated when osd starts.
> >>> > >>>>>>> 
> >>> > >>>>>>> 2018-10-03 14:03:21.534 7fe15eddb700  0 mon.SRV-SBKUARK14@0(leader)
> >>> > >>>>>>> e14 handle_command mon_command({"prefix": "osd crush
> >>> > >>>>>>> set-device-class", "class": "hdd", "ids": ["47"]} v 0) v1
> >>> > >>>>>>> 2018-10-03 14:03:21.534 7fe15eddb700  0 log_channel(audit) log [INF] :
> >>> > >>>>>>> from='osd.47 10.10.112.17:6803/64652' entity='osd.47' cmd=[{"prefix":
> >>> > >>>>>>> "osd crush set-device-class", "class": "hdd", "ids": ["47"]}]:
> >>> > >>>>>>> dispatch
> >>> > >>>>>>> 2018-10-03 14:03:21.538 7fe15eddb700  0 mon.SRV-SBKUARK14@0(leader)
> >>> > >>>>>>> e14 handle_command mon_command({"prefix": "osd crush create-or-move",
> >>> > >>>>>>> "id": 47, "weight":3.6396, "args": ["host=SRV-SEKUARK8",
> >>> > >>>>>>> "root=default"]} v 0) v1
> >>> > >>>>>>> 2018-10-03 14:03:21.538 7fe15eddb700  0 log_channel(audit) log [INF] :
> >>> > >>>>>>> from='osd.47 10.10.112.17:6803/64652' entity='osd.47' cmd=[{"prefix":
> >>> > >>>>>>> "osd crush create-or-move", "id": 47, "weight":3.6396, "args":
> >>> > >>>>>>> ["host=SRV-SEKUARK8", "root=default"]}]: dispatch
> >>> > >>>>>>> 2018-10-03 14:03:21.538 7fe15eddb700  0
> >>> > >>>>>>> mon.SRV-SBKUARK14@0(leader).osd e72601 create-or-move crush item name
> >>> > >>>>>>> 'osd.47' initial_weight 3.6396 at location
> >>> > >>>>>>> {host=SRV-SEKUARK8,root=default}
> >>> > >>>>>>> 2018-10-03 14:03:22.250 7fe1615e0700  1
> >>> > >>>>>>> mon.SRV-SBKUARK14@0(leader).osd e72601 do_prune osdmap full prune
> >>> > >>>>>>> enabled
> >>> > >>>>>>> 
> >>> > >>>>>>> 
> >>> > >>>>>>> On Wed, Oct 3, 2018 at 3:16 PM Goktug Yildirim
> >>> > >>>>>>> <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Hi Sage,
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Thank you for your response. Now I am sure this incident is going to be resolved.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> The problem started when 7 server crashed same time and they came back after ~5 minutes.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Two of our 3 mon services were restarted in this crash. Since mon services are enabled they should be started nearly at the same time. I dont know if this makes any difference but some of the guys on IRC told it is required that they start in order not at the same time. Otherwise it could break things badly.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> After 9 days we still see 3400-3500 active+clear PG. But in the end we have so many STUCK request and our cluster can not heal itself.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> When we set noup flag, OSDs can catch up epoch easily. But when we unset the flag we see so many STUCKS and SLOW OPS in 1 hour.
> >>> > >>>>>>>> I/O load on all of my OSD disks are at around %95 utilization and never ends. CPU and RAM usage are OK.
> >>> > >>>>>>>> OSDs get stuck that we even can't run “ceph pg osd.0 query”.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Also we tried to change RBD pool replication size 2 to 1. Our goal was the eliminate older PG's and leaving cluster with good ones.
> >>> > >>>>>>>> With replication size=1 we saw "%13 PGS not active”. But it didn’t solve our problem.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Of course we have to save %100 of data. But we feel like even saving %50 of our data will be make us very happy right now.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is what happens when the cluster starts. I believe it explains the whole story very nicely.
> >>> > >>>>>>>> https://drive.google.com/file/d/1-HHuACyXkYt7e0soafQwAbWJP1qs8-u1/view?usp=sharing
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is our ceph.conf:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/8sQhfPDXnW/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is the output of "osd stat && osd epochs && ceph -s && ceph health”:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/g5t8xnrjjZ/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is pg dump:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/zYqsN5T95h/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is iostat & perf top:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/Pgf3mcXXX8/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This strace output of ceph-osd:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/YCdtfh5qX8/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is OSD log (default debug):
> >>> > >>>>>>>> https://paste.ubuntu.com/p/Z2JrrBzzkM/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is leader MON log (default debug):
> >>> > >>>>>>>> https://paste.ubuntu.com/p/RcGmsVKmzG/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> These are OSDs failed to start. Total number is 58.
> >>> > >>>>>>>> https://paste.ubuntu.com/p/ZfRD5ZtvpS/
> >>> > >>>>>>>> https://paste.ubuntu.com/p/pkRdVjCH4D/
> >>> > >>>>>>>> https://paste.ubuntu.com/p/zJTf2fzSj9/
> >>> > >>>>>>>> https://paste.ubuntu.com/p/xpJRK6YhRX/
> >>> > >>>>>>>> https://paste.ubuntu.com/p/SY3576dNbJ/
> >>> > >>>>>>>> https://paste.ubuntu.com/p/smyT6Y976b/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is OSD video with debug osd = 20 and debug ms = 1 and debug_filestore = 20.
> >>> > >>>>>>>> https://drive.google.com/file/d/1UHHocK3Wy8pVpgZ4jV8Rl1z7rqK3bcJi/view?usp=sharing
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is OSD logfile with debug osd = 20 and debug ms = 1 and debug_filestore = 20.
> >>> > >>>>>>>> https://drive.google.com/file/d/1gH5Z0dUe36jM8FaulahEL36sxXrhORWI/view?usp=sharing
> >>> > >>>>>>>> 
> >>> > >>>>>>>> As far as I understand OSD catchs up with the mon epoch and exceeds mon epoch somehow??
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66c0bf9700 20 osd.150 72642 mkpg 66.f8 e60196@2018-09-28 23:57:08.251119
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66c0bf9700 10 osd.150 72642 build_initial_pg_history 66.f8 created 60196
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66c0bf9700 20 osd.150 72642 get_map 60196 - loading and decoding 0x19da8400
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process 66.d8 to_process <> waiting <> waiting_peering {}
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642 epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642) queued
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process 66.d8 to_process <OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642 epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642)> waiting <> waiting_peering {}
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process OpQueueItem(66.d8 PGPeeringEvent(epoch_sent: 72642 epoch_requested: 72642 NullEvt +create_info) prio 255 cost 10 e72642) pg 0xb579400
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 osd.150 pg_epoch: 72642 pg[66.d8( v 39934'8971934 (38146'8968839,39934'8971934] local-lis/les=72206/72212 n=2206 ec=50786/50786 lis/c 72206/72206 les/c/f 72212/72212/0 72642/72642/72642) [150] r=0 lpr=72642 pi=[72206,72642)/1 crt=39934'8971934 lcod 0'0 mlcod 0'0 peering mbc={} ps=[1~11]] do_peering_event: epoch_sent: 72642 epoch_requested: 72642 NullEvt +create_info
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 log is not dirty
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 10 osd.150 72642 queue_want_up_thru want 72642 <= queued 72642, currently 72206
> >>> > >>>>>>>> 2018-10-03 14:55:08.653 7f66a6bc5700 20 osd.150 op_wq(1) _process empty q, waiting
> >>> > >>>>>>>> 2018-10-03 14:55:08.665 7f66c0bf9700 10 osd.150 72642 add_map_bl 60196 50012 bytes
> >>> > >>>>>>>> 2018-10-03 14:55:08.665 7f66c0bf9700 20 osd.150 72642 get_map 60197 - loading and decoding 0x19da8880
> >>> > >>>>>>>> 2018-10-03 14:55:08.669 7f66c0bf9700 10 osd.150 72642 add_map_bl 60197 50012 bytes
> >>> > >>>>>>>> 2018-10-03 14:55:08.669 7f66c0bf9700 20 osd.150 72642 get_map 60198 - loading and decoding 0x19da9180
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> On 3 Oct 2018, at 05:14, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> osd_find_best_info_ignore_history_les is a dangerous option and you should
> >>> > >>>>>>>> only use it in very specific circumstances when directed by a developer.
> >>> > >>>>>>>> In such cases it will allow a stuck PG to peer.  But you're not getting to
> >>> > >>>>>>>> that point...you're seeing some sort of resource exhaustion.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> The noup trick works when OSDs are way behind on maps and all need to
> >>> > >>>>>>>> catch up.  The way to tell if they are behind is by looking at the 'ceph
> >>> > >>>>>>>> daemon osd.NNN status' output and comparing to the latest OSDMap epoch tha
> >>> > >>>>>>>> t the mons have.  Were they really caught up when you unset noup?
> >>> > >>>>>>>> 
> >>> > >>>>>>>> I'm just catching up and haven't read the whole thread but I haven't seen
> >>> > >>>>>>>> anything that explains why teh OSDs are dong lots of disk IO.  Catching up
> >>> > >>>>>>>> on maps could explain it but not why they wouldn't peer once they were all
> >>> > >>>>>>>> marked up...
> >>> > >>>>>>>> 
> >>> > >>>>>>>> sage
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> On Tue, 2 Oct 2018, Göktuğ Yıldırım wrote:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Anyone heart about osd_find_best_info_ignore_history_les = true ?
> >>> > >>>>>>>> Is that be usefull here? There is such a less information about it.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> şunları yazdı (2 Eki 2018 22:11):
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Hi,
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Indeed I left ceph-disk to decide the wal and db partitions when I read somewhere that that will do the proper sizing.
> >>> > >>>>>>>> For the blustore cache size I have plenty of RAM. I will increase 8GB for each and decide a more calculated number    after cluster settles.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> For the osd map loading I’ve also figured it out. And it is in loop. For that reason I started cluster with noup flag and waited OSDs to reach the uptodate epoch number. After that I unset noup. But I did not pay attention to manager logs. Let me check it, thank you!
> >>> > >>>>>>>> 
> >>> > >>>>>>>> I am not forcing jmellac or anything else really. I have a very standard installation and no tweaks or tunings. All we ask for the stability versus speed from the begining. And here we are :/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> On 2 Oct 2018, at 21:53, Darius Kasparavičius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Hi,
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> I can see some issues from the osd log file. You have an extremely low
> >>> > >>>>>>>> size db and wal partitions. Only 1GB for DB and 576MB for wal. I would
> >>> > >>>>>>>> recommend cranking up rocksdb cache size as much as possible. If you
> >>> > >>>>>>>> have RAM you can also increase bluestores cache size for hdd. Default
> >>> > >>>>>>>> is 1GB be as liberal as you can without getting OOM kills. You also
> >>> > >>>>>>>> have lots of osd map loading and decoding in the log. Are you sure all
> >>> > >>>>>>>> monitors/managers/osds are up to date? Plus make sure you aren't
> >>> > >>>>>>>> forcing jemalloc loading. I had a funny interaction after upgrading to
> >>> > >>>>>>>> mimic.
> >>> > >>>>>>>> On Tue, Oct 2, 2018 at 9:02 PM Goktug Yildirim
> >>> > >>>>>>>> <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Hello Darius,
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Thanks for reply!
> >>> > >>>>>>>> 
> >>> > >>>>>>>> The main problem is we can not query PGs. “ceph pg 67.54f query” does stucks and wait forever since OSD is unresponsive.
> >>> > >>>>>>>> We are certain that OSD gets unresponsive as soon as it UP. And we are certain that OSD responds again after its disk utilization stops.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> So we have a small test like that:
> >>> > >>>>>>>> * Stop all OSDs (168 of them)
> >>> > >>>>>>>> * Start OSD1. %95 osd disk utilization immediately starts. It takes 8 mins to finish. Only after that “ceph pg 67.54f query” works!
> >>> > >>>>>>>> * While OSD1 is “up" start OSD2. As soon as OSD2 starts OSD1 & OSD2 starts %95 disk utilization. This takes 17 minutes to finish.
> >>> > >>>>>>>> * Now start OSD3 and it is the same. All OSDs start high I/O and it takes 25 mins to settle.
> >>> > >>>>>>>> * If you happen to start 5 of them at the same all of the OSDs start high I/O again. And it takes 1 hour to finish.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> So in the light of these findings we flagged noup, started all OSDs. At first there was no I/O. After 10 minutes we unset noup. All of 168 OSD started to make high I/O. And we thought that if we wait long enough it will finish & OSDs will be responsive again. After 24hours they did not because I/O did not finish or even slowed down.
> >>> > >>>>>>>> One can think that is a lot of data there to scan. But it is just 33TB.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> So at short we dont know which PG is stuck so we can remove it.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> However we met an weird thing half an hour ago. We exported the same PG from two different OSDs. One was 4.2GB and the other is 500KB! So we decided to export all OSDs for backup. Then we will delete strange sized ones and start the cluster all over. Maybe then we could solve the stucked or unfound PGs as you advise.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Any thought would be greatly appreciated.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> On 2 Oct 2018, at 18:16, Darius Kasparavičius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Hello,
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Currently you have 15 objects missing. I would recommend finding them
> >>> > >>>>>>>> and making backups of them. Ditch all other osds that are failing to
> >>> > >>>>>>>> start and concentrate on bringing online those that have missing
> >>> > >>>>>>>> objects. Then slowly turn off nodown and noout on the cluster and see
> >>> > >>>>>>>> if it stabilises. If it stabilises leave these setting if not turn
> >>> > >>>>>>>> them back on.
> >>> > >>>>>>>> Now get some of the pg's that are blocked and querry the pgs to check
> >>> > >>>>>>>> why they are blocked. Try removing as much blocks as possible and then
> >>> > >>>>>>>> remove the norebalance/norecovery flags and see if it starts to fix
> >>> > >>>>>>>> itself. On Tue, Oct 2, 2018 at 5:14 PM by morphin
> >>> > >>>>>>>> <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> One of ceph experts indicated that bluestore is somewhat preview tech
> >>> > >>>>>>>> (as for Redhat).
> >>> > >>>>>>>> So it could be best to checkout bluestore and rocksdb. There are some
> >>> > >>>>>>>> tools to check health and also repair. But there are limited
> >>> > >>>>>>>> documentation.
> >>> > >>>>>>>> Anyone who has experince with it?
> >>> > >>>>>>>> Anyone lead/help to a proper check would be great.
> >>> > >>>>>>>> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 1 Eki 2018 Pzt, 22:55
> >>> > >>>>>>>> tarihinde şunu yazdı:
> >>> > >>>>>>>> 
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Hi all,
> >>> > >>>>>>>> 
> >>> > >>>>>>>> We have recently upgraded from luminous to mimic. It’s been 6 days since this cluster is offline. The long short story is here: http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/030078.html
> >>> > >>>>>>>> 
> >>> > >>>>>>>> I’ve also CC’ed developers since I believe this is a bug. If this is not to correct way I apology and please let me know.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> For the 6 days lots of thing happened and there were some outcomes about the problem. Some of them was misjudged and some of them are not looked deeper.
> >>> > >>>>>>>> However the most certain diagnosis is this: each OSD causes very high disk I/O to its bluestore disk (WAL and DB are fine). After that OSDs become unresponsive or very very less responsive. For example "ceph tell osd.x version” stucks like for ever.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> So due to unresponsive OSDs cluster does not settle. This is our problem!
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is the one we are very sure of. But we are not sure of the reason.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Here is the latest ceph status:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/2DyZ5YqPjh/.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This is the status after we started all of the OSDs 24 hours ago.
> >>> > >>>>>>>> Some of the OSDs are not started. However it didnt make any difference when all of them was online.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Here is the debug=20 log of an OSD which is same for all others:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/8n2kTvwnG6/
> >>> > >>>>>>>> As we figure out there is a loop pattern. I am sure it wont caught from eye.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> This the full log the same OSD.
> >>> > >>>>>>>> https://www.dropbox.com/s/pwzqeajlsdwaoi1/ceph-osd.90.log?dl=0
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Here is the strace of the same OSD process:
> >>> > >>>>>>>> https://paste.ubuntu.com/p/8n2kTvwnG6/
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Recently we hear more to uprade mimic. I hope none get hurts as we do. I am sure we have done lots of mistakes to let this happening. And this situation may be a example for other user and could be a potential bug for ceph developer.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Any help to figure out what is going on would be great.
> >>> > >>>>>>>> 
> >>> > >>>>>>>> Best Regards,
> >>> > >>>>>>>> Goktug Yildirim
> >>> > >>>>>>>> 
> >>> > >>>>>>>> _______________________________________________
> >>> > >>>>>>>> ceph-users mailing list
> >>> > >>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>> > >>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>> > >> 
> >>> > 
> >>> >
> 
--8323329-1887172461-1538595471=:31802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1887172461-1538595471=:31802--
