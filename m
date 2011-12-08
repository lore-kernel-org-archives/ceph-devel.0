From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: libvirtd + rbd - stale kvm after migrate
Date: Thu, 08 Dec 2011 15:47:53 +0100
Message-ID: <4EE0CE19.5060805@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:35019 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751651Ab1LHOrg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 09:47:36 -0500
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx04.smart-weblications.de (Postfix) with ESMTPA id 9E28227867FD
	for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2011 14:47:34 +0000 (UTC)
Received: from [192.168.200.13] (callosum.office.smart-weblications.net [192.168.200.13])
	by office.smart-weblications.net (Postfix) with ESMTP id 493A65B9CCD
	for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2011 15:47:33 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,


i set up a 4 node cluster using corosync, pacemaker and ceph, created a=
 160gb
rbd image file with qemu-img and started up one virtual machine using q=
emu-kvm.

The virtual machine runs fine until i isse crm node standby on the runn=
ing host.
I can see the VM to migrate to another host and start up without issues=
, but the
vm seems to be unable to access the disk so all processes inside the VM=
 are
hanging waiting on disk-io.

If i migrate the VM back to the host where i started the VM, it runs no=
rmally
without any problems. It seems that the other host is unable to use the=
 rbd
image - is there anything i am missing here?

I also tried to use a file mounted on ceph as image, but then the node =
to which
the VM wants to migrate gets kernel-oops when trying to access the imag=
e file
and locks up :(

Any help would be highly appreciated!

ceph --version
ceph version 0.39-54-g745be30 (commit:745be30f517216474d83b9ada2f355217=
a984258)
virsh --version
0.9.8
qemu-system-x86_64 --version
QEMU emulator version 1.0.50, Copyright (c) 2003-2008 Fabrice Bellard
rbd --version
ceph version 0.39-54-g745be30 (commit:745be30f517216474d83b9ada2f355217=
a984258)

Executing  rbd  showmapped  on node01
id      pool    image   snap    device
0       rbd     ns1     -       /dev/rbd0
Executing  rbd  showmapped  on node02
id      pool    image   snap    device
0       rbd     ns1     -       /dev/rbd0
Executing  rbd  showmapped  on node03
id      pool    image   snap    device
0       rbd     ns1     -       /dev/rbd0
Executing  rbd  showmapped  on node04
id      pool    image   snap    device
0       rbd     ns1     -       /dev/rbd0

cat /etc/ceph/ceph.conf
[global]
       pid file =3D /var/run/ceph/$name.pid
       debug ms =3D 1
        auth supported =3D cephx
       osd journal =3D /data/ceph.journal
       osd_journal_size =3D 512
#       filestore journal writeahead =3D true
#       filestore journal parallel =3D true
        mds max =3D 4

[mon]
       mon data =3D /data/ceph/mon
[mon.0]
       host =3D node01
       mon addr =3D xxx.xxx.xxx.4:6789
[mon.1]
       host =3D node02
       mon addr =3D xxx.xxx.xxx.5:6789
[mon.2]
       host =3D node03
       mon addr =3D xxx.xxx.xxx.6:6789
[mon.3]
       host =3D node04
       mon addr =3D xxx.xxx.xxx.7:6789

[mds]
        keyring =3D /etc/ceph/keyring.$name
#       mds dir max commit size 32

[mds.0]
       host =3D node01
[mds.1]
       host =3D node02
[mds.2]
       host =3D node03
[mds.3]
       host =3D node04


[osd]
       sudo =3D true
       osd data =3D /data/ceph/osd
        keyring =3D /etc/ceph/keyring.$name
[osd.0]
       host =3D node01
[osd.1]
       host =3D node02
[osd.2]
       host =3D node03
[osd.3]
       host =3D node04

ns1.xml:
<domain type=3D'kvm'>
  <name>ns1</name>
  <uuid>350e51e8-2fe5-274f-76c4-58b237bc0fba</uuid>
  <memory>1048576</memory>
  <currentMemory>524288</currentMemory>
  <vcpu>2</vcpu>
  <os>
    <type arch=3D'x86_64' machine=3D'pc-0.12'>hvm</type>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <pae/>
  </features>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>restart</on_crash>
  <devices>
    <emulator>/usr/local/bin/qemu-system-x86_64</emulator>
    <disk type=3D'file' device=3D'cdrom'>
      <driver name=3D'qemu' type=3D'raw'/>
      <source file=3D'/ceph/debian-6.0.3-amd64-netinst.iso'/>
      <target dev=3D'hdc' bus=3D'ide'/>
      <readonly/>
      <address type=3D'drive' controller=3D'0' bus=3D'1' unit=3D'0'/>
    </disk>
    <disk type=3D'network' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw'/>
      <source protocol=3D'rbd' name=3D'rbd/ns1'/>
      <target dev=3D'vda' bus=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04=
' function=3D'0x0'/>
    </disk>
    <controller type=3D'ide' index=3D'0'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01=
' function=3D'0x1'/>
    </controller>
    <interface type=3D'bridge'>
      <mac address=3D'52:54:00:d2:ec:15'/>
      <source bridge=3D'br0'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03=
' function=3D'0x0'/>
    </interface>
    <input type=3D'tablet' bus=3D'usb'/>
    <input type=3D'mouse' bus=3D'ps2'/>
    <graphics type=3D'vnc' port=3D'5900' autoport=3D'no'/>
    <video>
      <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02=
' function=3D'0x0'/>
    </video>
    <memballoon model=3D'virtio'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06=
' function=3D'0x0'/>
    </memballoon>
  </devices>
</domain>

--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
