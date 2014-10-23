From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: fio read and randread  cpu usage results for qemu and host machine
Date: Thu, 23 Oct 2014 17:20:57 +0200 (CEST)
Message-ID: <f3a5fdcf-171e-4387-8644-fc2748b60f42@mailpro>
References: <5448FD91.7010709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:53124 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbaJWPVG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 11:21:06 -0400
In-Reply-To: <5448FD91.7010709@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

>>Hi Alexandre, do you have access to perf?=20
yes. I can send perf report if you want. (I'm not sure how to analyze t=
he results)

>>Especially on newer kernels/distributions where you can use dwarf sym=
bols, perf can give you=20
>>a lot of information about what is using CPU where.=20
I'm using kernel 3.16, so I think It'll be ok

>> vtune is also a nice option if you ave a license.
Don't have it sorry.




BTW, about seq read results with virtio iothread and virtio-scsi multiq=
ueue
it's seem that it's enabling linux queues merging
I had try to disable it with echo 2 > /sys/block/sda/queue/nomerges,
and I have the same result than without multiqueue.
So it's more an optimization for qemu,=20
but this not improving the reals maximum ios we can reach from rbd.


----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, "Ceph Devel" <ceph-=
devel@vger.kernel.org>=20
Envoy=C3=A9: Jeudi 23 Octobre 2014 15:07:29=20
Objet: Re: fio read and randread cpu usage results for qemu and host ma=
chine=20

On 10/23/2014 07:30 AM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I have done fio tests on multiple qemu setups and host machine,=20
> to see if librbd use more cpu than krbd=20
> and also find the best qemu optimisations.=20
>=20
> Fio test was done with blocksize=3D4K , read and randread with num_jo=
bs=3D32.=20
>=20
>=20
>=20
>=20
>=20
> 1) First, I have done more tests with qemu optimisation, like iothrea=
d (dataplane) for virtio-blk disk,=20
> and num_queue=3D8 for virtio-scsi disks.=20
>=20
> for virtio iothread:=20
> --------------------=20
> It's working only with qemu + krbd, and for sequential reads.=20
> And It's seem that qemu aggregate reads in bigger ceph reads. (I see =
4x more iops on fio than on ceph, with same bandwith)=20
>=20
>=20
> for virtio-scsi num_queue =3D 8:=20
> -------------------------------=20
> works with krbd and librbd=20
>=20
> -for random read : I jump from 7000 to 12000iops=20
> -for sequential, qemu aggreate reads in bigger ceph reads. (Same, I s=
ee 4xmore iops on fio than on ceph, with same bandwith).=20
>=20
>=20
> So it seem to be useful for some specific workloads.=20
>=20
>=20
>=20
> 2 ) Now, about cpu usage, it's seem than librbd use really more cpu t=
han krbd,=20
>=20
> on host, librbd use 4x more cpu than krbd=20
> on qemu, librbd use 2x more cpu than krbd=20
>=20
>=20
> So, what could explain so much difference between both ?=20

Hi Alexandre, do you have access to perf? Especially on newer=20
kernels/distributions where you can use dwarf symbols, perf can give yo=
u=20
a lot of information about what is using CPU where. vtune is also a=20
nice option if you ave a license.=20

>=20
>=20
> Regards,=20
>=20
> Alexandre=20
>=20
>=20
>=20
> fio iops seq read summary results=20
> ----------------------------------=20
> qemu virtio iothread krbd vs qemu virtio iothread librbd : 27000 iops=
 vs 15000 ipos=20
> qemu virtio krbd vs qemu virtio librbd : 19000 iops vs 15000 iops=20
> qemu virtio-scsi krbd vs qemu virtio librbd : 50000 iops vs 48000 iop=
s=20
> host krbd vs host librbd : 36000 iops vs 25000 iops=20
>=20
>=20
>=20
> fio iops randread summary results=20
> ------------------------------=20
> qemu virtio iothread krbd vs qemu virtio iothread librbd : 15000 iops=
 vs 14000 iops=20
