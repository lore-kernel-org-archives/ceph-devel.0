From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: debugging librbd to a VM
Date: Fri, 26 Aug 2016 21:08:30 +0000
Message-ID: <MWHPR12MB19342F27DDBF165F5BAE4ADC9BEC0@MWHPR12MB1934.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:17819
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754508AbcHZXom (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 Aug 2016 19:44:42 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have two small clusters configured with the same version of Ceph and the =
same OS version.
(different processor hardware)

On these clusters I have bootable RBD images that I expect a VM to boot fro=
m.
On one cluster, the VM does not boot from the image.  On the other cluster,=
 it boots fine.
On the failing cluster, a VM can boot fine from the base qcow2 image from w=
hich the rbd image was created.  It's only rbd images that are causing prob=
lems for the VM.

I would like to enable some debug logging that could tell where the two clu=
sters are diverging.

I tried adding
        debug rbd =3D 20
        log file =3D /tmp/cbt/ceph/log/$name.log

I do see some rbd debug messages to stderr during operations like rbd clone=
, etc. but I don't see any log files created in /tmp/cbt/ceph or /var/log/c=
eph or any messages when librbd is being used by say qemu-img convert, or b=
y qemu-kvm.

Is there a way to see detailed debug messages for librbd?

Or is there a better way to see where things are diverging between these tw=
o clusters?
(note: I tried lttng but could not get it to record anything)

-- Tom
