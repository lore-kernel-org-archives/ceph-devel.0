From: Irek Fasikhov <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: rbd_cache, limiting read on high iops around 40k
Date: Mon, 22 Jun 2015 12:04:42 +0300
Message-ID: <CAF-rypz67RHWLzCCbJ=dbDiUM-pV1Q-Lk4VncUttoDEJrcQgTA@mail.gmail.com>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv>
	<961809688.968058.1434088993053.JavaMail.zimbra@oxygem.tv>
	<CAMc8nAWGHME1BbFvxP5zWEqjtYNZYBt61cWEfL8p3yhWh7_7nA@mail.gmail.com>
	<1927317035.2874975.1434472710336.JavaMail.zimbra@oxygem.tv>
	<CAMc8nAXWAjFr8u+wgdEXLgudGpDYiOGDfLV-QhF8YJWFK0pjVg@mail.gmail.com>
	<1603543754.1547292.1434956923734.JavaMail.zimbra@oxygem.tv>
	<942E436A-5668-4F76-91E7-FAA08CC0F48A@profihost.ag>
	<CAF-rypwr9NCnGW_SiLjVKtgHsaDVUjb-1cJfksQpG+mOAD=dNQ@mail.gmail.com>
	<1581092206.1667776.1434963299884.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0120458355=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1581092206.1667776.1434963299884.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
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

--===============0120458355==
Content-Type: multipart/alternative; boundary=047d7b3a8e60a31b9c051917910d

--047d7b3a8e60a31b9c051917910d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

| Proxmox 4.0 will allow to enable|disable 1 iothread by disk.

Alexandre, Useful option!
In proxmox 3.4 will it be possible to add at least in the configuration
file? Or it entails a change in the source code KVM?
Thanks.

2015-06-22 11:54 GMT+03:00 Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>:

