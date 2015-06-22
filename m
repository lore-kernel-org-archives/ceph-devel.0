From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: rbd_cache, limiting read on high iops around 40k
Date: Mon, 22 Jun 2015 11:28:03 +0200
Message-ID: <B7D8B5F0-4AB9-449A-895D-CF87AE49BCF6@profihost.ag>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv>
	<1927317035.2874975.1434472710336.JavaMail.zimbra@oxygem.tv>
	<CAMc8nAXWAjFr8u+wgdEXLgudGpDYiOGDfLV-QhF8YJWFK0pjVg@mail.gmail.com>
	<1603543754.1547292.1434956923734.JavaMail.zimbra@oxygem.tv>
	<942E436A-5668-4F76-91E7-FAA08CC0F48A@profihost.ag>
	<CAF-rypwr9NCnGW_SiLjVKtgHsaDVUjb-1cJfksQpG+mOAD=dNQ@mail.gmail.com>
	<1581092206.1667776.1434963299884.JavaMail.zimbra@oxygem.tv>
	<CAF-rypz67RHWLzCCbJ=dbDiUM-pV1Q-Lk4VncUttoDEJrcQgTA@mail.gmail.com>
	<43279853.1688973.1434965164602.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0 (1.0)
Content-Type: multipart/mixed; boundary="===============1015844792=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <43279853.1688973.1434965164602.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pushpesh sharma <pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1015844792==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1282DBAB-8B98-4641-A75C-80024FBFFC86
Content-Transfer-Encoding: 7bit


--Apple-Mail-1282DBAB-8B98-4641-A75C-80024FBFFC86
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oh so it only works for virtio disks? I'm using scsi with the virtio PCI con=
troller.

Stefan

Excuse my typo sent from my mobile phone.

Am 22.06.2015 um 11:26 schrieb Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>:

>>> In proxmox 3.4 will it be possible to add at least in the configuration f=
ile? Or it entails a change in the source code KVM?=20
>>> Thanks.
>=20
> This small patch on top of qemu-server should be enough (I think it should=
 apply on 3.4 sources without problem)
>=20
> https://git.proxmox.com/?p=3Dqemu-server.git;a=3Dcommit;h=3D51f492cd6da022=
8129aaab1393b5c5844d75a53c
>=20
> No need to hack qemu-kvm
>=20
>=20
>=20
> ----- Mail original -----
> De: "Irek Fasikhov" <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> Cc: "Stefan Priebe" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>, "pushpesh sharma" <pushpesh.e=
ck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Somnath Roy" <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-devel" <ceph-d=
evel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Envoy=C3=A9: Lundi 22 Juin 2015 11:04:42
> Objet: Re: rbd_cache, limiting read on high iops around 40k
>=20
> | Proxmox 4.0 will allow to enable|disable 1 iothread by disk.=20
> Alexandre, Useful option!=20
> In proxmox 3.4 will it be possible to add at least in the configuration fi=
le? Or it entails a change in the source code KVM?=20
> Thanks.=20
>=20
> 2015-06-22 11:54 GMT+03:00 Alexandre DERUMIER < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > :=20=

>=20
>=20
>>> It is already possible to do in proxmox 3.4 (with the latest updates qem=
u-kvm 2.2.x). But it is necessary to register in the conf file iothread:1. Fo=
r single drives the ambiguous behavior of productivity.
>=20
> Yes and no ;)=20
>=20
> Currently in proxmox 3.4, iothread:1 generate only 1 iothread for all disk=
s.=20
>=20
> So, you'll have a small extra boost, but it'll not scale with multiple dis=
ks.=20
>=20
> Proxmox 4.0 will allow to enable|disable 1 iothread by disk.=20
>=20
>=20
>>> Does it also help for single disks or only multiple disks?
>=20
> Iothread can also help for single disk, because by default qemu use a main=
 thread for disk but also other things(don't remember what exactly)=20
>=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Irek Fasikhov" < malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
> =C3=80: "Stefan Priebe" < s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org >=20
> Cc: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >, "pushpesh sharma" < pushpesh.eck@=
gmail.com >, "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >, "ceph-devel" < ceph-=
devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
> Envoy=C3=A9: Lundi 22 Juin 2015 09:22:13=20
> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>=20
> It is already possible to do in proxmox 3.4 (with the latest updates qemu-=
kvm 2.2.x). But it is necessary to register in the conf file iothread:1. For=
 single drives the ambiguous behavior of productivity.=20
>=20
> 2015-06-22 10:12 GMT+03:00 Stefan Priebe - Profihost AG < s.priebe@profiho=
st.ag > :=20
>=20
>=20
>=20
> Am 22.06.2015 um 09:08 schrieb Alexandre DERUMIER < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >:=
=20
>=20
>>>> Just an update, there seems to be no proper way to pass iothread=20
>>>> parameter from openstack-nova (not at least in Juno release). So a=20
>>>> default single iothread per VM is what all we have. So in conclusion a=20=

>>>> nova instance max iops on ceph rbd will be limited to 30-40K.
>>=20
>> Thanks for the update.=20
>>=20
>> For proxmox users,=20
>>=20
>> I have added iothread option to gui for proxmox 4.0
>=20
> Can we make iothread the default? Does it also help for single disks or on=
ly multiple disks?=20
>=20
>> and added jemalloc as default memory allocator=20
>>=20
>>=20
>> I have also send a jemmaloc patch to qemu dev mailing=20
>> https://lists.gnu.org/archive/html/qemu-devel/2015-06/msg05265.html=20
>>=20
>> (Help is welcome to push it in qemu upstream ! )=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>> Cc: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >, "Irek Fasikhov" < malmyzh@=
gmail.com >, "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" < cep=
h-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>> Envoy=C3=A9: Lundi 22 Juin 2015 07:58:47=20
>> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>>=20
>> Just an update, there seems to be no proper way to pass iothread=20
>> parameter from openstack-nova (not at least in Juno release). So a=20
>> default single iothread per VM is what all we have. So in conclusion a=20=

>> nova instance max iops on ceph rbd will be limited to 30-40K.=20
>>=20
>> On Tue, Jun 16, 2015 at 10:08 PM, Alexandre DERUMIER=20
>> < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:=20
>>> Hi,=20
>>>=20
>>> some news about qemu with tcmalloc vs jemmaloc.=20
>>>=20
>>> I'm testing with multiple disks (with iothreads) in 1 qemu guest.=20
>>>=20
>>> And if tcmalloc is a little faster than jemmaloc,=20
>>>=20
>>> I have hit a lot of time the tcmalloc::ThreadCache::ReleaseToCentralCach=
e bug.=20
>>>=20
>>> increasing TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES, don't help.=20
>>>=20
>>>=20
>>> with multiple disk, I'm around 200k iops with tcmalloc (before hitting t=
he bug) and 350kiops with jemmaloc.=20
>>>=20
>>> The problem is that when I hit malloc bug, I'm around 4000-10000 iops, a=
nd only way to fix is is to restart qemu ...=20
>>>=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>> De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>> Cc: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >, "Irek Fasikhov" < malmyzh=
@gmail.com >, "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" < ce=
ph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>> Envoy=C3=A9: Vendredi 12 Juin 2015 08:58:21=20
>>> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>>>=20
>>> Thanks, posted the question in openstack list. Hopefully will get some=20=

>>> expert opinion.=20
>>>=20
>>> On Fri, Jun 12, 2015 at 11:33 AM, Alexandre DERUMIER=20
>>> < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:=20
>>>> Hi,=20
>>>>=20
>>>> here a libvirt xml sample from libvirt src=20
>>>>=20
>>>> (you need to define <iothreads> number, then assign then in disks).=20
>>>>=20
>>>> I don't use openstack, so I really don't known how it's working with it=
.=20
>>>>=20
>>>>=20
>>>> <domain type=3D'qemu'>=20
>>>> <name>QEMUGuest1</name>=20
>>>> <uuid>c7a5fdbd-edaf-9455-926a-d65c16db1809</uuid>=20
>>>> <memory unit=3D'KiB'>219136</memory>=20
>>>> <currentMemory unit=3D'KiB'>219136</currentMemory>=20
>>>> <vcpu placement=3D'static'>2</vcpu>=20
>>>> <iothreads>2</iothreads>=20
>>>> <os>=20
>>>> <type arch=3D'i686' machine=3D'pc'>hvm</type>=20
>>>> <boot dev=3D'hd'/>=20
>>>> </os>=20
>>>> <clock offset=3D'utc'/>=20
>>>> <on_poweroff>destroy</on_poweroff>
>>>> <on_reboot>restart</on_reboot>=20
>>>> <on_crash>destroy</on_crash>=20
>>>> <devices>=20
>>>> <emulator>/usr/bin/qemu</emulator>=20
>>>> <disk type=3D'file' device=3D'disk'>=20
>>>> <driver name=3D'qemu' type=3D'raw' iothread=3D'1'/>=20
>>>> <source file=3D'/var/lib/libvirt/images/iothrtest1.img'/>=20
>>>> <target dev=3D'vdb' bus=3D'virtio'/>=20
>>>> <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' func=
tion=3D'0x0'/>=20
>>>> </disk>=20
>>>> <disk type=3D'file' device=3D'disk'>=20
>>>> <driver name=3D'qemu' type=3D'raw' iothread=3D'2'/>=20
>>>> <source file=3D'/var/lib/libvirt/images/iothrtest2.img'/>=20
>>>> <target dev=3D'vdc' bus=3D'virtio'/>=20
>>>> </disk>=20
>>>> <controller type=3D'usb' index=3D'0'/>=20
>>>> <controller type=3D'ide' index=3D'0'/>=20
>>>> <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>=20
>>>> <memballoon model=3D'none'/>=20
>>>> </devices>=20
>>>> </domain>=20
>>>>=20
>>>>=20
>>>> ----- Mail original -----=20
>>>> De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>>> Cc: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >, "Irek Fasikhov" < malmyz=
h@gmail.com >, "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" < c=
eph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>> Envoy=C3=A9: Vendredi 12 Juin 2015 07:52:41=20
>>>> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>>>>=20
>>>> Hi Alexandre,=20
>>>>=20
>>>> I agree with your rational, of one iothread per disk. CPU consumed in=20=

>>>> IOwait is pretty high in each VM. But I am not finding a way to set=20
>>>> the same on a nova instance. I am using openstack Juno with QEMU+KVM.=20=

>>>> As per libvirt documentation for setting iothreads, I can edit=20
>>>> domain.xml directly and achieve the same effect. However in as in=20
>>>> openstack env domain xml is created by nova with some additional=20
>>>> metadata, so editing the domain xml using 'virsh edit' does not seems=20=

>>>> to work(I agree, it is not a very cloud way of doing things, but a=20
>>>> hack). Changes made there vanish after saving them, due to reason=20
>>>> libvirt validation fails on the same.=20
>>>>=20
>>>> #virsh dumpxml instance-000000c5 > vm.xml=20
>>>> #virt-xml-validate vm.xml=20
>>>> Relax-NG validity error : Extra element cpu in interleave=20
>>>> vm.xml:1: element domain: Relax-NG validity error : Element domain=20
>>>> failed to validate content=20
>>>> vm.xml fails to validate=20
>>>>=20
>>>> Second approach I took was to setting QoS in volumes types. But there=20=

>>>> is no option to set iothreads per volume, there are parameter realted=20=

>>>> to max_read/wrirte ops/bytes.=20
>>>>=20
>>>> Thirdly, editing Nova flavor and proving extra specs like=20
>>>> hw:cpu_socket/thread/core, can change guest CPU topology however again=20=

>>>> no way to set iothread. It does accept hw_disk_iothreads(no type check=20=

>>>> in place, i believe ), but can not pass the same in domain.xml.=20
>>>>=20
>>>> Could you suggest me a way to set the same.=20
>>>>=20
>>>> -Pushpesh=20
>>>>=20
>>>> On Wed, Jun 10, 2015 at 12:59 PM, Alexandre DERUMIER=20
>>>> < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:=20
>>>>>>> I need to try out the performance on qemu soon and may come back to y=
ou if I need some qemu setting trick :-)
>>>>>=20
>>>>> Sure no problem.=20
>>>>>=20
>>>>> (BTW, I can reach around 200k iops in 1 qemu vm with 5 virtio disks wi=
th 1 iothread by disk)=20
>>>>>=20
>>>>>=20
>>>>> ----- Mail original -----=20
>>>>> De: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >=20
>>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >, "Irek Fasikhov" < malmyzh=
@gmail.com >=20
>>>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "pushpesh sharma" < p=
ushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>>> Envoy=C3=A9: Mercredi 10 Juin 2015 09:06:32=20
>>>>> Objet: RE: rbd_cache, limiting read on high iops around 40k=20
>>>>>=20
>>>>> Hi Alexandre,=20
>>>>> Thanks for sharing the data.=20
>>>>> I need to try out the performance on qemu soon and may come back to yo=
u if I need some qemu setting trick :-)=20
>>>>>=20
>>>>> Regards=20
>>>>> Somnath=20
>>>>>=20
>>>>> -----Original Message-----=20
>>>>> From: ceph-users [mailto: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org ] On Behal=
f Of Alexandre DERUMIER=20
>>>>> Sent: Tuesday, June 09, 2015 10:42 PM=20
>>>>> To: Irek Fasikhov=20
>>>>> Cc: ceph-devel; pushpesh sharma; ceph-users=20
>>>>> Subject: Re: [ceph-users] rbd_cache, limiting read on high iops around=
 40k=20
>>>>>=20
>>>>>>> Very good work!=20
>>>>>>> Do you have a rpm-file?=20
>>>>>>> Thanks.
>>>>> no sorry, I'm have compiled it manually (and I'm using debian jessie a=
s client)=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> ----- Mail original -----=20
>>>>> De: "Irek Fasikhov" < malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
>>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>>>> Cc: "Robert LeBlanc" < robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org >, "ceph-devel" < ceph-dev=
el-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-us=
ers" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>>> Envoy=C3=A9: Mercredi 10 Juin 2015 07:21:42=20
>>>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 4=
0k=20
>>>>>=20
>>>>> Hi, Alexandre.=20
>>>>>=20
>>>>> Very good work!=20
>>>>> Do you have a rpm-file?=20
>>>>> Thanks.=20
>>>>>=20
>>>>> 2015-06-10 7:10 GMT+03:00 Alexandre DERUMIER < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > :=
=20
>>>>>=20
>>>>>=20
>>>>> Hi,=20
>>>>>=20
>>>>> I have tested qemu with last tcmalloc 2.4, and the improvement is huge=
 with iothread: 50k iops (+45%) !=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> qemu : no iothread : glibc : iops=3D33395 qemu : no-iothread : tcmallo=
