From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: krbd + format=2 ?
Date: Wed, 12 Jun 2013 14:59:49 +1000
Message-ID: <20130612045949.GA13654@onthe.net.au>
References: <20130603092428.GB28293@onthe.net.au>
 <51B2103C.7040402@inktank.com>
 <20130608024852.GA31065@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:36150 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3FLE75 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 00:59:57 -0400
Content-Disposition: inline
In-Reply-To: <20130608024852.GA31065@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Jun 08, 2013 at 12:48:52PM +1000, Chris Dunlop wrote:
> On Fri, Jun 07, 2013 at 11:54:20AM -0500, Alex Elder wrote:
>> On 06/03/2013 04:24 AM, Chris Dunlop wrote:
>>> I pulled the for-linus branch (@ 3abef3b) on top of 3.10.0-rc4, and it's
>>> letting me map a format=2 image (created under bobtail), however reading
>>> from the block device returns zeros rather than the data. The same image
>>> correctly shows data (NTFS filesystem) when mounted into kvm using librbd.
>> 
>> Have you tried using a format 2 image that you created using
>> the Linux rbd environment?  It would be good to know whether
>> that works for you.
> 
> Sorry, how to you mean "created using the Linux rbd environment"?
> The one I was trying was created using:
> 
> rbd create --format 2 xxx --size nnnnn
> 
> ...then populated using qemu/librbd.

Looks like the kernel rbd and librbd aren't compatible, as at
3.10.0-rc4+ceph-client/for-linus@3abef3b vs librbd1 0.56.6-1~bpo70+1.

I can create a format=2 rbd image, map it, format and populate it using the
mapped device. I can then see that data after unmounting unmapping, then
re-mapping and re-mounting. However if I then attach that image via librbd to a
qemu-1.5.0~rc3 vm using the invocation below, the vm sees the whole device as
zeros.

Likewise, if I create a new format=2 rbd image, attach it via librbd to a
qemu-1.5.0~rc3 vm, format it and populate it, that data is thereafter visible
in the vm (e.g. after remounting etc.). But if I map that image using the
kernel client, again I get a device full of zeros.

# dpkg -l \*ceph\* \*rbd\* \*rados\* | grep ^i
ii  ceph           0.56.6-1~bpo70+1  amd64  distributed storage and file system
ii  ceph-common    0.56.6-1~bpo70+1  amd64  common utilities to mount and interact with a ceph storage cluster
ii  librados2      0.56.6-1~bpo70+1  amd64  RADOS distributed object store client library
ii  librbd1        0.56.6-1~bpo70+1  amd64  RADOS block device client library

##
## Attach disk to vm
##
# virsh attach-device test <(cat <<END
    <disk type='network' device='disk'>
      <driver name='qemu' type='raw'/>
      <auth username='vm'>
        <secret type='ceph' uuid='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'/>
      </auth> 
      <source protocol='rbd' name='rbd/crd-test'/>
      <target dev='vdc' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x7' function='0x0'/>
    </disk>
END
)


Cheers,

Chris