> >>It is already possible to do in proxmox 3.4 (with the latest updates
> qemu-kvm 2.2.x). But it is necessary to register in the conf file
> iothread:1. For single drives the ambiguous behavior of productivity.
>
> Yes and no ;)
>
> Currently in proxmox 3.4, iothread:1  generate only 1 iothread for all
> disks.
>
> So, you'll have a small extra boost, but it'll not scale with multiple
> disks.
>
> Proxmox 4.0 will allow to enable|disable 1 iothread by disk.
>
>
> >>Does it also help for single disks or only multiple disks?
>
> Iothread can also help for single disk, because by default qemu use a mai=
n
> thread for disk but also other things(don't remember what exactly)
>
>
>
>
> ----- Mail original -----
> De: "Irek Fasikhov" <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> =C3=80: "Stefan Priebe" <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
> Cc: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "pushpesh sharma" <
> pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Somnath Roy" <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>,
> "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Envoy=C3=A9: Lundi 22 Juin 2015 09:22:13
> Objet: Re: rbd_cache, limiting read on high iops around 40k
>
> It is already possible to do in proxmox 3.4 (with the latest updates
> qemu-kvm 2.2.x). But it is necessary to register in the conf file
> iothread:1. For single drives the ambiguous behavior of productivity.
>
> 2015-06-22 10:12 GMT+03:00 Stefan Priebe - Profihost AG <
> s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org > :
>
>
>
> Am 22.06.2015 um 09:08 schrieb Alexandre DERUMIER < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >=
:
>
> >>> Just an update, there seems to be no proper way to pass iothread
> >>> parameter from openstack-nova (not at least in Juno release). So a
> >>> default single iothread per VM is what all we have. So in conclusion =
a
> >>> nova instance max iops on ceph rbd will be limited to 30-40K.
> >
> > Thanks for the update.
> >
> > For proxmox users,
> >
> > I have added iothread option to gui for proxmox 4.0
>
> Can we make iothread the default? Does it also help for single disks or
> only multiple disks?
>
> > and added jemalloc as default memory allocator
> >
> >
> > I have also send a jemmaloc patch to qemu dev mailing
> > https://lists.gnu.org/archive/html/qemu-devel/2015-06/msg05265.html
> >
> > (Help is welcome to push it in qemu upstream ! )
> >
> >
> >
> > ----- Mail original -----
> > De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> > =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> > Cc: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >, "Irek Fasikhov" <
> malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >,
> "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> > Envoy=C3=A9: Lundi 22 Juin 2015 07:58:47
> > Objet: Re: rbd_cache, limiting read on high iops around 40k
> >
> > Just an update, there seems to be no proper way to pass iothread
> > parameter from openstack-nova (not at least in Juno release). So a
> > default single iothread per VM is what all we have. So in conclusion a
> > nova instance max iops on ceph rbd will be limited to 30-40K.
> >
> > On Tue, Jun 16, 2015 at 10:08 PM, Alexandre DERUMIER
> > < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:
> >> Hi,
> >>
> >> some news about qemu with tcmalloc vs jemmaloc.
> >>
> >> I'm testing with multiple disks (with iothreads) in 1 qemu guest.
> >>
> >> And if tcmalloc is a little faster than jemmaloc,
> >>
> >> I have hit a lot of time the
> tcmalloc::ThreadCache::ReleaseToCentralCache bug.
> >>
> >> increasing TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES, don't help.
> >>
> >>
> >> with multiple disk, I'm around 200k iops with tcmalloc (before hitting
> the bug) and 350kiops with jemmaloc.
> >>
> >> The problem is that when I hit malloc bug, I'm around 4000-10000 iops,
> and only way to fix is is to restart qemu ...
> >>
> >>
> >>
> >> ----- Mail original -----
> >> De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> >> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >> Cc: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >, "Irek Fasikhov" <
> malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >,
> "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >> Envoy=C3=A9: Vendredi 12 Juin 2015 08:58:21
> >> Objet: Re: rbd_cache, limiting read on high iops around 40k
> >>
> >> Thanks, posted the question in openstack list. Hopefully will get some
> >> expert opinion.
> >>
> >> On Fri, Jun 12, 2015 at 11:33 AM, Alexandre DERUMIER
> >> < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:
> >>> Hi,
> >>>
> >>> here a libvirt xml sample from libvirt src
> >>>
> >>> (you need to define <iothreads> number, then assign then in disks).
> >>>
> >>> I don't use openstack, so I really don't known how it's working with
> it.
> >>>
> >>>
> >>> <domain type=3D'qemu'>
> >>> <name>QEMUGuest1</name>
> >>> <uuid>c7a5fdbd-edaf-9455-926a-d65c16db1809</uuid>
> >>> <memory unit=3D'KiB'>219136</memory>
> >>> <currentMemory unit=3D'KiB'>219136</currentMemory>
> >>> <vcpu placement=3D'static'>2</vcpu>
> >>> <iothreads>2</iothreads>
> >>> <os>
> >>> <type arch=3D'i686' machine=3D'pc'>hvm</type>
> >>> <boot dev=3D'hd'/>
> >>> </os>
> >>> <clock offset=3D'utc'/>
> >>> <on_poweroff>destroy</on_poweroff>
> >>> <on_reboot>restart</on_reboot>
> >>> <on_crash>destroy</on_crash>
> >>> <devices>
> >>> <emulator>/usr/bin/qemu</emulator>
> >>> <disk type=3D'file' device=3D'disk'>
> >>> <driver name=3D'qemu' type=3D'raw' iothread=3D'1'/>
> >>> <source file=3D'/var/lib/libvirt/images/iothrtest1.img'/>
> >>> <target dev=3D'vdb' bus=3D'virtio'/>
> >>> <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04'
> function=3D'0x0'/>
> >>> </disk>
> >>> <disk type=3D'file' device=3D'disk'>
> >>> <driver name=3D'qemu' type=3D'raw' iothread=3D'2'/>
> >>> <source file=3D'/var/lib/libvirt/images/iothrtest2.img'/>
> >>> <target dev=3D'vdc' bus=3D'virtio'/>
> >>> </disk>
> >>> <controller type=3D'usb' index=3D'0'/>
> >>> <controller type=3D'ide' index=3D'0'/>
> >>> <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
> >>> <memballoon model=3D'none'/>
> >>> </devices>
> >>> </domain>
> >>>
> >>>
> >>> ----- Mail original -----
> >>> De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> >>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >>> Cc: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >, "Irek Fasikhov" <
> malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >,
> "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>> Envoy=C3=A9: Vendredi 12 Juin 2015 07:52:41
> >>> Objet: Re: rbd_cache, limiting read on high iops around 40k
> >>>
> >>> Hi Alexandre,
> >>>
> >>> I agree with your rational, of one iothread per disk. CPU consumed in
> >>> IOwait is pretty high in each VM. But I am not finding a way to set
> >>> the same on a nova instance. I am using openstack Juno with QEMU+KVM.
> >>> As per libvirt documentation for setting iothreads, I can edit
> >>> domain.xml directly and achieve the same effect. However in as in
> >>> openstack env domain xml is created by nova with some additional
> >>> metadata, so editing the domain xml using 'virsh edit' does not seems
> >>> to work(I agree, it is not a very cloud way of doing things, but a
> >>> hack). Changes made there vanish after saving them, due to reason
> >>> libvirt validation fails on the same.
> >>>
> >>> #virsh dumpxml instance-000000c5 > vm.xml
> >>> #virt-xml-validate vm.xml
> >>> Relax-NG validity error : Extra element cpu in interleave
> >>> vm.xml:1: element domain: Relax-NG validity error : Element domain
> >>> failed to validate content
> >>> vm.xml fails to validate
> >>>
> >>> Second approach I took was to setting QoS in volumes types. But there
> >>> is no option to set iothreads per volume, there are parameter realted
> >>> to max_read/wrirte ops/bytes.
> >>>
> >>> Thirdly, editing Nova flavor and proving extra specs like
> >>> hw:cpu_socket/thread/core, can change guest CPU topology however agai=
n
> >>> no way to set iothread. It does accept hw_disk_iothreads(no type chec=
k
> >>> in place, i believe ), but can not pass the same in domain.xml.
> >>>
> >>> Could you suggest me a way to set the same.
> >>>
> >>> -Pushpesh
> >>>
> >>> On Wed, Jun 10, 2015 at 12:59 PM, Alexandre DERUMIER
> >>> < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:
> >>>>>> I need to try out the performance on qemu soon and may come back t=
o
> you if I need some qemu setting trick :-)
> >>>>
> >>>> Sure no problem.
> >>>>
> >>>> (BTW, I can reach around 200k iops in 1 qemu vm with 5 virtio disks
> with 1 iothread by disk)
> >>>>
> >>>>
> >>>> ----- Mail original -----
> >>>> De: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >
> >>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >, "Irek Fasikhov" <
> malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> >>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "pushpesh sharma" <
> pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >, "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>>> Envoy=C3=A9: Mercredi 10 Juin 2015 09:06:32
> >>>> Objet: RE: rbd_cache, limiting read on high iops around 40k
> >>>>
> >>>> Hi Alexandre,
> >>>> Thanks for sharing the data.
> >>>> I need to try out the performance on qemu soon and may come back to
> you if I need some qemu setting trick :-)
> >>>>
> >>>> Regards
> >>>> Somnath
> >>>>
> >>>> -----Original Message-----
> >>>> From: ceph-users [mailto: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org ] On
> Behalf Of Alexandre DERUMIER
> >>>> Sent: Tuesday, June 09, 2015 10:42 PM
> >>>> To: Irek Fasikhov
> >>>> Cc: ceph-devel; pushpesh sharma; ceph-users
> >>>> Subject: Re: [ceph-users] rbd_cache, limiting read on high iops
> around 40k
> >>>>
> >>>>>> Very good work!
> >>>>>> Do you have a rpm-file?
> >>>>>> Thanks.
> >>>> no sorry, I'm have compiled it manually (and I'm using debian jessie
> as client)
> >>>>
> >>>>
> >>>>
> >>>> ----- Mail original -----
> >>>> De: "Irek Fasikhov" < malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> >>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >>>> Cc: "Robert LeBlanc" < robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org >, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >, "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>>> Envoy=C3=A9: Mercredi 10 Juin 2015 07:21:42
> >>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around
> 40k
> >>>>
> >>>> Hi, Alexandre.
> >>>>
> >>>> Very good work!
> >>>> Do you have a rpm-file?
> >>>> Thanks.
> >>>>
> >>>> 2015-06-10 7:10 GMT+03:00 Alexandre DERUMIER < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> :
> >>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> I have tested qemu with last tcmalloc 2.4, and the improvement is
> huge with iothread: 50k iops (+45%) !
> >>>>
> >>>>
> >>>>
> >>>> qemu : no iothread : glibc : iops=3D33395 qemu : no-iothread : tcmal=
loc
> (2.2.1) : iops=3D34516 (+3%) qemu : no-iothread : jemmaloc : iops=3D42226
> (+26%) qemu : no-iothread : tcmalloc (2.4) : iops=3D35974 (+7%)
> >>>>
> >>>>
> >>>> qemu : iothread : glibc : iops=3D34516
> >>>> qemu : iothread : tcmalloc : iops=3D38676 (+12%) qemu : iothread :
> jemmaloc : iops=3D28023 (-19%) qemu : iothread : tcmalloc (2.4) : iops=3D=
50276
> (+45%)
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)
> >>>> ------------------------------------------------------
> >>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> >>>> fio-2.1.11
> >>>> Starting 1 process
> >>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [214.7MB/0KB/0KB /s] [54.1K/0/=
0
> iops] [eta 00m:00s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D894: We=
d Jun 10
> 05:54:24 2015 read : io=3D5120.0MB, bw=3D201108KB/s, iops=3D50276, runt=
=3D
> 26070msec slat (usec): min=3D1, max=3D1136, avg=3D 3.54, stdev=3D 3.58 cl=
at (usec):
> min=3D128, max=3D6262, avg=3D631.41, stdev=3D197.71 lat (usec): min=3D149=
, max=3D6265,
> avg=3D635.27, stdev=3D197.40 clat percentiles (usec):
> >>>> | 1.00th=3D[ 318], 5.00th=3D[ 378], 10.00th=3D[ 418], 20.00th=3D[ 47=
4],
> >>>> | 30.00th=3D[ 516], 40.00th=3D[ 564], 50.00th=3D[ 612], 60.00th=3D[ =
652],
> >>>> | 70.00th=3D[ 700], 80.00th=3D[ 756], 90.00th=3D[ 860], 95.00th=3D[ =
980],
> >>>> | 99.00th=3D[ 1272], 99.50th=3D[ 1384], 99.90th=3D[ 1688], 99.95th=
=3D[ 1896],
> >>>> | 99.99th=3D[ 3760]
> >>>> bw (KB /s): min=3D145608, max=3D249688, per=3D100.00%, avg=3D201108.=
00,
> stdev=3D21718.87 lat (usec) : 250=3D0.04%, 500=3D25.84%, 750=3D53.00%, 10=
00=3D16.63%
> lat (msec) : 2=3D4.46%, 4=3D0.03%, 10=3D0.01% cpu : usr=3D9.73%, sys=3D24=
.93%,
> ctx=3D66417, majf=3D0, minf=3D38 IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%=
, 8=3D0.1%,
> 16=3D0.1%, 32=3D100.0%, >=3D64=3D0.0% submit : 0=3D0.0%, 4=3D100.0%, 8=3D=
0.0%, 16=3D0.0%,
> 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D=
0.0%, 16=3D0.0%,
> 32=3D0.1%, 64=3D0.0%, >=3D64=3D0.0% issued : total=3Dr=3D1310720/w=3D0/d=
=3D0,
> short=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentile=3D=
100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D201107KB/s, minb=3D201107KB/s,
> maxb=3D201107KB/s, mint=3D26070msec, maxt=3D26070msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1302555/0, merge=3D0/0, ticks=3D715176/0, in_queue=3D7148=
40,
> util=3D99.73%
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> >>>> fio-2.1.11
> >>>> Starting 1 process
> >>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [158.7MB/0KB/0KB /s] [40.6K/0/=
0
> iops] [eta 00m:00s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D889: We=
d Jun 10
> 06:05:06 2015 read : io=3D5120.0MB, bw=3D143897KB/s, iops=3D35974, runt=
=3D
> 36435msec slat (usec): min=3D1, max=3D710, avg=3D 3.31, stdev=3D 3.35 cla=
t (usec):
> min=3D191, max=3D4740, avg=3D884.66, stdev=3D315.65 lat (usec): min=3D289=
, max=3D4743,
> avg=3D888.31, stdev=3D315.51 clat percentiles (usec):
> >>>> | 1.00th=3D[ 462], 5.00th=3D[ 516], 10.00th=3D[ 548], 20.00th=3D[ 59=
6],
> >>>> | 30.00th=3D[ 652], 40.00th=3D[ 764], 50.00th=3D[ 868], 60.00th=3D[ =
940],
> >>>> | 70.00th=3D[ 1004], 80.00th=3D[ 1096], 90.00th=3D[ 1256], 95.00th=
=3D[ 1416],
> >>>> | 99.00th=3D[ 2024], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=
=3D[ 2640],
> >>>> | 99.99th=3D[ 3632]
> >>>> bw (KB /s): min=3D98352, max=3D177328, per=3D99.91%, avg=3D143772.11=
,
> stdev=3D21782.39 lat (usec) : 250=3D0.01%, 500=3D3.48%, 750=3D35.69%, 100=
0=3D30.01%
> lat (msec) : 2=3D29.74%, 4=3D1.07%, 10=3D0.01% cpu : usr=3D7.10%, sys=3D1=
6.90%,
> ctx=3D54855, majf=3D0, minf=3D38 IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%=
, 8=3D0.1%,
> 16=3D0.1%, 32=3D100.0%, >=3D64=3D0.0% submit : 0=3D0.0%, 4=3D100.0%, 8=3D=
0.0%, 16=3D0.0%,
> 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D=
0.0%, 16=3D0.0%,
> 32=3D0.1%, 64=3D0.0%, >=3D64=3D0.0% issued : total=3Dr=3D1310720/w=3D0/d=
=3D0,
> short=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentile=3D=
100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D143896KB/s, minb=3D143896KB/s,
> maxb=3D143896KB/s, mint=3D36435msec, maxt=3D36435msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1301357/0, merge=3D0/0, ticks=3D1033036/0, in_queue=3D103=
2716,
> util=3D99.85%
> >>>>
> >>>>
> >>>> ----- Mail original -----
> >>>> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >>>> =C3=80: "Robert LeBlanc" < robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org >
> >>>> Cc: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >, "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>>> Envoy=C3=A9: Mardi 9 Juin 2015 18:47:27
> >>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around
> 40k
> >>>>
> >>>> Hi Robert,
> >>>>
> >>>>>> What I found was that Ceph OSDs performed well with either tcmallo=
c
> or
> >>>>>> jemalloc (except when RocksDB was built with jemalloc instead of
> >>>>>> tcmalloc, I'm still working to dig into why that might be the case=
).
> >>>> yes,from my test, for osd tcmalloc is a little faster (but very
> little) than jemalloc.
> >>>>
> >>>>
> >>>>
> >>>>>> However, I found that tcmalloc with QEMU/KVM was very detrimental =
to
> >>>>>> small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was mu=
ch
> >>>>>> better for QEMU/KVM in the tests that we ran. [1]
> >>>>
> >>>>
> >>>> Just have done qemu test (4k randread - rbd_cache=3Doff), I don't se=
e
> speed regression with tcmalloc.
> >>>> with qemu iothread, tcmalloc have a speed increase over glib
> >>>> with qemu iothread, jemalloc have a speed decrease
> >>>>
> >>>> without iothread, jemalloc have a big speed increase
> >>>>
> >>>> this is with
> >>>> -qemu 2.3
> >>>> -tcmalloc 2.2.1
> >>>> -jemmaloc 3.6
> >>>> -libc6 2.19
> >>>>
> >>>>
> >>>> qemu : no iothread : glibc : iops=3D33395
> >>>> qemu : no-iothread : tcmalloc : iops=3D34516 (+3%)
> >>>> qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)
> >>>>
> >>>> qemu : iothread : glibc : iops=3D34516
> >>>> qemu : iothread : tcmalloc : iops=3D38676 (+12%)
> >>>> qemu : iothread : jemmaloc : iops=3D28023 (-19%)
> >>>>
> >>>>
> >>>> (The benefit of iothreads is that we can scale with more disks in 1v=
m)
> >>>>
> >>>>
> >>>> fio results:
> >>>> ------------
> >>>>
> >>>> qemu : iothread : tcmalloc : iops=3D38676
> >>>> -----------------------------------------
> >>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> >>>> fio-2.1.11
> >>>> Starting 1 process
> >>>> Jobs: 1 (f=3D0): [r(1)] [100.0% done] [123.5MB/0KB/0KB /s] [31.6K/0/=
0
> iops] [eta 00m:00s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D1265: T=
ue Jun 9
> 18:16:53 2015
> >>>> read : io=3D5120.0MB, bw=3D154707KB/s, iops=3D38676, runt=3D 33889ms=
ec
> >>>> slat (usec): min=3D1, max=3D715, avg=3D 3.63, stdev=3D 3.42
> >>>> clat (usec): min=3D152, max=3D5736, avg=3D822.12, stdev=3D289.34
> >>>> lat (usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D289.08
> >>>> clat percentiles (usec):
> >>>> | 1.00th=3D[ 402], 5.00th=3D[ 466], 10.00th=3D[ 510], 20.00th=3D[ 57=
2],
> >>>> | 30.00th=3D[ 636], 40.00th=3D[ 716], 50.00th=3D[ 780], 60.00th=3D[ =
852],
> >>>> | 70.00th=3D[ 932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], 95.00th=3D=
[ 1352],
> >>>> | 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=3D[ 2256], 99.95th=
=3D[ 2448],
> >>>> | 99.99th=3D[ 3888]
> >>>> bw (KB /s): min=3D123888, max=3D198584, per=3D100.00%, avg=3D154824.=
40,
> stdev=3D16978.03
> >>>> lat (usec) : 250=3D0.01%, 500=3D8.91%, 750=3D36.44%, 1000=3D32.63%
> >>>> lat (msec) : 2=3D21.65%, 4=3D0.37%, 10=3D0.01%
> >>>> cpu : usr=3D8.29%, sys=3D19.76%, ctx=3D55882, majf=3D0, minf=3D39
> >>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
> >>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
> >=3D64=3D0.0%
> >>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D154707KB/s, minb=3D154707KB/s,
> maxb=3D154707KB/s, mint=3D33889msec, maxt=3D33889msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_queue=3D9340=
96,
> util=3D99.77%
> >>>>
> >>>>
> >>>>
> >>>> qemu : no-iothread : tcmalloc : iops=3D34516
> >>>> ---------------------------------------------
> >>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s] [41.8K/0/=
0
> iops] [eta 00m:00s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D896: Tu=
e Jun 9
> 18:19:08 2015
> >>>> read : io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=3D 37974ms=
ec
> >>>> slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.57
> >>>> clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=3D333.61
> >>>> lat (usec): min=3D266, max=3D11862, avg=3D925.77, stdev=3D333.40
> >>>> clat percentiles (usec):
> >>>> | 1.00th=3D[ 434], 5.00th=3D[ 510], 10.00th=3D[ 564], 20.00th=3D[ 65=
2],
> >>>> | 30.00th=3D[ 732], 40.00th=3D[ 812], 50.00th=3D[ 876], 60.00th=3D[ =
940],
> >>>> | 70.00th=3D[ 1020], 80.00th=3D[ 1112], 90.00th=3D[ 1320], 95.00th=
=3D[ 1576],
> >>>> | 99.00th=3D[ 1992], 99.50th=3D[ 2128], 99.90th=3D[ 2736], 99.95th=
=3D[ 3248],
> >>>> | 99.99th=3D[ 4320]
> >>>> bw (KB /s): min=3D77312, max=3D185576, per=3D99.74%, avg=3D137709.88=
,
> stdev=3D16883.77
> >>>> lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=3D35.60%
> >>>> lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01%
> >>>> cpu : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, minf=3D38
> >>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
> >>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
> >=3D64=3D0.0%
> >>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s,
> maxb=3D138064KB/s, mint=3D37974msec, maxt=3D37974msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1309902/0, merge=3D0/0, ticks=3D1068768/0, in_queue=3D106=
8396,
> util=3D99.86%
> >>>>
> >>>>
> >>>>
> >>>> qemu : iothread : glibc : iops=3D34516
> >>>> -------------------------------------
> >>>>
> >>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> >>>> fio-2.1.11
> >>>> Starting 1 process
> >>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0KB /s] [34.2K/0/=
0
> iops] [eta 00m:00s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D876: Tu=
e Jun 9
> 18:24:01 2015
> >>>> read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=3D 38051ms=
ec
> >>>> slat (usec): min=3D1, max=3D496, avg=3D 3.88, stdev=3D 3.66
> >>>> clat (usec): min=3D283, max=3D7515, avg=3D923.34, stdev=3D300.28
> >>>> lat (usec): min=3D286, max=3D7519, avg=3D927.58, stdev=3D300.02
> >>>> clat percentiles (usec):
> >>>> | 1.00th=3D[ 506], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 65=
2],
> >>>> | 30.00th=3D[ 724], 40.00th=3D[ 804], 50.00th=3D[ 884], 60.00th=3D[ =
964],
> >>>> | 70.00th=3D[ 1048], 80.00th=3D[ 1144], 90.00th=3D[ 1304], 95.00th=
=3D[ 1448],
> >>>> | 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480], 99.95th=
=3D[ 2640],
> >>>> | 99.99th=3D[ 3984]
> >>>> bw (KB /s): min=3D102680, max=3D171112, per=3D100.00%, avg=3D137877.=
78,
> stdev=3D15521.30
> >>>> lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.82%
> >>>> lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01%
> >>>> cpu : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, minf=3D38
> >>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
> >>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
> >=3D64=3D0.0%
> >>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s,
> maxb=3D137785KB/s, mint=3D38051msec, maxt=3D38051msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1307426/0, merge=3D0/0, ticks=3D1051416/0, in_queue=3D105=
0972,
> util=3D99.85%
> >>>>
> >>>>
> >>>>
> >>>> qemu : no iothread : glibc : iops=3D33395
> >>>> -----------------------------------------
> >>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> >>>> fio-2.1.11
> >>>> Starting 1 process
> >>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s] [32.9K/0/=
0
> iops] [eta 00m:00s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D886: Tu=
e Jun 9
> 18:27:18 2015
> >>>> read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=3D 39248ms=
ec
> >>>> slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.29
> >>>> clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=3D335.51
> >>>> lat (usec): min=3D303, max=3D12638, avg=3D957.01, stdev=3D335.29
> >>>> clat percentiles (usec):
> >>>> | 1.00th=3D[ 516], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 65=
2],
> >>>> | 30.00th=3D[ 724], 40.00th=3D[ 820], 50.00th=3D[ 924], 60.00th=3D[ =
996],
> >>>> | 70.00th=3D[ 1080], 80.00th=3D[ 1176], 90.00th=3D[ 1336], 95.00th=
=3D[ 1528],
> >>>> | 99.00th=3D[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672], 99.95th=
=3D[ 2928],
> >>>> | 99.99th=3D[ 4832]
> >>>> bw (KB /s): min=3D98136, max=3D171624, per=3D100.00%, avg=3D133682.6=
4,
> stdev=3D19121.91
> >>>> lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=3D26.98%
> >>>> lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01%
> >>>> cpu : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D0, minf=3D38
> >>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
> >>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
> >=3D64=3D0.0%
> >>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s,
> maxb=3D133583KB/s, mint=3D39248msec, maxt=3D39248msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1304526/0, merge=3D0/0, ticks=3D1075020/0, in_queue=3D107=
4536,
> util=3D99.84%
> >>>>
> >>>>
> >>>>
> >>>> qemu : iothread : jemmaloc : iops=3D28023
> >>>> ----------------------------------------
> >>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> >>>> fio-2.1.11
> >>>> Starting 1 process
> >>>> Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] [39.1K/0/0
> iops] [eta 00m:01s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D899: Tu=
e Jun 9
> 18:30:26 2015
> >>>> read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=3D 46772ms=
ec
> >>>> slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.77
> >>>> clat (usec): min=3D253, max=3D11307, avg=3D1135.63, stdev=3D346.55
> >>>> lat (usec): min=3D256, max=3D11309, avg=3D1140.39, stdev=3D346.22
> >>>> clat percentiles (usec):
> >>>> | 1.00th=3D[ 510], 5.00th=3D[ 628], 10.00th=3D[ 700], 20.00th=3D[ 82=
0],
> >>>> | 30.00th=3D[ 924], 40.00th=3D[ 1032], 50.00th=3D[ 1128], 60.00th=3D=
[ 1224],
> >>>> | 70.00th=3D[ 1320], 80.00th=3D[ 1416], 90.00th=3D[ 1560], 95.00th=
=3D[ 1688],
> >>>> | 99.00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=
=3D[ 2832],
> >>>> | 99.99th=3D[ 3760]
> >>>> bw (KB /s): min=3D91792, max=3D174416, per=3D99.90%, avg=3D111985.27=
,
> stdev=3D17381.70
> >>>> lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33%
> >>>> lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01%
> >>>> cpu : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, minf=3D38
> >>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
> >>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
> >=3D64=3D0.0%
> >>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s,
> maxb=3D112094KB/s, mint=3D46772msec, maxt=3D46772msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1309169/0, merge=3D0/0, ticks=3D1305796/0, in_queue=3D130=
5376,
> util=3D98.68%
> >>>>
> >>>>
> >>>>
> >>>> qemu : non-iothread : jemmaloc : iops=3D42226
> >>>> --------------------------------------------
> >>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> >>>> fio-2.1.11
> >>>> Starting 1 process
> >>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s] [43.9K/0/=
0
> iops] [eta 00m:00s]
> >>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D892: Tu=
e Jun 9
> 18:34:11 2015
> >>>> read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=3D 29599ms=
ec
> >>>> slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D 3.74
> >>>> clat (usec): min=3D174, max=3D3841, avg=3D717.08, stdev=3D237.53
> >>>> lat (usec): min=3D210, max=3D3844, avg=3D721.23, stdev=3D237.22
> >>>> clat percentiles (usec):
> >>>> | 1.00th=3D[ 354], 5.00th=3D[ 422], 10.00th=3D[ 462], 20.00th=3D[ 51=
6],
> >>>> | 30.00th=3D[ 572], 40.00th=3D[ 628], 50.00th=3D[ 684], 60.00th=3D[ =
740],
> >>>> | 70.00th=3D[ 804], 80.00th=3D[ 884], 90.00th=3D[ 1004], 95.00th=3D[=
 1128],
