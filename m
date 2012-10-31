From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 17:50:03 +0100 (CET)
Message-ID: <4087ac54-76fc-45c7-9c65-d6add134ccfc@mailpro>
References: <97eeb8be-85a7-4309-b02c-e5d4f5b0f151@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:48407 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab2JaQud convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 12:50:33 -0400
In-Reply-To: <97eeb8be-85a7-4309-b02c-e5d4f5b0f151@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Also, I have same results with 8K or 16K block size....

Don't know if it's help, here a extract of perf dump of 1 mon and 1 osd

ceph --admin-daemon ceph-mon.a.asok perf dump
{"cluster":{"num_mon":3,"num_mon_quorum":3,"num_osd":15,"num_osd_up":15=
,"num_osd_in":15,"osd_epoch":54,"osd_kb":2140015680,"osd_kb_used":62762=
4,"osd_kb_avail":2139388056,"num_pool":3,"num_pg":3072,"num_pg_active_c=
lean":3072,"num_pg_active":3072,"num_pg_peering":0,"num_object":3,"num_=
object_degraded":0,"num_object_unfound":0,"num_bytes":274,"num_mds_up":=
0,"num_mds_in":0,"num_mds_failed":0,"mds_epoch":1},"mon":{},"throttle-m=
on_client_bytes":{"val":0,"max":104857600,"get":8773,"get_sum":556770,"=
get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put"=
:8773,"put_sum":556770,"wait":{"avgcount":0,"sum":0}},"throttle-mon_dae=
mon_bytes":{"val":0,"max":419430400,"get":1308,"get_sum":1859977,"get_o=
r_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":1308=
,"put_sum":1859977,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispat=
ch_throttler-mon":{"val":0,"max":104857600,"get":76565,"get_sum":140663=
76,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"=
put":76565,"put_sum":14066376,"wait":{"avgcount":0,"sum":0}}}


 ceph --admin-daemon ceph-osd.1.asok perf dump
{"filestore":{"journal_queue_max_ops":500,"journal_queue_ops":0,"journa=
l_ops":2847,"journal_queue_max_bytes":104857600,"journal_queue_bytes":0=
,"journal_bytes":10502288,"journal_latency":{"avgcount":2847,"sum":3.55=
3},"journal_wr":1523,"journal_wr_bytes":{"avgcount":1523,"sum":31055872=
},"op_queue_max_ops":500,"op_queue_ops":0,"ops":2847,"op_queue_max_byte=
s":104857600,"op_queue_bytes":0,"bytes":10487898,"apply_latency":{"avgc=
ount":2847,"sum":114.43},"committing":0,"commitcycle":12,"commitcycle_i=
nterval":{"avgcount":12,"sum":60.1172},"commitcycle_latency":{"avgcount=
":12,"sum":0.116291},"journal_full":0},"osd":{"opq":0,"op_wip":0,"op":4=
8366,"op_in_bytes":3168,"op_out_bytes":198000640,"op_latency":{"avgcoun=
t":48366,"sum":71.4412},"op_r":48340,"op_r_out_bytes":198000640,"op_r_l=
atency":{"avgcount":48340,"sum":71.1109},"op_w":26,"op_w_in_bytes":3168=
,"op_w_rlat":{"avgcount":26,"sum":0.034785},"op_w_latency":{"avgcount":=
26,"sum":0.3303},"op_rw":0,"op_rw_in_bytes":0,"op_rw_out_bytes":0,"op_r=
w_rlat":{"avgcount":0,"sum":0},"op_rw_latency":{"avgcount":0,"sum":0},"=
subop":18,"subop_in_bytes":2281,"subop_latency":{"avgcount":18,"sum":0.=
011883},"subop_w":0,"subop_w_in_bytes":2281,"subop_w_latency":{"avgcoun=
t":18,"sum":0.011883},"subop_pull":0,"subop_pull_latency":{"avgcount":0=
,"sum":0},"subop_push":0,"subop_push_in_bytes":0,"subop_push_latency":{=
"avgcount":0,"sum":0},"pull":0,"push":0,"push_out_bytes":0,"push_in":0,=
"push_in_bytes":0,"recovery_ops":0,"loadavg":0.1,"buffer_bytes":0,"nump=
g":408,"numpg_primary":189,"numpg_replica":219,"numpg_stray":0,"heartbe=
at_to_peers":10,"heartbeat_from_peers":0,"map_messages":195,"map_messag=
e_epochs":231,"map_message_epoch_dups":194},"throttle-filestore_bytes":=
{"val":0,"max":104857600,"get":0,"get_sum":0,"get_or_fail_fail":0,"get_=
or_fail_success":0,"take":2847,"take_sum":10502288,"put":1523,"put_sum"=
:10502288,"wait":{"avgcount":0,"sum":0}},"throttle-filestore_ops":{"val=
":0,"max":500,"get":0,"get_sum":0,"get_or_fail_fail":0,"get_or_fail_suc=
cess":0,"take":2847,"take_sum":2847,"put":1523,"put_sum":2847,"wait":{"=
avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-client":{"val":=
0,"max":104857600,"get":67047,"get_sum":10334526,"get_or_fail_fail":0,"=
get_or_fail_success":0,"take":0,"take_sum":0,"put":67047,"put_sum":1033=
4526,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-c=
luster":{"val":0,"max":104857600,"get":1880,"get_sum":1556536,"get_or_f=
ail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":1880,"p=
ut_sum":1556536,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_=
throttler-hbclient":{"val":0,"max":104857600,"get":49046,"get_sum":2305=
162,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,=
"put":49046,"put_sum":2305162,"wait":{"avgcount":0,"sum":0}},"throttle-=
msgr_dispatch_throttler-hbserver":{"val":0,"max":104857600,"get":48858,=
"get_sum":2296326,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0=
,"take_sum":0,"put":48858,"put_sum":2296326,"wait":{"avgcount":0,"sum":=
0}},"throttle-osd_client_bytes":{"val":0,"max":524288000,"get":66603,"g=
et_sum":10236339,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,=
"take_sum":0,"put":66605,"put_sum":10236339,"wait":{"avgcount":0,"sum":=
0}}}


