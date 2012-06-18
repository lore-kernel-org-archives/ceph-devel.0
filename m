From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal, normal behaviour ?
Date: Mon, 18 Jun 2012 16:47:18 +0200 (CEST)
Message-ID: <d8526549-5d30-4bc2-8dc3-9f08e4640466@mailpro>
References: <4FDF39A1.4060905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:59903 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab2FROrm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 10:47:42 -0400
In-Reply-To: <4FDF39A1.4060905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

>>Yeah, I just wanted to make sure that the constant writes weren't=20
>>because the filestore was falling behind. You may want to take a look=
=20
>>at some of the information that is provided by the admin socket for t=
he=20
>>OSD while the test is running. dump_ops_in_flight, perf schema, and p=
erf=20
>>dump are all useful.


don't know which values to check in these big json reponses ;)
But I have try with more osd, so write are splitted on more disks and a=
nd write are smaller, and the behaviour is same


root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok dump_=
ops_in_flight
{ "num_ops": 1,
  "ops": [
        { "description": "osd_op(client.4179.0:83 kvmtest1_1006560_obje=
ct82 [write 0~4194304] 3.9f5c55af)",
          "received_at": "2012-06-18 16:41:17.995167",
          "age": "0.406678",
          "flag_point": "waiting for sub ops",
          "client_info": { "client": "client.4179",
              "tid": 83}}]}


root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok perfc=
ounters_dump