> >>>> | 99.00th=3D[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928], 99.95th=
=3D[ 2064],
> >>>> | 99.99th=3D[ 2608]
> >>>> bw (KB /s): min=3D138120, max=3D230816, per=3D100.00%, avg=3D177192.=
14,
> stdev=3D23440.79
> >>>> lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=3D27.46%
> >>>> lat (msec) : 2=3D10.30%, 4=3D0.07%
> >>>> cpu : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, minf=3D39
> >>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
> >>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%,
> >=3D64=3D0.0%
> >>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>
> >>>> Run status group 0 (all jobs):
> >>>> READ: io=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s,
> maxb=3D177130KB/s, mint=3D29599msec, maxt=3D29599msec
> >>>>
> >>>> Disk stats (read/write):
> >>>> vdb: ios=3D1303992/0, merge=3D0/0, ticks=3D798008/0, in_queue=3D7976=
36,
> util=3D99.80%
> >>>>
> >>>>
> >>>>
> >>>> ----- Mail original -----
> >>>> De: "Robert LeBlanc" < robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org >
> >>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >>>> Cc: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >, "ceph-users" < ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>>> Envoy=C3=A9: Mardi 9 Juin 2015 18:00:29
> >>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around
> 40k
> >>>>
> >>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>> Hash: SHA256
> >>>>
> >>>> I also saw a similar performance increase by using alternative memor=
y
> >>>> allocators. What I found was that Ceph OSDs performed well with eith=
er
> >>>> tcmalloc or jemalloc (except when RocksDB was built with jemalloc
> >>>> instead of tcmalloc, I'm still working to dig into why that might be
> >>>> the case).
> >>>>
> >>>> However, I found that tcmalloc with QEMU/KVM was very detrimental to
> >>>> small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much
> >>>> better for QEMU/KVM in the tests that we ran. [1]
> >>>>
> >>>> I'm currently looking into I/O bottlenecks around the 16KB range and
> >>>> I'm seeing a lot of time in thread creation and destruction, the
> >>>> memory allocators are quite a bit down the list (both fio with
> >>>> ioengine rbd and on the OSDs). I wonder what the difference can be.
> >>>> I've tried using the async messenger but there wasn't a huge
> >>>> difference. [2]
> >>>>
> >>>> Further down the rabbit hole....
> >>>>
> >>>> [1]
> https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg20197.html
> >>>> [2]
> https://www.mail-archive.com/ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg23982.html
> >>>> -----BEGIN PGP SIGNATURE-----
> >>>> Version: Mailvelope v0.13.1
> >>>> Comment: https://www.mailvelope.com
> >>>>
> >>>> wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4MwP/1vt65cvTyyVGGSGRrE8
> >>>> unuWjafMHzl486XH+EaVrDVTXFVFOoncJ6kugSpD7yavtCpZNdhsIaTRZguU
> >>>> YpfAppNAJU5biSwNv9QPI7kPP2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw87
> >>>> afq46GhPHqEXdjp3rOB4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnCY2
> >>>> S695Dt1gzt0ERUOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivVl3
> >>>> vDYWxQHPK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+51
> >>>> 9ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPGOO
> >>>> qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHhu3
> >>>> Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c7b
> >>>> 6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV13
> >>>> R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTKVzQ
> >>>> 1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfbuEHalVjz4
> >>>> oSJX
> >>>> =3Dk281
> >>>> -----END PGP SIGNATURE-----
> >>>> ----------------
> >>>> Robert LeBlanc
> >>>> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904 C70E E654 3BB2 FA62 B9F1
> >>>>
> >>>>
> >>>> On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DERUMIER <
> aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:
> >>>>>>> Frankly, I'm a little impressed that without RBD cache we can hit
> 80K
> >>>>>>> IOPS from 1 VM!
> >>>>>
> >>>>> Note that theses result are not in a vm (fio-rbd on host), so in a
> vm we'll have overhead.
> >>>>> (I'm planning to send results in qemu soon)
> >>>>>
> >>>>>>> How fast are the SSDs in those 3 OSDs?
> >>>>>
> >>>>> Theses results are with datas in buffer memory of osd nodes.
> >>>>>
> >>>>> When reading fulling on ssd (intel s3500),
> >>>>>
> >>>>> For 1 client,
> >>>>>
> >>>>> I'm around 33k iops without cache and 32k iops with cache, with 1
> osd.
> >>>>> I'm around 55k iops without cache and 38k iops with cache, with 3
> osd.
> >>>>>
> >>>>> with multiple clients jobs, I can reach around 70kiops by osd , and
> 250k iops by osd when datas are in buffer.
> >>>>>
> >>>>> (cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)
> >>>>>
> >>>>>
> >>>>>
> >>>>> small tip :
> >>>>> I'm using tcmalloc for fio-rbd or rados bench to improve latencies
> by around 20%
> >>>>>
> >>>>> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...
> >>>>> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ...
> >>>>>
> >>>>> as a lot of time is spent in malloc/free
> >>>>>
> >>>>>
> >>>>> (qemu support also tcmalloc since some months , I'll bench it too
> >>>>> https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html
> )
> >>>>>
> >>>>>
> >>>>>
> >>>>> I'll try to send full bench results soon, from 1 to 18 ssd osd.
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> ----- Mail original -----
> >>>>> De: "Mark Nelson" < mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org >
> >>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >, "pushpesh sharma" <
> pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> >>>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>>>> Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31
> >>>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops aroun=
d
> 40k
> >>>>>
> >>>>> Hi All,
> >>>>>
> >>>>> In the past we've hit some performance issues with RBD cache that
> we've
> >>>>> fixed, but we've never really tried pushing a single VM beyond 40+K
> read
> >>>>> IOPS in testing (or at least I never have). I suspect there's a
> couple
> >>>>> of possibilities as to why it might be slower, but perhaps joshd ca=
n
> >>>>> chime in as he's more familiar with what that code looks like.
> >>>>>
> >>>>> Frankly, I'm a little impressed that without RBD cache we can hit 8=
0K
> >>>>> IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?
> >>>>>
> >>>>> Mark
> >>>>>
> >>>>>> On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:
> >>>>>> It's seem that the limit is mainly going in high queue depth (+- >
> 16)
> >>>>>>
> >>>>>> Here the result in iops with 1client- 4krandread- 3osd - with
> differents queue depth size.
> >>>>>> rbd_cache is almost the same than without cache with queue depth <=
16
> >>>>>>
> >>>>>>
> >>>>>> cache
> >>>>>> -----
> >>>>>> qd1: 1651
> >>>>>> qd2: 3482
> >>>>>> qd4: 7958
> >>>>>> qd8: 17912
> >>>>>> qd16: 36020
> >>>>>> qd32: 42765
> >>>>>> qd64: 46169
> >>>>>>
> >>>>>> no cache
> >>>>>> --------
> >>>>>> qd1: 1748
> >>>>>> qd2: 3570
> >>>>>> qd4: 8356
> >>>>>> qd8: 17732
> >>>>>> qd16: 41396
> >>>>>> qd32: 78633
> >>>>>> qd64: 79063
> >>>>>> qd128: 79550
> >>>>>>
> >>>>>>
> >>>>>> ----- Mail original -----
> >>>>>> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >>>>>> =C3=80: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> >>>>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>>>>> Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21
> >>>>>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops
> around 40k
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>>>> We tried adding more RBDs to single VM, but no luck.
> >>>>>>
> >>>>>> If you want to scale with more disks in a single qemu vm, you need
> to use iothread feature from qemu and assign 1 iothread by disk (works wi=
th
> virtio-blk).
> >>>>>> It's working for me, I can scale with adding more disks.
> >>>>>>
> >>>>>>
> >>>>>> My bench here are done with fio-rbd on host.
> >>>>>> I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a
> single host and around 250kiops 10clients-rbdcache=3Don.
> >>>>>>
> >>>>>>
> >>>>>> I just wonder why I don't have performance decrease around 30k iop=
s
> with 1osd.
> >>>>>>
> >>>>>> I'm going to see if this tracker
> >>>>>> http://tracker.ceph.com/issues/11056
> >>>>>>
> >>>>>> could be the cause.
> >>>>>>
> >>>>>> (My master build was done some week ago)
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> ----- Mail original -----
> >>>>>> De: "pushpesh sharma" < pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org >
> >>>>>> =C3=80: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >>>>>> Cc: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >>>>>> Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04
> >>>>>> Objet: Re: rbd_cache, limiting read on high iops around 40k
> >>>>>>
> >>>>>> Hi Alexandre,
> >>>>>>
> >>>>>> We have also seen something very similar on Hammer(0.94-1). We wer=
e
> doing some benchmarking for VMs hosted on hypervisor (QEMU-KVM,
> openstack-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as
> additional storage. For some strange reason it was not able to scale 4K- =
RR
> iops on each VM beyond 35-40k. We tried adding more RBDs to single VM, bu=
t
> no luck. However increasing number of VMs to 4 on a single hypervisor did
> scale to some extent. After this there was no much benefit we got from
> adding more VMs.
> >>>>>>
> >>>>>> Here is the trend we have seen, x-axis is number of hypervisor,
> each hypervisor has 4 VM, each VM has 1 RBD:-
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> VDbench is used as benchmarking tool. We were not saturating
> network and CPUs at OSD nodes. We were not able to saturate CPUs at
> hypervisors, and that is where we were suspecting of some throttling
> effect. However we haven't setted any such limits from nova or kvm end. W=
e
> tried some CPU pinning and other KVM related tuning as well, but no luck.
> >>>>>>
> >>>>>> We tried the same experiment on a bare metal. It was 4K RR IOPs
> were scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than
> scaling beyond that point the numbers were actually degrading. (Single pi=
pe
> more congestion effect)
> >>>>>>
> >>>>>> We never suspected that rbd cache enable could be detrimental to
> performance. It would nice to route cause the problem if that is the case=
.
> >>>>>>
> >>>>>> On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER <
> aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:
> >>>>>>
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> I'm doing benchmark (ceph master branch), with randread 4k
> qdepth=3D32,
> >>>>>> and rbd_cache=3Dtrue seem to limit the iops around 40k
> >>>>>>
> >>>>>>
> >>>>>> no cache
> >>>>>> --------
> >>>>>> 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops
> >>>>>> 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops
> >>>>>> 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops
> >>>>>>
> >>>>>>
> >>>>>> cache
> >>>>>> -----
> >>>>>> 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops
> >>>>>> 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops
> >>>>>> 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Is it expected ?
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> fio result rbd_cache=3Dfalse 3 osd
> >>>>>> --------------------------------
> >>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K=
,
> ioengine=3Drbd, iodepth=3D32
> >>>>>> fio-2.1.11
> >>>>>> Starting 1 process
> >>>>>> rbd engine: RBD version: 0.1.9
> >>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/=
0/0
> iops] [eta 00m:00s]
> >>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D11354=
8: Tue
> Jun 9 07:48:42 2015
> >>>>>> read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698m=
sec
> >>>>>> slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77
> >>>>>> clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82
> >>>>>> lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49
> >>>>>> clat percentiles (usec):
> >>>>>> | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ =
262],
> >>>>>> | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D=
[ 346],
> >>>>>> | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D=
[ 506],
> >>>>>> | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D=
[ 948],
> >>>>>> | 99.99th=3D[ 1176]
> >>>>>> bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D31340=
2.34,
> stdev=3D25196.21
> >>>>>> lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%,
> 1000=3D0.23%
> >>>>>> lat (msec) : 2=3D0.03%, 4=3D0.01%
> >>>>>> cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D1=
2452
> >>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=
=3D12.1%,
> >=3D64=3D0.0%
> >>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>>>> complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>>>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0
> >>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>>>
> >>>>>> Run status group 0 (all jobs):
> >>>>>> READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s,
> maxb=3D313169KB/s, mint=3D32698msec, maxt=3D32698msec
> >>>>>>
> >>>>>> Disk stats (read/write):
> >>>>>> dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0=
.00%,
> aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0, aggr=
util=3D0.00%
> >>>>>> sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0=
.00%
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> fio result rbd_cache=3Dtrue 3osd
> >>>>>> ------------------------------
> >>>>>>
> >>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K=
,
> ioengine=3Drbd, iodepth=3D32
> >>>>>> fio-2.1.11
> >>>>>> Starting 1 process
> >>>>>> rbd engine: RBD version: 0.1.9
> >>>>>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/=
0/0
> iops] [eta 00m:00s]
> >>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D11338=
9: Tue
> Jun 9 07:47:30 2015
> >>>>>> read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866m=
sec
> >>>>>> slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84
> >>>>>> clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73
> >>>>>> lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03
> >>>>>> clat percentiles (usec):
> >>>>>> | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ =
350],
> >>>>>> | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D=
[ 506],
> >>>>>> | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D=
[ 724],
> >>>>>> | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=
=3D[ 1288],
> >>>>>> | 99.99th=3D[ 2192]
> >>>>>> bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D18331=
5.10,
> stdev=3D15079.93
> >>>>>> lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%
> >>>>>> lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%
> >>>>>> cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D=
14100
> >>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 3=
2=3D5.3%,
> >=3D64=3D0.0%
> >>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>>>> complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
> >>>>>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0
> >>>>>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>>>>>
> >>>>>> Run status group 0 (all jobs):
> >>>>>> READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s,
> maxb=3D183295KB/s, mint=3D55866msec, maxt=3D55866msec
> >>>>>>
> >>>>>> Disk stats (read/write):
> >>>>>> dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0=
.01%,
> aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8, aggr=
util=3D0.01%
> >>>>>> sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0=
.01%
> >>>>> _______________________________________________
> >>>>> ceph-users mailing list
> >>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>> _______________________________________________
> >>>> ceph-users mailing list
> >>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=
=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=
=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
> >>>> =D0=9C=D0=BE=D0=B1.: +79229045757
> >>>> _______________________________________________
> >>>> ceph-users mailing list
> >>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>
> >>>> ________________________________
> >>>>
> >>>> PLEASE NOTE: The information contained in this electronic mail
> message is intended only for the use of the designated recipient(s) named
> above. If the reader of this message is not the intended recipient, you a=
re
> hereby notified that you have received this message in error and that any
> review, dissemination, distribution, or copying of this message is strict=
ly
> prohibited. If you have received this communication in error, please noti=
fy
> the sender by telephone or e-mail (as shown above) immediately and destro=
y
> any and all copies of this message in your possession (whether hard copie=
s
> or electronically stored copies).
> >>>
> >>>
> >>>
> >>> --
> >>> -Pushpesh
> >>
> >>
> >>
> >> --
> >> -Pushpesh
> >
> >
> >
> > --
> > -Pushpesh
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>
>
>
>
>
>
> --
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=
=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=
=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
> =D0=9C=D0=BE=D0=B1.: +79229045757
>
>
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=
=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
=D0=9C=D0=BE=D0=B1.: +79229045757

