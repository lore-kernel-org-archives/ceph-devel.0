From: Brian Andrus <brian.andrus-OZUH0SiS3Izby3iVrkZq2A@public.gmane.org>
Subject: Re: radosgw setup issue
Date: Wed, 4 Jan 2017 09:08:43 -0800
Message-ID: <CAANaFCxfKp3CTdBYxJjY7TnfZkzNkYuw6nBv2YYg5i0GjSKSYg@mail.gmail.com>
References: <A52F455C-9B88-4B90-9703-50F50D99B53A@Teradata.com>
	<CABo9giQ7cEU9uuvBWQL_t-t6NhbG718k3S3t0bRfSQx73qDJFA@mail.gmail.com>
	<EA0DF2D0-82D9-4ACB-AB57-EB41B1F3296C@Teradata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0629358209=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <EA0DF2D0-82D9-4ACB-AB57-EB41B1F3296C-Iz5qeGvAONRWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Kamble, Nitin A" <Nitin.Kamble-f0WWck5Ay29Wk0Htik3J/w@public.gmane.org>
Cc: Squid Cybernetic <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0629358209==
Content-Type: multipart/alternative; boundary=001a114ac30e4e5f9e054547d650

--001a114ac30e4e5f9e054547d650
Content-Type: text/plain; charset=UTF-8

Regardless of whether it worked before, have you verified your RadosGWs
have write access to monitors? They will need it if you want the RadosGW to
create its own pools.

ceph auth get <client.radosgwID>

On Wed, Jan 4, 2017 at 8:59 AM, Kamble, Nitin A <Nitin.Kamble-f0WWck5Ay29Wk0Htik3J/w@public.gmane.org>
wrote:

>
> > On Dec 26, 2016, at 2:48 AM, Orit Wasserman <owasserm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > On Fri, Dec 23, 2016 at 3:42 AM, Kamble, Nitin A
> > <Nitin.Kamble-f0WWck5Ay29Wk0Htik3J/w@public.gmane.org> wrote:
> >> I am trying to setup radosgw on a ceph cluster, and I am seeing some
> issues where google is not helping. I hope some of the developers would be
> able to help here.
> >>
> >>
> >> I tried to create radosgw as mentioned here [0] on a jewel cluster. And
> it gives the following error in log file after starting radosgw.
> >>
> >>
> >> 2016-12-22 17:36:46.755786 7f084beeb9c0  0 set uid:gid to 167:167
> (ceph:ceph)
> >> 2016-12-22 17:36:46.755849 7f084beeb9c0  0 ceph version
> 10.2.2-118-g894a5f8 (894a5f8d878d4b267f80b90a4bffce157f2b4ba7), process
> radosgw, pid 10092
> >> 2016-12-22 17:36:46.763821 7f084beeb9c0  1 -- :/0 messenger.start
> >> 2016-12-22 17:36:46.764731 7f084beeb9c0  1 -- :/1011033520 -->
> 39.0.16.7:6789/0 -- auth(proto 0 40 bytes epoch 0) v1 -- ?+0
> 0x7f084c8e9f60 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.765055 7f084beda700  1 -- 39.0.16.9:0/1011033520
> learned my addr 39.0.16.9:0/1011033520
> >> 2016-12-22 17:36:46.765492 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 1 ==== mon_map magic: 0 v1 ==== 195+0+0
> (146652916 0 0) 0x7f0814000a60 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.765562 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 2 ==== auth_reply(proto 2 0 (0) Success) v1
> ==== 33+0+0 (1206278719 0 0) 0x7f0814000ee0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.765697 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0
> 0x7f08180013b0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.765968 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 3 ==== auth_reply(proto 2 0 (0) Success) v1
> ==== 222+0+0 (4230455906 0 0) 0x7f0814000ee0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.766053 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- auth(proto 2 181 bytes epoch 0) v1 -- ?+0
> 0x7f0818001830 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.766315 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 4 ==== auth_reply(proto 2 0 (0) Success) v1
> ==== 425+0+0 (3179848142 0 0) 0x7f0814001180 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.766383 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0
> 0x7f084c8ea440 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.766452 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_subscribe({osdmap=0}) v2 -- ?+0
> 0x7f084c8ea440 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.766518 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 5 ==== mon_map magic: 0 v1 ==== 195+0+0
> (146652916 0 0) 0x7f0814001110 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.766671 7f08227fc700  2 RGWDataChangesLog::ChangesRenewThread:
> start
> >> 2016-12-22 17:36:46.766691 7f084beeb9c0 20 get_system_obj_state:
> rctx=0x7ffec2850d00 obj=.rgw.root:default.realm state=0x7f084c8efdf8
> s->prefetch_data=0
> >> 2016-12-22 17:36:46.766750 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 6 ==== osd_map(9506..9506 src has 8863..9506)
> v3 ==== 66915+0+0 (689048617 0 0) 0x7f0814011680 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767029 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=1) v1 -- ?+0
> 0x7f084c8f05f0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767163 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 7 ==== mon_get_version_reply(handle=1
> version=9506) v2 ==== 24+0+0 (2817198406 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767214 7f084beeb9c0 20 get_system_obj_state:
> rctx=0x7ffec2850210 obj=.rgw.root:default.realm state=0x7f084c8efdf8
> s->prefetch_data=0
> >> 2016-12-22 17:36:46.767231 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=2) v1 -- ?+0
> 0x7f084c8f0ac0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767341 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 8 ==== mon_get_version_reply(handle=2
> version=9506) v2 ==== 24+0+0 (1826043941 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767367 7f084beeb9c0 10 could not read realm id: (2)
> No such file or directory
> >> 2016-12-22 17:36:46.767390 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=3) v1 -- ?+0
> 0x7f084c8efe50 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767496 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 9 ==== mon_get_version_reply(handle=3
> version=9506) v2 ==== 24+0+0 (3600349867 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767518 7f084beeb9c0 10 failed to list objects
> pool_iterate_begin() returned r=-2
> >> 2016-12-22 17:36:46.767542 7f084beeb9c0 20 get_system_obj_state:
> rctx=0x7ffec2850420 obj=.rgw.root:zone_names.default state=0x7f084c8f0f38
> s->prefetch_data=0
> >> 2016-12-22 17:36:46.767554 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=4) v1 -- ?+0
> 0x7f084c8f1630 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767660 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 10 ==== mon_get_version_reply(handle=4
> version=9506) v2 ==== 24+0+0 (4282592274 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767685 7f084beeb9c0  0 error in read_id for id  :
> (2) No such file or directory
> >> 2016-12-22 17:36:46.767700 7f084beeb9c0 20 get_system_obj_state:
> rctx=0x7ffec2850ed0 obj=.rgw.root:region_map state=0x7f084c8f0f38
> s->prefetch_data=0
> >> 2016-12-22 17:36:46.767715 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=5) v1 -- ?+0
> 0x7f084c8f1c10 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767830 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 11 ==== mon_get_version_reply(handle=5
> version=9506) v2 ==== 24+0+0 (1158475420 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767855 7f084beeb9c0 10  cannot find current period
> zonegroup using local zonegroup
> >> 2016-12-22 17:36:46.767868 7f084beeb9c0 20 get_system_obj_state:
> rctx=0x7ffec2850880 obj=.rgw.root:default.realm state=0x7f084c8f0f38
> s->prefetch_data=0
> >> 2016-12-22 17:36:46.767880 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=6) v1 -- ?+0
> 0x7f084c8f21f0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.767983 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 12 ==== mon_get_version_reply(handle=6
> version=9506) v2 ==== 24+0+0 (2385567743 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768007 7f084beeb9c0 10 could not read realm id: (2)
> No such file or directory
> >> 2016-12-22 17:36:46.768014 7f084beeb9c0 10 Creating default zonegroup
> >> 2016-12-22 17:36:46.768034 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=7) v1 -- ?+0
> 0x7f084c8f1080 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768142 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 13 ==== mon_get_version_reply(handle=7
> version=9506) v2 ==== 24+0+0 (880745841 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768167 7f084beeb9c0 10 couldn't find old data
> placement pools config, setting up new ones for the zone
> >> 2016-12-22 17:36:46.768190 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=8) v1 -- ?+0
> 0x7f084c8f26c0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768293 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 14 ==== mon_get_version_reply(handle=8
> version=9506) v2 ==== 24+0+0 (3716641421 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768314 7f084beeb9c0 10 failed to list objects
> pool_iterate_begin() returned r=-2
> >> 2016-12-22 17:36:46.768320 7f084beeb9c0 10 WARNING: store->list_zones()
> returned r=-2
> >> 2016-12-22 17:36:46.768346 7f084beeb9c0 20 get_system_obj_state:
> rctx=0x7ffec2850400 obj=.rgw.root:zone_names.default state=0x7f084c8f2b38
> s->prefetch_data=0
> >> 2016-12-22 17:36:46.768362 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=9) v1 -- ?+0
> 0x7f084c8f3140 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768463 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 15 ==== mon_get_version_reply(handle=9
> version=9506) v2 ==== 24+0+0 (1741205507 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768578 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=10) v1 -- ?+0
> 0x7f084c8f2aa0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768681 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 16 ==== mon_get_version_reply(handle=10
> version=9506) v2 ==== 24+0+0 (2901705056 0 0) 0x7f0814001110 con
> 0x7f084c8e9480
> >> 2016-12-22 17:36:46.768724 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- pool_op(create pool 0 auid 0 tid 1 name .rgw.root
> v0) v4 -- ?+0 0x7f084c8f4520 con 0x7f084c8e9480
> >> 2016-12-22 17:36:47.052029 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 17 ==== pool_op_reply(tid 1 (34) Numerical
> result out of range v9507) v1 ==== 43+0+0 (366377631 0 0) 0x7f0814001110
> con 0x7f084c8e9480
> >
>
> Thanks for the response Orit.
>
> > what filesystem are you using? we longer support ext4
>
> OSDs are using XFS for Filestore.
>
> > Another option is version mismatch between rgw and the ods.
>
> Exact same version of ceph binaries are installed on OSD, MON and RGW
> nodes.
>
> Is there anything useful in the error messages?
>
> 2016-12-22 17:36:46.768314 7f084beeb9c0 10 failed to list objects
> pool_iterate_begin() returned r=-2
> 2016-12-22 17:36:46.768320 7f084beeb9c0 10 WARNING: store->list_zones()
> returned r=-2
>
> Is this the point where the failure has begun?
>
> As I see, the basic issue is, RGW is not able to create the needed pools
> on demand. I wish there was more detailed output regarding the Numerical
> result out of range issue.
> I am suspecting it may be related to the set of defaults used while
> creating pools automatically. Possibly the default crush rule.
>
> Thanks,
> Nitin
>
> >
> > Orit
> >
> >> 2016-12-22 17:36:47.052067 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> --> 39.0.16.7:6789/0 -- mon_subscribe({osdmap=9507}) v2 -- ?+0
> 0x7f0818022bb0 con 0x7f084c8e9480
> >> 2016-12-22 17:36:47.055809 7f082a7fc700  1 -- 39.0.16.9:0/1011033520
> <== mon.0 39.0.16.7:6789/0 18 ==== osd_map(9507..9507 src has 8863..9507)
> v3 ==== 214+0+0 (1829214220 0 0) 0x7f0814001110 con 0x7f084c8e9480
> >> 2016-12-22 17:36:47.055858 7f084beeb9c0  0 ERROR:  storing info for
> 84f3cdd9-71d9-4d74-a6ba-c0e87d776a2b: (34) Numerical result out of range
> >> 2016-12-22 17:36:47.055869 7f084beeb9c0  0 create_default: error in
> create_default  zone params: (34) Numerical result out of range
> >> 2016-12-22 17:36:47.055876 7f084beeb9c0  0 failure in zonegroup
> create_default: ret -34 (34) Numerical result out of range
> >> 2016-12-22 17:36:47.055970 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> mark_down 0x7f084c8e9480 -- 0x7f084c8ec0f0
> >> 2016-12-22 17:36:47.056169 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> mark_down_all
> >> 2016-12-22 17:36:47.056263 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520
> shutdown complete.
> >> 2016-12-22 17:36:47.056426 7f084beeb9c0 -1 Couldn't init storage
> provider (RADOS)
> >>
> >>
> >>
> >> I did not create the pools for rgw, as they get created automatically.
> few weeks back, I could setup RGW on jewel successfully. But this time I am
> not able to see any obvious issues which I can fix.
> >>
> >>
> >> [0] http://docs.ceph.com/docs/jewel/radosgw/config/
> >>
> >> Thanks in advance,
> >> Nitin
> >>
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Brian Andrus
Cloud Systems Engineer
DreamHost, LLC

