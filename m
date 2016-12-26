From: Orit Wasserman <owasserm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: radosgw setup issue
Date: Mon, 26 Dec 2016 12:48:35 +0200
Message-ID: <CABo9giQ7cEU9uuvBWQL_t-t6NhbG718k3S3t0bRfSQx73qDJFA@mail.gmail.com>
References: <A52F455C-9B88-4B90-9703-50F50D99B53A@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <A52F455C-9B88-4B90-9703-50F50D99B53A-Iz5qeGvAONRWk0Htik3J/w@public.gmane.org>
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

On Fri, Dec 23, 2016 at 3:42 AM, Kamble, Nitin A
<Nitin.Kamble-f0WWck5Ay29Wk0Htik3J/w@public.gmane.org> wrote:
> I am trying to setup radosgw on a ceph cluster, and I am seeing some issues where google is not helping. I hope some of the developers would be able to help here.
>
>
> I tried to create radosgw as mentioned here [0] on a jewel cluster. And it gives the following error in log file after starting radosgw.
>
>
> 2016-12-22 17:36:46.755786 7f084beeb9c0  0 set uid:gid to 167:167 (ceph:ceph)
> 2016-12-22 17:36:46.755849 7f084beeb9c0  0 ceph version 10.2.2-118-g894a5f8 (894a5f8d878d4b267f80b90a4bffce157f2b4ba7), process radosgw, pid 10092
> 2016-12-22 17:36:46.763821 7f084beeb9c0  1 -- :/0 messenger.start
> 2016-12-22 17:36:46.764731 7f084beeb9c0  1 -- :/1011033520 --> 39.0.16.7:6789/0 -- auth(proto 0 40 bytes epoch 0) v1 -- ?+0 0x7f084c8e9f60 con 0x7f084c8e9480
> 2016-12-22 17:36:46.765055 7f084beda700  1 -- 39.0.16.9:0/1011033520 learned my addr 39.0.16.9:0/1011033520
> 2016-12-22 17:36:46.765492 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 1 ==== mon_map magic: 0 v1 ==== 195+0+0 (146652916 0 0) 0x7f0814000a60 con 0x7f084c8e9480
> 2016-12-22 17:36:46.765562 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 2 ==== auth_reply(proto 2 0 (0) Success) v1 ==== 33+0+0 (1206278719 0 0) 0x7f0814000ee0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.765697 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0 0x7f08180013b0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.765968 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 3 ==== auth_reply(proto 2 0 (0) Success) v1 ==== 222+0+0 (4230455906 0 0) 0x7f0814000ee0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.766053 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- auth(proto 2 181 bytes epoch 0) v1 -- ?+0 0x7f0818001830 con 0x7f084c8e9480
> 2016-12-22 17:36:46.766315 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 4 ==== auth_reply(proto 2 0 (0) Success) v1 ==== 425+0+0 (3179848142 0 0) 0x7f0814001180 con 0x7f084c8e9480
> 2016-12-22 17:36:46.766383 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0 0x7f084c8ea440 con 0x7f084c8e9480
> 2016-12-22 17:36:46.766452 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_subscribe({osdmap=0}) v2 -- ?+0 0x7f084c8ea440 con 0x7f084c8e9480
> 2016-12-22 17:36:46.766518 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 5 ==== mon_map magic: 0 v1 ==== 195+0+0 (146652916 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.766671 7f08227fc700  2 RGWDataChangesLog::ChangesRenewThread: start
> 2016-12-22 17:36:46.766691 7f084beeb9c0 20 get_system_obj_state: rctx=0x7ffec2850d00 obj=.rgw.root:default.realm state=0x7f084c8efdf8 s->prefetch_data=0
> 2016-12-22 17:36:46.766750 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 6 ==== osd_map(9506..9506 src has 8863..9506) v3 ==== 66915+0+0 (689048617 0 0) 0x7f0814011680 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767029 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=1) v1 -- ?+0 0x7f084c8f05f0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767163 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 7 ==== mon_get_version_reply(handle=1 version=9506) v2 ==== 24+0+0 (2817198406 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767214 7f084beeb9c0 20 get_system_obj_state: rctx=0x7ffec2850210 obj=.rgw.root:default.realm state=0x7f084c8efdf8 s->prefetch_data=0
> 2016-12-22 17:36:46.767231 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=2) v1 -- ?+0 0x7f084c8f0ac0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767341 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 8 ==== mon_get_version_reply(handle=2 version=9506) v2 ==== 24+0+0 (1826043941 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767367 7f084beeb9c0 10 could not read realm id: (2) No such file or directory
> 2016-12-22 17:36:46.767390 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=3) v1 -- ?+0 0x7f084c8efe50 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767496 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 9 ==== mon_get_version_reply(handle=3 version=9506) v2 ==== 24+0+0 (3600349867 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767518 7f084beeb9c0 10 failed to list objects pool_iterate_begin() returned r=-2
> 2016-12-22 17:36:46.767542 7f084beeb9c0 20 get_system_obj_state: rctx=0x7ffec2850420 obj=.rgw.root:zone_names.default state=0x7f084c8f0f38 s->prefetch_data=0
> 2016-12-22 17:36:46.767554 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=4) v1 -- ?+0 0x7f084c8f1630 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767660 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 10 ==== mon_get_version_reply(handle=4 version=9506) v2 ==== 24+0+0 (4282592274 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767685 7f084beeb9c0  0 error in read_id for id  : (2) No such file or directory
> 2016-12-22 17:36:46.767700 7f084beeb9c0 20 get_system_obj_state: rctx=0x7ffec2850ed0 obj=.rgw.root:region_map state=0x7f084c8f0f38 s->prefetch_data=0
> 2016-12-22 17:36:46.767715 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=5) v1 -- ?+0 0x7f084c8f1c10 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767830 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 11 ==== mon_get_version_reply(handle=5 version=9506) v2 ==== 24+0+0 (1158475420 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767855 7f084beeb9c0 10  cannot find current period zonegroup using local zonegroup
> 2016-12-22 17:36:46.767868 7f084beeb9c0 20 get_system_obj_state: rctx=0x7ffec2850880 obj=.rgw.root:default.realm state=0x7f084c8f0f38 s->prefetch_data=0
> 2016-12-22 17:36:46.767880 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=6) v1 -- ?+0 0x7f084c8f21f0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.767983 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 12 ==== mon_get_version_reply(handle=6 version=9506) v2 ==== 24+0+0 (2385567743 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768007 7f084beeb9c0 10 could not read realm id: (2) No such file or directory
> 2016-12-22 17:36:46.768014 7f084beeb9c0 10 Creating default zonegroup
> 2016-12-22 17:36:46.768034 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=7) v1 -- ?+0 0x7f084c8f1080 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768142 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 13 ==== mon_get_version_reply(handle=7 version=9506) v2 ==== 24+0+0 (880745841 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768167 7f084beeb9c0 10 couldn't find old data placement pools config, setting up new ones for the zone
> 2016-12-22 17:36:46.768190 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=8) v1 -- ?+0 0x7f084c8f26c0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768293 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 14 ==== mon_get_version_reply(handle=8 version=9506) v2 ==== 24+0+0 (3716641421 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768314 7f084beeb9c0 10 failed to list objects pool_iterate_begin() returned r=-2
> 2016-12-22 17:36:46.768320 7f084beeb9c0 10 WARNING: store->list_zones() returned r=-2
> 2016-12-22 17:36:46.768346 7f084beeb9c0 20 get_system_obj_state: rctx=0x7ffec2850400 obj=.rgw.root:zone_names.default state=0x7f084c8f2b38 s->prefetch_data=0
> 2016-12-22 17:36:46.768362 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=9) v1 -- ?+0 0x7f084c8f3140 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768463 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 15 ==== mon_get_version_reply(handle=9 version=9506) v2 ==== 24+0+0 (1741205507 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768578 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_get_version(what=osdmap handle=10) v1 -- ?+0 0x7f084c8f2aa0 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768681 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 16 ==== mon_get_version_reply(handle=10 version=9506) v2 ==== 24+0+0 (2901705056 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:46.768724 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- pool_op(create pool 0 auid 0 tid 1 name .rgw.root v0) v4 -- ?+0 0x7f084c8f4520 con 0x7f084c8e9480
> 2016-12-22 17:36:47.052029 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 17 ==== pool_op_reply(tid 1 (34) Numerical result out of range v9507) v1 ==== 43+0+0 (366377631 0 0) 0x7f0814001110 con 0x7f084c8e9480

what filesystem are you using? we longer support ext4
Another option is version mismatch between rgw and the ods

Orit

> 2016-12-22 17:36:47.052067 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 --> 39.0.16.7:6789/0 -- mon_subscribe({osdmap=9507}) v2 -- ?+0 0x7f0818022bb0 con 0x7f084c8e9480
> 2016-12-22 17:36:47.055809 7f082a7fc700  1 -- 39.0.16.9:0/1011033520 <== mon.0 39.0.16.7:6789/0 18 ==== osd_map(9507..9507 src has 8863..9507) v3 ==== 214+0+0 (1829214220 0 0) 0x7f0814001110 con 0x7f084c8e9480
> 2016-12-22 17:36:47.055858 7f084beeb9c0  0 ERROR:  storing info for 84f3cdd9-71d9-4d74-a6ba-c0e87d776a2b: (34) Numerical result out of range
> 2016-12-22 17:36:47.055869 7f084beeb9c0  0 create_default: error in create_default  zone params: (34) Numerical result out of range
> 2016-12-22 17:36:47.055876 7f084beeb9c0  0 failure in zonegroup create_default: ret -34 (34) Numerical result out of range
> 2016-12-22 17:36:47.055970 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 mark_down 0x7f084c8e9480 -- 0x7f084c8ec0f0
> 2016-12-22 17:36:47.056169 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 mark_down_all
> 2016-12-22 17:36:47.056263 7f084beeb9c0  1 -- 39.0.16.9:0/1011033520 shutdown complete.
> 2016-12-22 17:36:47.056426 7f084beeb9c0 -1 Couldn't init storage provider (RADOS)
>
>
>
> I did not create the pools for rgw, as they get created automatically. few weeks back, I could setup RGW on jewel successfully. But this time I am not able to see any obvious issues which I can fix.
>
>
> [0] http://docs.ceph.com/docs/jewel/radosgw/config/
>
> Thanks in advance,
> Nitin
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