--047d7b3a8e60a31b9c051917910d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">|=C2=A0Proxmox 4.0 will allow to enable|disable 1 iothread=
 by disk.<div><br></div><div>Alexandre,=C2=A0Useful option!</div><div>In pr=
oxmox 3.4 will it be possible to add at least in the configuration file?=C2=
=A0Or it entails a change in the source code KVM?</div><div>Thanks.</div><d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-06-22 11:=
54 GMT+03:00 Alexandre DERUMIER <span dir=3D"ltr">&lt;<a href=3D"mailto:ade=
rumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org" target=3D"_blank">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;</span>:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><span class=3D"">&gt;&gt;It is already possible to do in p=
roxmox 3.4 (with the latest updates qemu-kvm 2.2.x). But it is necessary to=
 register in the conf file iothread:1. For single drives the ambiguous beha=
vior of productivity.<br>
<br>
</span>Yes and no ;)<br>
<br>
Currently in proxmox 3.4, iothread:1=C2=A0 generate only 1 iothread for all=
 disks.<br>
<br>
So, you&#39;ll have a small extra boost, but it&#39;ll not scale with multi=
ple disks.<br>
<br>
Proxmox 4.0 will allow to enable|disable 1 iothread by disk.<br>
<span class=3D""><br>
<br>
&gt;&gt;Does it also help for single disks or only multiple disks?<br>
<br>
</span>Iothread can also help for single disk, because by default qemu use =
a main thread for disk but also other things(don&#39;t remember what exactl=
y)<br>
<span class=3D""><br>
<br>
<br>
<br>
----- Mail original -----<br>
De: &quot;Irek Fasikhov&quot; &lt;<a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malm=
yzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
</span>=C3=80: &quot;Stefan Priebe&quot; &lt;<a href=3D"mailto:s.priebe@pro=
fihost.ag">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a>&gt;<br>
Cc: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderum=
ier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;, &quot;pushpesh sharma&quot; &lt;<a href=3D"mailto:pu=
shpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;, &quot;Somnath Roy&quo=
t; &lt;<a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</=
a>&gt;, &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<a hre=
f=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<br=
>
Envoy=C3=A9: Lundi 22 Juin 2015 09:22:13<br>
<div class=3D""><div class=3D"h5">Objet: Re: rbd_cache, limiting read on hi=
gh iops around 40k<br>
<br>
It is already possible to do in proxmox 3.4 (with the latest updates qemu-k=
vm 2.2.x). But it is necessary to register in the conf file iothread:1. For=
 single drives the ambiguous behavior of productivity.<br>
<br>
2015-06-22 10:12 GMT+03:00 Stefan Priebe - Profihost AG &lt; <a href=3D"mai=
lto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a> &gt; :<br>
<br>
<br>
<br>
Am 22.06.2015 um 09:08 schrieb Alexandre DERUMIER &lt; <a href=3D"mailto:ad=
erumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;:<br>
<br>
&gt;&gt;&gt; Just an update, there seems to be no proper way to pass iothre=
ad<br>
&gt;&gt;&gt; parameter from openstack-nova (not at least in Juno release). =
So a<br>
&gt;&gt;&gt; default single iothread per VM is what all we have. So in conc=
lusion a<br>
&gt;&gt;&gt; nova instance max iops on ceph rbd will be limited to 30-40K.<=
br>
&gt;<br>
&gt; Thanks for the update.<br>
&gt;<br>
&gt; For proxmox users,<br>
&gt;<br>
&gt; I have added iothread option to gui for proxmox 4.0<br>
<br>
Can we make iothread the default? Does it also help for single disks or onl=
y multiple disks?<br>
<br>
&gt; and added jemalloc as default memory allocator<br>
&gt;<br>
&gt;<br>
&gt; I have also send a jemmaloc patch to qemu dev mailing<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2015-06/msg05=
265.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2015-06/msg05265.html</a><br>
&gt;<br>
&gt; (Help is welcome to push it in qemu upstream ! )<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ----- Mail original -----<br>
&gt; De: &quot;pushpesh sharma&quot; &lt; <a href=3D"mailto:pushpesh.eck@gm=
ail.com">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderumier@odiso.c=
om">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt; Cc: &quot;Somnath Roy&quot; &lt; <a href=3D"mailto:Somnath.Roy@sandisk=
.com">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt;, &quot;Irek Fasikhov&quot; &lt; <a h=
ref=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;ceph-dev=
el&quot; &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel@vger=
.kernel.org</a> &gt;, &quot;ceph-users&quot; &lt; <a href=3D"mailto:ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;<br>
&gt; Envoy=C3=A9: Lundi 22 Juin 2015 07:58:47<br>
&gt; Objet: Re: rbd_cache, limiting read on high iops around 40k<br>
&gt;<br>
&gt; Just an update, there seems to be no proper way to pass iothread<br>
&gt; parameter from openstack-nova (not at least in Juno release). So a<br>
&gt; default single iothread per VM is what all we have. So in conclusion a=
<br>
&gt; nova instance max iops on ceph rbd will be limited to 30-40K.<br>
&gt;<br>
&gt; On Tue, Jun 16, 2015 at 10:08 PM, Alexandre DERUMIER<br>
&gt; &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &g=
t; wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; some news about qemu with tcmalloc vs jemmaloc.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m testing with multiple disks (with iothreads) in 1 qemu gue=
st.<br>
&gt;&gt;<br>
&gt;&gt; And if tcmalloc is a little faster than jemmaloc,<br>
&gt;&gt;<br>
&gt;&gt; I have hit a lot of time the tcmalloc::ThreadCache::ReleaseToCentr=
alCache bug.<br>
&gt;&gt;<br>
&gt;&gt; increasing TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES, don&#39;t help.<=
br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; with multiple disk, I&#39;m around 200k iops with tcmalloc (before=
 hitting the bug) and 350kiops with jemmaloc.<br>
