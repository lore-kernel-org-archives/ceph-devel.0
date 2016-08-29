From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: debugging librbd to a VM
Date: Mon, 29 Aug 2016 18:33:28 +0000
Message-ID: <MWHPR12MB19344F276252365A9F02AFBC9BE10@MWHPR12MB1934.namprd12.prod.outlook.com>
References: <MWHPR12MB19342F27DDBF165F5BAE4ADC9BEC0@MWHPR12MB1934.namprd12.prod.outlook.com>
 <20160829080314.GA1733@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:22290
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757226AbcH3AFN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 Aug 2016 20:05:13 -0400
In-Reply-To: <20160829080314.GA1733@gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>, Jason Dillaman <jdillama@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Mykola, Jason --

I notice on both clusters the qemu process running is /usr/libexec/qemu-kvm=
 (this is RHEL 7.2) and the euser,fgroup,ruser,uname printed by ps are all =
user qemu.

(note: I am initiating the VM thru virsh define xyz.xml followed by virsh s=
tart, and the user initiating both those virsh commands is root).

On both clusters /etc/ceph/ceph.conf is 644 access.

On both clusters, I get
ldd /usr/libexec/qemu-kvm | grep rbd
    librbd.so.1 =3D> /lib64/librbd.so.1 (0x00007fbdf1071000)


When I try=20
    rbd --id admin export <image-spec> - | md5sum
I get the same md5sum values on both clusters.

If I use --id qemu instead, I get=20
    rbd: couldn't connect to the cluster
on both clusters.

If I leave off the --id option entirely, it works on both clusters and I ge=
t the same md5sum.

Have not tried setting debug options on the working cluster, will try that.

-- Tom


> -----Original Message-----
> From: Mykola Golub [mailto:mgolub@mirantis.com]
> Sent: Monday, August 29, 2016 3:03 AM
> To: Deneau, Tom <tom.deneau@amd.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: debugging librbd to a VM
>=20
> May be qemu does not see you ceph.conf? Or some other environmental
> issue (e.g. with qemu rbd driver). Try
>=20
> ldd /usr/bin/qemu-system-x86_64 |grep rbd
>=20
> Have you tried starting it from command line?
>=20
> You could check if config debug options work as expected setting them
> on your working cluster.
>=20
> On Fri, Aug 26, 2016 at 09:08:30PM +0000, Deneau, Tom wrote:
> > I have two small clusters configured with the same version of Ceph and
> the same OS version.
> > (different processor hardware)
> >
> > On these clusters I have bootable RBD images that I expect a VM to boot
> from.
> > On one cluster, the VM does not boot from the image.  On the other
> cluster, it boots fine.
> > On the failing cluster, a VM can boot fine from the base qcow2 image
> from which the rbd image was created.  It's only rbd images that are
> causing problems for the VM.
> >
> > I would like to enable some debug logging that could tell where the two
> clusters are diverging.
> >
> > I tried adding
> >         debug rbd =3D 20
> >         log file =3D /tmp/cbt/ceph/log/$name.log
> >
> > I do see some rbd debug messages to stderr during operations like rbd
> clone, etc. but I don't see any log files created in /tmp/cbt/ceph or
> /var/log/ceph or any messages when librbd is being used by say qemu-img
> convert, or by qemu-kvm.
> >
> > Is there a way to see detailed debug messages for librbd?
> >
> > Or is there a better way to see where things are diverging between thes=
e
> two clusters?
> > (note: I tried lttng but could not get it to record anything)
> >
> > -- Tom
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> Mykola Golub