c (2.2.1) : iops=3D34516 (+3%) qemu : no-iothread : jemmaloc : iops=3D42226 (=
+26%) qemu : no-iothread : tcmalloc (2.4) : iops=3D35974 (+7%)=20
>>>>>=20
>>>>>=20
>>>>> qemu : iothread : glibc : iops=3D34516=20
>>>>> qemu : iothread : tcmalloc : iops=3D38676 (+12%) qemu : iothread : jem=
maloc : iops=3D28023 (-19%) qemu : iothread : tcmalloc (2.4) : iops=3D50276 (=
+45%)=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)=20
>>>>> ------------------------------------------------------=20
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32=20
>>>>> fio-2.1.11=20
>>>>> Starting 1 process=20
>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [214.7MB/0KB/0KB /s] [54.1K/0/0 i=
ops] [eta 00m:00s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D894: Wed J=
un 10 05:54:24 2015 read : io=3D5120.0MB, bw=3D201108KB/s, iops=3D50276, run=
t=3D 26070msec slat (usec): min=3D1, max=3D1136, avg=3D 3.54, stdev=3D 3.58 c=
lat (usec): min=3D128, max=3D6262, avg=3D631.41, stdev=3D197.71 lat (usec): m=
in=3D149, max=3D6265, avg=3D635.27, stdev=3D197.40 clat percentiles (usec):=20=

>>>>> | 1.00th=3D[ 318], 5.00th=3D[ 378], 10.00th=3D[ 418], 20.00th=3D[ 474]=
,=20
>>>>> | 30.00th=3D[ 516], 40.00th=3D[ 564], 50.00th=3D[ 612], 60.00th=3D[ 65=
2],=20
>>>>> | 70.00th=3D[ 700], 80.00th=3D[ 756], 90.00th=3D[ 860], 95.00th=3D[ 98=
0],=20
>>>>> | 99.00th=3D[ 1272], 99.50th=3D[ 1384], 99.90th=3D[ 1688], 99.95th=3D[=
 1896],=20
>>>>> | 99.99th=3D[ 3760]=20
>>>>> bw (KB /s): min=3D145608, max=3D249688, per=3D100.00%, avg=3D201108.00=
, stdev=3D21718.87 lat (usec) : 250=3D0.04%, 500=3D25.84%, 750=3D53.00%, 100=
0=3D16.63% lat (msec) : 2=3D4.46%, 4=3D0.03%, 10=3D0.01% cpu : usr=3D9.73%, s=
ys=3D24.93%, ctx=3D66417, majf=3D0, minf=3D38 IO depths : 1=3D0.1%, 2=3D0.1%=
, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, >=3D64=3D0.0% submit : 0=3D0.0=
%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% comp=
lete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%, >=3D=
64=3D0.0% issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0 latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D201107KB/s, minb=3D201107KB/s, maxb=3D201=
107KB/s, mint=3D26070msec, maxt=3D26070msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1302555/0, merge=3D0/0, ticks=3D715176/0, in_queue=3D714840=
, util=3D99.73%=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32=20
>>>>> fio-2.1.11=20
>>>>> Starting 1 process=20
>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [158.7MB/0KB/0KB /s] [40.6K/0/0 i=
ops] [eta 00m:00s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D889: Wed J=
un 10 06:05:06 2015 read : io=3D5120.0MB, bw=3D143897KB/s, iops=3D35974, run=
t=3D 36435msec slat (usec): min=3D1, max=3D710, avg=3D 3.31, stdev=3D 3.35 c=
lat (usec): min=3D191, max=3D4740, avg=3D884.66, stdev=3D315.65 lat (usec): m=
in=3D289, max=3D4743, avg=3D888.31, stdev=3D315.51 clat percentiles (usec):=20=

>>>>> | 1.00th=3D[ 462], 5.00th=3D[ 516], 10.00th=3D[ 548], 20.00th=3D[ 596]=
,=20
>>>>> | 30.00th=3D[ 652], 40.00th=3D[ 764], 50.00th=3D[ 868], 60.00th=3D[ 94=
0],=20
>>>>> | 70.00th=3D[ 1004], 80.00th=3D[ 1096], 90.00th=3D[ 1256], 95.00th=3D[=
 1416],=20
>>>>> | 99.00th=3D[ 2024], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=3D[=
 2640],=20
>>>>> | 99.99th=3D[ 3632]=20
>>>>> bw (KB /s): min=3D98352, max=3D177328, per=3D99.91%, avg=3D143772.11, s=
tdev=3D21782.39 lat (usec) : 250=3D0.01%, 500=3D3.48%, 750=3D35.69%, 1000=3D=
30.01% lat (msec) : 2=3D29.74%, 4=3D1.07%, 10=3D0.01% cpu : usr=3D7.10%, sys=
=3D16.90%, ctx=3D54855, majf=3D0, minf=3D38 IO depths : 1=3D0.1%, 2=3D0.1%, 4=
=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, >=3D64=3D0.0% submit : 0=3D0.0%, 4=
=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete=
 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%, >=3D64=3D=
0.0% issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 lat=
ency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D143896KB/s, minb=3D143896KB/s, maxb=3D143=
896KB/s, mint=3D36435msec, maxt=3D36435msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1301357/0, merge=3D0/0, ticks=3D1033036/0, in_queue=3D10327=
16, util=3D99.85%=20
>>>>>=20
>>>>>=20
>>>>> ----- Mail original -----=20
>>>>> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>>>> =C3=80: "Robert LeBlanc" < robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org >=20
>>>>> Cc: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >, "ceph-devel" < ceph-devel@vg=
er.kernel.org >, "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-users" <=
 ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>>> Envoy=C3=A9: Mardi 9 Juin 2015 18:47:27=20
>>>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 4=
0k=20
>>>>>=20
>>>>> Hi Robert,=20
>>>>>=20
>>>>>>> What I found was that Ceph OSDs performed well with either tcmalloc o=
r=20
>>>>>>> jemalloc (except when RocksDB was built with jemalloc instead of=20
>>>>>>> tcmalloc, I'm still working to dig into why that might be the case).=

>>>>> yes,from my test, for osd tcmalloc is a little faster (but very little=
) than jemalloc.=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>>> However, I found that tcmalloc with QEMU/KVM was very detrimental to=
=20
>>>>>>> small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much=
=20
>>>>>>> better for QEMU/KVM in the tests that we ran. [1]
>>>>>=20
>>>>>=20
>>>>> Just have done qemu test (4k randread - rbd_cache=3Doff), I don't see s=
peed regression with tcmalloc.=20
>>>>> with qemu iothread, tcmalloc have a speed increase over glib=20
>>>>> with qemu iothread, jemalloc have a speed decrease=20
>>>>>=20
>>>>> without iothread, jemalloc have a big speed increase=20
>>>>>=20
>>>>> this is with=20
>>>>> -qemu 2.3=20
>>>>> -tcmalloc 2.2.1=20
>>>>> -jemmaloc 3.6=20
>>>>> -libc6 2.19=20
>>>>>=20
>>>>>=20
>>>>> qemu : no iothread : glibc : iops=3D33395=20
>>>>> qemu : no-iothread : tcmalloc : iops=3D34516 (+3%)=20
>>>>> qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)=20
>>>>>=20
>>>>> qemu : iothread : glibc : iops=3D34516=20
>>>>> qemu : iothread : tcmalloc : iops=3D38676 (+12%)=20
>>>>> qemu : iothread : jemmaloc : iops=3D28023 (-19%)=20
>>>>>=20
>>>>>=20
>>>>> (The benefit of iothreads is that we can scale with more disks in 1vm)=
=20
>>>>>=20
>>>>>=20
>>>>> fio results:=20
>>>>> ------------=20
>>>>>=20
>>>>> qemu : iothread : tcmalloc : iops=3D38676=20
>>>>> -----------------------------------------=20
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32=20
>>>>> fio-2.1.11=20
>>>>> Starting 1 process=20
>>>>> Jobs: 1 (f=3D0): [r(1)] [100.0% done] [123.5MB/0KB/0KB /s] [31.6K/0/0 i=
ops] [eta 00m:00s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D1265: Tue=
 Jun 9 18:16:53 2015=20
>>>>> read : io=3D5120.0MB, bw=3D154707KB/s, iops=3D38676, runt=3D 33889msec=
=20
>>>>> slat (usec): min=3D1, max=3D715, avg=3D 3.63, stdev=3D 3.42=20
>>>>> clat (usec): min=3D152, max=3D5736, avg=3D822.12, stdev=3D289.34=20
>>>>> lat (usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D289.08=20
>>>>> clat percentiles (usec):=20
>>>>> | 1.00th=3D[ 402], 5.00th=3D[ 466], 10.00th=3D[ 510], 20.00th=3D[ 572]=
,=20
>>>>> | 30.00th=3D[ 636], 40.00th=3D[ 716], 50.00th=3D[ 780], 60.00th=3D[ 85=
2],=20
>>>>> | 70.00th=3D[ 932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], 95.00th=3D[ 1=
352],=20
>>>>> | 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=3D[ 2256], 99.95th=3D[=
 2448],=20
>>>>> | 99.99th=3D[ 3888]=20
>>>>> bw (KB /s): min=3D123888, max=3D198584, per=3D100.00%, avg=3D154824.40=
, stdev=3D16978.03=20
>>>>> lat (usec) : 250=3D0.01%, 500=3D8.91%, 750=3D36.44%, 1000=3D32.63%=20
>>>>> lat (msec) : 2=3D21.65%, 4=3D0.37%, 10=3D0.01%=20
>>>>> cpu : usr=3D8.29%, sys=3D19.76%, ctx=3D55882, majf=3D0, minf=3D39=20
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D10=
0.0%, >=3D64=3D0.0%=20
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%=20
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D154707KB/s, minb=3D154707KB/s, maxb=3D154=
707KB/s, mint=3D33889msec, maxt=3D33889msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_queue=3D934096=
, util=3D99.77%=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> qemu : no-iothread : tcmalloc : iops=3D34516=20
>>>>> ---------------------------------------------=20
>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s] [41.8K/0/0 i=
ops] [eta 00m:00s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D896: Tue J=
un 9 18:19:08 2015=20
>>>>> read : io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=3D 37974msec=
=20
>>>>> slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.57=20
>>>>> clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=3D333.61=20
>>>>> lat (usec): min=3D266, max=3D11862, avg=3D925.77, stdev=3D333.40=20
>>>>> clat percentiles (usec):=20
>>>>> | 1.00th=3D[ 434], 5.00th=3D[ 510], 10.00th=3D[ 564], 20.00th=3D[ 652]=
,=20
>>>>> | 30.00th=3D[ 732], 40.00th=3D[ 812], 50.00th=3D[ 876], 60.00th=3D[ 94=
0],=20
>>>>> | 70.00th=3D[ 1020], 80.00th=3D[ 1112], 90.00th=3D[ 1320], 95.00th=3D[=
 1576],=20
>>>>> | 99.00th=3D[ 1992], 99.50th=3D[ 2128], 99.90th=3D[ 2736], 99.95th=3D[=
 3248],=20
>>>>> | 99.99th=3D[ 4320]=20
>>>>> bw (KB /s): min=3D77312, max=3D185576, per=3D99.74%, avg=3D137709.88, s=
tdev=3D16883.77=20
>>>>> lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=3D35.60%=20
>>>>> lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01%=20
>>>>> cpu : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, minf=3D38=20
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D10=
0.0%, >=3D64=3D0.0%=20
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%=20
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s, maxb=3D138=
064KB/s, mint=3D37974msec, maxt=3D37974msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1309902/0, merge=3D0/0, ticks=3D1068768/0, in_queue=3D10683=
96, util=3D99.86%=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> qemu : iothread : glibc : iops=3D34516=20
>>>>> -------------------------------------=20
>>>>>=20
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32=20
>>>>> fio-2.1.11=20
>>>>> Starting 1 process=20
>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0KB /s] [34.2K/0/0 i=
ops] [eta 00m:00s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D876: Tue J=
un 9 18:24:01 2015=20
>>>>> read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=3D 38051msec=
=20
>>>>> slat (usec): min=3D1, max=3D496, avg=3D 3.88, stdev=3D 3.66=20
>>>>> clat (usec): min=3D283, max=3D7515, avg=3D923.34, stdev=3D300.28=20
>>>>> lat (usec): min=3D286, max=3D7519, avg=3D927.58, stdev=3D300.02=20
>>>>> clat percentiles (usec):=20
>>>>> | 1.00th=3D[ 506], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652]=
,=20
>>>>> | 30.00th=3D[ 724], 40.00th=3D[ 804], 50.00th=3D[ 884], 60.00th=3D[ 96=
4],=20
>>>>> | 70.00th=3D[ 1048], 80.00th=3D[ 1144], 90.00th=3D[ 1304], 95.00th=3D[=
 1448],=20
>>>>> | 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480], 99.95th=3D[=
 2640],=20
>>>>> | 99.99th=3D[ 3984]=20
>>>>> bw (KB /s): min=3D102680, max=3D171112, per=3D100.00%, avg=3D137877.78=
, stdev=3D15521.30=20
>>>>> lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.82%=20
>>>>> lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01%=20
>>>>> cpu : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, minf=3D38=20
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D10=
0.0%, >=3D64=3D0.0%=20
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%=20
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s, maxb=3D137=
785KB/s, mint=3D38051msec, maxt=3D38051msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1307426/0, merge=3D0/0, ticks=3D1051416/0, in_queue=3D10509=
72, util=3D99.85%=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> qemu : no iothread : glibc : iops=3D33395=20
>>>>> -----------------------------------------=20
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32=20
>>>>> fio-2.1.11=20
>>>>> Starting 1 process=20
>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s] [32.9K/0/0 i=
ops] [eta 00m:00s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D886: Tue J=
un 9 18:27:18 2015=20
>>>>> read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=3D 39248msec=
=20
>>>>> slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.29=20
>>>>> clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=3D335.51=20
>>>>> lat (usec): min=3D303, max=3D12638, avg=3D957.01, stdev=3D335.29=20
>>>>> clat percentiles (usec):=20
>>>>> | 1.00th=3D[ 516], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652]=
,=20
>>>>> | 30.00th=3D[ 724], 40.00th=3D[ 820], 50.00th=3D[ 924], 60.00th=3D[ 99=
6],=20
>>>>> | 70.00th=3D[ 1080], 80.00th=3D[ 1176], 90.00th=3D[ 1336], 95.00th=3D[=
 1528],=20
>>>>> | 99.00th=3D[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672], 99.95th=3D[=
 2928],=20
>>>>> | 99.99th=3D[ 4832]=20
>>>>> bw (KB /s): min=3D98136, max=3D171624, per=3D100.00%, avg=3D133682.64,=
 stdev=3D19121.91=20
>>>>> lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=3D26.98%=20
>>>>> lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01%=20
>>>>> cpu : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D0, minf=3D38=20
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D10=
0.0%, >=3D64=3D0.0%=20
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%=20
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s, maxb=3D133=
583KB/s, mint=3D39248msec, maxt=3D39248msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1304526/0, merge=3D0/0, ticks=3D1075020/0, in_queue=3D10745=
36, util=3D99.84%=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> qemu : iothread : jemmaloc : iops=3D28023=20
>>>>> ----------------------------------------=20
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32=20
>>>>> fio-2.1.11=20
>>>>> Starting 1 process=20
>>>>> Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] [39.1K/0/0 i=
ops] [eta 00m:01s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D899: Tue J=
un 9 18:30:26 2015=20
>>>>> read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=3D 46772msec=
=20
>>>>> slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.77=20
>>>>> clat (usec): min=3D253, max=3D11307, avg=3D1135.63, stdev=3D346.55=20
>>>>> lat (usec): min=3D256, max=3D11309, avg=3D1140.39, stdev=3D346.22=20
>>>>> clat percentiles (usec):=20
>>>>> | 1.00th=3D[ 510], 5.00th=3D[ 628], 10.00th=3D[ 700], 20.00th=3D[ 820]=
,=20
>>>>> | 30.00th=3D[ 924], 40.00th=3D[ 1032], 50.00th=3D[ 1128], 60.00th=3D[ 1=
224],=20
>>>>> | 70.00th=3D[ 1320], 80.00th=3D[ 1416], 90.00th=3D[ 1560], 95.00th=3D[=
 1688],=20
>>>>> | 99.00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=3D[=
 2832],=20
>>>>> | 99.99th=3D[ 3760]=20
>>>>> bw (KB /s): min=3D91792, max=3D174416, per=3D99.90%, avg=3D111985.27, s=
tdev=3D17381.70=20
>>>>> lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33%=20
>>>>> lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01%=20
>>>>> cpu : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, minf=3D38=20
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D10=
0.0%, >=3D64=3D0.0%=20
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%=20
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s, maxb=3D112=
094KB/s, mint=3D46772msec, maxt=3D46772msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1309169/0, merge=3D0/0, ticks=3D1305796/0, in_queue=3D13053=
76, util=3D98.68%=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> qemu : non-iothread : jemmaloc : iops=3D42226=20
>>>>> --------------------------------------------=20
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32=20
>>>>> fio-2.1.11=20
>>>>> Starting 1 process=20
>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s] [43.9K/0/0 i=
ops] [eta 00m:00s]=20
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D892: Tue J=
un 9 18:34:11 2015=20
>>>>> read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=3D 29599msec=
=20
>>>>> slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D 3.74=20
>>>>> clat (usec): min=3D174, max=3D3841, avg=3D717.08, stdev=3D237.53=20
>>>>> lat (usec): min=3D210, max=3D3844, avg=3D721.23, stdev=3D237.22=20
>>>>> clat percentiles (usec):=20
>>>>> | 1.00th=3D[ 354], 5.00th=3D[ 422], 10.00th=3D[ 462], 20.00th=3D[ 516]=
,=20
>>>>> | 30.00th=3D[ 572], 40.00th=3D[ 628], 50.00th=3D[ 684], 60.00th=3D[ 74=
0],=20
>>>>> | 70.00th=3D[ 804], 80.00th=3D[ 884], 90.00th=3D[ 1004], 95.00th=3D[ 1=
128],=20
>>>>> | 99.00th=3D[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928], 99.95th=3D[=
 2064],=20