&gt;&gt;<br>
&gt;&gt; The problem is that when I hit malloc bug, I&#39;m around 4000-100=
00 iops, and only way to fix is is to restart qemu ...<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ----- Mail original -----<br>
&gt;&gt; De: &quot;pushpesh sharma&quot; &lt; <a href=3D"mailto:pushpesh.ec=
k@gmail.com">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderumier@odi=
so.com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt; Cc: &quot;Somnath Roy&quot; &lt; <a href=3D"mailto:Somnath.Roy@san=
disk.com">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt;, &quot;Irek Fasikhov&quot; &lt; =
<a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;ceph=
-devel&quot; &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel@=
vger.kernel.org</a> &gt;, &quot;ceph-users&quot; &lt; <a href=3D"mailto:cep=
h-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;<br>
&gt;&gt; Envoy=C3=A9: Vendredi 12 Juin 2015 08:58:21<br>
&gt;&gt; Objet: Re: rbd_cache, limiting read on high iops around 40k<br>
&gt;&gt;<br>
&gt;&gt; Thanks, posted the question in openstack list. Hopefully will get =
some<br>
&gt;&gt; expert opinion.<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Jun 12, 2015 at 11:33 AM, Alexandre DERUMIER<br>
&gt;&gt; &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a=
> &gt; wrote:<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; here a libvirt xml sample from libvirt src<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; (you need to define &lt;iothreads&gt; number, then assign then=
 in disks).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I don&#39;t use openstack, so I really don&#39;t known how it&=
#39;s working with it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &lt;domain type=3D&#39;qemu&#39;&gt;<br>
&gt;&gt;&gt; &lt;name&gt;QEMUGuest1&lt;/name&gt;<br>
&gt;&gt;&gt; &lt;uuid&gt;c7a5fdbd-edaf-9455-926a-d65c16db1809&lt;/uuid&gt;<=
br>
&gt;&gt;&gt; &lt;memory unit=3D&#39;KiB&#39;&gt;219136&lt;/memory&gt;<br>
&gt;&gt;&gt; &lt;currentMemory unit=3D&#39;KiB&#39;&gt;219136&lt;/currentMe=
mory&gt;<br>
&gt;&gt;&gt; &lt;vcpu placement=3D&#39;static&#39;&gt;2&lt;/vcpu&gt;<br>
&gt;&gt;&gt; &lt;iothreads&gt;2&lt;/iothreads&gt;<br>
&gt;&gt;&gt; &lt;os&gt;<br>
&gt;&gt;&gt; &lt;type arch=3D&#39;i686&#39; machine=3D&#39;pc&#39;&gt;hvm&l=
t;/type&gt;<br>
&gt;&gt;&gt; &lt;boot dev=3D&#39;hd&#39;/&gt;<br>
&gt;&gt;&gt; &lt;/os&gt;<br>
&gt;&gt;&gt; &lt;clock offset=3D&#39;utc&#39;/&gt;<br>
&gt;&gt;&gt; &lt;on_poweroff&gt;destroy&lt;/on_poweroff&gt;<br>
&gt;&gt;&gt; &lt;on_reboot&gt;restart&lt;/on_reboot&gt;<br>
&gt;&gt;&gt; &lt;on_crash&gt;destroy&lt;/on_crash&gt;<br>
&gt;&gt;&gt; &lt;devices&gt;<br>
&gt;&gt;&gt; &lt;emulator&gt;/usr/bin/qemu&lt;/emulator&gt;<br>
&gt;&gt;&gt; &lt;disk type=3D&#39;file&#39; device=3D&#39;disk&#39;&gt;<br>
&gt;&gt;&gt; &lt;driver name=3D&#39;qemu&#39; type=3D&#39;raw&#39; iothread=
=3D&#39;1&#39;/&gt;<br>
&gt;&gt;&gt; &lt;source file=3D&#39;/var/lib/libvirt/images/iothrtest1.img&=
#39;/&gt;<br>
&gt;&gt;&gt; &lt;target dev=3D&#39;vdb&#39; bus=3D&#39;virtio&#39;/&gt;<br>
&gt;&gt;&gt; &lt;address type=3D&#39;pci&#39; domain=3D&#39;0x0000&#39; bus=
=3D&#39;0x00&#39; slot=3D&#39;0x04&#39; function=3D&#39;0x0&#39;/&gt;<br>
&gt;&gt;&gt; &lt;/disk&gt;<br>
&gt;&gt;&gt; &lt;disk type=3D&#39;file&#39; device=3D&#39;disk&#39;&gt;<br>
&gt;&gt;&gt; &lt;driver name=3D&#39;qemu&#39; type=3D&#39;raw&#39; iothread=
=3D&#39;2&#39;/&gt;<br>
&gt;&gt;&gt; &lt;source file=3D&#39;/var/lib/libvirt/images/iothrtest2.img&=
#39;/&gt;<br>
&gt;&gt;&gt; &lt;target dev=3D&#39;vdc&#39; bus=3D&#39;virtio&#39;/&gt;<br>
&gt;&gt;&gt; &lt;/disk&gt;<br>
&gt;&gt;&gt; &lt;controller type=3D&#39;usb&#39; index=3D&#39;0&#39;/&gt;<b=
r>
&gt;&gt;&gt; &lt;controller type=3D&#39;ide&#39; index=3D&#39;0&#39;/&gt;<b=
r>
&gt;&gt;&gt; &lt;controller type=3D&#39;pci&#39; index=3D&#39;0&#39; model=
=3D&#39;pci-root&#39;/&gt;<br>
&gt;&gt;&gt; &lt;memballoon model=3D&#39;none&#39;/&gt;<br>
&gt;&gt;&gt; &lt;/devices&gt;<br>
&gt;&gt;&gt; &lt;/domain&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt; De: &quot;pushpesh sharma&quot; &lt; <a href=3D"mailto:pushpes=
h.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderumier=
@odiso.com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt; Cc: &quot;Somnath Roy&quot; &lt; <a href=3D"mailto:Somnath.Roy=
@sandisk.com">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt;, &quot;Irek Fasikhov&quot; &=
lt; <a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;=
ceph-devel&quot; &lt; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-de=
vel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, &quot;ceph-users&quot; &lt; <a href=3D"mailto=
:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt; Envoy=C3=A9: Vendredi 12 Juin 2015 07:52:41<br>
&gt;&gt;&gt; Objet: Re: rbd_cache, limiting read on high iops around 40k<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Alexandre,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I agree with your rational, of one iothread per disk. CPU cons=
umed in<br>
&gt;&gt;&gt; IOwait is pretty high in each VM. But I am not finding a way t=
o set<br>
&gt;&gt;&gt; the same on a nova instance. I am using openstack Juno with QE=
MU+KVM.<br>
&gt;&gt;&gt; As per libvirt documentation for setting iothreads, I can edit=
<br>
&gt;&gt;&gt; domain.xml directly and achieve the same effect. However in as=
 in<br>
&gt;&gt;&gt; openstack env domain xml is created by nova with some addition=
al<br>
&gt;&gt;&gt; metadata, so editing the domain xml using &#39;virsh edit&#39;=
 does not seems<br>
&gt;&gt;&gt; to work(I agree, it is not a very cloud way of doing things, b=
ut a<br>
&gt;&gt;&gt; hack). Changes made there vanish after saving them, due to rea=
son<br>
&gt;&gt;&gt; libvirt validation fails on the same.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; #virsh dumpxml instance-000000c5 &gt; vm.xml<br>
&gt;&gt;&gt; #virt-xml-validate vm.xml<br>
&gt;&gt;&gt; Relax-NG validity error : Extra element cpu in interleave<br>
&gt;&gt;&gt; vm.xml:1: element domain: Relax-NG validity error : Element do=
main<br>
&gt;&gt;&gt; failed to validate content<br>
&gt;&gt;&gt; vm.xml fails to validate<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Second approach I took was to setting QoS in volumes types. Bu=
t there<br>
&gt;&gt;&gt; is no option to set iothreads per volume, there are parameter =
realted<br>
&gt;&gt;&gt; to max_read/wrirte ops/bytes.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thirdly, editing Nova flavor and proving extra specs like<br>
&gt;&gt;&gt; hw:cpu_socket/thread/core, can change guest CPU topology howev=
er again<br>
&gt;&gt;&gt; no way to set iothread. It does accept hw_disk_iothreads(no ty=
pe check<br>
&gt;&gt;&gt; in place, i believe ), but can not pass the same in domain.xml=
.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Could you suggest me a way to set the same.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -Pushpesh<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Wed, Jun 10, 2015 at 12:59 PM, Alexandre DERUMIER<br>
&gt;&gt;&gt; &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10@public.gmane.org=
m</a> &gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; I need to try out the performance on qemu soon and=
 may come back to you if I need some qemu setting trick :-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Sure no problem.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; (BTW, I can reach around 200k iops in 1 qemu vm with 5 vir=
tio disks with 1 iothread by disk)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt;&gt; De: &quot;Somnath Roy&quot; &lt; <a href=3D"mailto:Somnath=
.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderu=
mier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;Irek Fasikhov&quot; &lt=
; <a href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; Cc: &quot;ceph-devel&quot; &lt; <a href=3D"mailto:ceph-dev=
el-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, &quot;pushpesh sha=
rma&quot; &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck@gmail=
.com</a> &gt;, &quot;ceph-users&quot; &lt; <a href=3D"mailto:ceph-users@lis=
ts.ceph.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; Envoy=C3=A9: Mercredi 10 Juin 2015 09:06:32<br>
&gt;&gt;&gt;&gt; Objet: RE: rbd_cache, limiting read on high iops around 40=
k<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Alexandre,<br>
&gt;&gt;&gt;&gt; Thanks for sharing the data.<br>
&gt;&gt;&gt;&gt; I need to try out the performance on qemu soon and may com=
e back to you if I need some qemu setting trick :-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; Somnath<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt; From: ceph-users [mailto: <a href=3D"mailto:ceph-users-bou=
nces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> ] On Behalf Of A=
lexandre DERUMIER<br>
&gt;&gt;&gt;&gt; Sent: Tuesday, June 09, 2015 10:42 PM<br>
&gt;&gt;&gt;&gt; To: Irek Fasikhov<br>
&gt;&gt;&gt;&gt; Cc: ceph-devel; pushpesh sharma; ceph-users<br>
&gt;&gt;&gt;&gt; Subject: Re: [ceph-users] rbd_cache, limiting read on high=
 iops around 40k<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Very good work!<br>
&gt;&gt;&gt;&gt;&gt;&gt; Do you have a rpm-file?<br>
&gt;&gt;&gt;&gt;&gt;&gt; Thanks.<br>
&gt;&gt;&gt;&gt; no sorry, I&#39;m have compiled it manually (and I&#39;m u=
sing debian jessie as client)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt;&gt; De: &quot;Irek Fasikhov&quot; &lt; <a href=3D"mailto:malmy=
zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderu=
mier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; Cc: &quot;Robert LeBlanc&quot; &lt; <a href=3D"mailto:robe=
rt-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a> &gt;, &quot;ceph-devel&quot; &lt=
; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<=
/a> &gt;, &quot;pushpesh sharma&quot; &lt; <a href=3D"mailto:pushpesh.eck@g=
mail.com">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;ceph-users&quot; &lt; <a h=
ref=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;=
<br>
&gt;&gt;&gt;&gt; Envoy=C3=A9: Mercredi 10 Juin 2015 07:21:42<br>
&gt;&gt;&gt;&gt; Objet: Re: [ceph-users] rbd_cache, limiting read on high i=
ops around 40k<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi, Alexandre.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Very good work!<br>
&gt;&gt;&gt;&gt; Do you have a rpm-file?<br>
&gt;&gt;&gt;&gt; Thanks.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 2015-06-10 7:10 GMT+03:00 Alexandre DERUMIER &lt; <a href=
=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; :<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I have tested qemu with last tcmalloc 2.4, and the improve=
ment is huge with iothread: 50k iops (+45%) !<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : no iothread : glibc : iops=3D33395 qemu : no-iothre=
ad : tcmalloc (2.2.1) : iops=3D34516 (+3%) qemu : no-iothread : jemmaloc : =
iops=3D42226 (+26%) qemu : no-iothread : tcmalloc (2.4) : iops=3D35974 (+7%=
)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : iothread : glibc : iops=3D34516<br>
&gt;&gt;&gt;&gt; qemu : iothread : tcmalloc : iops=3D38676 (+12%) qemu : io=
thread : jemmaloc : iops=3D28023 (-19%) qemu : iothread : tcmalloc (2.4) : =
iops=3D50276 (+45%)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)<br>
&gt;&gt;&gt;&gt; ------------------------------------------------------<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [214.7MB/0KB/0KB /s]=
 [54.1K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D894: Wed Jun 10 05:54:24 2015 read : io=3D5120.0MB, bw=3D201108KB/s, iop=
s=3D50276, runt=3D 26070msec slat (usec): min=3D1, max=3D1136, avg=3D 3.54,=
 stdev=3D 3.58 clat (usec): min=3D128, max=3D6262, avg=3D631.41, stdev=3D19=
7.71 lat (usec): min=3D149, max=3D6265, avg=3D635.27, stdev=3D197.40 clat p=
ercentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 318], 5.00th=3D[ 378], 10.00th=3D[ 418], 20.0=
0th=3D[ 474],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 516], 40.00th=3D[ 564], 50.00th=3D[ 612], 60=
.00th=3D[ 652],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 700], 80.00th=3D[ 756], 90.00th=3D[ 860], 95=
.00th=3D[ 980],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 1272], 99.50th=3D[ 1384], 99.90th=3D[ 1688],=
 99.95th=3D[ 1896],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 3760]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D145608, max=3D249688, per=3D100.00%, avg=
