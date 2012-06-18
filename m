From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal, normal behaviour ?
Date: Mon, 18 Jun 2012 17:45:14 +0200 (CEST)
Message-ID: <2be85e0d-e528-454b-a1fc-eef1e9a7bd24@mailpro>
References: <4FDF4641.4070405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:59899 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2FRPpi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:45:38 -0400
In-Reply-To: <4FDF4641.4070405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

>>Hrm, look at your journal_queue_max_ops, journal_queue_max_bytes,=20
>>op_queue_max_ops, and op_queue_max_bytes. Looks like you are set at 5=
00=20
>>ops and a maximum of 100MB. With 1GigE you'd be able to max out the=20
>>data in the journal really fast. Try tweaking these up and see what=20
>>happens.=20

test was made with 15 osd, each osd with 1GB journal.

(so 1Gits =3D 100MB/S *3 with replication =3D 300MB /15 osd =3D 20MB/S =
(that around what I see with iostat)
with 1GB journal , it should handle around 50s.




I have redone a test, with 1 osd on 3 nodes with 8GB journal (write aro=
und 60-80MB/S on each osd)

journal_queue_max_bytes show again 100MB
journal_queue_max_ops =3D 500
but
journal_ops =3D 6500=20
journal_queue_ops =3D 0
journal_queue_bytes =3D 0
(I have done perfcounters_dump each second and journal_queue_ops,journa=
l_queue_bytes are always 0)

op_queue_max_bytes:100MB
op_queue_max_ops:500
(what are op_ counters ? osd counter ?)

Should'nt be queues values as low as possible ? (0 queue =3D 0 bottlene=
ck) ?