>>>>> | 99.99th=3D[ 2608]=20
>>>>> bw (KB /s): min=3D138120, max=3D230816, per=3D100.00%, avg=3D177192.14=
, stdev=3D23440.79=20
>>>>> lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=3D27.46%=20=

>>>>> lat (msec) : 2=3D10.30%, 4=3D0.07%=20
>>>>> cpu : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, minf=3D39=20
>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D10=
0.0%, >=3D64=3D0.0%=20
>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%=20
>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>>>>=20
>>>>> Run status group 0 (all jobs):=20
>>>>> READ: io=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s, maxb=3D177=
130KB/s, mint=3D29599msec, maxt=3D29599msec=20
>>>>>=20
>>>>> Disk stats (read/write):=20
>>>>> vdb: ios=3D1303992/0, merge=3D0/0, ticks=3D798008/0, in_queue=3D797636=
, util=3D99.80%=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> ----- Mail original -----=20
>>>>> De: "Robert LeBlanc" < robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org >=20
>>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>>>> Cc: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >, "ceph-devel" < ceph-devel@vg=
er.kernel.org >, "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-users" <=
 ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>>> Envoy=C3=A9: Mardi 9 Juin 2015 18:00:29=20
>>>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 4=
0k=20
>>>>>=20
>>>>> -----BEGIN PGP SIGNED MESSAGE-----=20
>>>>> Hash: SHA256=20
>>>>>=20
>>>>> I also saw a similar performance increase by using alternative memory=20=

>>>>> allocators. What I found was that Ceph OSDs performed well with either=
=20
>>>>> tcmalloc or jemalloc (except when RocksDB was built with jemalloc=20
>>>>> instead of tcmalloc, I'm still working to dig into why that might be=20=

>>>>> the case).=20
>>>>>=20
>>>>> However, I found that tcmalloc with QEMU/KVM was very detrimental to=20=

>>>>> small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much=20=

>>>>> better for QEMU/KVM in the tests that we ran. [1]=20
>>>>>=20
>>>>> I'm currently looking into I/O bottlenecks around the 16KB range and=20=

>>>>> I'm seeing a lot of time in thread creation and destruction, the=20
>>>>> memory allocators are quite a bit down the list (both fio with=20
>>>>> ioengine rbd and on the OSDs). I wonder what the difference can be.=20=

>>>>> I've tried using the async messenger but there wasn't a huge=20
>>>>> difference. [2]=20
>>>>>=20
>>>>> Further down the rabbit hole....=20
>>>>>=20
>>>>> [1] https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg20197.ht=
ml=20
>>>>> [2] https://www.mail-archive.com/ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg23982.h=
tml=20
>>>>> -----BEGIN PGP SIGNATURE-----=20
>>>>> Version: Mailvelope v0.13.1=20
>>>>> Comment: https://www.mailvelope.com=20
>>>>>=20
>>>>> wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4MwP/1vt65cvTyyVGGSGRrE8=20
>>>>> unuWjafMHzl486XH+EaVrDVTXFVFOoncJ6kugSpD7yavtCpZNdhsIaTRZguU=20
>>>>> YpfAppNAJU5biSwNv9QPI7kPP2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw87
>>>>> afq46GhPHqEXdjp3rOB4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnCY2=20
>>>>> S695Dt1gzt0ERUOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivVl3=20
>>>>> vDYWxQHPK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+51=20
>>>>> 9ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPGOO=20
>>>>> qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHhu3=20
>>>>> Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c7b=20
>>>>> 6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV13=20
>>>>> R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTKVzQ=20
>>>>> 1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfbuEHalVjz4=20
>>>>> oSJX=20
>>>>> =3Dk281=20
>>>>> -----END PGP SIGNATURE-----=20
>>>>> ----------------=20
>>>>> Robert LeBlanc=20
>>>>> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904 C70E E654 3BB2 FA62 B9F1=20
>>>>>=20
>>>>>=20
>>>>> On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DERUMIER < aderumier@odiso.c=
om > wrote:=20
>>>>>>>> Frankly, I'm a little impressed that without RBD cache we can hit 8=
0K=20
>>>>>>>> IOPS from 1 VM!
>>>>>>=20
>>>>>> Note that theses result are not in a vm (fio-rbd on host), so in a vm=
 we'll have overhead.=20
>>>>>> (I'm planning to send results in qemu soon)=20
>>>>>>=20
>>>>>>>> How fast are the SSDs in those 3 OSDs?
>>>>>>=20
>>>>>> Theses results are with datas in buffer memory of osd nodes.=20
>>>>>>=20
>>>>>> When reading fulling on ssd (intel s3500),=20
>>>>>>=20
>>>>>> For 1 client,=20
>>>>>>=20
>>>>>> I'm around 33k iops without cache and 32k iops with cache, with 1 osd=
.=20
>>>>>> I'm around 55k iops without cache and 38k iops with cache, with 3 osd=
.=20
>>>>>>=20
>>>>>> with multiple clients jobs, I can reach around 70kiops by osd , and 2=
50k iops by osd when datas are in buffer.=20
>>>>>>=20
>>>>>> (cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> small tip :=20
>>>>>> I'm using tcmalloc for fio-rbd or rados bench to improve latencies by=
 around 20%=20
>>>>>>=20
>>>>>> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...=20
>>>>>> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ...=20
>>>>>>=20
>>>>>> as a lot of time is spent in malloc/free=20
>>>>>>=20
>>>>>>=20
>>>>>> (qemu support also tcmalloc since some months , I'll bench it too=20
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html )=
=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> I'll try to send full bench results soon, from 1 to 18 ssd osd.=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> ----- Mail original -----=20
>>>>>> De: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >=20
>>>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >, "pushpesh sharma" < push=
pesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
>>>>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" < ceph-=
users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>>>> Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31=20
>>>>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 4=
0k=20
>>>>>>=20
>>>>>> Hi All,=20
>>>>>>=20
>>>>>> In the past we've hit some performance issues with RBD cache that we'=
ve=20
>>>>>> fixed, but we've never really tried pushing a single VM beyond 40+K r=
ead=20
>>>>>> IOPS in testing (or at least I never have). I suspect there's a coupl=
e=20
>>>>>> of possibilities as to why it might be slower, but perhaps joshd can=20=

>>>>>> chime in as he's more familiar with what that code looks like.=20
>>>>>>=20
>>>>>> Frankly, I'm a little impressed that without RBD cache we can hit 80K=
=20
>>>>>> IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?=20
>>>>>>=20
>>>>>> Mark=20
>>>>>>=20
>>>>>>> On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:=20
>>>>>>> It's seem that the limit is mainly going in high queue depth (+- > 1=
6)=20
>>>>>>>=20
>>>>>>> Here the result in iops with 1client- 4krandread- 3osd - with differ=
ents queue depth size.=20
>>>>>>> rbd_cache is almost the same than without cache with queue depth <16=
=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> cache=20
>>>>>>> -----=20
>>>>>>> qd1: 1651=20
>>>>>>> qd2: 3482=20
>>>>>>> qd4: 7958=20
>>>>>>> qd8: 17912=20
>>>>>>> qd16: 36020=20
>>>>>>> qd32: 42765=20
>>>>>>> qd64: 46169=20
>>>>>>>=20
>>>>>>> no cache=20
>>>>>>> --------=20
>>>>>>> qd1: 1748=20
>>>>>>> qd2: 3570=20
>>>>>>> qd4: 8356=20
>>>>>>> qd8: 17732=20
>>>>>>> qd16: 41396=20
>>>>>>> qd32: 78633=20
>>>>>>> qd64: 79063=20
>>>>>>> qd128: 79550=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> ----- Mail original -----=20
>>>>>>> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>>>>>> =C3=80: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
>>>>>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" < ceph=
-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>>>>> Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21=20
>>>>>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around=
 40k=20
>>>>>>>=20
>>>>>>> Hi,=20
>>>>>>>=20
>>>>>>>>> We tried adding more RBDs to single VM, but no luck.
>>>>>>>=20
>>>>>>> If you want to scale with more disks in a single qemu vm, you need t=
o use iothread feature from qemu and assign 1 iothread by disk (works with v=
irtio-blk).=20
>>>>>>> It's working for me, I can scale with adding more disks.=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> My bench here are done with fio-rbd on host.=20
>>>>>>> I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a sing=
le host and around 250kiops 10clients-rbdcache=3Don.=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> I just wonder why I don't have performance decrease around 30k iops w=
ith 1osd.=20
>>>>>>>=20
>>>>>>> I'm going to see if this tracker=20
>>>>>>> http://tracker.ceph.com/issues/11056=20
>>>>>>>=20
>>>>>>> could be the cause.=20
>>>>>>>=20
>>>>>>> (My master build was done some week ago)=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> ----- Mail original -----=20
>>>>>>> De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >=20
>>>>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=20
>>>>>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" < ceph=
-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >=20
>>>>>>> Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04=20
>>>>>>> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>>>>>>>=20
>>>>>>> Hi Alexandre,=20
>>>>>>>=20
>>>>>>> We have also seen something very similar on Hammer(0.94-1). We were d=
oing some benchmarking for VMs hosted on hypervisor (QEMU-KVM, openstack-jun=
o). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as additional storage. =
For some strange reason it was not able to scale 4K- RR iops on each VM beyo=
nd 35-40k. We tried adding more RBDs to single VM, but no luck. However incr=
easing number of VMs to 4 on a single hypervisor did scale to some extent. A=
fter this there was no much benefit we got from adding more VMs.=20
>>>>>>>=20
>>>>>>> Here is the trend we have seen, x-axis is number of hypervisor, each=
 hypervisor has 4 VM, each VM has 1 RBD:-=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> VDbench is used as benchmarking tool. We were not saturating network=
 and CPUs at OSD nodes. We were not able to saturate CPUs at hypervisors, an=
d that is where we were suspecting of some throttling effect. However we hav=
en't setted any such limits from nova or kvm end. We tried some CPU pinning a=
nd other KVM related tuning as well, but no luck.=20
>>>>>>>=20
>>>>>>> We tried the same experiment on a bare metal. It was 4K RR IOPs were=
 scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than scaling=
 beyond that point the numbers were actually degrading. (Single pipe more co=
ngestion effect)=20
>>>>>>>=20
>>>>>>> We never suspected that rbd cache enable could be detrimental to per=
formance. It would nice to route cause the problem if that is the case.=20
>>>>>>>=20
>>>>>>> On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER < aderumier@odis=
o.com > wrote:=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> Hi,=20
>>>>>>>=20
>>>>>>> I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D=
32,=20
>>>>>>> and rbd_cache=3Dtrue seem to limit the iops around 40k=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> no cache=20
>>>>>>> --------=20
>>>>>>> 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops=20
>>>>>>> 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops=20
>>>>>>> 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> cache=20
>>>>>>> -----=20
>>>>>>> 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops=20
>>>>>>> 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops=20
>>>>>>> 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> Is it expected ?=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> fio result rbd_cache=3Dfalse 3 osd=20
>>>>>>> --------------------------------=20
>>>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Drbd, iodepth=3D32=20
>>>>>>> fio-2.1.11=20
>>>>>>> Starting 1 process=20
>>>>>>> rbd engine: RBD version: 0.1.9=20
>>>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/=
0 iops] [eta 00m:00s]=20
>>>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548:=
 Tue Jun 9 07:48:42 2015=20