--001a114ac30e4e5f9e054547d650
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Regardless of whether it worked before, have you verified =
your RadosGWs have write access to monitors? They will need it if you want =
the RadosGW to create its own pools.<div><br></div><div>ceph auth get &lt;c=
lient.radosgwID&gt;</div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Wed, Jan 4, 2017 at 8:59 AM, Kamble, Nitin A <span dir=3D"=
ltr">&lt;<a href=3D"mailto:Nitin.Kamble-f0WWck5Ay29Wk0Htik3J/w@public.gmane.org" target=3D"_blank">Nit=
in.Kamble-f0WWck5Ay29Wk0Htik3J/w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; On Dec 26, 2016, at 2:48 AM, Orit Wasserman &lt;<a href=3D"mailto:owas=
serm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">owasserm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Dec 23, 2016 at 3:42 AM, Kamble, Nitin A<br>
&gt; &lt;<a href=3D"mailto:Nitin.Kamble-f0WWck5Ay29Wk0Htik3J/w@public.gmane.org">Nitin.Kamble@teradata=
.com</a>&gt; wrote:<br>
&gt;&gt; I am trying to setup radosgw on a ceph cluster, and I am seeing so=
me issues where google is not helping. I hope some of the developers would =
be able to help here.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I tried to create radosgw as mentioned here [0] on a jewel cluster=
. And it gives the following error in log file after starting radosgw.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; 2016-12-22 17:36:46.755786 7f084beeb9c0=C2=A0 0 set uid:gid to 167=
:167 (ceph:ceph)<br>
&gt;&gt; 2016-12-22 17:36:46.755849 7f084beeb9c0=C2=A0 0 ceph version 10.2.=
2-118-g894a5f8 (<wbr>894a5f8d878d4b267f80b90a4bffce<wbr>157f2b4ba7), proces=
s radosgw, pid 10092<br>
&gt;&gt; 2016-12-22 17:36:46.763821 7f084beeb9c0=C2=A0 1 -- :/0 messenger.s=
tart<br>
&gt;&gt; 2016-12-22 17:36:46.764731 7f084beeb9c0=C2=A0 1 -- :/1011033520 --=
&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferrer" target=3D"_blan=
k">39.0.16.7:6789/0</a> -- auth(proto 0 40 bytes epoch 0) v1 -- ?+0 0x7f084=
c8e9f60 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.765055 7f084beda700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> learned my addr <a href=3D"http://39.0.16.9:0/1011033520" r=
el=3D"noreferrer" target=3D"_blank">39.0.16.9:0/1011033520</a><br>
&gt;&gt; 2016-12-22 17:36:46.765492 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 1 =3D=3D=3D=3D mon_map =
magic: 0 v1 =3D=3D=3D=3D 195+0+0 (146652916 0 0) 0x7f0814000a60 con 0x7f084=
c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.765562 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 2 =3D=3D=3D=3D auth_rep=
ly(proto 2 0 (0) Success) v1 =3D=3D=3D=3D 33+0+0 (1206278719 0 0) 0x7f08140=
00ee0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.765697 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- auth(proto 2 32 bytes epoch 0)=
 v1 -- ?+0 0x7f08180013b0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.765968 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 3 =3D=3D=3D=3D auth_rep=
