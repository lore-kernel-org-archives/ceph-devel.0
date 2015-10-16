From: Matt Benjamin <mbenjamin@redhat.com>
Subject: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Fri, 16 Oct 2015 17:08:17 -0400 (EDT)
Message-ID: <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:48651 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbJPVIR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 17:08:17 -0400
In-Reply-To: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Sage Weil <sweil@redhat.com>, "J. Bruce Fields" <bfields@redhat.com>

Hi devs (CC Bruce--here is a use case for vmci sockets transport)

One of Sage's possible plans for Manilla integration would use nfs over the new Linux  vmci sockets transport integration in qemu (below) to access Cephfs via an nfs-ganesha server running in the host vm.

This now experimentally works.

some notes on running nfs-ganesha over AF_VSOCK:

1. need stefan hajnoczi's patches for
* linux kernel (and build w/vhost-vsock support
* qemu (and build w/vhost-vsock support)
* nfs-utils (in vm guest)

all linked from https://github.com/stefanha?tab=repositories

2. host and vm guest kernels must include vhost-vsock
* host kernel should load vhost-vsock.ko

3. start a qemu(-kvm) guest (w/patched kernel) with a vhost-vsock-pci device, e.g

/opt/qemu-vsock/bin/qemu-system-x86_64    -m 2048 -usb -name vsock1     --enable-kvm     -drive file=/opt/images/vsock.qcow,if=virtio,index=0,format=qcow2     -drive file=/opt/isos/f22.iso,media=cdrom     -net nic,model=virtio,macaddr=02:36:3e:41:1b:78     -net bridge,br=br0     -parallel none     -serial mon:stdio -device vhost-vsock-pci,id=vhost-vsock-pci0,addr=4.0,guest-cid=4  -boot c

4. nfs-gansha (in host)
* need nfs-ganesha and its ntirpc rpc provider with vsock support
https://github.com/linuxbox2/nfs-ganesha (vsock branch)
https://github.com/linuxbox2/ntirpc (vsock branch)

* configure ganesha w/vsock support
cmake -DCMAKE_INSTALL_PREFIX=/cache/nfs-vsock -DUSE_FSAL_VFS=ON -DUSE_VSOCK -DCMAKE_C_FLAGS="-O0 -g3 -gdwarf-4" ../src

in ganesha.conf, add "nfsvsock" to Protocols list in EXPORT block

5. mount in guest w/nfs41:
(e.g., in fstab)
2:// /vsock41 nfs noauto,soft,nfsvers=4.1,sec=sys,proto=vsock,clientaddr=4,rsize=1048576,wsize=1048576 0 0

If you try this, send feedback.

Thanks!

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309

