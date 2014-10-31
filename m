From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Fri, 31 Oct 2014 06:04:14 +0100 (CET)
Message-ID: <528ecbc5-504c-47fd-a69e-2a419a380e96@mailpro>
References: <CACJqLyb4WK-Pb3LHmY4V7-UCFZ3Y5W1OEcm-y6zCyJug0p3fHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55317 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaJaFEX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Oct 2014 01:04:23 -0400
In-Reply-To: <CACJqLyb4WK-Pb3LHmY4V7-UCFZ3Y5W1OEcm-y6zCyJug0p3fHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

>>Could you describe more about 2x70000 iops?
>>So you mean 8 OSD each backend with SSD can achieve with 14w iops?

It's a small rbd (10G), so mostly read hit the buffer cache.
But yes, it's able to deliver 140000iops with 8 osd. (I check also stat=
s in ceph cluster to be sure).
(and I'm not cpu bound on osd nodes)
>> 2014-10-31 05:58:34.231037 mon.0 [INF] pgmap v7109: 1264 pgs: 1264 a=
ctive+clean; 165 GB data, 109 GB used, 6226 GB / 6335 GB avail; 560 MB/=
s rd, 140 kop/s


here the ceph.conf of osd nodes

[global]
fsid =3D c29f4643-9577-4671-ae25-59ad14550aba
auth_cluster_required =3D none
auth_service_required =3D none
auth_client_required =3D none
filestore_xattr_use_omap =3D true

       debug lockdep =3D 0/0
        debug context =3D 0/0
        debug crush =3D 0/0
        debug buffer =3D 0/0
        debug timer =3D 0/0
        debug journaler =3D 0/0
        debug osd =3D 0/0
        debug optracker =3D 0/0
        debug objclass =3D 0/0
        debug filestore =3D 0/0
        debug journal =3D 0/0
        debug ms =3D 0/0
        debug monc =3D 0/0
        debug tp =3D 0/0
        debug auth =3D 0/0
        debug finisher =3D 0/0
        debug heartbeatmap =3D 0/0
        debug perfcounter =3D 0/0
        debug asok =3D 0/0
        debug throttle =3D 0/0

        osd_op_threads =3D 5
        filestore_op_threads =3D 4


        osd_op_num_threads_per_shard =3D 1
        osd_op_num_shards =3D 25
        filestore_fd_cache_size =3D 64
        filestore_fd_cache_shards =3D 32
        osd_enable_op_tracker =3D false

=20

>>is it read or write? could you give fio options?
random read 4K

Here the fio config.

[global]
ioengine=3Daio
invalidate=3D1   =20
rw=3Drandread
bs=3D4K
direct=3D1
numjobs=3D1
group_reporting=3D1
size=3D10G

[test1]
iodepth=3D64
filename=3D/dev/rbd/test/test


On 1 client node, I can't reach more than 50000iops with 6osd or 70000i=
ops with 8 osd.
(I had try to increasing numjobs to have more fio process or with 2 dif=
ferents rbd volume at the same time,=20
 but performance is the same).

>> 2014-10-31 05:57:30.078348 mon.0 [INF] pgmap v7070: 1264 pgs: 1264 a=
ctive+clean; 165 GB data, 109 GB used, 6226 GB / 6335 GB avail; 290 MB/=
s rd, 74572 op/s


But If I launch same fio test on another client node, I can reach same =
70000iops at the same time.


>> 2014-10-31 05:58:34.231037 mon.0 [INF] pgmap v7109: 1264 pgs: 1264 a=
ctive+clean; 165 GB data, 109 GB used, 6226 GB / 6335 GB avail; 560 MB/=
s rd, 140 kop/s


----- Mail original -----=20

De: "Haomai Wang" <haomaiwang@gmail.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Sage Weil" <sage@newdream.net>, "Christoph Hellwig" <hch@infradead=
=2Eorg>, "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Jeudi 30 Octobre 2014 18:05:26=20
Objet: Re: krbd blk-mq support ?=20

Could you describe more about 2x70000 iops?=20
So you mean 8 OSD each backend with SSD can achieve with 14w iops?=20
is it read or write? could you give fio options?=20

On Fri, Oct 31, 2014 at 12:01 AM, Alexandre DERUMIER=20
<aderumier@odiso.com> wrote:=20
>>>I'll try to add more OSD next week, if it's scale it's a very good n=
ews !=20
>=20
> I just tried to add 2 more osds,=20
>=20
> I can now reach 2x 70000 iops on 2 client nodes (vs 2 x 50000 previou=
sly).=20
>=20
> and kworker cpu usage is also lower (84% vs 97%).=20
> (don't understand why exactly)=20
>=20
> So, Thanks for help everybody !=20
>=20
>=20
>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> =C3=80: "Sage Weil" <sage@newdream.net>=20
> Cc: "Christoph Hellwig" <hch@infradead.org>, "Ceph Devel" <ceph-devel=
@vger.kernel.org>=20
> Envoy=C3=A9: Jeudi 30 Octobre 2014 09:11:11=20
> Objet: Re: krbd blk-mq support ?=20
>=20
>>>Hmm, this is probably the messenger.c worker then that is feeding me=
ssages=20
>>>to the network. How many OSDs do you have? It should be able to scal=
e=20
>>>with the number of OSDs.=20
>=20
> Thanks Sage for your reply.=20
>=20
> Currently 6 OSD (ssd) on the test platform.=20
>=20
> But I can reach 2x 50000iops on same rbd volume with 2 clients on 2 d=
ifferents host.=20
> Do you think messenger.c worker can be the bottleneck in this case ?=20
>=20
>=20
> I'll try to add more OSD next week, if it's scale it's a very good ne=
ws !=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Sage Weil" <sage@newdream.net>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: "Christoph Hellwig" <hch@infradead.org>, "Ceph Devel" <ceph-devel=
@vger.kernel.org>=20
> Envoy=C3=A9: Mercredi 29 Octobre 2014 16:00:56=20
> Objet: Re: krbd blk-mq support ?=20
>=20
> On Wed, 29 Oct 2014, Alexandre DERUMIER wrote:=20
>> >>Oh, that's without the blk-mq patch?=20
>>=20
>> Yes, sorry, I don't how to use perf with a custom compiled kernel.=20
>> (Usualy I'm using perf from debian, with linux-tools package provide=
d with the debian kernel package)=20
>>=20
>> >>Either way the profile doesn't really sum up to a fully used up cp=
u.=20
>>=20
>> But I see mostly same behaviour with or without blk-mq patch, I have=
 always 1 kworker at around 97-100%cpu (1core) for 50000iops.=20
>>=20
>> I had also tried to map the rbd volume with nocrc, it's going to 600=
00iops with same kworker at around 97-100%cpu=20
>=20
> Hmm, this is probably the messenger.c worker then that is feeding mes=
sages=20
> to the network. How many OSDs do you have? It should be able to scale=
=20
> with the number of OSDs.=20
>=20
> sage=20
>=20
>=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>>=20
>> De: "Christoph Hellwig" <hch@infradead.org>=20
>> ?: "Alexandre DERUMIER" <aderumier@odiso.com>=20
>> Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
>> Envoy?: Mardi 28 Octobre 2014 19:07:25=20
>> Objet: Re: krbd blk-mq support ?=20
>>=20
>> On Mon, Oct 27, 2014 at 11:00:46AM +0100, Alexandre DERUMIER wrote:=20
>> > >>Can you do a perf report -ag and then a perf report to see where=
 these=20
>> > >>cycles are spent?=20
>> >=20
>> > Yes, sure.=20
>> >=20
>> > I have attached the perf report to this mail.=20
>> > (This is with kernel 3.14, don't have access to my 3.18 host for n=
ow)=20
>>=20
>> Oh, that's without the blk-mq patch?=20
>>=20
>> Either way the profile doesn't really sum up to a fully used up=20
>> cpu. Sage, Alex - are there any ordring constraints in the rbd clien=
t?=20
>> If not we could probably aim for per-cpu queues using blk-mq and a=20
>> socket per cpu or similar.=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20
Best Regards,=20

Wheat=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
