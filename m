From: Christian Brunner <chb@muc.de>
Subject: Re: libvirtd + rbd - stale kvm after migrate
Date: Thu, 8 Dec 2011 23:49:15 +0100
Message-ID: <CAO47_-98p+8cB+jatjJiD4dsAvxeEYO2rBTT6Z7DQV6w64tquQ@mail.gmail.com>
References: <4EE0CE19.5060805@smart-weblications.de>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41033 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab1LHWtQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 17:49:16 -0500
Received: by vbbfc26 with SMTP id fc26so1883343vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Dec 2011 14:49:15 -0800 (PST)
In-Reply-To: <4EE0CE19.5060805@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-devel@vger.kernel.org

Hi Florian,

live migration with rbd images usually works fine. A few recommendation=
s:

- You should not map the image on the host, while using it in a VM
with the qemu driver.
- For testing I would remove the ISO-Image from your VM. (Not sure if
that matters).

Also I'm not using cephx authentication. I don't know if the
credentials are available on the second host, as you don't specifiy
them in the libvirt.xml.

Viele Gr=FC=DFe
Christian

2011/12/8 Smart Weblications GmbH - Florian Wiessner
<f.wiessner@smart-weblications.de>:
> Hi List,
>
>
> i set up a 4 node cluster using corosync, pacemaker and ceph, created=
 a 160gb
> rbd image file with qemu-img and started up one virtual machine using=
 qemu-kvm.