=3D201108.00, stdev=3D21718.87 lat (usec) : 250=3D0.04%, 500=3D25.84%, 750=
=3D53.00%, 1000=3D16.63% lat (msec) : 2=3D4.46%, 4=3D0.03%, 10=3D0.01% cpu =
: usr=3D9.73%, sys=3D24.93%, ctx=3D66417, majf=3D0, minf=3D38 IO depths : 1=
=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, &gt;=3D64=3D=
0.0% submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, &gt;=3D64=3D0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, =
32=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% issued : total=3Dr=3D1310720/w=3D0/d=
=3D0, short=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentil=
e=3D100.00%, depth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D201107KB/s, minb=3D201107KB/s=
, maxb=3D201107KB/s, mint=3D26070msec, maxt=3D26070msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1302555/0, merge=3D0/0, ticks=3D715176/0, in_qu=
eue=3D714840, util=3D99.73%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [158.7MB/0KB/0KB /s]=
 [40.6K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D889: Wed Jun 10 06:05:06 2015 read : io=3D5120.0MB, bw=3D143897KB/s, iop=
s=3D35974, runt=3D 36435msec slat (usec): min=3D1, max=3D710, avg=3D 3.31, =
stdev=3D 3.35 clat (usec): min=3D191, max=3D4740, avg=3D884.66, stdev=3D315=
.65 lat (usec): min=3D289, max=3D4743, avg=3D888.31, stdev=3D315.51 clat pe=
rcentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 462], 5.00th=3D[ 516], 10.00th=3D[ 548], 20.0=
0th=3D[ 596],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 652], 40.00th=3D[ 764], 50.00th=3D[ 868], 60=
.00th=3D[ 940],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 1004], 80.00th=3D[ 1096], 90.00th=3D[ 1256],=
 95.00th=3D[ 1416],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 2024], 99.50th=3D[ 2224], 99.90th=3D[ 2544],=
 99.95th=3D[ 2640],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 3632]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D98352, max=3D177328, per=3D99.91%, avg=
=3D143772.11, stdev=3D21782.39 lat (usec) : 250=3D0.01%, 500=3D3.48%, 750=
=3D35.69%, 1000=3D30.01% lat (msec) : 2=3D29.74%, 4=3D1.07%, 10=3D0.01% cpu=
 : usr=3D7.10%, sys=3D16.90%, ctx=3D54855, majf=3D0, minf=3D38 IO depths : =
1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, &gt;=3D64=
=3D0.0% submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, &gt;=3D64=3D0.0% complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0=
.0%, 32=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0% issued : total=3Dr=3D1310720/w=
=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, per=
centile=3D100.00%, depth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D143896KB/s, minb=3D143896KB/s=
, maxb=3D143896KB/s, mint=3D36435msec, maxt=3D36435msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1301357/0, merge=3D0/0, ticks=3D1033036/0, in_q=
ueue=3D1032716, util=3D99.85%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt;&gt; De: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderumier=
@odiso.com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; =C3=80: &quot;Robert LeBlanc&quot; &lt; <a href=3D"mailto:=
robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; Cc: &quot;Mark Nelson&quot; &lt; <a href=3D"mailto:mnelson=
@redhat.com">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> &gt;, &quot;ceph-devel&quot; &lt; <a hr=
ef=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt=
;, &quot;pushpesh sharma&quot; &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8@public.gmane.org=
m">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;ceph-users&quot; &lt; <a href=3D"=
mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; Envoy=C3=A9: Mardi 9 Juin 2015 18:47:27<br>
&gt;&gt;&gt;&gt; Objet: Re: [ceph-users] rbd_cache, limiting read on high i=
ops around 40k<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Robert,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; What I found was that Ceph OSDs performed well wit=
h either tcmalloc or<br>
&gt;&gt;&gt;&gt;&gt;&gt; jemalloc (except when RocksDB was built with jemal=
loc instead of<br>
&gt;&gt;&gt;&gt;&gt;&gt; tcmalloc, I&#39;m still working to dig into why th=
at might be the case).<br>
&gt;&gt;&gt;&gt; yes,from my test, for osd tcmalloc is a little faster (but=
 very little) than jemalloc.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; However, I found that tcmalloc with QEMU/KVM was v=
ery detrimental to<br>
&gt;&gt;&gt;&gt;&gt;&gt; small I/O, but provided huge gains in I/O &gt;=3D1=
MB. Jemalloc was much<br>
&gt;&gt;&gt;&gt;&gt;&gt; better for QEMU/KVM in the tests that we ran. [1]<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Just have done qemu test (4k randread - rbd_cache=3Doff), =
I don&#39;t see speed regression with tcmalloc.<br>
&gt;&gt;&gt;&gt; with qemu iothread, tcmalloc have a speed increase over gl=
ib<br>
&gt;&gt;&gt;&gt; with qemu iothread, jemalloc have a speed decrease<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; without iothread, jemalloc have a big speed increase<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; this is with<br>
&gt;&gt;&gt;&gt; -qemu 2.3<br>
&gt;&gt;&gt;&gt; -tcmalloc 2.2.1<br>
&gt;&gt;&gt;&gt; -jemmaloc 3.6<br>
&gt;&gt;&gt;&gt; -libc6 2.19<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : no iothread : glibc : iops=3D33395<br>
&gt;&gt;&gt;&gt; qemu : no-iothread : tcmalloc : iops=3D34516 (+3%)<br>
&gt;&gt;&gt;&gt; qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : iothread : glibc : iops=3D34516<br>
&gt;&gt;&gt;&gt; qemu : iothread : tcmalloc : iops=3D38676 (+12%)<br>
&gt;&gt;&gt;&gt; qemu : iothread : jemmaloc : iops=3D28023 (-19%)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; (The benefit of iothreads is that we can scale with more d=
isks in 1vm)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; fio results:<br>
&gt;&gt;&gt;&gt; ------------<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : iothread : tcmalloc : iops=3D38676<br>
&gt;&gt;&gt;&gt; -----------------------------------------<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D0): [r(1)] [100.0% done] [123.5MB/0KB/0KB /s]=
 [31.6K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D1265: Tue Jun 9 18:16:53 2015<br>
&gt;&gt;&gt;&gt; read : io=3D5120.0MB, bw=3D154707KB/s, iops=3D38676, runt=
=3D 33889msec<br>
&gt;&gt;&gt;&gt; slat (usec): min=3D1, max=3D715, avg=3D 3.63, stdev=3D 3.4=
2<br>
&gt;&gt;&gt;&gt; clat (usec): min=3D152, max=3D5736, avg=3D822.12, stdev=3D=
289.34<br>
&gt;&gt;&gt;&gt; lat (usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D2=
89.08<br>
&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 402], 5.00th=3D[ 466], 10.00th=3D[ 510], 20.0=
0th=3D[ 572],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 636], 40.00th=3D[ 716], 50.00th=3D[ 780], 60=
.00th=3D[ 852],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], =
95.00th=3D[ 1352],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=3D[ 2256],=
 99.95th=3D[ 2448],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 3888]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D123888, max=3D198584, per=3D100.00%, avg=
=3D154824.40, stdev=3D16978.03<br>
&gt;&gt;&gt;&gt; lat (usec) : 250=3D0.01%, 500=3D8.91%, 750=3D36.44%, 1000=
=3D32.63%<br>
&gt;&gt;&gt;&gt; lat (msec) : 2=3D21.65%, 4=3D0.37%, 10=3D0.01%<br>
&gt;&gt;&gt;&gt; cpu : usr=3D8.29%, sys=3D19.76%, ctx=3D55882, majf=3D0, mi=
nf=3D39<br>
&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0=
.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=
=3D0/d=3D0<br>
&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, de=
pth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D154707KB/s, minb=3D154707KB/s=
, maxb=3D154707KB/s, mint=3D33889msec, maxt=3D33889msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_qu=
eue=3D934096, util=3D99.77%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : no-iothread : tcmalloc : iops=3D34516<br>
&gt;&gt;&gt;&gt; ---------------------------------------------<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s]=
 [41.8K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D896: Tue Jun 9 18:19:08 2015<br>
&gt;&gt;&gt;&gt; read : io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=
=3D 37974msec<br>
&gt;&gt;&gt;&gt; slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.5=
7<br>
&gt;&gt;&gt;&gt; clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=
=3D333.61<br>
&gt;&gt;&gt;&gt; lat (usec): min=3D266, max=3D11862, avg=3D925.77, stdev=3D=
333.40<br>
&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 434], 5.00th=3D[ 510], 10.00th=3D[ 564], 20.0=
0th=3D[ 652],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 732], 40.00th=3D[ 812], 50.00th=3D[ 876], 60=
.00th=3D[ 940],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 1020], 80.00th=3D[ 1112], 90.00th=3D[ 1320],=
 95.00th=3D[ 1576],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 1992], 99.50th=3D[ 2128], 99.90th=3D[ 2736],=
 99.95th=3D[ 3248],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 4320]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D77312, max=3D185576, per=3D99.74%, avg=
=3D137709.88, stdev=3D16883.77<br>
&gt;&gt;&gt;&gt; lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=
=3D35.60%<br>
&gt;&gt;&gt;&gt; lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01%=
<br>
&gt;&gt;&gt;&gt; cpu : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, mi=
nf=3D38<br>
&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0=
.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=
=3D0/d=3D0<br>
&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, de=
pth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s=
, maxb=3D138064KB/s, mint=3D37974msec, maxt=3D37974msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1309902/0, merge=3D0/0, ticks=3D1068768/0, in_q=
ueue=3D1068396, util=3D99.86%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : iothread : glibc : iops=3D34516<br>
&gt;&gt;&gt;&gt; -------------------------------------<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0KB /s]=
 [34.2K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D876: Tue Jun 9 18:24:01 2015<br>
&gt;&gt;&gt;&gt; read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=
=3D 38051msec<br>
&gt;&gt;&gt;&gt; slat (usec): min=3D1, max=3D496, avg=3D 3.88, stdev=3D 3.6=
6<br>
&gt;&gt;&gt;&gt; clat (usec): min=3D283, max=3D7515, avg=3D923.34, stdev=3D=
300.28<br>
&gt;&gt;&gt;&gt; lat (usec): min=3D286, max=3D7519, avg=3D927.58, stdev=3D3=
00.02<br>
&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 506], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.0=
0th=3D[ 652],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 724], 40.00th=3D[ 804], 50.00th=3D[ 884], 60=
.00th=3D[ 964],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 1048], 80.00th=3D[ 1144], 90.00th=3D[ 1304],=
 95.00th=3D[ 1448],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480],=
 99.95th=3D[ 2640],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 3984]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D102680, max=3D171112, per=3D100.00%, avg=
