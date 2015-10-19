From: "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Mon, 19 Oct 2015 11:58:45 -0400
Message-ID: <20151019155845.GC2755@pad.redhat.com>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com>
 <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
 <20151019151351.GB2755@pad.redhat.com>
 <1690677640.33968582.1445269755253.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbbJSP6q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Oct 2015 11:58:46 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 91A93319ADF
	for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 15:58:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1690677640.33968582.1445269755253.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Sage Weil <sweil@redhat.com>

On Mon, Oct 19, 2015 at 11:49:15AM -0400, Matt Benjamin wrote:
> ----- Original Message -----
> > From: "J. Bruce Fields" <bfields@redhat.com>
...
> > 
> > On Fri, Oct 16, 2015 at 05:08:17PM -0400, Matt Benjamin wrote:
> > > Hi devs (CC Bruce--here is a use case for vmci sockets transport)
> > > 
> > > One of Sage's possible plans for Manilla integration would use nfs over the
> > > new Linux  vmci sockets transport integration in qemu (below) to access
> > > Cephfs via an nfs-ganesha server running in the host vm.
> > 
> > What does "the host vm" mean, and why is this a particularly useful
> > configuration?
> 
> Sorry, I should say, "the vm host."

Got it, thanks!

> I think the claimed utility here is (at least) three-fold:
> 
> 1. simplified configuration on host and guests
> 2. some claim to improved security through isolation

So why is it especially interesting to put Ceph inside the VM and
Ganesha outside?

> 3. some expectation of improved latency/performance wrt TCP
> 
> Stefan sent a link to a set of slides with his original patches.  Did you get a chance to read through those?
> 
> [1] http://events.linuxfoundation.org/sites/events/files/slides/stefanha-kvm-forum-2015.pdf

Yep, thanks.--b.

> 
> Regards,
> 
> Matt
> 
> > 
> > --b.
> > 
> > > 
> > > This now experimentally works.
> > > 
> > > some notes on running nfs-ganesha over AF_VSOCK:
> > > 
> > > 1. need stefan hajnoczi's patches for
> > > * linux kernel (and build w/vhost-vsock support
> > > * qemu (and build w/vhost-vsock support)
> > > * nfs-utils (in vm guest)
> > > 
> > > all linked from https://github.com/stefanha?tab=repositories
> > > 
> > > 2. host and vm guest kernels must include vhost-vsock
> > > * host kernel should load vhost-vsock.ko
> > > 
> > > 3. start a qemu(-kvm) guest (w/patched kernel) with a vhost-vsock-pci
> > > device, e.g
> > > 
> > > /opt/qemu-vsock/bin/qemu-system-x86_64    -m 2048 -usb -name vsock1
> > > --enable-kvm     -drive
> > > file=/opt/images/vsock.qcow,if=virtio,index=0,format=qcow2     -drive
> > > file=/opt/isos/f22.iso,media=cdrom     -net
> > > nic,model=virtio,macaddr=02:36:3e:41:1b:78     -net bridge,br=br0
> > > -parallel none     -serial mon:stdio -device
> > > vhost-vsock-pci,id=vhost-vsock-pci0,addr=4.0,guest-cid=4  -boot c
> > > 
> > > 4. nfs-gansha (in host)
> > > * need nfs-ganesha and its ntirpc rpc provider with vsock support
> > > https://github.com/linuxbox2/nfs-ganesha (vsock branch)
> > > https://github.com/linuxbox2/ntirpc (vsock branch)
> > > 
> > > * configure ganesha w/vsock support
> > > cmake -DCMAKE_INSTALL_PREFIX=/cache/nfs-vsock -DUSE_FSAL_VFS=ON -DUSE_VSOCK
> > > -DCMAKE_C_FLAGS="-O0 -g3 -gdwarf-4" ../src
> > > 
> > > in ganesha.conf, add "nfsvsock" to Protocols list in EXPORT block
> > > 
> > > 5. mount in guest w/nfs41:
> > > (e.g., in fstab)
> > > 2:// /vsock41 nfs
> > > noauto,soft,nfsvers=4.1,sec=sys,proto=vsock,clientaddr=4,rsize=1048576,wsize=1048576
> > > 0 0
> > > 
> > > If you try this, send feedback.
> > > 
> > > Thanks!
> > > 
> > > Matt
> > > 
> > > --
> > > Matt Benjamin
> > > Red Hat, Inc.
> > > 315 West Huron Street, Suite 140A
> > > Ann Arbor, Michigan 48103
> > > 
> > > http://www.redhat.com/en/technologies/storage
> > > 
> > > tel.  734-707-0660
> > > fax.  734-769-8938
> > > cel.  734-216-5309
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
