From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD boot from volume weirdness in OpenStack
Date: Thu, 25 Oct 2012 08:42:19 -0700
Message-ID: <bdf1660d88c03cd19087407dd63ef973@hq.newdream.net>
References: <CACkq2mryT7Nsqs3W5HJ-pTDHqyuDjn4_dqiDp3+zv9=Wd3TJZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ps79606.dreamhost.com ([66.33.206.83]:47218 "EHLO
	webmail.hq.newdream.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759720Ab2JYPsD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 11:48:03 -0400
In-Reply-To: <CACkq2mryT7Nsqs3W5HJ-pTDHqyuDjn4_dqiDp3+zv9=Wd3TJZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 2012-10-25 08:22, Travis Rhoden wrote:
> I've been trying to take advantage of the code additions made by Josh
> Durgin to OpenStack Folsom for combining  boot-from-volume and Ceph
> RBD.  First off, nice work Josh!  I'm hoping you folks can help me 
> out
> with something strange I am seeing.  The question may be more
> OpenStack related than Ceph, though, but hear me out first.
>
> I created a new volume (to use for boot-from-volume) from an existing
> image like so:
>
> #cinder create --display-name uec-test-vol --image-id
> 699137a2-a864-4a87-98fa-1684d7677044 5
>
> This completes just fine.
>
> Later I try to boot from it, that fails.  Cutting to the chase, here 
> is why:
>
> kvm: -drive
> 
> file=rbd:nova-volume/volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b,if=none,id=drive-virtio-disk0,format=raw,cache=none:
> error reading header from volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
> kvm: -drive
> 
> file=rbd:nova-volume/volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b,if=none,id=drive-virtio-disk0,format=raw,cache=none:
> could not open disk image
> rbd:nova-volume/volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b: No such
> file or directory
>
> It's weird that creating the volume was successful, but that KVM 
> can't
> read it.  Poking around a bit more, it was clear why:
>
> # rbd -n client.novavolume --pool nova-volume ls
> <returns nothing>
>
> # rbd -n client.novavolume ls
> volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
>
> Okay, the volume is the "rbd" pool!  That's really weird, though.
> Here is the my nova.conf entries:
> volume_driver=nova.volume.driver.RBDDriver
> rbd_pool=nova-volume
> rbd_user=novavolume
>
>
> AND, here are the log entries from nova-volume.log (cleaned up a 
> little):
>
> rbd create --pool nova-volume --size 5120
> volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
> rbd rm --pool nova-volume volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
> rbd import --pool nova-volume /tmp/tmplQUwzt
> volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
>
> I'm not sure why it goes create/delete/import, but regardless all of
> that worked.  More importantly, all these commands used --pool
> nova-volume.  So how the heck did that RBD end up in the "rbd" pool
> instead of the "nova-volume" pool?  Any ideas?
>
> Before I hit "send", I figured I should at least test this myself.  
> Watch this:
>
> #rbd create -n client.novavolume --pool nova-volume --size 1024 test
> # rbd ls -n client.novavolume --pool nova-volume
> test
> # rbd export -n client.novavolume --pool nova-volume test /tmp/test
> Exporting image: 100% complete...done.
> # rbd rm -n client.novavolume --pool nova-volume test
> Removing image: 100% complete...done.
> # rbd import -n client.novavolume --pool nova-volume /tmp/test test
> Importing image: 100% complete...done.
> # rbd ls -n client.novavolume --pool nova-volume
>
> # rbd ls -n client.novavolume --pool rbd
> test
>
>
> So it seems that "rbd import" doesn't honor the --pool argument?

This was true in 0.48, but it should have been fixed in 0.48.2 (and 
0.52).
I'll add a note about this to the docs.

> I am using 0.53 on the backend, but my client is 0.48.2.  I'll 
> upgrade
> that and see if that makes a different.

The ceph-common package in particular should be 0.48.2 or >=0.52.

>  - Travis