>>>>>>> read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698mse=
c=20
>>>>>>> slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77=20
>>>>>>> clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82=20
>>>>>>> lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49=20
>>>>>>> clat percentiles (usec):=20
>>>>>>> | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ 26=
2],=20
>>>>>>> | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D[ 3=
46],=20
>>>>>>> | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D[ 5=
06],=20
>>>>>>> | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D[ 9=
48],=20
>>>>>>> | 99.99th=3D[ 1176]=20
>>>>>>> bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D313402.=
34, stdev=3D25196.21=20
>>>>>>> lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, 1=
000=3D0.23%=20
>>>>>>> lat (msec) : 2=3D0.03%, 4=3D0.01%=20
>>>>>>> cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D124=
52=20
>>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=3D=
12.1%, >=3D64=3D0.0%=20
>>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>>>> complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>>>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20=

>>>>>>>=20
>>>>>>> Run status group 0 (all jobs):=20
>>>>>>> READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D31=
3169KB/s, mint=3D32698msec, maxt=3D32698msec=20
>>>>>>>=20
>>>>>>> Disk stats (read/write):=20
>>>>>>> dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.0=
0%, aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0, agg=
rutil=3D0.00%=20
>>>>>>> sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.0=
0%=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> fio result rbd_cache=3Dtrue 3osd=20
>>>>>>> ------------------------------=20
>>>>>>>=20
>>>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, i=
oengine=3Drbd, iodepth=3D32=20
>>>>>>> fio-2.1.11=20
>>>>>>> Starting 1 process=20
>>>>>>> rbd engine: RBD version: 0.1.9=20
>>>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/=
0 iops] [eta 00m:00s]=20
>>>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389:=
 Tue Jun 9 07:47:30 2015=20
>>>>>>> read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866mse=
c=20
>>>>>>> slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84=20
>>>>>>> clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73=20
>>>>>>> lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03=20
>>>>>>> clat percentiles (usec):=20
>>>>>>> | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ 35=
0],=20
>>>>>>> | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D[ 5=
06],=20
>>>>>>> | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D[ 7=
24],=20
>>>>>>> | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=3D[=
 1288],=20
>>>>>>> | 99.99th=3D[ 2192]=20
>>>>>>> bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D183315.=
10, stdev=3D15079.93=20
>>>>>>> lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%=20=

>>>>>>> lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%=20
>>>>>>> cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D14=
100=20
>>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=3D=
5.3%, >=3D64=3D0.0%=20
>>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>>>> complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>>>>>>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20=

>>>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20=

>>>>>>>=20
>>>>>>> Run status group 0 (all jobs):=20
>>>>>>> READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D18=
3295KB/s, mint=3D55866msec, maxt=3D55866msec=20
>>>>>>>=20
>>>>>>> Disk stats (read/write):=20
>>>>>>> dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0.0=
1%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8, agg=
rutil=3D0.01%=20
>>>>>>> sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.0=
1%
>>>>>> _______________________________________________=20
>>>>>> ceph-users mailing list=20
>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>> _______________________________________________=20
>>>>> ceph-users mailing list=20
>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> --=20
>>>>> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=
=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=
=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87=20
>>>>> =D0=9C=D0=BE=D0=B1.: +79229045757=20
>>>>> _______________________________________________=20
>>>>> ceph-users mailing list=20
>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=20
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
>>>>>=20
>>>>> ________________________________=20
>>>>>=20
>>>>> PLEASE NOTE: The information contained in this electronic mail message=
 is intended only for the use of the designated recipient(s) named above. If=
 the reader of this message is not the intended recipient, you are hereby no=
tified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited.=
 If you have received this communication in error, please notify the sender b=
y telephone or e-mail (as shown above) immediately and destroy any and all c=
opies of this message in your possession (whether hard copies or electronica=
lly stored copies).
>>>>=20
>>>>=20
>>>>=20
>>>> --=20
>>>> -Pushpesh
>>>=20
>>>=20
>>>=20
>>> --=20
>>> -Pushpesh
>>=20
>>=20
>>=20
>> --=20
>> -Pushpesh=20
>>=20
>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=
=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87=20
> =D0=9C=D0=BE=D0=B1.: +79229045757=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=
=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87=20
> =D0=9C=D0=BE=D0=B1.: +79229045757=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in

--Apple-Mail-1282DBAB-8B98-4641-A75C-80024FBFFC86
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>Oh so it only works for virtio disks? I=
'm using scsi with the virtio PCI controller.<br><br>Stefan<div><br></div><d=
iv>Excuse my typo s<span style=3D"font-size: 13pt;">ent from my mobile phone=
.</span></div></div><div><br>Am 22.06.2015 um 11:26 schrieb Alexandre DERUMI=
ER &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;:<b=
r><br></div><blockquote type=3D"cite"><div><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>In proxmox 3.4 will it be possible to add at least i=
n the configuration file? Or it entails a change in the source code KVM? </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>Thanks. </span><br></blockquote></blockquote><span></span><b=
r><span>This small patch on top of qemu-server should be enough (I think it s=
hould apply on 3.4 sources without problem)</span><br><span></span><br><span=
><a href=3D"https://git.proxmox.com/?p=3Dqemu-server.git;a=3Dcommit;h=3D51f4=
92cd6da0228129aaab1393b5c5844d75a53c">https://git.proxmox.com/?p=3Dqemu-serv=
er.git;a=3Dcommit;h=3D51f492cd6da0228129aaab1393b5c5844d75a53c</a></span><br=
><span></span><br><span>No need to hack qemu-kvm</span><br><span></span><br>=
<span></span><br><span></span><br><span>----- Mail original -----</span><br>=
<span>De: "Irek Fasikhov" &lt;<a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh@g=
mail.com</a>&gt;</span><br><span>=C3=80: "aderumier" &lt;<a href=3D"mailto:a=
derumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;</span><br><span>Cc: "Stefan P=
riebe" &lt;<a href=3D"mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a=
>&gt;, "pushpesh sharma" &lt;<a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushp=
esh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;, "Somnath Roy" &lt;<a href=3D"mailto:Somnath.Roy@s=
andisk.com">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;, "ceph-devel" &lt;<a href=3D"mai=
lto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, "ceph-us=
ers" &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFKrVG3r5yU2QA@public.gmane.org=
com</a>&gt;</span><br><span>Envoy=C3=A9: Lundi 22 Juin 2015 11:04:42</span><=
br><span>Objet: Re: rbd_cache, limiting read on high iops around 40k</span><=
br><span></span><br><span>| Proxmox 4.0 will allow to enable|disable 1 iothr=
ead by disk. </span><br><span>Alexandre, Useful option! </span><br><span>In p=
roxmox 3.4 will it be possible to add at least in the configuration file? Or=
 it entails a change in the source code KVM? </span><br><span>Thanks. </span=
><br><span></span><br><span>2015-06-22 11:54 GMT+03:00 Alexandre DERUMIER &l=
t; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; : </s=
pan><br><span></span><br><span></span><br><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>It is already possible to do in proxmox 3.4 (with th=
e latest updates qemu-kvm 2.2.x). But it is necessary to register in the con=
f file iothread:1. For single drives the ambiguous behavior of productivity.=
 </span><br></blockquote></blockquote><span></span><br><span>Yes and no ;) <=
/span><br><span></span><br><span>Currently in proxmox 3.4, iothread:1 genera=
te only 1 iothread for all disks. </span><br><span></span><br><span>So, you'=
ll have a small extra boost, but it'll not scale with multiple disks. </span=
><br><span></span><br><span>Proxmox 4.0 will allow to enable|disable 1 iothr=
ead by disk. </span><br><span></span><br><span></span><br><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Does it also help for single disks or=
 only multiple disks? </span><br></blockquote></blockquote><span></span><br>=
<span>Iothread can also help for single disk, because by default qemu use a m=
ain thread for disk but also other things(don't remember what exactly) </spa=
n><br><span></span><br><span></span><br><span></span><br><span></span><br><s=
pan>----- Mail original ----- </span><br><span>De: "Irek Fasikhov" &lt; <a h=
ref=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br><span=
>=C3=80: "Stefan Priebe" &lt; <a href=3D"mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">s.pri=
ebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a> &gt; </span><br><span>Cc: "aderumier" &lt; <a href=3D"m=
ailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;, "pushpesh sharma" &=
lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt=
;, "Somnath Roy" &lt; <a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Somnath.Roy=
@sandisk.com</a> &gt;, "ceph-devel" &lt; <a href=3D"mailto:ceph-devel@vger.k=
ernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" &lt; <a href=3D=
"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span=
><br><span>Envoy=C3=A9: Lundi 22 Juin 2015 09:22:13 </span><br><span>Objet: R=
e: rbd_cache, limiting read on high iops around 40k </span><br><span></span>=
<br><span>It is already possible to do in proxmox 3.4 (with the latest updat=
es qemu-kvm 2.2.x). But it is necessary to register in the conf file iothrea=
d:1. For single drives the ambiguous behavior of productivity. </span><br><s=
pan></span><br><span>2015-06-22 10:12 GMT+03:00 Stefan Priebe - Profihost AG=
 &lt; <a href=3D"mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a> &gt=
; : </span><br><span></span><br><span></span><br><span></span><br><span>Am 2=
2.06.2015 um 09:08 schrieb Alexandre DERUMIER &lt; <a href=3D"mailto:aderumi=
er-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;: </span><br><span></span><br><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>Just an update, there seems to be no proper way to pass iothread </span>=
<br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>parameter from openstack-=
nova (not at least in Juno release). So a </span><br></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>default single iothread per VM is what all we have. S=
o in conclusion a </span><br></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
nova instance max iops on ceph rbd will be limited to 30-40K. </span><br></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><span></span><=
br></blockquote><blockquote type=3D"cite"><span>Thanks for the update. </spa=
n><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><=
blockquote type=3D"cite"><span>For proxmox users, </span><br></blockquote><b=
lockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"ci=
te"><span>I have added iothread option to gui for proxmox 4.0 </span><br></b=
lockquote><span></span><br><span>Can we make iothread the default? Does it a=
lso help for single disks or only multiple disks? </span><br><span></span><b=
r><blockquote type=3D"cite"><span>and added jemalloc as default memory alloc=
ator </span><br></blockquote><blockquote type=3D"cite"><span></span><br></bl=
ockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote=
 type=3D"cite"><span>I have also send a jemmaloc patch to qemu dev mailing <=
/span><br></blockquote><blockquote type=3D"cite"><span><a href=3D"https://li=
sts.gnu.org/archive/html/qemu-devel/2015-06/msg05265.html">https://lists.gnu=
.org/archive/html/qemu-devel/2015-06/msg05265.html</a> </span><br></blockquo=
te><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span>(Help is welcome to push it in qemu upstream ! ) </span><br></b=
lockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquot=
e type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><spa=
n></span><br></blockquote><blockquote type=3D"cite"><span>----- Mail origina=
l ----- </span><br></blockquote><blockquote type=3D"cite"><span>De: "pushpes=
h sharma" &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck@gmail.=
com</a> &gt; </span><br></blockquote><blockquote type=3D"cite"><span>=C3=80:=
 "aderumier" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org=
</a> &gt; </span><br></blockquote><blockquote type=3D"cite"><span>Cc: "Somna=
th Roy" &lt; <a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Somnath.Roy@sandisk.=
com</a> &gt;, "Irek Fasikhov" &lt; <a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malm=
yzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, "ceph-devel" &lt; <a href=3D"mailto:ceph-devel@vger.=
kernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" &lt; <a href=3D=
"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span=
><br></blockquote><blockquote type=3D"cite"><span>Envoy=C3=A9: Lundi 22 Juin=
 2015 07:58:47 </span><br></blockquote><blockquote type=3D"cite"><span>Objet=
: Re: rbd_cache, limiting read on high iops around 40k </span><br></blockquo=
te><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span>Just an update, there seems to be no proper way to pass iothrea=
d </span><br></blockquote><blockquote type=3D"cite"><span>parameter from ope=
nstack-nova (not at least in Juno release). So a </span><br></blockquote><bl=
ockquote type=3D"cite"><span>default single iothread per VM is what all we h=
ave. So in conclusion a </span><br></blockquote><blockquote type=3D"cite"><s=
pan>nova instance max iops on ceph rbd will be limited to 30-40K. </span><br=
></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><block=
quote type=3D"cite"><span>On Tue, Jun 16, 2015 at 10:08 PM, Alexandre DERUMI=
ER </span><br></blockquote><blockquote type=3D"cite"><span>&lt; <a href=3D"m=
ailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; wrote: </span><br></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Hi, </s=
pan><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>some news about qemu with tcmalloc vs jem=
maloc. </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span></span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>I'm testing with multiple disks=
 (with iothreads) in 1 qemu guest. </span><br></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>And=
 if tcmalloc is a little faster than jemmaloc, </span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>I have hit a lot of time the tcmalloc::ThreadCache::ReleaseToCentra=
lCache bug. </span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span></span><br></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>increasing TCMALLOC_MAX_TO=
TAL_THREAD_CACHE_BYTES, don't help. </span><br></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>with multiple disk, I'm around 200k iops with tcmalloc (bef=
ore hitting the bug) and 350kiops with jemmaloc. </span><br></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>The problem is that when I hit malloc bug, I'm around 4000-10000 i=
ops, and only way to fix is is to restart qemu ... </span><br></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span></span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>----- Mail original -----=
 </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>De: "pushpesh sharma" &lt; <a href=3D"mailto:pushpesh.eck=
@gmail.com">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=C3=80: "ader=
umier" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &=
gt; </span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>Cc: "Somnath Roy" &lt; <a href=3D"mailto:Somnath.Roy@=
sandisk.com">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt;, "Irek Fasikhov" &lt; <a href=3D=
"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, "ceph-devel" &lt; <a h=
ref=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt=
;, "ceph-users" &lt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users=
@lists.ceph.com</a> &gt; </span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>Envoy=C3=A9: Vendredi 12 Juin 20=
15 08:58:21 </span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>Objet: Re: rbd_cache, limiting read on high i=
ops around 40k </span><br></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>Thanks, posted the ques=
tion in openstack list. Hopefully will get some </span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>expert op=
inion. </span><br></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span></span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>On Fri, Jun 12, 2015 at 11:33 A=
M, Alexandre DERUMIER </span><br></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>&lt; <a href=3D"mailto:aderumier@odis=
o.com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; wrote: </span><br></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>Hi, </span><br></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></=
span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>here a libvirt xml s=
ample from libvirt src </span><br></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span></span><br></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>(you need to d=
efine &lt;iothreads&gt; number, then assign then in disks). </span><br></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>I don't use openstack, so I really don't known how i=
t's working with it. </span><br></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>&lt;domain type=3D'qemu'&gt; </sp=
an><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;name&gt;QEMUGuest1=
&lt;/name&gt; </span><br></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;u=
uid&gt;c7a5fdbd-edaf-9455-926a-d65c16db1809&lt;/uuid&gt; </span><br></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>&lt;memory unit=3D'KiB'&gt;219136&lt;=
/memory&gt; </span><br></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;cu=
rrentMemory unit=3D'KiB'&gt;219136&lt;/currentMemory&gt; </span><br></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>&lt;vcpu placement=3D'static'&gt;2&lt=
;/vcpu&gt; </span><br></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;iot=
hreads&gt;2&lt;/iothreads&gt; </span><br></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>&lt;os&gt; </span><br></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>&lt;type arch=3D'i686' machine=3D'pc'&gt;hvm&lt;/type&gt; </span><br></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>&lt;boot dev=3D'hd'/&gt; </span=
><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>&lt;/os&gt; </span><br><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>&lt;clock offset=3D'utc'/&gt; <=
/span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;on_poweroff&gt;=
destroy&lt;/on_poweroff&gt; </span><br></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>&lt;on_reboot&gt;restart&lt;/on_reboot&gt; </span><br></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>&lt;on_crash&gt;destroy&lt;/on_crash&gt; <=
/span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;devices&gt; </s=
pan><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;emulator&gt;/usr/=
bin/qemu&lt;/emulator&gt; </span><br></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>&lt;disk type=3D'file' device=3D'disk'&gt; </span><br></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>&lt;driver name=3D'qemu' type=3D'raw' iothr=
ead=3D'1'/&gt; </span><br></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt=
;source file=3D'/var/lib/libvirt/images/iothrtest1.img'/&gt; </span><br></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>&lt;target dev=3D'vdb' bus=3D'vir=
tio'/&gt; </span><br></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;addr=
ess type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' function=3D'0x=
0'/&gt; </span><br></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;/disk&g=
t; </span><br></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;disk type=3D=
'file' device=3D'disk'&gt; </span><br></blockquote></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>&lt;driver name=3D'qemu' type=3D'raw' iothread=3D'2'/&gt; </span><b=
r></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>&lt;source file=3D'/var/lib=
/libvirt/images/iothrtest2.img'/&gt; </span><br></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>&lt;target dev=3D'vdc' bus=3D'virtio'/&gt; </span><br></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>&lt;/disk&gt; </span><br></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>&lt;controller type=3D'usb' index=3D'=
0'/&gt; </span><br></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;control=
ler type=3D'ide' index=3D'0'/&gt; </span><br></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><span>&lt;controller type=3D'pci' index=3D'0' model=3D'pci-root'/&=
gt; </span><br></blockquote></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>&lt;memballoon=
 model=3D'none'/&gt; </span><br></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>&lt;/devices&gt; </span><br></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>&lt;/domain&gt; </span><br></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
</span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>----- Mail original ----- </span><br>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>De: "pushpesh sharma" &lt; <a=
 href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </sp=
an><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>=C3=80: "aderumier" &l=
t; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; </spa=
n><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>Cc: "Somnath Roy" &lt; <=
a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt;, "=
Irek Fasikhov" &lt; <a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a> &gt;, "ceph-devel" &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">cep=
h-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" &lt; <a href=3D"mailto:ceph-u=
sers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span><br></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>Envoy=C3=A9: Vendredi 12 Juin 2015 07:=
52:41 </span><br></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Objet: Re: r=
bd_cache, limiting read on high iops around 40k </span><br></blockquote></bl=
ockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><span></span><br></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>Hi Alexandre, </span><br></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>I agree wit=
h your rational, of one iothread per disk. CPU consumed in </span><br></bloc=
kquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>IOwait is pretty high in each VM. But=
 I am not finding a way to set </span><br></blockquote></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>the same on a nova instance. I am using openstack Juno with QEM=
U+KVM. </span><br></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>As per libv=
irt documentation for setting iothreads, I can edit </span><br></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>domain.xml directly and achieve the same e=
ffect. However in as in </span><br></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>openstack env domain xml is created by nova with some additional </spa=
n><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>metadata, so editing th=
e domain xml using 'virsh edit' does not seems </span><br></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>to work(I agree, it is not a very cloud way of d=
oing things, but a </span><br></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>hack). Changes made there vanish after saving them, due to reason </span><b=
r></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>libvirt validation fails on=
 the same. </span><br></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span>=
<br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>#virsh dumpxml instance-0=
00000c5 &gt; vm.xml </span><br></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>#virt-xml-validate vm.xml </span><br></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>Relax-NG validity error : Extra element cpu in interleave </span><=
br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>vm.xml:1: element domain: R=
elax-NG validity error : Element domain </span><br></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>failed to validate content </span><br></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>vm.xml fails to validate </span><br></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>Second approach I took was to setting QoS in volumes type=
s. But there </span><br></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>is no=
 option to set iothreads per volume, there are parameter realted </span><br>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>to max_read/wrirte ops/bytes.=
 </span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bloc=
kquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Thirdly, editing Nova flavor and prov=
ing extra specs like </span><br></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>hw:cpu_socket/thread/core, can change guest CPU topology however again </=
span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>no way to set iothre=
ad. It does accept hw_disk_iothreads(no type check </span><br></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>in place, i believe ), but can not pass the=
 same in domain.xml. </span><br></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Could you sugge=
st me a way to set the same. </span><br></blockquote></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span></span><br></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>-Pushpe=
sh </span><br></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>On Wed, Jun 10, 2015 at 12:59 PM,=
 Alexandre DERUMIER </span><br></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>&lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; w=
rote: </span><br></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>I need to t=
ry out the performance on qemu soon and may come back to you if I need some q=
emu setting trick :-) </span><br></blockquote></blockquote></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Sure no problem. </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>(BTW,=
 I can reach around 200k iops in 1 qemu vm with 5 virtio disks with 1 iothre=
ad by disk) </span><br></blockquote></blockquote></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquot=
e></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>-=
---- Mail original ----- </span><br></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>De: "Somnath Roy" &lt; <a href=3D=
"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt; </span><br=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>=C3=80: "aderumier" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">a=
derumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;, "Irek Fasikhov" &lt; <a href=3D"mailto:malmyzh@=
gmail.com">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Cc: "ceph-devel" &=
lt; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=
</a> &gt;, "pushpesh sharma" &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">=
pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, "ceph-users" &lt; <a href=3D"mailto:ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
Envoy=C3=A9: Mercredi 10 Juin 2015 09:06:32 </span><br></blockquote></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Objet: RE: r=
bd_cache, limiting read on high iops around 40k </span><br></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Hi Alexandre, </span><br></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>Thanks for sharing the data.=
 </span><br></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>I need to try out the performance on qemu soon and may c=
