From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: passing secrets to block devices
Date: Thu, 20 Oct 2011 20:24:17 +0100
Message-ID: <20111020192417.GB16526@redhat.com>
References: <4EA068D2.4030101@dreamhost.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10860 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724Ab1JTTY1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 Oct 2011 15:24:27 -0400
Content-Disposition: inline
In-Reply-To: <4EA068D2.4030101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>

On Thu, Oct 20, 2011 at 11:30:42AM -0700, Josh Durgin wrote:
> We're working on libvirt support for block device authentication [1]. To
> authenticate, rbd needs a username and a secret. Normally, to
> avoid putting the secret on the command line, you can store the secret
> in a file and pass the file to qemu, but when this is automated,
> there's no good way to know when the file can be removed. There are
> a few ways to pass the secret to qemu that avoid this problem:

This is the same problem the iSCSI block driver currently faces,
and also if the Curl/HTTP block driver wanted todo authentication
we'd hit this. So it isn't unique to Ceph/RBD.

> 1) pass an fd to an unlinked file containing the secret
> 
> This is the simplest method, but it sounds like qemu developers don't
> like fd passing from libvirt. [2]

That would be workable, but it means people trying to run the libvirt
QEMU command line themselves, would have to remove some args.

> 2) start guests paused, without disks requiring authentication, then
>    use the drive_add monitor command to attach them
> 
> This would make disks with authentication somewhat of a special case
> in libvirt, but would be simple to implement, and require no qemu changes.

This makes it very hard for people to take the libvirt QEMU command line
and run themselves, since now an entire chunk of it is just missing.
So I really don't want to go down this route.

> 3) start guests paused, then send the secret via a new QMP/HMP
>    command (block_set_conf <key> <value>?)
> 
> This is a larger change, but it would be more generally useful for
> changing configuration at runtime.

I don't think you need to try to solve the problem of a general
purpose 'set configuration' command here, not least because that
will likely get you drawn into a huge discussion about qemu device
configuration in general which will likely never end.

We already have a 'block_passwd' command for setting qcow2 decryption
keys. These aren't decryption passwords, rather they are authentication
passwords, so they're a little different, but I think this command could
still likely be leveraged for Ceph/iSCSI/etc auth passwords.

Ideally, we want to cope with having both a decryption & auth password
for the same block device. eg, an encrypted qcow2 image accessed, over
HTTP would require both. In these case there are 2 block drivers involved,
the 'qcow2' driver and the 'http' driver. So perhaps an extra parameter
for the 'block_password' command to identify which driver the password
is intended for is the right approach. If omitted,we'd default to 'qcow2'
for back compat.

So eg, for a encrypted qcow2 disk accessed over http

   -drive  file=http://fred@host/my.iso,format=qcow2,id=mydrive

the app would invoke

  { "execute": "block_password", "argument": { "device": "mydrive",
                                               "driver", "qcow2",
                                               "password", "12345" } }
  { "execute": "block_password", "argument": { "device": "mydrive",
                                               "driver", "curl",
                                               "password", "7890" } }

For Ceph/RBD with a plain file, you'd just do


  { "execute": "block_password", "argument": { "device": "mydrive",
                                               "driver", "rbd",
                                               "password", "7890" } }


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