ly(proto 2 0 (0) Success) v1 =3D=3D=3D=3D 222+0+0 (4230455906 0 0) 0x7f0814=
000ee0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.766053 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- auth(proto 2 181 bytes epoch 0=
) v1 -- ?+0 0x7f0818001830 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.766315 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 4 =3D=3D=3D=3D auth_rep=
ly(proto 2 0 (0) Success) v1 =3D=3D=3D=3D 425+0+0 (3179848142 0 0) 0x7f0814=
001180 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.766383 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_subscribe({monmap=3D0+}) v=
2 -- ?+0 0x7f084c8ea440 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.766452 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_subscribe({osdmap=3D0}) v2=
 -- ?+0 0x7f084c8ea440 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.766518 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 5 =3D=3D=3D=3D mon_map =
magic: 0 v1 =3D=3D=3D=3D 195+0+0 (146652916 0 0) 0x7f0814001110 con 0x7f084=
c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.766671 7f08227fc700=C2=A0 2 RGWDataChangesLog:=
:<wbr>ChangesRenewThread: start<br>
&gt;&gt; 2016-12-22 17:36:46.766691 7f084beeb9c0 20 get_system_obj_state: r=
ctx=3D0x7ffec2850d00 obj=3D.rgw.root:default.realm state=3D0x7f084c8efdf8 s=
-&gt;prefetch_data=3D0<br>
&gt;&gt; 2016-12-22 17:36:46.766750 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 6 =3D=3D=3D=3D osd_map(=
9506..9506 src has 8863..9506) v3 =3D=3D=3D=3D 66915+0+0 (689048617 0 0) 0x=
7f0814011680 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767029 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D1) v1 -- ?+0 0x7f084c8f05f0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767163 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 7 =3D=3D=3D=3D mon_get_=
version_reply(handle=3D1 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 <a href=3D"=
tel:%282817198406" value=3D"+12817198406">(2817198406</a> 0 0) 0x7f08140011=
10 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767214 7f084beeb9c0 20 get_system_obj_state: r=
ctx=3D0x7ffec2850210 obj=3D.rgw.root:default.realm state=3D0x7f084c8efdf8 s=
-&gt;prefetch_data=3D0<br>
&gt;&gt; 2016-12-22 17:36:46.767231 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D2) v1 -- ?+0 0x7f084c8f0ac0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767341 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 8 =3D=3D=3D=3D mon_get_=
version_reply(handle=3D2 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (1826043941=
 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767367 7f084beeb9c0 10 could not read realm id=
: (2) No such file or directory<br>
&gt;&gt; 2016-12-22 17:36:46.767390 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D3) v1 -- ?+0 0x7f084c8efe50 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767496 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 9 =3D=3D=3D=3D mon_get_=
version_reply(handle=3D3 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (3600349867=
 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767518 7f084beeb9c0 10 failed to list objects =
pool_iterate_begin() returned r=3D-2<br>
&gt;&gt; 2016-12-22 17:36:46.767542 7f084beeb9c0 20 get_system_obj_state: r=
ctx=3D0x7ffec2850420 obj=3D.rgw.root:zone_names.<wbr>default state=3D0x7f08=
4c8f0f38 s-&gt;prefetch_data=3D0<br>
&gt;&gt; 2016-12-22 17:36:46.767554 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D4) v1 -- ?+0 0x7f084c8f1630 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767660 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 10 =3D=3D=3D=3D mon_get=
_version_reply(handle=3D4 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (428259227=
4 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767685 7f084beeb9c0=C2=A0 0 error in read_id f=
or id=C2=A0 : (2) No such file or directory<br>
&gt;&gt; 2016-12-22 17:36:46.767700 7f084beeb9c0 20 get_system_obj_state: r=
ctx=3D0x7ffec2850ed0 obj=3D.rgw.root:region_map state=3D0x7f084c8f0f38 s-&g=
t;prefetch_data=3D0<br>
&gt;&gt; 2016-12-22 17:36:46.767715 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D5) v1 -- ?+0 0x7f084c8f1c10 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767830 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 11 =3D=3D=3D=3D mon_get=
_version_reply(handle=3D5 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (115847542=
0 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767855 7f084beeb9c0 10=C2=A0 cannot find curre=
nt period zonegroup using local zonegroup<br>
&gt;&gt; 2016-12-22 17:36:46.767868 7f084beeb9c0 20 get_system_obj_state: r=
ctx=3D0x7ffec2850880 obj=3D.rgw.root:default.realm state=3D0x7f084c8f0f38 s=
-&gt;prefetch_data=3D0<br>
&gt;&gt; 2016-12-22 17:36:46.767880 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D6) v1 -- ?+0 0x7f084c8f21f0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.767983 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 12 =3D=3D=3D=3D mon_get=
_version_reply(handle=3D6 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (238556774=
3 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768007 7f084beeb9c0 10 could not read realm id=
: (2) No such file or directory<br>
&gt;&gt; 2016-12-22 17:36:46.768014 7f084beeb9c0 10 Creating default zonegr=
oup<br>
&gt;&gt; 2016-12-22 17:36:46.768034 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D7) v1 -- ?+0 0x7f084c8f1080 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768142 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 13 =3D=3D=3D=3D mon_get=
_version_reply(handle=3D7 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (880745841=
 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768167 7f084beeb9c0 10 couldn&#39;t find old d=
ata placement pools config, setting up new ones for the zone<br>
&gt;&gt; 2016-12-22 17:36:46.768190 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D8) v1 -- ?+0 0x7f084c8f26c0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768293 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 14 =3D=3D=3D=3D mon_get=
_version_reply(handle=3D8 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (371664142=
1 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768314 7f084beeb9c0 10 failed to list objects =
pool_iterate_begin() returned r=3D-2<br>
&gt;&gt; 2016-12-22 17:36:46.768320 7f084beeb9c0 10 WARNING: store-&gt;list=
_zones() returned r=3D-2<br>
&gt;&gt; 2016-12-22 17:36:46.768346 7f084beeb9c0 20 get_system_obj_state: r=
ctx=3D0x7ffec2850400 obj=3D.rgw.root:zone_names.<wbr>default state=3D0x7f08=
4c8f2b38 s-&gt;prefetch_data=3D0<br>
&gt;&gt; 2016-12-22 17:36:46.768362 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D9) v1 -- ?+0 0x7f084c8f3140 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768463 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 15 =3D=3D=3D=3D mon_get=
_version_reply(handle=3D9 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (174120550=
7 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768578 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_get_version(what=3Dosdmap =
handle=3D10) v1 -- ?+0 0x7f084c8f2aa0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768681 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 16 =3D=3D=3D=3D mon_get=
_version_reply(handle=3D<wbr>10 version=3D9506) v2 =3D=3D=3D=3D 24+0+0 (290=
1705056 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:46.768724 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- pool_op(create pool 0 auid 0 t=
id 1 name .rgw.root v0) v4 -- ?+0 0x7f084c8f4520 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:47.052029 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 17 =3D=3D=3D=3D pool_op=
_reply(tid 1 (34) Numerical result out of range v9507) v1 =3D=3D=3D=3D 43+0=
+0 (366377631 0 0) 0x7f0814001110 con 0x7f084c8e9480<br>
&gt;<br>
<br>
</div></div>Thanks for the response Orit.<br>
<span class=3D""><br>
&gt; what filesystem are you using? we longer support ext4<br>
<br>
</span>OSDs are using XFS for Filestore.<br>
<br>
&gt; Another option is version mismatch between rgw and the ods.<br>
<br>
Exact same version of ceph binaries are installed on OSD, MON and RGW nodes=
.<br>
<br>
Is there anything useful in the error messages?<br>
<span class=3D""><br>
2016-12-22 17:36:46.768314 7f084beeb9c0 10 failed to list objects pool_iter=
ate_begin() returned r=3D-2<br>
2016-12-22 17:36:46.768320 7f084beeb9c0 10 WARNING: store-&gt;list_zones() =
returned r=3D-2<br>
<br>
</span>Is this the point where the failure has begun?<br>
<br>
As I see, the basic issue is, RGW is not able to create the needed pools on=
 demand. I wish there was more detailed output regarding the Numerical resu=
lt out of range issue.<br>
I am suspecting it may be related to the set of defaults used while creatin=
g pools automatically. Possibly the default crush rule.<br>
<br>
Thanks,<br>
Nitin<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Orit<br>
&gt;<br>
&gt;&gt; 2016-12-22 17:36:47.052067 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> --&gt; <a href=3D"http://39.0.16.7:6789/0" rel=3D"noreferre=
r" target=3D"_blank">39.0.16.7:6789/0</a> -- mon_subscribe({osdmap=3D9507})=
 v2 -- ?+0 0x7f0818022bb0 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:47.055809 7f082a7fc700=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> &lt;=3D=3D mon.0 <a href=3D"http://39.0.16.7:6789/0" rel=3D=
"noreferrer" target=3D"_blank">39.0.16.7:6789/0</a> 18 =3D=3D=3D=3D osd_map=
(9507..9507 src has 8863..9507) v3 =3D=3D=3D=3D 214+0+0 (1829214220 0 0) 0x=
7f0814001110 con 0x7f084c8e9480<br>
&gt;&gt; 2016-12-22 17:36:47.055858 7f084beeb9c0=C2=A0 0 ERROR:=C2=A0 stori=
ng info for 84f3cdd9-71d9-4d74-a6ba-<wbr>c0e87d776a2b: (34) Numerical resul=
t out of range<br>
&gt;&gt; 2016-12-22 17:36:47.055869 7f084beeb9c0=C2=A0 0 create_default: er=
ror in create_default=C2=A0 zone params: (34) Numerical result out of range=
<br>
&gt;&gt; 2016-12-22 17:36:47.055876 7f084beeb9c0=C2=A0 0 failure in zonegro=
up create_default: ret -34 (34) Numerical result out of range<br>
&gt;&gt; 2016-12-22 17:36:47.055970 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> mark_down 0x7f084c8e9480 -- 0x7f084c8ec0f0<br>
&gt;&gt; 2016-12-22 17:36:47.056169 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> mark_down_all<br>
&gt;&gt; 2016-12-22 17:36:47.056263 7f084beeb9c0=C2=A0 1 -- <a href=3D"http=
://39.0.16.9:0/1011033520" rel=3D"noreferrer" target=3D"_blank">39.0.16.9:0=
/1011033520</a> shutdown complete.<br>
&gt;&gt; 2016-12-22 17:36:47.056426 7f084beeb9c0 -1 Couldn&#39;t init stora=
ge provider (RADOS)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I did not create the pools for rgw, as they get created automatica=
lly. few weeks back, I could setup RGW on jewel successfully. But this time=
 I am not able to see any obvious issues which I can fix.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; [0] <a href=3D"http://docs.ceph.com/docs/jewel/radosgw/config/" re=
l=3D"noreferrer" target=3D"_blank">http://docs.ceph.com/docs/<wbr>jewel/rad=
osgw/config/</a><br>
&gt;&gt;<br>
&gt;&gt; Thanks in advance,<br>
&gt;&gt; Nitin<br>
&gt;&gt;<br>
&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; ceph-users mailing list<br>
&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com</a><br>
&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"=
 rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.c=
gi/ceph-users-ceph.<wbr>com</a><br>
<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Brian Andrus<div>Cloud Systems Engineer</div><div>DreamHost, LLC</=
div></div></div>
</div>

--001a114ac30e4e5f9e054547d650--

--===============0629358209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0629358209==--
