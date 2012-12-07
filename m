From: Michael Morgan <mmorgan@dca.net>
Subject: Errors attaching RBD image to a running VM
Date: Fri, 7 Dec 2012 16:22:47 -0500
Message-ID: <20121207212247.GA12635@staff.dca.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from staff.dca.net ([207.245.84.197]:56724 "EHLO staff.dca.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756865Ab2LGVmV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Dec 2012 16:42:21 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

 I've been building an OpenStack cluster using Ceph as the storage backend.
Currently running SL 6.3, OpenStack Folsom packages from EPEL, Libvirt 0.9.10,
QEMU 1.2.1 built from an epel-testing SRPM for RBD support, and Ceph 0.54. I
can boot off of an image without problems but attaching to a running instance
fails. Tracking back from Horizon and Cinder I see Libvirt generating the
errors:

2012-12-07 20:03:20.657+0000: 19803: error : qemuMonitorJSONCheckError:338 : internal error unable to execute QEMU command 'device_add': Property 'virtio-blk-pci.drive' can't find value 'drive-virtio-disk1'
2012-12-07 20:03:20.664+0000: 19803: error : qemuMonitorTextDriveDel:2895 : operation failed: deleting file=rbd:volumes/volume-6c82e5d3-e697-43a8-8194-1f7df932ceb8:id=volumes:key=AQCicbZQ8Oo2IBAALganQv+zY/jjECc9fHUBBA==:auth_supported=cephx none,if=none,id=drive-virtio-disk1,format=raw,cache=none drive failed: drive_del: extraneous characters at the end of line

 I can reproduce the error with virsh attach-device and the following XML:

<disk type='network' device='disk'>
  <driver name='qemu' type='raw' cache='none'/>
  <auth username='volumes'>
    <secret type='ceph' uuid='93fb3d32-7e2d-691d-db94-4c1cf21bed02'/>
  </auth>
  <source protocol="rbd" name="volumes/volume-6c82e5d3-e697-43a8-8194-1f7df932ceb8"/>
  <target bus='virtio' dev='vdb'/>
</disk>
 
 I realize this is probably more of a Libvirt/QEMU problem but the only
reference I could find to an error like this was a post here from last year:

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/4713

 In that thread the problem disappeared after multiple version changes without
any clear source for the resolution. Has anyone seen this type of error before?

 I can certainly move along to other lists if appropriate but figured I'd start
here since it's the only place I saw such an issue pop up. It also gives me an
opportunity to say how awesome Ceph seems. The level of support I've seen on
this list is pretty amazing and I hope to increase our use of Ceph in the
future.

Thanks in advance,
 Mike
