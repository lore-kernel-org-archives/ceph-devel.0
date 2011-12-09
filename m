From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: libvirtd + rbd - stale kvm after migrate
Date: Fri, 09 Dec 2011 10:17:08 +0100
Message-ID: <4EE1D214.8030708@smart-weblications.de>
References: <4EE0CE19.5060805@smart-weblications.de> <CAO47_-98p+8cB+jatjJiD4dsAvxeEYO2rBTT6Z7DQV6w64tquQ@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:40004 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751961Ab1LIJQp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2011 04:16:45 -0500
In-Reply-To: <CAO47_-98p+8cB+jatjJiD4dsAvxeEYO2rBTT6Z7DQV6w64tquQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Hi Christian,

Am 08.12.2011 23:49, schrieb Christian Brunner:
>=20
> live migration with rbd images usually works fine. A few recommendati=
ons:
>=20
> - You should not map the image on the host, while using it in a VM
> with the qemu driver.
> - For testing I would remove the ISO-Image from your VM. (Not sure if
> that matters).
>=20
> Also I'm not using cephx authentication. I don't know if the
> credentials are available on the second host, as you don't specifiy
> them in the libvirt.xml.

i now recreated cephfs without authx support, and added host-decription=
 in the
VM xml file.

anyway the VM still does not seem to be able to do disk-io when migrate=
d...

the iso-image should not be a problem, as it is in /ceph which is mount=
ed on
every node... but i gave it a try and disabled the cdrom in the xml fil=
e, still
no success...

i also found out that using hostnames defined in /etc/hosts won't work.=
 i still
got no clue how to figure out what is going wrong... when i start the V=
M
directly on the host i want the VM to migrate to, the VM behaves normal=
=2E

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
    <disk type=3D'network' device=3D'disk'>
      <source protocol=3D'rbd' name=3D'rbd/ns1'>
        <host name=3D'xxx.xxx.xxx.4' port=3D'6789'/>
        <host name=3D'xxx.xxx.xxx.5' port=3D'6789'/>
        <host name=3D'xxx.xxx.xxx.6' port=3D'6789'/>
        <host name=3D'xxx.xxx.xxx.7' port=3D'6789'/>
      </source>
      <target dev=3D'vda' bus=3D'virtio'/>
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