ome back to you if I need some qemu setting trick :-) </span><br></blockquot=
e></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span><=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>Regards </span><br></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>Somnath </span><br></blockqu=
ote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
></span><br></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>-----Original Message----- </span><br></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>From: c=
eph-users [mailto: <a href=3D"mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph=
-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> ] On Behalf Of Alexandre DERUMIER </span><=
br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Sent: Tuesday, June 09, 2015 10:42 PM </span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>To: I=
rek Fasikhov </span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>Cc: ceph-devel; pushpesh sharma; ceph-user=
s </span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>Subject: Re: [ceph-users] rbd_cache, limiting read on=
 high iops around 40k </span><br></blockquote></blockquote></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Very good work! </span><br></blockquo=
te></blockquote></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>Do you have a rpm-file? </span><br></blockquote></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>Thanks. </span><br></blockq=
uote></blockquote></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>no sorry, I'm have compiled it manually (and I'm=
 using debian jessie as client) </span><br></blockquote></blockquote></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote=
></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></=
span><br></blockquote></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>----- Mail original ----- </span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>De: "Irek Fasikhov" &lt; <a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malm=
yzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>=C3=80: "aderumier" &lt; <a href=
=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>Cc: "Robert LeBlanc" &lt; <a href=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robe=
rt-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a> &gt;, "ceph-devel" &lt; <a href=3D"mailto:ceph-devel@vg=
er.kernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "pushpesh sharma" &lt; <=
a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, "c=
eph-users" &lt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@list=
s.ceph.com</a> &gt; </span><br></blockquote></blockquote></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Envoy=C3=A9: Mercredi 10 Juin 2015 07=
:21:42 </span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>Objet: Re: [ceph-users] rbd_cache, limiting read=
 on high iops around 40k </span><br></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Hi, Alexand=
re. </span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>Very good work! </span><br></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>Do you have a rpm-file? </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>Thanks. </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan></span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>2015-06-10 7:10 GMT+03:00 Alexandre DERUMIER &lt; <=
a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; : </span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>Hi, </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan></span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>I have tested qemu with last tcmalloc 2.4, and the i=
mprovement is huge with iothread: 50k iops (+45%) ! </span><br></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></s=
pan><br></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qemu : no iothre=
ad : glibc : iops=3D33395 qemu : no-iothread : tcmalloc (2.2.1) : iops=3D345=
16 (+3%) qemu : no-iothread : jemmaloc : iops=3D42226 (+26%) qemu : no-iothr=
ead : tcmalloc (2.4) : iops=3D35974 (+7%) </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>qemu : iothread : glibc : iops=3D34516 </span><=
br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>qemu : iothread : tcmalloc : iops=3D38676 (+12%) qemu : iothrea=
d : jemmaloc : iops=3D28023 (-19%) qemu : iothread : tcmalloc (2.4) : iops=3D=
50276 (+45%) </span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
</span><br></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qemu : iothre=
ad : tcmalloc (2.4) : iops=3D50276 (+45%) </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>-------------=
----------------------------------------- </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32=
-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dlibaio, io=
depth=3D32 </span><br></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>fio-2.1.11 </span><br></blockquote></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Starting 1 p=
rocess </span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [214.7MB/0=
KB/0KB /s] [54.1K/0/0 iops] [eta 00m:00s] </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32=
-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D894: Wed Jun 10 05:54:24 201=
5 read : io=3D5120.0MB, bw=3D201108KB/s, iops=3D50276, runt=3D 26070msec sla=
t (usec): min=3D1, max=3D1136, avg=3D 3.54, stdev=3D 3.58 clat (usec): min=3D=
128, max=3D6262, avg=3D631.41, stdev=3D197.71 lat (usec): min=3D149, max=3D6=
265, avg=3D635.27, stdev=3D197.40 clat percentiles (usec): </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>| 1.00th=3D[ 318], 5.00th=3D[ 378], 10.00th=3D[ 418], 20.00th=3D[ 474], <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>| 30.00th=3D[ 516], 40.00th=3D[ 564], 50.00th=3D[ 612], 6=
0.00th=3D[ 652], </span><br></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>| 70.00th=3D[ 700], 80.00th=3D[ 756], 9=
0.00th=3D[ 860], 95.00th=3D[ 980], </span><br></blockquote></blockquote></bl=
ockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>| 99.00th=3D[ 1272],=
 99.50th=3D[ 1384], 99.90th=3D[ 1688], 99.95th=3D[ 1896], </span><br></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>| 99.99th=3D[ 3760] </span><br></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>bw (KB /s): min=3D145608, max=3D=
249688, per=3D100.00%, avg=3D201108.00, stdev=3D21718.87 lat (usec) : 250=3D=
0.04%, 500=3D25.84%, 750=3D53.00%, 1000=3D16.63% lat (msec) : 2=3D4.46%, 4=3D=
0.03%, 10=3D0.01% cpu : usr=3D9.73%, sys=3D24.93%, ctx=3D66417, majf=3D0, mi=
nf=3D38 IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%, &gt;=3D64=3D0.0% submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%,=
 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D=
0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% issued : total=3Dr=3D=
1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D=
0, percentile=3D100.00%, depth=3D32 </span><br></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>Run status group 0 (all jobs): </span><br></blockquote></blockquote></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>READ: io=3D5120.0MB, a=
ggrb=3D201107KB/s, minb=3D201107KB/s, maxb=3D201107KB/s, mint=3D26070msec, m=
axt=3D26070msec </span><br></blockquote></blockquote></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>Disk stats (read/w=
rite): </span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>vdb: ios=3D1302555/0, merge=3D0/0, ticks=3D71517=
6/0, in_queue=3D714840, util=3D99.73% </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan></span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span></span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>rbd_iodepth32-test: (g=3D0): rw=3Drandread, b=
s=3D4K-4K/4K-4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32 </span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
fio-2.1.11 </span><br></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>Starting 1 process </span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Jobs:=
 1 (f=3D1): [r(1)] [100.0% done] [158.7MB/0KB/0KB /s] [40.6K/0/0 iops] [eta 0=
0m:00s] </span><br></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>rbd_iodepth32-test: (groupid=3D0, jobs=3D1): er=
r=3D 0: pid=3D889: Wed Jun 10 06:05:06 2015 read : io=3D5120.0MB, bw=3D14389=
7KB/s, iops=3D35974, runt=3D 36435msec slat (usec): min=3D1, max=3D710, avg=3D=
 3.31, stdev=3D 3.35 clat (usec): min=3D191, max=3D4740, avg=3D884.66, stdev=
=3D315.65 lat (usec): min=3D289, max=3D4743, avg=3D888.31, stdev=3D315.51 cl=
at percentiles (usec): </span><br></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>| 1.00th=3D[ 462], 5.00th=3D[ 51=
6], 10.00th=3D[ 548], 20.00th=3D[ 596], </span><br></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 30.00th=3D[ 6=
52], 40.00th=3D[ 764], 50.00th=3D[ 868], 60.00th=3D[ 940], </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>| 70.00th=3D[ 1004], 80.00th=3D[ 1096], 90.00th=3D[ 1256], 95.00th=3D[ 1=
416], </span><br></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>| 99.00th=3D[ 2024], 99.50th=3D[ 2224], 99.90th=3D=
[ 2544], 99.95th=3D[ 2640], </span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>| 99.99th=3D[ 3632] </span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>bw (KB /s): min=3D98352, max=3D177328, per=3D99.91%, avg=3D1437=
72.11, stdev=3D21782.39 lat (usec) : 250=3D0.01%, 500=3D3.48%, 750=3D35.69%,=
 1000=3D30.01% lat (msec) : 2=3D29.74%, 4=3D1.07%, 10=3D0.01% cpu : usr=3D7.=
10%, sys=3D16.90%, ctx=3D54855, majf=3D0, minf=3D38 IO depths : 1=3D0.1%, 2=3D=
0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0% submit : 0=
=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D=
0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0=
.0%, &gt;=3D64=3D0.0% issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D=
0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
32 </span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>Run status group 0 (all jobs): <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>READ: io=3D5120.0MB, aggrb=3D143896KB/s, minb=3D143896KB/=
s, maxb=3D143896KB/s, mint=3D36435msec, maxt=3D36435msec </span><br></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n></span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>Disk stats (read/write): </span><br></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>vdb: io=
s=3D1301357/0, merge=3D0/0, ticks=3D1033036/0, in_queue=3D1032716, util=3D99=
.85% </span><br></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>----- Ma=
il original ----- </span><br></blockquote></blockquote></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>De: "aderumier" &lt; <a href=3D"mailt=
o:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=C3=
=80: "Robert LeBlanc" &lt; <a href=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert@le=
blancnet.us</a> &gt; </span><br></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>Cc: "Mark Nelson" &lt; <a href=3D"=
mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> &gt;, "ceph-devel" &lt; <a=
 href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &=