{"filestore":{"journal_queue_max_ops":500,"journal_queue_ops":0,"journa=
l_ops":2198,"journal_queue_max_bytes":104857600,"journal_queue_bytes":0=
,"journal_bytes":1012769525,"journal_latency":{"avgcount":2198,"sum":3.=
13569},"op_queue_max_ops":500,"op_queue_ops":0,"ops":2198,"op_queue_max=
_bytes":104857600,"op_queue_bytes":0,"bytes":1012757330,"apply_latency"=
:{"avgcount":2198,"sum":290.27},"committing":0,"commitcycle":59,"commit=
cycle_interval":{"avgcount":59,"sum":300.04},"commitcycle_latency":{"av=
gcount":59,"sum":4.76299},"journal_full":0},"osd":{"opq":0,"op_wip":0,"=
op":127,"op_in_bytes":532692449,"op_out_bytes":0,"op_latency":{"avgcoun=
t":127,"sum":49.2627},"op_r":0,"op_r_out_bytes":0,"op_r_latency":{"avgc=
ount":0,"sum":0},"op_w":127,"op_w_in_bytes":532692449,"op_w_rlat":{"avg=
count":127,"sum":0},"op_w_latency":{"avgcount":127,"sum":49.2627},"op_r=
w":0,"op_rw_in_bytes":0,"op_rw_out_bytes":0,"op_rw_rlat":{"avgcount":0,=
"sum":0},"op_rw_latency":{"avgcount":0,"sum":0},"subop":114,"subop_in_b=
ytes":478212311,"subop_latency":{"avgcount":114,"sum":8.82174},"subop_w=
":0,"subop_w_in_bytes":478212311,"subop_w_latency":{"avgcount":114,"sum=
":8.82174},"subop_pull":0,"subop_pull_latency":{"avgcount":0,"sum":0},"=
subop_push":0,"subop_push_in_bytes":0,"subop_push_latency":{"avgcount":=
0,"sum":0},"pull":0,"push":0,"push_out_bytes":0,"recovery_ops":0,"loada=
vg":0.47,"buffer_bytes":0,"numpg":423,"numpg_primary":259,"numpg_replic=
a":164,"numpg_stray":0,"heartbeat_to_peers":10,"heartbeat_from_peers":0=
,"map_messages":34,"map_message_epochs":44,"map_message_epoch_dups":24}=
,"throttle-filestore_bytes":{"val":0,"max":104857600,"get":0,"get_sum":=
0,"get_or_fail_fail":0,"get_or_fail_success":0,"take":2198,"take_sum":1=
012769525,"put":1503,"put_sum":1012769525,"wait":{"avgcount":0,"sum":0}=
},"throttle-filestore_ops":{"val":0,"max":500,"get":0,"get_sum":0,"get_=
or_fail_fail":0,"get_or_fail_success":0,"take":2198,"take_sum":2198,"pu=
t":1503,"put_sum":2198,"wait":{"avgcount":0,"sum":0}},"throttle-msgr_di=
spatch_throttler-client":{"val":4194469,"max":104857600,"get":243,"get_=
sum":536987810,"get_or_fail_fail":0,"get_or_fail_success":0,"take":0,"t=
ake_sum":0,"put":242,"put_sum":532793341,"wait":{"avgcount":0,"sum":0}}=
,"throttle-msgr_dispatch_throttler-cluster":{"val":0,"max":104857600,"g=
et":1480,"get_sum":482051948,"get_or_fail_fail":0,"get_or_fail_success"=
:0,"take":0,"take_sum":0,"put":1480,"put_sum":482051948,"wait":{"avgcou=
nt":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbclient":{"val":0,"m=
ax":104857600,"get":1077,"get_sum":50619,"get_or_fail_fail":0,"get_or_f=
ail_success":0,"take":0,"take_sum":0,"put":1077,"put_sum":50619,"wait":=
{"avgcount":0,"sum":0}},"throttle-msgr_dispatch_throttler-hbserver":{"v=
al":0,"max":104857600,"get":972,"get_sum":45684,"get_or_fail_fail":0,"g=
et_or_fail_success":0,"take":0,"take_sum":0,"put":972,"put_sum":45684,"=
wait":{"avgcount":0,"sum":0}},"throttle-osd_client_bytes":{"val":419446=
9,"max":524288000,"get":128,"get_sum":536892019,"get_or_fail_fail":0,"g=
et_or_fail_success":0,"take":0,"take_sum":0,"put":254,"put_sum":5326975=
50,"wait":{"avgcount":0,"sum":0}}}


root@cephtest1:/var/run/ceph# ceph --admin-daemon ceph-osd.0.asok perfc=
ounters_schema

{"filestore":{"journal_queue_max_ops":{"type":2},"journal_queue_ops":{"=
type":2},"journal_ops":{"type":10},"journal_queue_max_bytes":{"type":2}=
,"journal_queue_bytes":{"type":2},"journal_bytes":{"type":10},"journal_=
latency":{"type":5},"op_queue_max_ops":{"type":2},"op_queue_ops":{"type=
":2},"ops":{"type":10},"op_queue_max_bytes":{"type":2},"op_queue_bytes"=
:{"type":2},"bytes":{"type":10},"apply_latency":{"type":5},"committing"=
:{"type":2},"commitcycle":{"type":10},"commitcycle_interval":{"type":5}=
,"commitcycle_latency":{"type":5},"journal_full":{"type":10}},"osd":{"o=
pq":{"type":2},"op_wip":{"type":2},"op":{"type":10},"op_in_bytes":{"typ=
e":10},"op_out_bytes":{"type":10},"op_latency":{"type":5},"op_r":{"type=
":10},"op_r_out_bytes":{"type":10},"op_r_latency":{"type":5},"op_w":{"t=
ype":10},"op_w_in_bytes":{"type":10},"op_w_rlat":{"type":5},"op_w_laten=
cy":{"type":5},"op_rw":{"type":10},"op_rw_in_bytes":{"type":10},"op_rw_=
out_bytes":{"type":10},"op_rw_rlat":{"type":5},"op_rw_latency":{"type":=
5},"subop":{"type":10},"subop_in_bytes":{"type":10},"subop_latency":{"t=
ype":5},"subop_w":{"type":10},"subop_w_in_bytes":{"type":10},"subop_w_l=
atency":{"type":5},"subop_pull":{"type":10},"subop_pull_latency":{"type=
":5},"subop_push":{"type":10},"subop_push_in_bytes":{"type":10},"subop_=
push_latency":{"type":5},"pull":{"type":10},"push":{"type":10},"push_ou=
t_bytes":{"type":10},"recovery_ops":{"type":10},"loadavg":{"type":1},"b=
uffer_bytes":{"type":2},"numpg":{"type":2},"numpg_primary":{"type":2},"=
numpg_replica":{"type":2},"numpg_stray":{"type":2},"heartbeat_to_peers"=
:{"type":2},"heartbeat_from_peers":{"type":2},"map_messages":{"type":10=
},"map_message_epochs":{"type":10},"map_message_epoch_dups":{"type":10}=
},"throttle-filestore_bytes":{"val":{"type":10},"max":{"type":10},"get"=
:{"type":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_=
or_fail_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},=
"put":{"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-fi=
lestore_ops":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"ge=
t_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success"=
:{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10=
},"put_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_thro=
ttler-client":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"g=
et_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success=
":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":1=
0},"put_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_thr=
ottler-cluster":{"val":{"type":10},"max":{"type":10},"get":{"type":10},=
"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_succe=
ss":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type"=
:10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatch_t=
hrottler-hbclient":{"val":{"type":10},"max":{"type":10},"get":{"type":1=
0},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_su=
ccess":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{"ty=
pe":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-msgr_dispatc=
h_throttler-hbserver":{"val":{"type":10},"max":{"type":10},"get":{"type=
":10},"get_sum":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail=
_success":{"type":10},"take":{"type":10},"take_sum":{"type":10},"put":{=
"type":10},"put_sum":{"type":10},"wait":{"type":5}},"throttle-osd_clien=
t_bytes":{"val":{"type":10},"max":{"type":10},"get":{"type":10},"get_su=
m":{"type":10},"get_or_fail_fail":{"type":10},"get_or_fail_success":{"t=
ype":10},"take":{"type":10},"take_sum":{"type":10},"put":{"type":10},"p=
ut_sum":{"type":10},"wait":{"type":5}}}




>> Nuts. Do you still see the little peaks/valleys every couple seconds=
?=20
I see some little peak/valleys, but iostat is not precise enough if thi=
nk, I'll try to do some seekwatcher movie.


Do you have a seekwatcher movie of a normal write behaviour ?
Do I need to see small peak period (when journal is flushed to osd) and=
 long valley period ?





----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 16:22:25=20
Objet: Re: iostat show constants write to osd disk with writeahead jour=
nal, normal behaviour ?=20

On 6/18/12 9:04 AM, Alexandre DERUMIER wrote:=20
> Hi Mark,=20
>=20
>>> Sorry I got behind at looking at your output last week. I've create=
d a=20
>>> seekwatcher movie of your blktrace results here:=20
>>>=20
>>> http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg=20
>=20
> how do you create seekwatcher movie from blktrace ? (I'd like to crea=
te them myself, seem good to debug)=20

You'll need to download seekwatcher from Chris Mason's website. Get the=
=20
newest unstable version. To make movies you'll need mencoder. (It also=20
needs numpy and matplotlib). There is a small bug in the code where "&>=
=20
/dev/null" should be changed to "> /dev/null 2>&1". If you have trouble=
=20
let me know and I can send you a fixed version of the script.=20

>=20
>=20
>>> The results match up well with your iostat output. Peaks and valley=
s in=20
>>> the writes every couple of seconds. Low numbers of seeks, so probab=
ly=20
>>> not limited by the filestore (a quick "osd tell X bench" might conf=
irm=20
>>> that).=20
>=20
> yet, i'm pretty sure that the limitation if not hardware. (each osd a=
re 15k drive, handling around 10MB/S during the test, so I think it sho=
uld be ok ^_^ )=20
> how do you use "osd tell X bench" ?=20

