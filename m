From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Errors attaching RBD image to a running VM
Date: Fri, 07 Dec 2012 14:50:08 -0800
Message-ID: <50C272A0.9020506@inktank.com>
References: <20121207212247.GA12635@staff.dca.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46674 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab2LGWuZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Dec 2012 17:50:25 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so663600pbc.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Dec 2012 14:50:24 -0800 (PST)
In-Reply-To: <20121207212247.GA12635@staff.dca.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Morgan <mmorgan@dca.net>
Cc: ceph-devel@vger.kernel.org

On 12/07/2012 01:22 PM, Michael Morgan wrote:
> Hello,
>
>   I've been building an OpenStack cluster using Ceph as the storage backend.
> Currently running SL 6.3, OpenStack Folsom packages from EPEL, Libvirt 0.9.10,
> QEMU 1.2.1 built from an epel-testing SRPM for RBD support, and Ceph 0.54. I
> can boot off of an image without problems but attaching to a running instance
> fails. Tracking back from Horizon and Cinder I see Libvirt generating the
> errors:
>
> 2012-12-07 20:03:20.657+0000: 19803: error : qemuMonitorJSONCheckError:338 : internal error unable to execute QEMU command 'device_add': Property 'virtio-blk-pci.drive' can't find value 'drive-virtio-disk1'
> 2012-12-07 20:03:20.664+0000: 19803: error : qemuMonitorTextDriveDel:2895 : operation failed: deleting file=rbd:volumes/volume-6c82e5d3-e697-43a8-8194-1f7df932ceb8:id=volumes:key=AQCicbZQ8Oo2IBAALganQv+zY/jjECc9fHUBBA==:auth_supported=cephx none,if=none,id=drive-virtio-disk1,format=raw,cache=none drive failed: drive_del: extraneous characters at the end of line
>
>   I can reproduce the error with virsh attach-device and the following XML:
>
> <disk type='network' device='disk'>
>    <driver name='qemu' type='raw' cache='none'/>
>    <auth username='volumes'>
>      <secret type='ceph' uuid='93fb3d32-7e2d-691d-db94-4c1cf21bed02'/>
>    </auth>
>    <source protocol="rbd" name="volumes/volume-6c82e5d3-e697-43a8-8194-1f7df932ceb8"/>
>    <target bus='virtio' dev='vdb'/>
> </disk>
>
>   I realize this is probably more of a Libvirt/QEMU problem but the only
> reference I could find to an error like this was a post here from last year:
>
> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/4713
>
>   In that thread the problem disappeared after multiple version changes without
> any clear source for the resolution. Has anyone seen this type of error before?

Yes, this is fixed in libvirt 0.9.12. There were a couple issues with
properly escaping JSON and using a space instead of a semicolon with
qemu's command parsing.

There are a couple more rbd-related bug fixes in later versions of
libvirt, but you wouldn't hit those problems using OpenStack.

>   I can certainly move along to other lists if appropriate but figured I'd start
> here since it's the only place I saw such an issue pop up. It also gives me an
> opportunity to say how awesome Ceph seems. The level of support I've seen on
> this list is pretty amazing and I hope to increase our use of Ceph in the
> future.

Thanks :). I actually prefer ceph-related stuff coming to this list,
since it's easier to keep track of and gets more attention from people
more familiar with ceph, rather than just libvirt, qemu, etc.

Josh