>
> The virtual machine runs fine until i isse crm node standby on the ru=
nning host.
> I can see the VM to migrate to another host and start up without issu=
es, but the
> vm seems to be unable to access the disk so all processes inside the =
VM are
> hanging waiting on disk-io.
>
> If i migrate the VM back to the host where i started the VM, it runs =
normally
> without any problems. It seems that the other host is unable to use t=
he rbd
> image - is there anything i am missing here?
>
> I also tried to use a file mounted on ceph as image, but then the nod=
e to which
> the VM wants to migrate gets kernel-oops when trying to access the im=
age file
> and locks up :(
>
> Any help would be highly appreciated!
>
> ceph --version
> ceph version 0.39-54-g745be30 (commit:745be30f517216474d83b9ada2f3552=
17a984258)
> virsh --version
> 0.9.8
> qemu-system-x86_64 --version
> QEMU emulator version 1.0.50, Copyright (c) 2003-2008 Fabrice Bellard
> rbd --version
> ceph version 0.39-54-g745be30 (commit:745be30f517216474d83b9ada2f3552=
17a984258)
>
> Executing =A0rbd =A0showmapped =A0on node01
> id =A0 =A0 =A0pool =A0 =A0image =A0 snap =A0 =A0device
> 0 =A0 =A0 =A0 rbd =A0 =A0 ns1 =A0 =A0 - =A0 =A0 =A0 /dev/rbd0
> Executing =A0rbd =A0showmapped =A0on node02
> id =A0 =A0 =A0pool =A0 =A0image =A0 snap =A0 =A0device
> 0 =A0 =A0 =A0 rbd =A0 =A0 ns1 =A0 =A0 - =A0 =A0 =A0 /dev/rbd0
> Executing =A0rbd =A0showmapped =A0on node03
> id =A0 =A0 =A0pool =A0 =A0image =A0 snap =A0 =A0device
> 0 =A0 =A0 =A0 rbd =A0 =A0 ns1 =A0 =A0 - =A0 =A0 =A0 /dev/rbd0
> Executing =A0rbd =A0showmapped =A0on node04
> id =A0 =A0 =A0pool =A0 =A0image =A0 snap =A0 =A0device
> 0 =A0 =A0 =A0 rbd =A0 =A0 ns1 =A0 =A0 - =A0 =A0 =A0 /dev/rbd0
>
> cat /etc/ceph/ceph.conf
> [global]
> =A0 =A0 =A0 pid file =3D /var/run/ceph/$name.pid
> =A0 =A0 =A0 debug ms =3D 1
> =A0 =A0 =A0 =A0auth supported =3D cephx
> =A0 =A0 =A0 osd journal =3D /data/ceph.journal
> =A0 =A0 =A0 osd_journal_size =3D 512
> # =A0 =A0 =A0 filestore journal writeahead =3D true
> # =A0 =A0 =A0 filestore journal parallel =3D true
> =A0 =A0 =A0 =A0mds max =3D 4
>
> [mon]
> =A0 =A0 =A0 mon data =3D /data/ceph/mon
> [mon.0]
> =A0 =A0 =A0 host =3D node01
> =A0 =A0 =A0 mon addr =3D xxx.xxx.xxx.4:6789
> [mon.1]
> =A0 =A0 =A0 host =3D node02
> =A0 =A0 =A0 mon addr =3D xxx.xxx.xxx.5:6789
> [mon.2]
> =A0 =A0 =A0 host =3D node03
> =A0 =A0 =A0 mon addr =3D xxx.xxx.xxx.6:6789
> [mon.3]
> =A0 =A0 =A0 host =3D node04
> =A0 =A0 =A0 mon addr =3D xxx.xxx.xxx.7:6789
>
> [mds]
> =A0 =A0 =A0 =A0keyring =3D /etc/ceph/keyring.$name
> # =A0 =A0 =A0 mds dir max commit size 32
>
> [mds.0]
> =A0 =A0 =A0 host =3D node01
> [mds.1]
> =A0 =A0 =A0 host =3D node02
> [mds.2]
> =A0 =A0 =A0 host =3D node03
> [mds.3]
> =A0 =A0 =A0 host =3D node04
>
>
> [osd]
> =A0 =A0 =A0 sudo =3D true
> =A0 =A0 =A0 osd data =3D /data/ceph/osd
> =A0 =A0 =A0 =A0keyring =3D /etc/ceph/keyring.$name
> [osd.0]
> =A0 =A0 =A0 host =3D node01
> [osd.1]
> =A0 =A0 =A0 host =3D node02
> [osd.2]
> =A0 =A0 =A0 host =3D node03
> [osd.3]
> =A0 =A0 =A0 host =3D node04
>
> ns1.xml:
> <domain type=3D'kvm'>
> =A0<name>ns1</name>
> =A0<uuid>350e51e8-2fe5-274f-76c4-58b237bc0fba</uuid>
> =A0<memory>1048576</memory>
> =A0<currentMemory>524288</currentMemory>
> =A0<vcpu>2</vcpu>
> =A0<os>
> =A0 =A0<type arch=3D'x86_64' machine=3D'pc-0.12'>hvm</type>
> =A0 =A0<boot dev=3D'hd'/>
> =A0</os>
> =A0<features>
> =A0 =A0<acpi/>
> =A0 =A0<apic/>
> =A0 =A0<pae/>
> =A0</features>
> =A0<clock offset=3D'utc'/>
> =A0<on_poweroff>destroy</on_poweroff>
> =A0<on_reboot>restart</on_reboot>
> =A0<on_crash>restart</on_crash>
> =A0<devices>
> =A0 =A0<emulator>/usr/local/bin/qemu-system-x86_64</emulator>
> =A0 =A0<disk type=3D'file' device=3D'cdrom'>
> =A0 =A0 =A0<driver name=3D'qemu' type=3D'raw'/>
> =A0 =A0 =A0<source file=3D'/ceph/debian-6.0.3-amd64-netinst.iso'/>
> =A0 =A0 =A0<target dev=3D'hdc' bus=3D'ide'/>
> =A0 =A0 =A0<readonly/>
> =A0 =A0 =A0<address type=3D'drive' controller=3D'0' bus=3D'1' unit=3D=
'0'/>
> =A0 =A0</disk>
> =A0 =A0<disk type=3D'network' device=3D'disk'>
> =A0 =A0 =A0<driver name=3D'qemu' type=3D'raw'/>
> =A0 =A0 =A0<source protocol=3D'rbd' name=3D'rbd/ns1'/>
> =A0 =A0 =A0<target dev=3D'vda' bus=3D'virtio'/>
> =A0 =A0 =A0<address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D=
'0x04' function=3D'0x0'/>
> =A0 =A0</disk>
> =A0 =A0<controller type=3D'ide' index=3D'0'>
> =A0 =A0 =A0<address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D=
'0x01' function=3D'0x1'/>
> =A0 =A0</controller>
> =A0 =A0<interface type=3D'bridge'>
> =A0 =A0 =A0<mac address=3D'52:54:00:d2:ec:15'/>
> =A0 =A0 =A0<source bridge=3D'br0'/>
> =A0 =A0 =A0<model type=3D'virtio'/>
> =A0 =A0 =A0<address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D=
'0x03' function=3D'0x0'/>
> =A0 =A0</interface>
> =A0 =A0<input type=3D'tablet' bus=3D'usb'/>
> =A0 =A0<input type=3D'mouse' bus=3D'ps2'/>
> =A0 =A0<graphics type=3D'vnc' port=3D'5900' autoport=3D'no'/>
> =A0 =A0<video>
> =A0 =A0 =A0<model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
> =A0 =A0 =A0<address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D=
'0x02' function=3D'0x0'/>
> =A0 =A0</video>
> =A0 =A0<memballoon model=3D'virtio'>
> =A0 =A0 =A0<address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D=
'0x06' function=3D'0x0'/>
> =A0 =A0</memballoon>
> =A0</devices>
> </domain>
>
> --
>
> Mit freundlichen Gr=FC=DFen,
>
> Florian Wiessner
>
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
>
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
>
> --
> Sitz der Gesellschaft: Naila
> Gesch=E4ftsf=FChrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