> qemu virtio krbd vs qemu virtio librbd : 14000 iops vs 15000 iops=20
> qemu virtio-scsi krbd vs qemu virtio librbd : 7500 iops vs 12000 iops=
=20
> host krbd vs host librbd : 38000 iops vs 25000 iops=20
>=20
>=20
> cpu usage ratio summary=20
> ------------------------=20
> qemu virtio krbd vs qemu virtio librbd : 2x more cpu usage for librbd=
=20
> qemu virtio-scsi krbd vs qemu virtio-scsi librbd : 2x more cpu usage =
for librbd=20
> host krbd vs host librbd : 4x more cpu usage for fio-rbd=20
>=20
>=20
>=20
>=20
>=20
>=20
> RESULTS=20
> -------=20
>=20
> host + fio - krbd=20
> -------------------=20
> read=20
> -----=20
> fio iops : 142.9MB/Ss , 36000 iops=20
> ceph : 134 MB/s rd, 34319 op/s=20
>=20
> fio : 70,4% kworker : 93,9% cpu =3D 164% cpu=20
>=20
> 100%cpu : 21000iops=20
>=20
> randread=20
> --------=20
> fio: 151MB/S,38000 iops=20
> ceph :148 MB/s rd, 37932 op/s=20
>=20
> fio : 80%cpu kwoker : 110,3%cpu =3D 180% cpu=20
>=20
> 100%cpu : 21000 iops=20
>=20
>=20
>=20
>=20
> host + fio-rbdengin :=20
> ---------------------=20
> randread (cpu bound)=20
> --------------------=20
> fio iops : 25000 ops=20
> ceph iops : 99636 kB/s rd, 24909 op/s=20
>=20
> fio : 460%cpu=20
>=20
> 100%cpu : 5415iops=20
>=20
> read (cpu bound)=20
> -----------------=20
> fio iops : 25000 ops=20
> ceph ios : 94212 kB/s rd, 23553 op/s=20
>=20
> fio : 480%cpu=20
>=20
> 100%cpu : 5323iops=20
>=20
>=20
>=20
>=20
>=20
> qemu + krbd + virtio + iothread=20
> ---------------------------------=20
> read=20
> ----=20
> fio :107MB/S : 27000 iops >>>SEEM THAT QEMU AGGREGATE READS ops=20
> ceph : 93942 kB/s rd, 12430 op/s=20
>=20
> kvm: 130% cpu - kworker : 41,2% =3D 171,2% cpu=20
>=20
> 100%cpu ratio : 7260iops=20
>=20
> randread=20
> --------=20
> fio : 60MBS - 15000 iops=20
> ceph : 54400 kB/s rd, 13600 op/s=20
>=20
> kvm: 95,0% cpu - kworker : 42,1 % cpu =3D 137,1%cpu=20
>=20
> 100%cpu ratio : 9919 iops=20
>=20
>=20
>=20
>=20
>=20
> qemu + krbd + virtio=20
> ----------------------=20
> read=20
> -----=20
> fio : 70mbs/ , 19000iops=20
> ceph:75705 kB/s rd, 18926 op/s=20
> kvm : 164% cpu - kworker : 48,5% cpu =3D 212,5%cpu=20
>=20
> 100%cpu ratio : 8906 iops=20
>=20
> randread=20
> --------=20
> fio : 54mbs/ , 14000iops=20
> ceph : 54800 kB/s rd, 13700 op/s=20
> kvm: 103% cpu - kworker 41,2% cpu =3D 144,2%cpu=20
>=20
> 100%cpu ratio : 9513 iops=20
>=20
>=20
>=20
> qemu + krbd + virtio-scsi (num_queue 8)=20
> --------------------------------------=20
> read:=20
> ----=20
> fio : 200MB / 50000 iops >>>SEEM THAT QEMU AGGREGATE READS ops=20
> ceph : 205 MB/s rd, 7648 op/s=20
>=20
> kvm: 145% kworker : 46,5% =3D 191,5%cpu=20
>=20
> 100%cpu ratio : 3993 iops=20
>=20
> randread:=20
> ----------=20
> fio : 30MB/S / 7500 iops=20
> ceph : 29318 kB/s rd, 7329 op/s=20
> kvm : 150% kworker : 21,4% cpu =3D 171,4% cpu=20
>=20
> 100%cpu ratio : 4275 iops=20
>=20
>=20
>=20
>=20
> qemu + librbd + virtio + iothread=20
> ----------------------------------=20
> read=20
> ----=20
> fio : 60MBS/s , 15000iops=20
> ceph: 56199 kB/s rd, 14052 op/s=20
>=20
> kvm: 300% cpu=20
>=20
> 100%cpu : 4666iops=20
>=20
>=20
> randread=20
> ---------=20
> fio : 56MBS/s, 14000iops=20
> ceph : 55916 kB/s rd, 13979 op/s=20
>=20
> kvm: 300% cpu=20
>=20
> 100%cpu : 4659 iops=20
>=20
>=20
>=20
> qemu + librbd + virtio=20
> -------------------------=20
> read=20
> -----=20
> fio : 60MBS/s, 15000iops=20
> ceph : 63021 kB/s rd, 15755 op/s=20
>=20
> kvm: 300% cpu=20
>=20
> 100%cpu : 5233 iops=20
>=20
> randread=20
> --------=20
> fio : 60MBS/s, 15000iops=20
> ceph : 55916 kB/s rd, 13979 op/s=20
>=20
> kvm : 300%cpu=20
>=20
> 100%cpu : 4659 iops=20
>=20
>=20
> qemu + librbd + virtio-scsi (num_queue 8)=20
> ----------------------------------------=20
> read=20
> ----=20
> fio : 256 MB/S , 48000iops >>>SEEM THAT QEMU AGGREGATE READS ops=20
> ceph : 244 MB/s rd, 12002 op/s=20
>=20
> kvm : 300% cpu=20
>=20
> 100%cpu : 4000 iops=20
>=20
> randread=20
> --------=20
> fio: 12000iops=20
> ceph iops : 47511 kB/s rd, 11877 op/s=20
>=20
> kvm: 300% cpu=20
>=20
> 100%cpu: 3959 iops=20
>=20
>=20
>=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