----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Sage Weil" <sage@inktank.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 31 Octobre 2012 17:29:28=20
Objet: Re: slow fio random read benchmark, need help=20

>>Have you tried increasing the iodepth?=20
Yes, I have try with 100 and 200, same results.=20

I have also try directly from the host, with /dev/rbd1, and I have same=
 result.=20
I have also try with 3 differents hosts, with differents cpus models.=20

(note: I can reach around 40.000 iops with same fio config on a zfs isc=
si array)=20

My test ceph cluster nodes cpus are old (xeon E5420), but they are arou=
nd 10% usage, so I think it's ok.=20


Do you have an idea if I can trace something ?=20

Thanks,=20

Alexandre=20

----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 31 Octobre 2012 16:57:05=20
Objet: Re: slow fio random read benchmark, need help=20

On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:=20
> Hello,=20
>=20
> I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,cach=
e=3Dnone), randread, with 4K block size on a small size of 1G (so it ca=
n be handle by the buffer cache on ceph cluster)=20
>=20
>=20
> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000M --i=
odepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dlibaio --dire=
ct=3D1=20
>=20
>=20
> I can't get more than 5000 iops.=20

Have you tried increasing the iodepth?=20

sage=20

>=20
>=20
> RBD cluster is :=20
> ---------------=20
> 3 nodes,with each node :=20
> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon=20
> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ=20
> rbd 0.53=20
>=20
> ceph.conf=20
>=20
> journal dio =3D false=20
> filestore fiemap =3D false=20
> filestore flusher =3D false=20
> osd op threads =3D 24=20
> osd disk threads =3D 24=20
> filestore op threads =3D 6=20
>=20
> kvm host is : 4 x 12 cores opteron=20
> ------------=20
>=20
>=20
> During the bench:=20
>=20
> on ceph nodes:=20
> - cpu is around 10% used=20
> - iostat show no disks activity on osds. (so I think that the 1G file=
 is handle in the linux buffer)=20
>=20
>=20
> on kvm host:=20
>=20
> -cpu is around 20% used=20
>=20
>=20
> I really don't see where is the bottleneck....=20
>=20
> Any Ideas, hints ?=20
>=20
>=20
> Regards,=20
>=20
> Alexandre=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