gt;, "pushpesh sharma" &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpe=
sh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, "ceph-users" &lt; <a href=3D"mailto:ceph-users@li=
sts.ceph.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Envoy=C3=
=A9: Mardi 9 Juin 2015 18:47:27 </span><br></blockquote></blockquote></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>Objet: Re: [ceph-users]=
 rbd_cache, limiting read on high iops around 40k </span><br></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></spa=
n><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Hi Robert, </span><br></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>What I found was that Ceph OSDs perfo=
rmed well with either tcmalloc or </span><br></blockquote></blockquote></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>jemalloc (except wh=
en RocksDB was built with jemalloc instead of </span><br></blockquote></bloc=
kquote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>tcmalloc, I=
'm still working to dig into why that might be the case). </span><br></block=
quote></blockquote></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>yes,from my test, for osd tcmalloc is a little f=
aster (but very little) than jemalloc. </span><br></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span></span><br></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>However, I found that tcmalloc with QEMU/KVM was very=
 detrimental to </span><br></blockquote></blockquote></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>small I/O, but provided huge gains in=
 I/O &gt;=3D1MB. Jemalloc was much </span><br></blockquote></blockquote></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>better for QEMU/KV=
M in the tests that we ran. [1] </span><br></blockquote></blockquote></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>Just have done qemu test (4k ra=
ndread - rbd_cache=3Doff), I don't see speed regression with tcmalloc. </spa=
n><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>with qemu iothread, tcmalloc have a speed increase over glib </=
span><br></blockquote></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>with qemu iothread, jemalloc have a speed decrease </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>without iothread, jemalloc have a big spee=
d increase </span><br></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span></span><br></blockquote></blockquote></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>this is with </span><br=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>-qemu 2.3 </span><br></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>-tcmalloc 2.2.1 </span><br></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>-jemmaloc 3.6 </span><br></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>-libc6 2.19 </span><br></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></spa=
n><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>qemu : no iothread : glibc : iops=3D33395 <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>qemu : no-iothread : tcmalloc : iops=3D34516 (+3%) </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>qemu : no-iothread : jemmaloc : iops=3D42226 (+26%) </span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span></span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>qemu : iothread : glibc : iops=3D34516 </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>qemu : iothread : tcmalloc : iops=3D38676 (+12%) </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>qemu : iothread : jemmaloc : iops=3D28023 (-19%) </span><br></blockqu=
ote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
></span><br></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>(The benefit of iothreads is that w=
e can scale with more disks in 1vm) </span><br></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n></span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>fio results: </span><br></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>------------ </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>qemu : iothread : tcmalloc : iops=3D38676 <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>----------------------------------------- </span><br></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, io=
engine=3Dlibaio, iodepth=3D32 </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>fio-2.1.11 </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>Starting 1 process </span><br></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>Jobs: 1 (f=3D0): [r(1)] [100.=
0% done] [123.5MB/0KB/0KB /s] [31.6K/0/0 iops] [eta 00m:00s] </span><br></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D1265: Tue=
 Jun 9 18:16:53 2015 </span><br></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>read : io=3D5120.0MB, bw=3D154707K=
B/s, iops=3D38676, runt=3D 33889msec </span><br></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>slat (usec): min=3D=
1, max=3D715, avg=3D 3.63, stdev=3D 3.42 </span><br></blockquote></blockquot=
e></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>clat (usec): m=
in=3D152, max=3D5736, avg=3D822.12, stdev=3D289.34 </span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>lat (=
usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D289.08 </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>clat percentiles (usec): </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>| 1.00th=3D[ 402], 5.00th=3D=
[ 466], 10.00th=3D[ 510], 20.00th=3D[ 572], </span><br></blockquote></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 30.00th=3D=
[ 636], 40.00th=3D[ 716], 50.00th=3D[ 780], 60.00th=3D[ 852], </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>| 70.00th=3D[ 932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], 95.00th=3D[=
 1352], </span><br></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>| 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=
=3D[ 2256], 99.95th=3D[ 2448], </span><br></blockquote></blockquote></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>| 99.99th=3D[ 3888] </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>bw (KB /s): min=3D123888, max=3D198584, per=3D100.00%, avg=3D15=
4824.40, stdev=3D16978.03 </span><br></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>lat (usec) : 250=3D0.01%, 500=
=3D8.91%, 750=3D36.44%, 1000=3D32.63% </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>lat (msec) : 2=3D=
21.65%, 4=3D0.37%, 10=3D0.01% </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>cpu : usr=3D8.29%, sys=3D=
19.76%, ctx=3D55882, majf=3D0, minf=3D39 </span><br></blockquote></blockquot=
e></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>IO depths : 1=3D=
0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0%=
 </span><br></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>complete : 0=3D0.0%, 4=
=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% </spa=
n><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0 </span><br></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>latency : target=3D0, window=3D0, percentile=3D100=
.00%, depth=3D32 </span><br></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Run status group 0=
 (all jobs): </span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>READ: io=3D5120.0MB, aggrb=3D154707KB/s, m=
inb=3D154707KB/s, maxb=3D154707KB/s, mint=3D33889msec, maxt=3D33889msec </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>Disk stats (read/write): </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_queue=3D934096, u=
til=3D99.77% </span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
</span><br></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>qemu : no-iothread : tcmalloc : iops=3D34516 </span><br=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>--------------------------------------------- </span><br></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s] [41.8K/0/0 iops=
] [eta 00m:00s] </span><br></blockquote></blockquote></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>rbd_iodepth32-test: (groupid=3D0, jobs=3D=
1): err=3D 0: pid=3D896: Tue Jun 9 18:19:08 2015 </span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>read :=
 io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=3D 37974msec </span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.57 </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=3D333.=
61 </span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>lat (usec): min=3D266, max=3D11862, avg=3D925.77, st=
dev=3D333.40 </span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>clat percentiles (usec): </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>| 1.00th=3D[ 434], 5.00th=3D[ 510], 10.00th=3D[ 564], 20.00th=3D[ 652], <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>| 30.00th=3D[ 732], 40.00th=3D[ 812], 50.00th=3D[ 876], 6=
0.00th=3D[ 940], </span><br></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>| 70.00th=3D[ 1020], 80.00th=3D[ 1112]=
, 90.00th=3D[ 1320], 95.00th=3D[ 1576], </span><br></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 99.00th=3D[ 1=
992], 99.50th=3D[ 2128], 99.90th=3D[ 2736], 99.95th=3D[ 3248], </span><br></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>| 99.99th=3D[ 4320] </span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>bw (KB /s): min=3D77312, ma=
x=3D185576, per=3D99.74%, avg=3D137709.88, stdev=3D16883.77 </span><br></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=3D35.60% </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01% </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>cpu : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, minf=3D=
38 </span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 1=
6=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>submit : 0=3D0.=
0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>issued : total=3Dr=3D=
1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 </span><br></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>latency :=
 target=3D0, window=3D0, percentile=3D100.00%, depth=3D32 </span><br></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>Run status group 0 (all jobs): </span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s, maxb=3D138064KB/=
s, mint=3D37974msec, maxt=3D37974msec </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>Disk stats (read/write): </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>vdb: ios=3D1309902/0, merg=
e=3D0/0, ticks=3D1068768/0, in_queue=3D1068396, util=3D99.86% </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span></span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span></span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qemu :=
 iothread : glibc : iops=3D34516 </span><br></blockquote></blockquote></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>----------------------=
--------------- </span><br></blockquote></blockquote></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test=
: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dlibaio, iodepth=
=3D32 </span><br></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>fio-2.1.11 </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Starting 1 proces=
s </span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0K=
B /s] [34.2K/0/0 iops] [eta 00m:00s] </span><br></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test=
: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D876: Tue Jun 9 18:24:01 2015 </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=3D 38=
051msec </span><br></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>slat (usec): min=3D1, max=3D496, avg=3D 3.88, s=
tdev=3D 3.66 </span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>clat (usec): min=3D283, max=3D7515, avg=3D=
923.34, stdev=3D300.28 </span><br></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>lat (usec): min=3D286, max=3D751=
9, avg=3D927.58, stdev=3D300.02 </span><br></blockquote></blockquote></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>clat percentiles (usec)=
: </span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>| 1.00th=3D[ 506], 5.00th=3D[ 564], 10.00th=3D[ 596],=
 20.00th=3D[ 652], </span><br></blockquote></blockquote></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>| 30.00th=3D[ 724], 40.00th=3D[ 804],=
 50.00th=3D[ 884], 60.00th=3D[ 964], </span><br></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 70.00th=3D[ 1048=
], 80.00th=3D[ 1144], 90.00th=3D[ 1304], 95.00th=3D[ 1448], </span><br></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>| 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480], 99.95th=3D[ 2=
640], </span><br></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>| 99.99th=3D[ 3984] </span><br></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>bw (KB /=
s): min=3D102680, max=3D171112, per=3D100.00%, avg=3D137877.78, stdev=3D1552=
1.30 </span><br></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.=
82% </span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01% </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>cpu : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, minf=3D=
38 </span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 1=
6=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>submit : 0=3D0.=
0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>issued : total=3Dr=3D=
1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 </span><br></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>latency :=
 target=3D0, window=3D0, percentile=3D100.00%, depth=3D32 </span><br></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>Run status group 0 (all jobs): </span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s, maxb=3D137785KB/=
s, mint=3D38051msec, maxt=3D38051msec </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>Disk stats (read/write): </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>vdb: ios=3D1307426/0, merg=
e=3D0/0, ticks=3D1051416/0, in_queue=3D1050972, util=3D99.85% </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span></span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span></span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qemu :=
 no iothread : glibc : iops=3D33395 </span><br></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>-------------------=
---------------------- </span><br></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test: (g=3D0): rw=3D=
randread, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32 </span><br=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>fio-2.1.11 </span><br></blockquote></blockquote></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>Starting 1 process </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s] [32.9K/0/0=
 iops] [eta 00m:00s] </span><br></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test: (groupid=3D0, j=
obs=3D1): err=3D 0: pid=3D886: Tue Jun 9 18:27:18 2015 </span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=3D 39248msec </spa=
n><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.29 </=
span><br></blockquote></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=3D=
335.51 </span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>lat (usec): min=3D303, max=3D12638, avg=3D957.01=
, stdev=3D335.29 </span><br></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>clat percentiles (usec): </span><br></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>| 1.00th=3D[ 516], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 65=
2], </span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>| 30.00th=3D[ 724], 40.00th=3D[ 820], 50.00th=3D[ 9=
24], 60.00th=3D[ 996], </span><br></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>| 70.00th=3D[ 1080], 80.00th=3D[=
 1176], 90.00th=3D[ 1336], 95.00th=3D[ 1528], </span><br></blockquote></bloc=
kquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 99.00th=3D=
[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672], 99.95th=3D[ 2928], </span><br=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>| 99.99th=3D[ 4832] </span><br></blockquote></blockquote></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>bw (KB /s): min=3D98136,=
 max=3D171624, per=3D100.00%, avg=3D133682.64, stdev=3D19121.91 </span><br><=
/blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=3D26.98% <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01=
% </span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>cpu : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D=
0, minf=3D38 </span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=
=3D0.1%, 16=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0% </span><br></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>submi=
t : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D=
64=3D0.0% </span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=
=3D0.0%, 32=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>issued :=
 total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 </span><br></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32 </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>Run status group 0 (all jobs): </span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s, maxb=3D=
133583KB/s, mint=3D39248msec, maxt=3D39248msec </span><br></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><=
br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Disk stats (read/write): </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>vdb: ios=3D130452=
6/0, merge=3D0/0, ticks=3D1075020/0, in_queue=3D1074536, util=3D99.84% </spa=
n><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
qemu : iothread : jemmaloc : iops=3D28023 </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>-------------=
--------------------------- </span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test: (g=3D0)=
: rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32 </s=
pan><br></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>fio-2.1.11 </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>Starting 1 process </span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] [39.1=
K/0/0 iops] [eta 00m:01s] </span><br></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test: (groupid=3D=
0, jobs=3D1): err=3D 0: pid=3D899: Tue Jun 9 18:30:26 2015 </span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=3D 46772msec <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.=
77 </span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>clat (usec): min=3D253, max=3D11307, avg=3D1135.63, s=
tdev=3D346.55 </span><br></blockquote></blockquote></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>lat (usec): min=3D256, max=3D11309, avg=3D=
1140.39, stdev=3D346.22 </span><br></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>clat percentiles (usec): </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>| 1.00th=3D[ 510], 5.00th=3D[ 628], 10.00th=3D[ 700], 20.00th=3D=
[ 820], </span><br></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>| 30.00th=3D[ 924], 40.00th=3D[ 1032], 50.00th=3D=
[ 1128], 60.00th=3D[ 1224], </span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>| 70.00th=3D[ 1320], 80.00t=
h=3D[ 1416], 90.00th=3D[ 1560], 95.00th=3D[ 1688], </span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 99.=
00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=3D[ 2832], </s=
pan><br></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>| 99.99th=3D[ 3760] </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>bw (KB /s): min=3D=
91792, max=3D174416, per=3D99.90%, avg=3D111985.27, stdev=3D17381.70 </span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33% </span><b=
r></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01% </spa=
n><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>cpu : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, minf=3D=
38 </span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 1=
6=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>submit : 0=3D0.=
0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>issued : total=3Dr=3D=
1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 </span><br></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>latency :=
 target=3D0, window=3D0, percentile=3D100.00%, depth=3D32 </span><br></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>Run status group 0 (all jobs): </span><br></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s, maxb=3D112094KB/=
s, mint=3D46772msec, maxt=3D46772msec </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan>Disk stats (read/write): </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>vdb: ios=3D1309169/0, merg=
e=3D0/0, ticks=3D1305796/0, in_queue=3D1305376, util=3D98.68% </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span></span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span></span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qemu :=
 non-iothread : jemmaloc : iops=3D42226 </span><br></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>---------------=
----------------------------- </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test: (g=3D=
0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32 <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>fio-2.1.11 </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>Starting 1 process </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s] [43.=
9K/0/0 iops] [eta 00m:00s] </span><br></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>rbd_iodepth32-test: (groupid=
=3D0, jobs=3D1): err=3D 0: pid=3D892: Tue Jun 9 18:34:11 2015 </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=3D 29599mse=
c </span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D=
 3.74 </span><br></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>clat (usec): min=3D174, max=3D3841, avg=3D717.08,=
 stdev=3D237.53 </span><br></blockquote></blockquote></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>lat (usec): min=3D210, max=3D3844, avg=3D=
