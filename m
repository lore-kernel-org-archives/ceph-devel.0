From: John Spray <jspray@redhat.com>
Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Mon, 19 Oct 2015 17:13:02 +0100
Message-ID: <CALe9h7cGzjgBO=K-p7PF=MQViawh8ZKd6u_u4E5A_JSf5zhMVg@mail.gmail.com>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com> <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36082 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359AbbJSQNW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 12:13:22 -0400
Received: by obcqt19 with SMTP id qt19so64920661obc.3
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 09:13:21 -0700 (PDT)
In-Reply-To: <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 16, 2015 at 10:08 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi devs (CC Bruce--here is a use case for vmci sockets transport)
>
> One of Sage's possible plans for Manilla integration would use nfs over the new Linux  vmci sockets transport integration in qemu (below) to access Cephfs via an nfs-ganesha server running in the host vm.
>
> This now experimentally works.

Very cool!  Thank you for the detailed instructions, I look forward to
trying this out soon.

John

> some notes on running nfs-ganesha over AF_VSOCK:
>
> 1. need stefan hajnoczi's patches for
> * linux kernel (and build w/vhost-vsock support
> * qemu (and build w/vhost-vsock support)
> * nfs-utils (in vm guest)
>
> all linked from https://github.com/stefanha?tab=repositories
>
> 2. host and vm guest kernels must include vhost-vsock
> * host kernel should load vhost-vsock.ko
>
> 3. start a qemu(-kvm) guest (w/patched kernel) with a vhost-vsock-pci device, e.g
>
> /opt/qemu-vsock/bin/qemu-system-x86_64    -m 2048 -usb -name vsock1     --enable-kvm     -drive file=/opt/images/vsock.qcow,if=virtio,index=0,format=qcow2     -drive file=/opt/isos/f22.iso,media=cdrom     -net nic,model=virtio,macaddr=02:36:3e:41:1b:78     -net bridge,br=br0     -parallel none     -serial mon:stdio -device vhost-vsock-pci,id=vhost-vsock-pci0,addr=4.0,guest-cid=4  -boot c
>
> 4. nfs-gansha (in host)
> * need nfs-ganesha and its ntirpc rpc provider with vsock support
> https://github.com/linuxbox2/nfs-ganesha (vsock branch)
> https://github.com/linuxbox2/ntirpc (vsock branch)
>
> * configure ganesha w/vsock support
> cmake -DCMAKE_INSTALL_PREFIX=/cache/nfs-vsock -DUSE_FSAL_VFS=ON -DUSE_VSOCK -DCMAKE_C_FLAGS="-O0 -g3 -gdwarf-4" ../src
>
> in ganesha.conf, add "nfsvsock" to Protocols list in EXPORT block
>
> 5. mount in guest w/nfs41:
> (e.g., in fstab)
> 2:// /vsock41 nfs noauto,soft,nfsvers=4.1,sec=sys,proto=vsock,clientaddr=4,rsize=1048576,wsize=1048576 0 0
>
> If you try this, send feedback.
>
> Thanks!
>
> Matt
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