root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok perfc=
ounters_dump
{"filestore":{"journal_queue_max_ops":500,"journal_queue_ops":0,"journa=
l_ops":6554,"journal_queue_max_bytes":104857600,"journal_queue_bytes":0=
,"journal_bytes":6624795873,"journal_latency":{"avgcount":6554,"sum":11=
=2E5094},"op_queue_max_ops":500,"op_queue_ops":0,"ops":6554,"op_queue_m=
ax_bytes":104857600,"op_queue_bytes":0,"bytes":6624755213,"apply_latenc=
y":{"avgcount":6554,"sum":4462.6},"committing":0,"commitcycle":143,"com=
mitcycle_interval":{"avgcount":143,"sum":736.741},"commitcycle_latency"=
:{"avgcount":143,"sum":17.2976},"journal_full":0},"osd":{"opq":0,"op_wi=
p":1,"op":838,"op_in_bytes":3514930636,"op_out_bytes":0,"op_latency":{"=
avgcount":838,"sum":201.494},"op_r":0,"op_r_out_bytes":0,"op_r_latency"=
:{"avgcount":0,"sum":0},"op_w":838,"op_w_in_bytes":3514930636,"op_w_rla=
t":{"avgcount":838,"sum":0},"op_w_latency":{"avgcount":838,"sum":201.49=
4},"op_rw":0,"op_rw_in_bytes":0,"op_rw_out_bytes":0,"op_rw_rlat":{"avgc=
ount":0,"sum":0},"op_rw_latency":{"avgcount":0,"sum":0},"subop":739,"su=
bop_in_bytes":3099988795,"subop_latency":{"avgcount":739,"sum":45.7711}=
,"subop_w":0,"subop_w_in_bytes":3099988795,"subop_w_latency":{"avgcount=
":739,"sum":45.7711},"subop_pull":0,"subop_pull_latency":{"avgcount":0,=
"sum":0},"subop_push":0,"subop_push_in_bytes":0,"subop_push_latency":{"=
avgcount":0,"sum":0},"pull":0,"push":0,"push_out_bytes":0,"recovery_ops=
":0,"loadavg":0.56,"buffer_bytes":0,"numpg":1387,"numpg_primary":701,"n=
umpg_replica":686,"numpg_stray":0,"heartbeat_to_peers":2,"heartbeat_fro=
m_peers":0,"map_messages":18,"map_message_epochs":37,"map_message_epoch=
_dups":31},"throttle-filestore_bytes":{"val":0,"max":104857600,"get":0,=
"get_sum":0,"get_or_fail_fail":0,"get_or_fail_success":0,"take":6554,"t=
ake_sum":6624795873,"put":6078,"put_sum":6624795873,"wait":{"avgcount":=
0,"sum":0}},"throttle-filestore_ops":{"val":0,"max":500,"get":0,"get_su=
m":0,"get_or_fail_fail":0,"get_or_fail_success":0,"take":6554,"take_sum=
":6554,"put":6078,"put_sum":6554,"wait":{"avgcount":0,"sum":0}},"thrott=
le-msgr_dispatch_throttler-client":{"val":0,"max":104857600,"get":1076,=
"get_sum":3523503185,"get_or_fail_fail":0,"get_or_fail_success":0,"take=
":0,"take_sum":0,"put":1076,"put_sum":3523503185,"wait":{"avgcount":0,"=
sum":0}},"throttle-msgr_dispatch_throttler-cluster":{"val":0,"max":1048=
57600,"get":5006,"get_sum":3103900299,"get_or_fail_fail":0,"get_or_fail=
_success":0,"take":0,"take_sum":0,"put":5006,"put_sum":3103900299,"wait=
":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbclient":{=
"val":0,"max":104857600,"get":478,"get_sum":22466,"get_or_fail_fail":0,=
"get_or_fail_success":0,"take":0,"take_sum":0,"put":478,"put_sum":22466=
,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbser=
ver":{"val":0,"max":104857600,"get":484,"get_sum":22748,"get_or_fail_fa=
il":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":484,"put_sum"=
:22748,"wait":{"avgcount":0,"sum":0}},"throttle-osd_client_bytes":{"val=
":0,"max":524288000,"get":840,"get_sum":3523353965,"get_or_fail_fail":0=
,"get_or_fail_success":0,"take":0,"take_sum":0,"put":1679,"put_sum":352=
3353965,"wait":{"avgcount":0,"sum":0}}}




----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 17:16:17=20
Objet: Re: iostat show constants write to osd disk with writeahead jour=
nal, normal behaviour ?=20

On 6/18/12 9:47 AM, Alexandre DERUMIER wrote:=20
>>> Yeah, I just wanted to make sure that the constant writes weren't=20
>>> because the filestore was falling behind. You may want to take a lo=
ok=20
>>> at some of the information that is provided by the admin socket for=
 the=20
>>> OSD while the test is running. dump_ops_in_flight, perf schema, and=
 perf=20
>>> dump are all useful.=20
>=20
>=20
> don't know which values to check in these big json reponses ;)=20
> But I have try with more osd, so write are splitted on more disks and=
 and write are smaller, and the behaviour is same=20

No worries, there is a lot of data there!=20

>=20
>=20
> root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok dum=
p_ops_in_flight=20
> { "num_ops": 1,=20
> "ops": [=20
> { "description": "osd_op(client.4179.0:83 kvmtest1_1006560_object82 [=
write 0~4194304] 3.9f5c55af)",=20
> "received_at": "2012-06-18 16:41:17.995167",=20
> "age": "0.406678",=20
> "flag_point": "waiting for sub ops",=20
> "client_info": { "client": "client.4179",=20
> "tid": 83}}]}=20
>=20
>=20
> root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok per=
fcounters_dump=20
>=20
> {"filestore":{"journal_queue_max_ops":500,"journal_queue_ops":0,"jour=
nal_ops":2198,"journal_queue_max_bytes":104857600,"journal_queue_bytes"=
:0,"journal_bytes":1012769525,"journal_latency":{"avgcount":2198,"sum":=
3.13569},"op_queue_max_ops":500,"op_queue_ops":0,"ops":2198,"op_queue_m=
ax_bytes":104857600,"op_queue_bytes":0,"bytes":1012757330,"apply_latenc=
y":{"avgcount":2198,"sum":290.27},"committing":0,"commitcycle":59,"comm=
itcycle_interval":{"avgcount":59,"sum":300.04},"commitcycle_latency":{"=
avgcount":59,"sum":4.76299},"journal_full":0},"osd":{"opq":0,"op_wip":0=
,"op":127,"op_in_bytes":532692449,"op_out_bytes":0,"op_latency":{"avgco=
unt":127,"sum":49.2627},"op_r":0,"op_r_out_bytes":0,"op_r_latency":{"av=
gcount":0,"sum":0},"op_w":127,"op_w_in_bytes":532692449,"op_w_rlat":{"a=
vgcount":127,"sum":0},"op_w_latency":{"avgcount":127,"sum":49.2627},"op=
_rw":0,"op_rw_in_bytes":0,"op_rw_out_bytes":0,"op_rw_rlat":{"avgcount":=
0,"sum":0},"op_rw_latency":{"avgcount":0,"sum":0},"subop":114,"subo=20
p_in_byte=20
s":478212311,"subop_latency":{"avgcount":114,"sum":8.82174},"subop_w":0=
,"subop_w_in_bytes":478212311,"subop_w_latency":{"avgcount":114,"sum":8=
=2E82174},"subop_pull":0,"subop_pull_latency":{"avgcount":0,"sum":0},"s=
ubop_push":0,"subop_push_in_bytes":0,"subop_push_latency":{"avgcount":0=
,"sum":0},"pull":0,"push":0,"push_out_bytes":0,"recovery_ops":0,"loadav=
g":0.47,"buffer_bytes":0,"numpg":423,"numpg_primary":259,"numpg_replica=
":164,"numpg_stray":0,"heartbeat_to_peers":10,"heartbeat_from_peers":0,=
"map_messages":34,"map_message_epochs":44,"map_message_epoch_dups":24},=
"throttle-filestore_bytes":{"val":0,"max":104857600,"get":0,"get_sum":0=
,"get_or_fail_fail":0,"get_or_fail_success":0,"take":2198,"take_sum":10=
12769525,"put":1503,"put_sum":1012769525,"wait":{"avgcount":0,"sum":0}}=
,"throttle-filestore_ops":{"val":0,"max":500,"get":0,"get_sum":0,"get_o=
r_fail_fail":0,"get_or_fail_success":0,"take":2198,"take_sum":2198,"put=
":1503,"put_sum":2198,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_d=20
ispatch_t=20
hrottler-client":{"val":4194469,"max":104857600,"get":243,"get_sum":536=
987810,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum"=
:0,"put":242,"put_sum":532793341,"wait":{"avgcount":0,"sum":0}},"thrott=
le-msgr_dispatch_throttler-cluster":{"val":0,"max":104857600,"get":1480=
,"get_sum":482051948,"get_or_fail_fail":0,"get_or_fail_success":0,"take=
":0,"take_sum":0,"put":1480,"put_sum":482051948,"wait":{"avgcount":0,"s=
um":0}},"throttle-msgr_dispatch_throttler-hbclient":{"val":0,"max":1048=
57600,"get":1077,"get_sum":50619,"get_or_fail_fail":0,"get_or_fail_succ=
ess":0,"take":0,"take_sum":0,"put":1077,"put_sum":50619,"wait":{"avgcou=
nt":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbserver":{"val":0,"m=
ax":104857600,"get":972,"get_sum":45684,"get_or_fail_fail":0,"get_or_fa=
il_success":0,"take":0,"take_sum":0,"put":972,"put_sum":45684,"wait":{"=
avgcount":0,"sum":0}},"throttle-osd_client_bytes":{"val":4194469,"max":=
524288000,"get":128,"get_sum":536892019,"get_or_fail_fail":0,"get_o=20
r_fail_su=20
ccess":0,"take":0,"take_sum":0,"put":254,"put_sum":532697550,"wait":{"a=
vgcount":0,"sum":0}}}=20
>=20
>=20
> root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok per=
fcounters_schema=20
>=20
> {"filestore":{"journal_queue_max_ops":{"type":2},"journal_queue_ops":=
{"type":2},"journal_ops":{"type":10},"journal_queue_max_bytes":{"type":=
2},"journal_queue_bytes":{"type":2},"journal_bytes":{"type":10},"journa=
l_latency":{"type":5},"op_queue_max_ops":{"type":2},"op_queue_ops":{"ty=
pe":2},"ops":{"type":10},"op_queue_max_bytes":{"type":2},"op_queue_byte=
s":{"type":2},"bytes":{"type":10},"apply_latency":{"type":5},"committin=
g":{"type":2},"commitcycle":{"type":10},"commitcycle_interval":{"type":=
5},"commitcycle_latency":{"type":5},"journal_full":{"type":10}},"osd":{=
"opq":{"type":2},"op_wip":{"type":2},"op":{"type":10},"op_in_bytes":{"t=
ype":10},"op_out_bytes":{"type":10},"op_latency":{"type":5},"op_r":{"ty=
pe":10},"op_r_out_bytes":{"type":10},"op_r_latency":{"type":5},"op_w":{=
"type":10},"op_w_in_bytes":{"type":10},"op_w_rlat":{"type":5},"op_w_lat=
ency":{"type":5},"op_rw":{"type":10},"op_rw_in_bytes":{"type":10},"op_r=
w_out_bytes":{"type":10},"op_rw_rlat":{"type":5},"op_rw_latency":{"=20
type":5},=20
"subop":{"type":10},"subop_in_bytes":{"type":10},"subop_latency":{"type=
":5},"subop_w":{"type":10},"subop_w_in_bytes":{"type":10},"subop_w_late=
ncy":{"type":5},"subop_pull":{"type":10},"subop_pull_latency":{"type":5=
},"subop_push":{"type":10},"subop_push_in_bytes":{"type":10},"subop_pus=
h_latency":{"type":5},"pull":{"type":10},"push":{"type":10},"push_out_b=
ytes":{"type":10},"recovery_ops":{"type":10},"loadavg":{"type":1},"buff=
er_bytes":{"type":2},"numpg":{"type":2},"numpg_primary":{"type":2},"num=
pg_replica":{"type":2},"numpg_stray":{"type":2},"heartbeat_to_peers":{"=
type":2},"heartbeat_from_peers":{"type":2},"map_messages":{"type":10},"=
map_message_epochs":{"type":10},"map_message_epoch_dups":{"type":10}},"=
throttle-filestore_bytes":{"val":{"type":10},"max":{"type":10},"get":{"=
type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_=
fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"pu=
t":{"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-f=20
ilestore_=20
ops":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{=
"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type"=
:10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_s=
um":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_throttler-cl=
ient":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":=
{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type=
":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_=
sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_throttler-c=
luster":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum=
":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"ty=
pe":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"pu=
t_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_throttler=
-hbclient":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_=
sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_succes=20
s":{"type=20
":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_=
sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_throttler-h=
bserver":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_su=
m":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"t=
ype":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"p=
ut_sum":{"type":10},"wait":{"type":5}},"throttle-osd_client_bytes":{"va=
l":{"type":10},"max":{"type":10},"get":{"type":10},"get_sum":{"type":10=
},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"type":10},"tak=
e":{"type":10},"take_sum":{"type":10},"put":{"type":10},"put_sum":{"typ=
e":10},"wait":{"type":5}}}=20
>=20

Hrm, look at your journal_queue_max_ops, journal_queue_max_bytes,=20
op_queue_max_ops, and op_queue_max_bytes. Looks like you are set at 500=
=20
ops and a maximum of 100MB. With 1GigE you'd be able to max out the=20
data in the journal really fast. Try tweaking these up and see what=20
happens.=20

>=20
>=20
>=20
>>> Nuts. Do you still see the little peaks/valleys every couple second=
s?=20
> I see some little peak/valleys, but iostat is not precise enough if t=
hink, I'll try to do some seekwatcher movie.=20
>=20
>=20
> Do you have a seekwatcher movie of a normal write behaviour ?=20
> Do I need to see small peak period (when journal is flushed to osd) a=
nd long valley period ?=20
>=20

I think "normal" is not yet well defined. ;) There's so many variables=20
that can affect performance that it's hard to get a good bead on what=20
people should expect to see. Having said that, I've got some data I'm=20
going to post to the mailing list later today that you can look at in=20
comparison.=20

Mark=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