=3D137877.78, stdev=3D15521.30<br>
&gt;&gt;&gt;&gt; lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.82%<br>
&gt;&gt;&gt;&gt; lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01%<br>
&gt;&gt;&gt;&gt; cpu : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, mi=
nf=3D38<br>
&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0=
.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=
=3D0/d=3D0<br>
&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, de=
pth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s=
, maxb=3D137785KB/s, mint=3D38051msec, maxt=3D38051msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1307426/0, merge=3D0/0, ticks=3D1051416/0, in_q=
ueue=3D1050972, util=3D99.85%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : no iothread : glibc : iops=3D33395<br>
&gt;&gt;&gt;&gt; -----------------------------------------<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s]=
 [32.9K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D886: Tue Jun 9 18:27:18 2015<br>
&gt;&gt;&gt;&gt; read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=
=3D 39248msec<br>
&gt;&gt;&gt;&gt; slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.=
29<br>
&gt;&gt;&gt;&gt; clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=
=3D335.51<br>
&gt;&gt;&gt;&gt; lat (usec): min=3D303, max=3D12638, avg=3D957.01, stdev=3D=
335.29<br>
&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 516], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.0=
0th=3D[ 652],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 724], 40.00th=3D[ 820], 50.00th=3D[ 924], 60=
.00th=3D[ 996],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 1080], 80.00th=3D[ 1176], 90.00th=3D[ 1336],=
 95.00th=3D[ 1528],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672],=
 99.95th=3D[ 2928],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 4832]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D98136, max=3D171624, per=3D100.00%, avg=
=3D133682.64, stdev=3D19121.91<br>
&gt;&gt;&gt;&gt; lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=
=3D26.98%<br>
&gt;&gt;&gt;&gt; lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01%=
<br>
&gt;&gt;&gt;&gt; cpu : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D0, mi=
nf=3D38<br>
&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0=
.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=
=3D0/d=3D0<br>
&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, de=
pth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s=
, maxb=3D133583KB/s, mint=3D39248msec, maxt=3D39248msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1304526/0, merge=3D0/0, ticks=3D1075020/0, in_q=
ueue=3D1074536, util=3D99.84%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : iothread : jemmaloc : iops=3D28023<br>
&gt;&gt;&gt;&gt; ----------------------------------------<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] =
[39.1K/0/0 iops] [eta 00m:01s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D899: Tue Jun 9 18:30:26 2015<br>
&gt;&gt;&gt;&gt; read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=
=3D 46772msec<br>
&gt;&gt;&gt;&gt; slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.7=
7<br>
&gt;&gt;&gt;&gt; clat (usec): min=3D253, max=3D11307, avg=3D1135.63, stdev=
=3D346.55<br>
&gt;&gt;&gt;&gt; lat (usec): min=3D256, max=3D11309, avg=3D1140.39, stdev=
=3D346.22<br>
&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 510], 5.00th=3D[ 628], 10.00th=3D[ 700], 20.0=
0th=3D[ 820],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 924], 40.00th=3D[ 1032], 50.00th=3D[ 1128], =
60.00th=3D[ 1224],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 1320], 80.00th=3D[ 1416], 90.00th=3D[ 1560],=
 95.00th=3D[ 1688],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544],=
 99.95th=3D[ 2832],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 3760]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D91792, max=3D174416, per=3D99.90%, avg=