Yeah, I just wanted to make sure that the constant writes weren't=20
because the filestore was falling behind. You may want to take a look=20
at some of the information that is provided by the admin socket for the=
=20
OSD while the test is running. dump_ops_in_flight, perf schema, and per=
f=20
dump are all useful.=20

Try:=20

ceph --admin-daemon <socket> help=20

The osd admin sockets should be available in /var/run/ceph.=20

>=20
>>> I'm wondering if you increase "filestore max sync interval" to some=
thing=20
>>> bigger (default is 5s) if you'd see somewhat different behavior. Ma=
ybe=20
>>> try something like 30s and see what happens?=20
>=20
> I have done test with 30s, that doesn't change nothing.=20
> I have try with filestore min sync interval =3D 29 + filestore max sy=
nc interval =3D 30=20
>=20

Nuts. Do you still see the little peaks/valleys every couple seconds?=20

>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Mark Nelson"<mark.nelson@inktank.com>=20
> =C3=80: "Alexandre DERUMIER"<aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Lundi 18 Juin 2012 15:29:58=20
> Objet: Re: iostat show constants write to osd disk with writeahead jo=
urnal, normal behaviour ?=20
>=20
> On 6/18/12 7:34 AM, Alexandre DERUMIER wrote:=20
>> Hi,=20
>>=20
>> I'm doing test with rados bench, and I see constant writes to osd di=
sks.=20
>> Is it the normal behaviour ? with write-ahead should write occur eac=
h 20-30 seconde ?=20
>>=20
>>=20
>> Cluster is=20
>> 3 nodes (ubuntu precise - glibc 2.14 - ceph 0.47.2) with each node 1=
 journal on tmpfs 8GB - 1 osd (xfs) on sas disk - 1 gigabit link=20
>>=20
>>=20
>> 8GB journal can handle easily 20s of write (1 gigabit link)=20
>>=20
>> [osd]=20
>> osd data =3D /srv/osd.$id=20
>> osd journal =3D /tmpfs/osd.$id.journal=20
>> osd journal size =3D 8000=20
>> journal dio =3D false=20
>> filestore journal parallel =3D false=20
>> filestore journal writeahead =3D true=20
>> filestore fiemap =3D false=20
>>=20
>>=20
>>=20
>>=20
>> I have done tests with differents kernel (3.0,3.2,3.4) , differents =
filesystem (xfs,btrfs,ext4), forced journal mode to writeahead.=20
>> Bench were done write rados bench and fio.=20
>>=20
>> I always have constant write since the first second of bench start.=20
>>=20
>> Any idea ?=20
>=20
> Hi Alex,=20
>=20
> Sorry I got behind at looking at your output last week. I've created =
a=20
> seekwatcher movie of your blktrace results here:=20
>=20
> http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg=20
>=20
> The results match up well with your iostat output. Peaks and valleys =
in=20
> the writes every couple of seconds. Low numbers of seeks, so probably=
=20
> not limited by the filestore (a quick "osd tell X bench" might confir=
m=20
> that).=20
>=20
> I'm wondering if you increase "filestore max sync interval" to someth=
ing=20
> bigger (default is 5s) if you'd see somewhat different behavior. Mayb=
e=20
> try something like 30s and see what happens?=20
>=20
> Mark=20
>=20
>=20
>=20
>=20




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