721.23, stdev=3D237.22 </span><br></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>clat percentiles (usec): </span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>| 1.00th=3D[ 354], 5.00th=3D[ 422], 10.00th=3D[ 462], 20.00th=3D=
[ 516], </span><br></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>| 30.00th=3D[ 572], 40.00th=3D[ 628], 50.00th=3D=
[ 684], 60.00th=3D[ 740], </span><br></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>| 70.00th=3D[ 804], 80.00th=3D=
[ 884], 90.00th=3D[ 1004], 95.00th=3D[ 1128], </span><br></blockquote></bloc=
kquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 99.00th=3D=
[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928], 99.95th=3D[ 2064], </span><br=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>| 99.99th=3D[ 2608] </span><br></blockquote></blockquote></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>bw (KB /s): min=3D138120=
, max=3D230816, per=3D100.00%, avg=3D177192.14, stdev=3D23440.79 </span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=3D27.46=
% </span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>lat (msec) : 2=3D10.30%, 4=3D0.07% </span><br></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>cpu : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, minf=3D39 </span=
><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 3=
2=3D100.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>submit : 0=3D0.0%, 4=3D100=
.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 6=
4=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>issued : total=3Dr=3D1310720=
/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 </span><br></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>latency : targe=
t=3D0, window=3D0, percentile=3D100.00%, depth=3D32 </span><br></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></s=
pan><br></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>Run status group 0 (all jobs): </span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>READ: i=
o=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s, maxb=3D177130KB/s, mint=
=3D29599msec, maxt=3D29599msec </span><br></blockquote></blockquote></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Dis=
k stats (read/write): </span><br></blockquote></blockquote></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><span>vdb: ios=3D1303992/0, merge=3D0/0=
, ticks=3D798008/0, in_queue=3D797636, util=3D99.80% </span><br></blockquote=
></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></=
span><br></blockquote></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>----- Mail origi=
nal ----- </span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>De: "Robert LeBlanc" &lt; <a href=3D"mailto:r=
obert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a> &gt; </span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=C3=80=
: "aderumier" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10@public.gmane.org=
m</a> &gt; </span><br></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>Cc: "Mark Nelson" &lt; <a href=3D"mailto:mne=
lson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> &gt;, "ceph-devel" &lt; <a href=3D"m=
ailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "push=
pesh sharma" &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck@gma=
il.com</a> &gt;, "ceph-users" &lt; <a href=3D"mailto:ceph-users-idqoXFIVOFKIjjVqG0RrOw@public.gmane.org=
om">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span><br></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Envoy=C3=A9: Mar=
di 9 Juin 2015 18:00:29 </span><br></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>Objet: Re: [ceph-users] rbd_cac=
he, limiting read on high iops around 40k </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>-----BEGIN PGP SIGNED MESSAGE----- </span><br></blockquote></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Hash: SHA256=
 </span><br></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>I also saw a similar performance i=
ncrease by using alternative memory </span><br></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>allocators. What I f=
ound was that Ceph OSDs performed well with either </span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>tcmal=
loc or jemalloc (except when RocksDB was built with jemalloc </span><br></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>instead of tcmalloc, I'm still working to dig into why that might be <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>the case). </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Howev=
er, I found that tcmalloc with QEMU/KVM was very detrimental to </span><br><=
/blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>small I/O, but provided huge gains in I/O &gt;=3D1MB. Jemalloc was m=
uch </span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>better for QEMU/KVM in the tests that we ran. [1] <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>I'm currently looking into I/O bottle=
necks around the 16KB range and </span><br></blockquote></blockquote></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>I'm seeing a lot of tim=
e in thread creation and destruction, the </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>memory alloca=
tors are quite a bit down the list (both fio with </span><br></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>ioeng=
ine rbd and on the OSDs). I wonder what the difference can be. </span><br></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>I've tried using the async messenger but there wasn't a huge </span>=
<br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>difference. [2] </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Furth=
er down the rabbit hole.... </span><br></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>[1] <a=
 href=3D"https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg20197.htm=
l">https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg20197.html</a> <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>[2] <a href=3D"https://www.mail-archive.com/ceph-devel@vg=
er.kernel.org/msg23982.html">https://www.mail-archive.com/ceph-devel-fy+rA21nqHI@public.gmane.org=
rnel.org/msg23982.html</a> </span><br></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>-----BEGIN PGP SIGNATURE----=
- </span><br></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>Version: Mailvelope v0.13.1 </span><br></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Comme=
nt: <a href=3D"https://www.mailvelope.com">https://www.mailvelope.com</a> </=
span><br></blockquote></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4=
MwP/1vt65cvTyyVGGSGRrE8 </span><br></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>unuWjafMHzl486XH+EaVrDVTXFVFOon=
cJ6kugSpD7yavtCpZNdhsIaTRZguU </span><br></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>YpfAppNAJU5biSwNv9QPI7kPP=
2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw87 </span><br></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>afq46GhPHqEXdjp3rOB=
4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnCY2 </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>S695Dt1gzt0ER=
UOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivVl3 </span><br></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>vDYWxQH=
PK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+51 </span><br></blockquot=
e></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>9=
ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPGOO </span><br></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHhu3 </span><br=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c7b </sp=
an><br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV13 </=
span><br></blockquote></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTK=
VzQ </span><br></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfb=
uEHalVjz4 </span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>oSJX </span><br></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>=3Dk281 </span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>-----END PGP SIGNATURE----- </span><br></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>---------------- <=
/span><br></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>Robert LeBlanc </span><br></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>GPG Fingerprint 79A2 9=
CA4 6CC4 45DD A904 C70E E654 3BB2 FA62 B9F1 </span><br></blockquote></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span></span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DER=
UMIER &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &g=
t; wrote: </span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>Frankly, I'm a little impressed that withou=
t RBD cache we can hit 80K </span><br></blockquote></blockquote></blockquote=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>IOPS from 1 VM! </span><br></blockquote></blockquote></blockquo=
te></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>Note that theses result are not in a vm (fio-rbd on h=
ost), so in a vm we'll have overhead. </span><br></blockquote></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>(I'm planning to send results in qemu soon) </span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>How fast are the SSDs in those 3 OSDs? </span><br></blockquote></bl=
ockquote></blockquote></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></block=
quote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Theses results are with datas in buff=
er memory of osd nodes. </span><br></blockquote></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>When rea=
ding fulling on ssd (intel s3500), </span><br></blockquote></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>For 1 client, </span><br></blockquote></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
></span><br></blockquote></blockquote></blockquote></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>I'm around 33k i=
ops without cache and 32k iops with cache, with 1 osd. </span><br></blockquo=
te></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>I'm around 55k iops without cache and=
 38k iops with cache, with 3 osd. </span><br></blockquote></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>with multiple clients jobs, I can reach around 70kiops by osd , and 250k i=
ops by osd when datas are in buffer. </span><br></blockquote></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>(cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon) </span><br></bloc=
kquote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span></span><br></blockquote></blockquote></blockquote></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>small tip :=
 </span><br></blockquote></blockquote></blockquote></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>I'm using tcmal=
loc for fio-rbd or rados bench to improve latencies by around 20% </span><br=
></blockquote></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.=
so.4 fio ... </span><br></blockquote></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>LD_=
PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ... </span><br></blo=
ckquote></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>as a lot of time is spent in malloc/free </span>=
<br></blockquote></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>(qemu support also tcmalloc since some months , I'll be=
nch it too </span><br></blockquote></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span><a hr=
ef=3D"https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html">h=
ttps://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html</a> ) </s=
pan><br></blockquote></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockq=
uote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>I'll try to send full bench results soon, from 1 to 18 ssd osd. </spa=
n><br></blockquote></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquo=
te></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span></span><br></blockquote></blockquote></blockquote></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>----- Mail o=
riginal ----- </span><br></blockquote></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>De=
: "Mark Nelson" &lt; <a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mnelson-H+wXaHxf7aJhl2p70BpVqQ@public.gmane.org=
m</a> &gt; </span><br></blockquote></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=C3=80=
: "aderumier" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10@public.gmane.org=
m</a> &gt;, "pushpesh sharma" &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
>pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote></blockquote></bloc=
kquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Cc: "ceph-devel" &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" &lt; <a href=3D"mailt=
o:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span><br><=
/blockquote></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>Envoy=C3=A9: Mardi 9 Juin 201=
5 13:36:31 </span><br></blockquote></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Objet=
: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k </span><=
br></blockquote></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>Hi All, </span><br></blockquote></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span></span><br></blockquote></blockquote></blockquot=
e></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>In the past we've hit some performance issues with RBD cache tha=
t we've </span><br></blockquote></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>fixed, b=
ut we've never really tried pushing a single VM beyond 40+K read </span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>IOPS in testing (or at leas=
t I never have). I suspect there's a couple </span><br></blockquote></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>of possibilities as to why it might be slower, b=
ut perhaps joshd can </span><br></blockquote></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>chime in as he's more familiar with what that code looks like. </span><=
br></blockquote></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>Frankly, I'm a little impressed that wit=
hout RBD cache we can hit 80K </span><br></blockquote></blockquote></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>IOPS from 1 VM! How fast are the SSDs in those 3 OSDs? </span><=
br></blockquote></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>Mark </span><br></blockquote></blockquot=
e></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>On 06/09/2015 03:36 AM, Alexandre DERUMIE=
R wrote: </span><br></blockquote></blockquote></blockquote></blockquote></bl=
ockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>It's seem that the limit is mainly going in h=
igh queue depth (+- &gt; 16) </span><br></blockquote></blockquote></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote>=
</blockquote></blockquote></blockquote></blockquote></blockquote><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>H=
ere the result in iops with 1client- 4krandread- 3osd - with differents queu=
e depth size. </span><br></blockquote></blockquote></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>rbd_cache is almost the same than witho=
ut cache with queue depth &lt;16 </span><br></blockquote></blockquote></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockqu=
ote></blockquote></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>cache </span><br></blockquote></blockquote></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>----- </span><br></bl=
ockquote></blockquote></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>qd1: 1651 </span><br></blockquote></blockquote></blockquote></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>qd2: 3482 </span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qd4: 7=
958 </span><br></blockquote></blockquote></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>qd8: 17912 </span><br></blockquote></blockquote><=
/blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qd16: 36020 </s=
pan><br></blockquote></blockquote></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>qd32: 42765 </span><br></blockquote></blockquote></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>qd64: 46169 </span><br=
></blockquote></blockquote></blockquote></blockquote></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>no cache </span><br></blockquote></block=
quote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>-------- </=
span><br></blockquote></blockquote></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>qd1: 1748 </span><br></blockquote></blockquote></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>qd2: 3570 </span><br><=
/blockquote></blockquote></blockquote></blockquote></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>qd4: 8356 </span><br></blockquote></blockquote></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>qd8: 17732 </span><br></blockquo=
te></blockquote></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>qd16: 41396 </span><br></blockquote></blockquote></blockquote></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><span>qd32: 78633 </span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>qd64:=
 79063 </span><br></blockquote></blockquote></blockquote></blockquote></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><span>qd128: 79550 </span><br></blockquote></blockqu=
ote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span></span><br></blockquote></blockquote></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>----- Mail original ----- </span><br></bl=
ockquote></blockquote></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>De: "aderumier" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumie=
r@odiso.com</a> &gt; </span><br></blockquote></blockquote></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>=C3=80: "pushpesh sharma" &lt; <=
a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </s=
pan><br></blockquote></blockquote></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>Cc: "ceph-devel" &lt; <a href=3D"mailto:ceph-devel@vger.k=
ernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" &lt; <a href=3D=
"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; </span=
><br></blockquote></blockquote></blockquote></blockquote></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21 </span><br></blockquote=
></blockquote></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k </s=
pan><br></blockquote></blockquote></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Hi, </span><br></blockquote></blockqu=
ote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>We tried add=
ing more RBDs to single VM, but no luck. </span><br></blockquote></blockquot=
e></blockquote></blockquote></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>If you want to scale with more disks in a=
 single qemu vm, you need to use iothread feature from qemu and assign 1 iot=
hread by disk (works with virtio-blk). </span><br></blockquote></blockquote>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>It's working f=
or me, I can scale with adding more disks. </span><br></blockquote></blockqu=
ote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span></span><br></blockquote></blockquote></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>My bench here are done with fio-rbd on ho=
st. </span><br></blockquote></blockquote></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>I can scale up to 400k iops with 10clients-rbd_ca=
che=3Doff on a single host and around 250kiops 10clients-rbdcache=3Don. </sp=
an><br></blockquote></blockquote></blockquote></blockquote></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>I just wonder w=
hy I don't have performance decrease around 30k iops with 1osd. </span><br><=
/blockquote></blockquote></blockquote></blockquote></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span></span><br></blockquote></blockquote></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>I'm going to see if this tracker </span><b=
r></blockquote></blockquote></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span><a href=3D"http://tracker.ceph.com/issues/11056">http://tracker=
.ceph.com/issues/11056</a> </span><br></blockquote></blockquote></blockquote=
></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></=
blockquote></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>cou=
ld be the cause. </span><br></blockquote></blockquote></blockquote></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>(My master bui=
ld was done some week ago) </span><br></blockquote></blockquote></blockquote=
></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></=
blockquote></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></s=
pan><br></blockquote></blockquote></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>----- Mail original ----- </span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>De: "pushpesh sharma" &lt; <a href=3D"mailto:pushpesh.eck@gmail.=
com">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt; </span><br></blockquote></blockquote></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=C3=80: "aderumi=
er" &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;=
 </span><br></blockquote></blockquote></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>Cc: "ceph-devel" &lt; <a href=3D"mailto:ceph-devel@v=
