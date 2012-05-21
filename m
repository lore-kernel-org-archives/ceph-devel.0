From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: qemu-rdb questions
Date: Sun, 20 May 2012 23:07:59 -0700
Message-ID: <4FB9DBBF.5070107@inktank.com>
References: <f5e64790-567a-4ad4-8b3d-01f6f6604dd7@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43683 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab2EUGID (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 02:08:03 -0400
Received: by pbbrp8 with SMTP id rp8so6488966pbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 23:08:02 -0700 (PDT)
In-Reply-To: <f5e64790-567a-4ad4-8b3d-01f6f6604dd7@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On 05/19/2012 09:33 PM, Alexandre DERUMIER wrote:
> Hi,
> i'm planning to do rdb integration in proxmox2 kvm distribution (not using libvirt).
>
> I found some doc here
> http://ceph.com/wiki/QEMU-RBD
> and also in libvirt mailing list.
>
>
> some questions:
>
> qemu drive command line :
> -------------------------
> -drive file=rbd:pool/image:id=myname:key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:auth_supported=cephx none:mon_host=mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,if=virtio,format=raw
>
> is it the right syntax ?

Newer qemu doesn't like the space in auth_supported, so you'll want to
use a semicolon instead:

-drive 
file=rbd:pool/image:id=myname:key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:auth_supported=cephx;none:mon_host=mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,if=virtio,format=raw

The key/value pairs separated by colons are Ceph configuration options.
The above drive line is equivalent the following settings:

/path/to/myname.keyring containing the keyring for myname, as shown by 
'ceph auth list'.

/etc/ceph/ceph.conf containing:

[client.myname]
     keyring = /path/to/myname.keyring
     auth supported = cephx none
     mon host = 
mon1.example.org:6321;mon2.example.org:6322;mon3.example.org:6322

And a drive line like:

-drive file=rbd:pool/image:id=myname,if=virtio,format=raw

Qemu reads the from the ceph.conf file if it exists. Any extra
options you add override those from the configuration file.

You can have it read from another file by adding ':conf=/path/to/file'.

>
>
> for image management, what is the best way ? qemu-img or rdb ?
>
> rdb creation with qemu-img:
> ----------------------------
> qemu-img create -f rbd rbd:data/foo 10G
>
> how to specify monitor, authentification,.... ?
>
> rdb delete/resize with qemu-img?
> --------------------------------
> don't find any infos.

The rbd tool has more features. As you noticed, qemu doesn't know how
to delete images. It also can't rename them. I'm not sure if qemu-img
lets you resize them. The monitor and auth options for qemu-img are the
same as for qemu's -drive syntax. You can configure them in
/etc/ceph/ceph.conf, or on the command line.

For the rbd tool, if you don't want to use a configuration file, the
options would be:

rbd --mon-host 
'mon1.example.org:6321;mon2.example.org:6322;mon3.example.org:6322' 
--keyring /path/to/keyring --id myname --auth-supported 'cephx;none'

These are generic ceph options, and work with any ceph command. They can
also be set in the CEPH_ARGS environment variable.

>
>
> rdb commands
> ------------
> Is the rdb kernel module require to use rdb command ?

Nope, it's only needed if you want to have /dev/rbd devices on your
hosts.

> Also,I would like to not have any /dev/rdbx device on my client.

qemu goes directly through the userspace librbd to access rbd images.
The rbd kernel module isn't involved at all, and no devices appear on 
the host. The guest does not know it's using rbd; it sees a block 
device, just as if you were using e.g. a qcow2 file.

Josh