=3D111985.27, stdev=3D17381.70<br>
&gt;&gt;&gt;&gt; lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33%<br>
&gt;&gt;&gt;&gt; lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01%=
<br>
&gt;&gt;&gt;&gt; cpu : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, mi=
nf=3D38<br>
&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0=
.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=
=3D0/d=3D0<br>
&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, de=
pth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s=
, maxb=3D112094KB/s, mint=3D46772msec, maxt=3D46772msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1309169/0, merge=3D0/0, ticks=3D1305796/0, in_q=
ueue=3D1305376, util=3D98.68%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; qemu : non-iothread : jemmaloc : iops=3D42226<br>
&gt;&gt;&gt;&gt; --------------------------------------------<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s]=
 [43.9K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=
=3D892: Tue Jun 9 18:34:11 2015<br>
&gt;&gt;&gt;&gt; read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=
=3D 29599msec<br>
&gt;&gt;&gt;&gt; slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D 3.7=
4<br>
&gt;&gt;&gt;&gt; clat (usec): min=3D174, max=3D3841, avg=3D717.08, stdev=3D=
237.53<br>
&gt;&gt;&gt;&gt; lat (usec): min=3D210, max=3D3844, avg=3D721.23, stdev=3D2=
37.22<br>
&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt; | 1.00th=3D[ 354], 5.00th=3D[ 422], 10.00th=3D[ 462], 20.0=
0th=3D[ 516],<br>
&gt;&gt;&gt;&gt; | 30.00th=3D[ 572], 40.00th=3D[ 628], 50.00th=3D[ 684], 60=
.00th=3D[ 740],<br>
&gt;&gt;&gt;&gt; | 70.00th=3D[ 804], 80.00th=3D[ 884], 90.00th=3D[ 1004], 9=
5.00th=3D[ 1128],<br>
&gt;&gt;&gt;&gt; | 99.00th=3D[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928],=
 99.95th=3D[ 2064],<br>
&gt;&gt;&gt;&gt; | 99.99th=3D[ 2608]<br>
&gt;&gt;&gt;&gt; bw (KB /s): min=3D138120, max=3D230816, per=3D100.00%, avg=
=3D177192.14, stdev=3D23440.79<br>
&gt;&gt;&gt;&gt; lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=
=3D27.46%<br>
&gt;&gt;&gt;&gt; lat (msec) : 2=3D10.30%, 4=3D0.07%<br>
&gt;&gt;&gt;&gt; cpu : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, m=
inf=3D39<br>
&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0=
.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt; issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=
=3D0/d=3D0<br>
&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, de=
pth=3D32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt; READ: io=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s=
, maxb=3D177130KB/s, mint=3D29599msec, maxt=3D29599msec<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt; vdb: ios=3D1303992/0, merge=3D0/0, ticks=3D798008/0, in_qu=
eue=3D797636, util=3D99.80%<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt;&gt; De: &quot;Robert LeBlanc&quot; &lt; <a href=3D"mailto:robe=
rt-4JaGZRWAfWbajFs6igw21g@public.gmane.org">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderu=
mier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; Cc: &quot;Mark Nelson&quot; &lt; <a href=3D"mailto:mnelson=
@redhat.com">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> &gt;, &quot;ceph-devel&quot; &lt; <a hr=
ef=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt=
;, &quot;pushpesh sharma&quot; &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8@public.gmane.org=
m">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;ceph-users&quot; &lt; <a href=3D"=
mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt; Envoy=C3=A9: Mardi 9 Juin 2015 18:00:29<br>
&gt;&gt;&gt;&gt; Objet: Re: [ceph-users] rbd_cache, limiting read on high i=
ops around 40k<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt;&gt;&gt;&gt; Hash: SHA256<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I also saw a similar performance increase by using alterna=
tive memory<br>
&gt;&gt;&gt;&gt; allocators. What I found was that Ceph OSDs performed well=
 with either<br>
&gt;&gt;&gt;&gt; tcmalloc or jemalloc (except when RocksDB was built with j=
emalloc<br>
&gt;&gt;&gt;&gt; instead of tcmalloc, I&#39;m still working to dig into why=
 that might be<br>
&gt;&gt;&gt;&gt; the case).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; However, I found that tcmalloc with QEMU/KVM was very detr=
imental to<br>
&gt;&gt;&gt;&gt; small I/O, but provided huge gains in I/O &gt;=3D1MB. Jema=
lloc was much<br>
&gt;&gt;&gt;&gt; better for QEMU/KVM in the tests that we ran. [1]<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I&#39;m currently looking into I/O bottlenecks around the =
16KB range and<br>
&gt;&gt;&gt;&gt; I&#39;m seeing a lot of time in thread creation and destru=
ction, the<br>
&gt;&gt;&gt;&gt; memory allocators are quite a bit down the list (both fio =
with<br>
&gt;&gt;&gt;&gt; ioengine rbd and on the OSDs). I wonder what the differenc=
e can be.<br>
&gt;&gt;&gt;&gt; I&#39;ve tried using the async messenger but there wasn&#3=
9;t a huge<br>
&gt;&gt;&gt;&gt; difference. [2]<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Further down the rabbit hole....<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [1] <a href=3D"https://www.mail-archive.com/ceph-users@lis=
ts.ceph.com/msg20197.html" rel=3D"noreferrer" target=3D"_blank">https://www=
.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg20197.html</a><br>
&gt;&gt;&gt;&gt; [2] <a href=3D"https://www.mail-archive.com/ceph-devel@vge=
r.kernel.org/msg23982.html" rel=3D"noreferrer" target=3D"_blank">https://ww=
w.mail-archive.com/ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg23982.html</a><br>
&gt;&gt;&gt;&gt; -----BEGIN PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt; Version: Mailvelope v0.13.1<br>
&gt;&gt;&gt;&gt; Comment: <a href=3D"https://www.mailvelope.com" rel=3D"nor=
eferrer" target=3D"_blank">https://www.mailvelope.com</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4MwP/1vt65cvTyyVGGSGRr=
E8<br>
&gt;&gt;&gt;&gt; unuWjafMHzl486XH+EaVrDVTXFVFOoncJ6kugSpD7yavtCpZNdhsIaTRZg=
uU<br>
&gt;&gt;&gt;&gt; YpfAppNAJU5biSwNv9QPI7kPP2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw=
87<br>
&gt;&gt;&gt;&gt; afq46GhPHqEXdjp3rOB4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnC=
Y2<br>
&gt;&gt;&gt;&gt; S695Dt1gzt0ERUOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivV=
l3<br>
&gt;&gt;&gt;&gt; vDYWxQHPK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+=
51<br>
&gt;&gt;&gt;&gt; 9ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPG=
OO<br>
&gt;&gt;&gt;&gt; qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHh=
u3<br>
&gt;&gt;&gt;&gt; Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c=
7b<br>
&gt;&gt;&gt;&gt; 6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV=
13<br>
&gt;&gt;&gt;&gt; R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTKV=
zQ<br>
&gt;&gt;&gt;&gt; 1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfbuEHalVj=
z4<br>
&gt;&gt;&gt;&gt; oSJX<br>
&gt;&gt;&gt;&gt; =3Dk281<br>
&gt;&gt;&gt;&gt; -----END PGP SIGNATURE-----<br>
&gt;&gt;&gt;&gt; ----------------<br>
&gt;&gt;&gt;&gt; Robert LeBlanc<br>
&gt;&gt;&gt;&gt; GPG Fingerprint 79A2 9CA4 6CC4 45DD A904 C70E E654 3BB2 FA=
62 B9F1<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DERUMIER &lt; <a=
 href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; wrote:<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Frankly, I&#39;m a little impressed that witho=
ut RBD cache we can hit 80K<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; IOPS from 1 VM!<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Note that theses result are not in a vm (fio-rbd on ho=
st), so in a vm we&#39;ll have overhead.<br>
&gt;&gt;&gt;&gt;&gt; (I&#39;m planning to send results in qemu soon)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; How fast are the SSDs in those 3 OSDs?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Theses results are with datas in buffer memory of osd =
nodes.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; When reading fulling on ssd (intel s3500),<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; For 1 client,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I&#39;m around 33k iops without cache and 32k iops wit=
h cache, with 1 osd.<br>
&gt;&gt;&gt;&gt;&gt; I&#39;m around 55k iops without cache and 38k iops wit=
h cache, with 3 osd.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; with multiple clients jobs, I can reach around 70kiops=
 by osd , and 250k iops by osd when datas are in buffer.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; (cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)<=
br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; small tip :<br>
&gt;&gt;&gt;&gt;&gt; I&#39;m using tcmalloc for fio-rbd or rados bench to i=
mprove latencies by around 20%<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...=
<br>
&gt;&gt;&gt;&gt;&gt; LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados b=
ench ...<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; as a lot of time is spent in malloc/free<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; (qemu support also tcmalloc since some months , I&#39;=
ll bench it too<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-dev=
el/2015-03/msg05372.html" rel=3D"noreferrer" target=3D"_blank">https://list=
s.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html</a> )<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I&#39;ll try to send full bench results soon, from 1 t=
o 18 ssd osd.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt;&gt;&gt; De: &quot;Mark Nelson&quot; &lt; <a href=3D"mailto:mne=
lson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mailto:a=
derumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;, &quot;pushpesh sharma&quo=
t; &lt; <a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a=
> &gt;<br>
&gt;&gt;&gt;&gt;&gt; Cc: &quot;ceph-devel&quot; &lt; <a href=3D"mailto:ceph=
-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, &quot;ceph-use=
rs&quot; &lt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists=
.ceph.com</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt; Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31<br>
&gt;&gt;&gt;&gt;&gt; Objet: Re: [ceph-users] rbd_cache, limiting read on hi=
gh iops around 40k<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Hi All,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; In the past we&#39;ve hit some performance issues with=
 RBD cache that we&#39;ve<br>
&gt;&gt;&gt;&gt;&gt; fixed, but we&#39;ve never really tried pushing a sing=
le VM beyond 40+K read<br>
&gt;&gt;&gt;&gt;&gt; IOPS in testing (or at least I never have). I suspect =
there&#39;s a couple<br>
&gt;&gt;&gt;&gt;&gt; of possibilities as to why it might be slower, but per=
haps joshd can<br>
&gt;&gt;&gt;&gt;&gt; chime in as he&#39;s more familiar with what that code=
 looks like.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Frankly, I&#39;m a little impressed that without RBD c=
ache we can hit 80K<br>
&gt;&gt;&gt;&gt;&gt; IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?=
<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Mark<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; It&#39;s seem that the limit is mainly going in hi=
gh queue depth (+- &gt; 16)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Here the result in iops with 1client- 4krandread- =
3osd - with differents queue depth size.<br>
&gt;&gt;&gt;&gt;&gt;&gt; rbd_cache is almost the same than without cache wi=
th queue depth &lt;16<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; cache<br>
&gt;&gt;&gt;&gt;&gt;&gt; -----<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd1: 1651<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd2: 3482<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd4: 7958<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd8: 17912<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd16: 36020<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd32: 42765<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd64: 46169<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; no cache<br>
&gt;&gt;&gt;&gt;&gt;&gt; --------<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd1: 1748<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd2: 3570<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd4: 8356<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd8: 17732<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd16: 41396<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd32: 78633<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd64: 79063<br>
&gt;&gt;&gt;&gt;&gt;&gt; qd128: 79550<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt;&gt;&gt;&gt; De: &quot;aderumier&quot; &lt; <a href=3D"mailto:a=
derumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C3=80: &quot;pushpesh sharma&quot; &lt; <a href=
=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: &quot;ceph-devel&quot; &lt; <a href=3D"mailto:=
ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, &quot;ceph=
-users&quot; &lt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@l=
ists.ceph.com</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21<br>
&gt;&gt;&gt;&gt;&gt;&gt; Objet: Re: [ceph-users] rbd_cache, limiting read o=
n high iops around 40k<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; We tried adding more RBDs to single VM, bu=
t no luck.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; If you want to scale with more disks in a single q=
emu vm, you need to use iothread feature from qemu and assign 1 iothread by=
 disk (works with virtio-blk).<br>
&gt;&gt;&gt;&gt;&gt;&gt; It&#39;s working for me, I can scale with adding m=
ore disks.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; My bench here are done with fio-rbd on host.<br>
&gt;&gt;&gt;&gt;&gt;&gt; I can scale up to 400k iops with 10clients-rbd_cac=
he=3Doff on a single host and around 250kiops 10clients-rbdcache=3Don.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I just wonder why I don&#39;t have performance dec=
rease around 30k iops with 1osd.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m going to see if this tracker<br>
&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://tracker.ceph.com/issues/11056" r=
el=3D"noreferrer" target=3D"_blank">http://tracker.ceph.com/issues/11056</a=
><br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; could be the cause.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; (My master build was done some week ago)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ----- Mail original -----<br>
&gt;&gt;&gt;&gt;&gt;&gt; De: &quot;pushpesh sharma&quot; &lt; <a href=3D"ma=
ilto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; =C3=80: &quot;aderumier&quot; &lt; <a href=3D"mail=
to:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: &quot;ceph-devel&quot; &lt; <a href=3D"mailto:=
ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, &quot;ceph=
-users&quot; &lt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@l=
ists.ceph.com</a> &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04<br>
&gt;&gt;&gt;&gt;&gt;&gt; Objet: Re: rbd_cache, limiting read on high iops a=
round 40k<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi Alexandre,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; We have also seen something very similar on Hammer=
(0.94-1). We were doing some benchmarking for VMs hosted on hypervisor (QEM=
U-KVM, openstack-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as=
 additional storage. For some strange reason it was not able to scale 4K- R=
R iops on each VM beyond 35-40k. We tried adding more RBDs to single VM, bu=
t no luck. However increasing number of VMs to 4 on a single hypervisor did=
 scale to some extent. After this there was no much benefit we got from add=
ing more VMs.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Here is the trend we have seen, x-axis is number o=
f hypervisor, each hypervisor has 4 VM, each VM has 1 RBD:-<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; VDbench is used as benchmarking tool. We were not =
saturating network and CPUs at OSD nodes. We were not able to saturate CPUs=
 at hypervisors, and that is where we were suspecting of some throttling ef=
fect. However we haven&#39;t setted any such limits from nova or kvm end. W=
e tried some CPU pinning and other KVM related tuning as well, but no luck.=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; We tried the same experiment on a bare metal. It w=
as 4K RR IOPs were scaling from 40K(1 RBD) to 180K(4 RBDs). But after that =
rather than scaling beyond that point the numbers were actually degrading. =
(Single pipe more congestion effect)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; We never suspected that rbd cache enable could be =
detrimental to performance. It would nice to route cause the problem if tha=
t is the case.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIE=
R &lt; <a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; =
wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m doing benchmark (ceph master branch), with=
 randread 4k qdepth=3D32,<br>
&gt;&gt;&gt;&gt;&gt;&gt; and rbd_cache=3Dtrue seem to limit the iops around=
 40k<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; no cache<br>
&gt;&gt;&gt;&gt;&gt;&gt; --------<br>
&gt;&gt;&gt;&gt;&gt;&gt; 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; cache<br>
&gt;&gt;&gt;&gt;&gt;&gt; -----<br>
&gt;&gt;&gt;&gt;&gt;&gt; 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Is it expected ?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; fio result rbd_cache=3Dfalse 3 osd<br>
&gt;&gt;&gt;&gt;&gt;&gt; --------------------------------<br>
&gt;&gt;&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4=
K-4K/4K-4K/4K-4K, ioengine=3Drbd, iodepth=3D32<br>
&gt;&gt;&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt;&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt;&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB=
/0KB /s] [78.8K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=
=3D 0: pid=3D113548: Tue Jun 9 07:48:42 2015<br>
&gt;&gt;&gt;&gt;&gt;&gt; read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292=
, runt=3D 32698msec<br>
&gt;&gt;&gt;&gt;&gt;&gt; slat (usec): min=3D5, max=3D530, avg=3D11.77, stde=
v=3D 6.77<br>
&gt;&gt;&gt;&gt;&gt;&gt; clat (usec): min=3D70, max=3D2240, avg=3D336.08, s=
tdev=3D94.82<br>
&gt;&gt;&gt;&gt;&gt;&gt; lat (usec): min=3D101, max=3D2247, avg=3D347.84, s=
tdev=3D95.49<br>
&gt;&gt;&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 23=
1], 20.00th=3D[ 262],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ =
322], 60.00th=3D[ 346],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ =
454], 95.00th=3D[ 506],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ =
860], 99.95th=3D[ 948],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 99.99th=3D[ 1176]<br>
&gt;&gt;&gt;&gt;&gt;&gt; bw (KB /s): min=3D238856, max=3D360448, per=3D100.=
00%, avg=3D313402.34, stdev=3D25196.21<br>
&gt;&gt;&gt;&gt;&gt;&gt; lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.6=
0%, 750=3D5.19%, 1000=3D0.23%<br>
&gt;&gt;&gt;&gt;&gt;&gt; lat (msec) : 2=3D0.03%, 4=3D0.01%<br>
&gt;&gt;&gt;&gt;&gt;&gt; cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, ma=
jf=3D0, minf=3D12452<br>
&gt;&gt;&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%=
, 16=3D87.0%, 32=3D12.1%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%=
, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5=
%, 32=3D0.4%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt;&gt;&gt; issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3D=
r=3D0/w=3D0/d=3D0<br>
&gt;&gt;&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100=
.00%, depth=3D32<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt;&gt;&gt; READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313=
169KB/s, maxb=3D313169KB/s, mint=3D32698msec, maxt=3D32698msec<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt;&gt;&gt; dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_que=
ue=3D0, util=3D0.00%, aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, ag=
grin_queue=3D0, aggrutil=3D0.00%<br>
&gt;&gt;&gt;&gt;&gt;&gt; sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_que=
ue=3D0, util=3D0.00%<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; fio result rbd_cache=3Dtrue 3osd<br>
&gt;&gt;&gt;&gt;&gt;&gt; ------------------------------<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4=
K-4K/4K-4K/4K-4K, ioengine=3Drbd, iodepth=3D32<br>
&gt;&gt;&gt;&gt;&gt;&gt; fio-2.1.11<br>
&gt;&gt;&gt;&gt;&gt;&gt; Starting 1 process<br>
&gt;&gt;&gt;&gt;&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt;&gt;&gt;&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB=
/0KB /s] [43.1K/0/0 iops] [eta 00m:00s]<br>
&gt;&gt;&gt;&gt;&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=
=3D 0: pid=3D113389: Tue Jun 9 07:47:30 2015<br>
&gt;&gt;&gt;&gt;&gt;&gt; read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823=
, runt=3D 55866msec<br>
&gt;&gt;&gt;&gt;&gt;&gt; slat (usec): min=3D7, max=3D805, avg=3D21.26, stde=
v=3D15.84<br>
&gt;&gt;&gt;&gt;&gt;&gt; clat (usec): min=3D101, max=3D4602, avg=3D478.55, =
stdev=3D143.73<br>
&gt;&gt;&gt;&gt;&gt;&gt; lat (usec): min=3D123, max=3D4669, avg=3D499.80, s=
tdev=3D146.03<br>
&gt;&gt;&gt;&gt;&gt;&gt; clat percentiles (usec):<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 30=
6], 20.00th=3D[ 350],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ =
470], 60.00th=3D[ 506],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ =
660], 95.00th=3D[ 724],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ =
1112], 99.95th=3D[ 1288],<br>
&gt;&gt;&gt;&gt;&gt;&gt; | 99.99th=3D[ 2192]<br>
&gt;&gt;&gt;&gt;&gt;&gt; bw (KB /s): min=3D115280, max=3D204416, per=3D100.=
00%, avg=3D183315.10, stdev=3D15079.93<br>
&gt;&gt;&gt;&gt;&gt;&gt; lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.4=
8%, 1000=3D3.28%<br>
&gt;&gt;&gt;&gt;&gt;&gt; lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%<br>
&gt;&gt;&gt;&gt;&gt;&gt; cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, m=
ajf=3D0, minf=3D14100<br>
&gt;&gt;&gt;&gt;&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5=
%, 16=3D81.0%, 32=3D5.3%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt;&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%=
, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt;&gt;&gt; complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0=
%, 32=3D4.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt;&gt;&gt;&gt;&gt; issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3D=
r=3D0/w=3D0/d=3D0<br>
&gt;&gt;&gt;&gt;&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100=
.00%, depth=3D32<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt;&gt;&gt;&gt;&gt; READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183=
295KB/s, maxb=3D183295KB/s, mint=3D55866msec, maxt=3D55866msec<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Disk stats (read/write):<br>
&gt;&gt;&gt;&gt;&gt;&gt; dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_que=
ue=3D8, util=3D0.01%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, ag=
grin_queue=3D8, aggrutil=3D0.01%<br>
&gt;&gt;&gt;&gt;&gt;&gt; sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_que=
ue=3D8, util=3D0.01%<br>
&gt;&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-user=
s@lists.ceph.com</a><br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-use=
rs-ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/lis=
tinfo.cgi/ceph-users-ceph.com</a><br>
&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@li=
sts.ceph.com</a><br>
&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-c=
eph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinf=
o.cgi/ceph-users-ceph.com</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=
=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =
=D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87<br>
&gt;&gt;&gt;&gt; =D0=9C=D0=BE=D0=B1.: +79229045757<br>
&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@li=
sts.ceph.com</a><br>
&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-c=
eph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinf=
o.cgi/ceph-users-ceph.com</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ________________________________<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; PLEASE NOTE: The information contained in this electronic =
mail message is intended only for the use of the designated recipient(s) na=
med above. If the reader of this message is not the intended recipient, you=
 are hereby notified that you have received this message in error and that =
any review, dissemination, distribution, or copying of this message is stri=
ctly prohibited. If you have received this communication in error, please n=
otify the sender by telephone or e-mail (as shown above) immediately and de=
stroy any and all copies of this message in your possession (whether hard c=
opies or electronically stored copies).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; -Pushpesh<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; -Pushpesh<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; -Pushpesh<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
<br>
<br>
<br>
<br>
<br>
<br>
--<br>
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=
=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87<br>
=D0=9C=D0=BE=D0=B1.: +79229045757<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr">=D0=A1 =D1=83=D0=B2=D0=B0=
=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=
=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=
=D0=BE=D0=B2=D0=B8=D1=87<div>=D0=9C=D0=BE=D0=B1.: +79229045757</div></div><=
/div>
</div></div></div>

--047d7b3a8e60a31b9c051917910d--

--===============0120458355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0120458355==--