ger.kernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, "ceph-users" &lt; <a hr=
ef=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt; <=
/span><br></blockquote></blockquote></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04 </span><br></bl=
ockquote></blockquote></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span>Objet: Re: rbd_cache, limiting read on high iops around 40k </span><=
br></blockquote></blockquote></blockquote></blockquote></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>Hi Alexandre, </span><br></blockquote></=
blockquote></blockquote></blockquote></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></s=
pan><br></blockquote></blockquote></blockquote></blockquote></blockquote></b=
lockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>We have also seen something very similar on Hammer(0.94-1=
). We were doing some benchmarking for VMs hosted on hypervisor (QEMU-KVM, o=
penstack-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as addition=
al storage. For some strange reason it was not able to scale 4K- RR iops on e=
ach VM beyond 35-40k. We tried adding more RBDs to single VM, but no luck. H=
owever increasing number of VMs to 4 on a single hypervisor did scale to som=
e extent. After this there was no much benefit we got from adding more VMs. <=
/span><br></blockquote></blockquote></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>Here is the trend we have seen, x=
-axis is number of hypervisor, each hypervisor has 4 VM, each VM has 1 RBD:-=
 </span><br></blockquote></blockquote></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blo=
ckquote></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span=
><br></blockquote></blockquote></blockquote></blockquote></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>VDbench is used as benchmarking tool. We=
 were not saturating network and CPUs at OSD nodes. We were not able to satu=
rate CPUs at hypervisors, and that is where we were suspecting of some throt=
tling effect. However we haven't setted any such limits from nova or kvm end=
. We tried some CPU pinning and other KVM related tuning as well, but no luc=
k. </span><br></blockquote></blockquote></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>We tried the same experimen=
t on a bare metal. It was 4K RR IOPs were scaling from 40K(1 RBD) to 180K(4 R=
BDs). But after that rather than scaling beyond that point the numbers were a=
ctually degrading. (Single pipe more congestion effect) </span><br></blockqu=
ote></blockquote></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an></span><br></blockquote></blockquote></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>We never suspected that rbd cache enable could be d=
etrimental to performance. It would nice to route cause the problem if that i=
s the case. </span><br></blockquote></blockquote></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>On Tue, Jun 9, 201=
5 at 11:21 AM, Alexandre DERUMIER &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org=
">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; wrote: </span><br></blockquote></blockquote><=
/blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></bl=
ockquote></blockquote></blockquote></blockquote></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote></blockquote></blockquote></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>Hi, </span><br></blockquote></blockquote></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></block=
quote></blockquote></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D32,=
 </span><br></blockquote></blockquote></blockquote></blockquote></blockquote=
></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>and rbd_cache=3Dtrue seem to limit the iops around 4=
0k </span><br></blockquote></blockquote></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><span></span><br></blockquote></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>no ca=
che </span><br></blockquote></blockquote></blockquote></blockquote></blockqu=
ote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><span>-------- </span><br></blockquote></blockquote></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1 client - rbd_ca=
che=3Dfalse - 1osd : 38300 iops </span><br></blockquote></blockquote></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>1 client - rbd_cache=3D=
false - 2osd : 69073 iops </span><br></blockquote></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span>1 client - rbd_cache=3Dfals=
e - 3osd : 78292 iops </span><br></blockquote></blockquote></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>cache </span><br></blockquote></blockquote></blockquote></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>----- </span><br></blockquote></block=
quote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1 client - r=
bd_cache=3Dtrue - 1osd : 38100 iops </span><br></blockquote></blockquote></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>1 client - rbd_ca=
che=3Dtrue - 2osd : 42457 iops </span><br></blockquote></blockquote></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>1 client - rbd_cache=3D=
true - 3osd : 45823 iops </span><br></blockquote></blockquote></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blo=
ckquote></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span=
><br></blockquote></blockquote></blockquote></blockquote></blockquote></bloc=
kquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span></span><br></blockquote></blockquote></blockquote></blockquote>=
</blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>Is it expected ? </span><br></blockquote=
></blockquote></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
</span><br></blockquote></blockquote></blockquote></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></block=
quote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>fio result r=
bd_cache=3Dfalse 3 osd </span><br></blockquote></blockquote></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>-------------------------------=
- </span><br></blockquote></blockquote></blockquote></blockquote></blockquot=
e></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K=
-4K/4K-4K/4K-4K, ioengine=3Drbd, iodepth=3D32 </span><br></blockquote></bloc=
kquote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>fio-2.1.11 <=
/span><br></blockquote></blockquote></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>Starting 1 process </span><br></blockquote></blockquote=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd engine: R=
BD version: 0.1.9 </span><br></blockquote></blockquote></blockquote></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>Jobs: 1 (f=3D1): [r(1)] [100.0% done]=
 [307.5MB/0KB/0KB /s] [78.8K/0/0 iops] [eta 00m:00s] </span><br></blockquote=
></blockquote></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548: Tue Jun=
 9 07:48:42 2015 </span><br></blockquote></blockquote></blockquote></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>read : io=3D10000MB, bw=3D313169KB/s,=
 iops=3D78292, runt=3D 32698msec </span><br></blockquote></blockquote></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>slat (usec): min=3D5=
, max=3D530, avg=3D11.77, stdev=3D 6.77 </span><br></blockquote></blockquote=
></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>clat (usec): m=
in=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82 </span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>lat (=
usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49 </span><br></block=
quote></blockquote></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>clat percentiles (usec): </span><br></blockquote></blockquote></blockqu=
ote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><span>| 1.00th=3D[ 173], 5.00=
th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ 262], </span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 30.=
00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D[ 346], </span>=
<br></blockquote></blockquote></blockquote></blockquote></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>| 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=
=3D[ 506], </span><br></blockquote></blockquote></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>| 99.00th=3D[ 628], 99.50th=3D[ 692], 99.9=
0th=3D[ 860], 99.95th=3D[ 948], </span><br></blockquote></blockquote></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>| 99.99th=3D[ 1176] <=
/span><br></blockquote></blockquote></blockquote></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span>bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, a=
vg=3D313402.34, stdev=3D25196.21 </span><br></blockquote></blockquote></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>lat (usec) : 100=3D0=
.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, 1000=3D0.23% </span><br></blo=
ckquote></blockquote></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span>lat (msec) : 2=3D0.03%, 4=3D0.01% </span><br></blockquote></blockquot=
e></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>cpu : usr=3D=
74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D12452 </span><br></bloc=
kquote></blockquote></blockquote></blockquote></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=3D1=
2.1%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>submit : 0=3D0.0%, 4=3D100.0%, 8=
=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></bloc=
kquote></blockquote></blockquote></blockquote></blockquote></blockquote><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=3D0=
.0%, &gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>issued : total=3Dr=3D2560000/w=3D=
0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 </span><br></blockquote></blockquote></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>latency : target=3D=
0, window=3D0, percentile=3D100.00%, depth=3D32 </span><br></blockquote></bl=
ockquote></blockquote></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></spa=
n><br></blockquote></blockquote></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>Run status group 0 (all jobs): </span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>READ:=
 io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D313169KB/s, min=
t=3D32698msec, maxt=3D32698msec </span><br></blockquote></blockquote></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquo=
te></blockquote></blockquote></blockquote></blockquote></blockquote><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>Disk stats (read/write): </span><br></blockquote></blockquote></blockquote=
></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span>dm-0: ios=3D0/45, merge=3D=
0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00%, aggrios=3D0/24, aggrmerge=3D0/=
21, aggrticks=3D0/0, aggrin_queue=3D0, aggrutil=3D0.00% </span><br></blockqu=
ote></blockquote></blockquote></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.00% </=
span><br></blockquote></blockquote></blockquote></blockquote></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blo=
ckquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockq=
uote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span></span><br></blockquote></blockquote></blockquote></blockquote><=
/blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>fio result rbd_cache=3Dtrue 3osd </span><=
br></blockquote></blockquote></blockquote></blockquote></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>------------------------------ </span><br></blockquote></blockq=
uote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-=
4K, ioengine=3Drbd, iodepth=3D32 </span><br></blockquote></blockquote></bloc=
kquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>fio-2.1.11 </span><b=
r></blockquote></blockquote></blockquote></blockquote></blockquote></blockqu=
ote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>Starting 1 process </span><br></blockquote></blockquote></block=
quote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd engine: RBD versi=
on: 0.1.9 </span><br></blockquote></blockquote></blockquote></blockquote></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.=
6MB/0KB/0KB /s] [43.1K/0/0 iops] [eta 00m:00s] </span><br></blockquote></blo=
ckquote></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>rbd_io=
depth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389: Tue Jun 9 07:=
47:30 2015 </span><br></blockquote></blockquote></blockquote></blockquote></=
blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><blockquote type=3D"cite"><span>read : io=3D10000MB, bw=3D183296KB/s, iops=
=3D45823, runt=3D 55866msec </span><br></blockquote></blockquote></blockquot=
e></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>slat (usec): min=3D7, max=
=3D805, avg=3D21.26, stdev=3D15.84 </span><br></blockquote></blockquote></bl=
ockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>clat (usec): min=3D=
101, max=3D4602, avg=3D478.55, stdev=3D143.73 </span><br></blockquote></bloc=
kquote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>lat (usec):=
 min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03 </span><br></blockquote=
></blockquote></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
clat percentiles (usec): </span><br></blockquote></blockquote></blockquote><=
/blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><span>| 1.00th=3D[ 227], 5.00th=3D[=
 274], 10.00th=3D[ 306], 20.00th=3D[ 350], </span><br></blockquote></blockqu=
ote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>| 30.00th=3D=
[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D[ 506], </span><br></b=
lockquote></blockquote></blockquote></blockquote></blockquote></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><span>| 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D[=
 724], </span><br></blockquote></blockquote></blockquote></blockquote></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><b=
lockquote type=3D"cite"><span>| 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D=
[ 1112], 99.95th=3D[ 1288], </span><br></blockquote></blockquote></blockquot=
e></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>| 99.99th=3D[ 2192] </spa=
n><br></blockquote></blockquote></blockquote></blockquote></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span>bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=
=3D183315.10, stdev=3D15079.93 </span><br></blockquote></blockquote></blockq=
uote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><span>lat (usec) : 250=3D2.4=
2%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28% </span><br></blockquote></block=
quote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>lat (msec) :=
 2=3D0.19%, 4=3D0.01%, 10=3D0.01% </span><br></blockquote></blockquote></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>cpu : usr=3D60.27%,=
 sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D14100 </span><br></blockquote=
></blockquote></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=3D5.3%, &=
gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.=
0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% </span><br></blockquot=
e></blockquote></blockquote></blockquote></blockquote></blockquote><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
>complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0% </span><br></blockquote></blockquote></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>issued : total=3Dr=3D2560000/w=3D0/d=3D=
0, short=3Dr=3D0/w=3D0/d=3D0 </span><br></blockquote></blockquote></blockquo=
te></blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>latency : target=3D0, wi=
ndow=3D0, percentile=3D100.00%, depth=3D32 </span><br></blockquote></blockqu=
ote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>Run status group 0 (all jobs): </span><br></blockquote></blockqu=
ote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>READ: io=3D=
10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D183295KB/s, mint=3D55=
866msec, maxt=3D55866msec </span><br></blockquote></blockquote></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></b=
lockquote></blockquote></blockquote></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Disk s=
tats (read/write): </span><br></blockquote></blockquote></blockquote></block=
quote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>dm-0: ios=3D0/61, merge=3D0/0, ticks=3D=
0/8, in_queue=3D8, util=3D0.01%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=
=3D0/8, aggrin_queue=3D8, aggrutil=3D0.01% </span><br></blockquote></blockqu=
ote></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>sda: ios=3D=
0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.01% </span><br></blo=
ckquote></blockquote></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>___________________=
____________________________ </span><br></blockquote></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>ceph-users mailing list </span><br></blockquote></blockquote></=
blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><span><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users=
@lists.ceph.com</a> </span><br></blockquote></blockquote></blockquote></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><s=
pan><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http:=
//lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a> </span><br></blockquot=
e></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>_______________________________________________ </span><br></blo=
ckquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>ceph-users mailing list </span><br></blockquote></blockquote></blockquo=
te></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><blockquote type=3D"cite"><span><a href=3D"mailto:ceph-use=
rs-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> </span><br></blockquote></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span><a hre=
f=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ce=
ph.com/listinfo.cgi/ceph-users-ceph.com</a> </span><br></blockquote></blockq=
uote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></span><br>=
</blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite=
"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span></span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span></span><br></blockquote></blockquote></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote>=
</blockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span></s=
pan><br></blockquote></blockquote></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><span></span><br></blockquote></blockquote></blockquote></blockq=
uote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><blockquote type=3D"cite"><span>-- </span><br></blockquote></blockquo=
te></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=D0=A1 =D1=83=
=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=
=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=
=D0=B7=D0=BE=D0=B2=D0=B8=D1=87 </span><br></blockquote></blockquote></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><span>=D0=9C=D0=BE=D0=B1.: +79=
229045757 </span><br></blockquote></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>_____________________________________________=
__ </span><br></blockquote></blockquote></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockqu=
ote type=3D"cite"><span>ceph-users mailing list </span><br></blockquote></bl=
ockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span><a href=
=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> </span><=
br></blockquote></blockquote></blockquote></blockquote><blockquote type=3D"c=
ite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.c=
om">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a> </span><br></=
blockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite=
"><span></span><br></blockquote></blockquote></blockquote></blockquote><bloc=
kquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>________________________________ </span><br></b=
lockquote></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"=
><span></span><br></blockquote></blockquote></blockquote></blockquote><block=
quote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>PLEASE NOTE: The information contained in this e=
lectronic mail message is intended only for the use of the designated recipi=
ent(s) named above. If the reader of this message is not the intended recipi=
ent, you are hereby notified that you have received this message in error an=
d that any review, dissemination, distribution, or copying of this message i=
s strictly prohibited. If you have received this communication in error, ple=
ase notify the sender by telephone or e-mail (as shown above) immediately an=
d destroy any and all copies of this message in your possession (whether har=
d copies or electronically stored copies). </span><br></blockquote></blockqu=
ote></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span></span><br></blockquote></blockquote><=
/blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><span=
></span><br></blockquote></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>-- </span><br></b=
lockquote></blockquote></blockquote><blockquote type=3D"cite"><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>-Pushpesh </span><br></blockquot=
e></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span></span><br></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span></span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span></span><br></blockquote></bl=
ockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>-- </span=
><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>-Pushpesh </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span></sp=
an><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote>=
<blockquote type=3D"cite"><span>-- </span><br></blockquote><blockquote type=3D=
"cite"><span>-Pushpesh </span><br></blockquote><blockquote type=3D"cite"><sp=
an></span><br></blockquote><blockquote type=3D"cite"><span></span><br></bloc=
kquote><blockquote type=3D"cite"><span>-- </span><br></blockquote><blockquot=
e type=3D"cite"><span>To unsubscribe from this list: send the line "unsubscr=
ibe ceph-devel" in </span><br></blockquote><span></span><br><span></span><br=
><span></span><br><span></span><br><span></span><br><span></span><br><span>-=
- </span><br><span>=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=
=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=
=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87 </span><br><=
span>=D0=9C=D0=BE=D0=B1.: +79229045757 </span><br><span></span><br><span></s=
pan><br><span></span><br><span></span><br><span></span><br><span></span><br>=
<span></span><br><span></span><br><span>-- </span><br><span>=D0=A1 =D1=83=D0=
=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=
=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=
=B7=D0=BE=D0=B2=D0=B8=D1=87 </span><br><span>=D0=9C=D0=BE=D0=B1.: +792290457=
57 </span><br><span>--</span><br><span>To unsubscribe from this list: send t=
he line "unsubscribe ceph-devel" in</span><br></div></blockquote></body></ht=
ml>=

--Apple-Mail-1282DBAB-8B98-4641-A75C-80024FBFFC86--

--===============1015844792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1015844792==--
