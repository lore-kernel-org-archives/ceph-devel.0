From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [RBD][OpenStack]The way to solve problem when boot VM and root disk size is specified
Date: Wed, 13 Nov 2013 22:10:33 +0800
Message-ID: <308D023A-C151-4F4C-ABC6-CA72D6853A43@gmail.com>
References: <E7DD39A7-418B-4C08-98A2-8CB27AD18711@gmail.com> <5282EAC8.90902@inktank.com> <B688DDF9-C53E-46CC-ACC9-31E5B7EB24D6@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43104 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759080Ab3KMOLE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 09:11:04 -0500
Received: by mail-pd0-f177.google.com with SMTP id v10so456090pde.22
        for <ceph-devel@vger.kernel.org>; Wed, 13 Nov 2013 06:11:02 -0800 (PST)
In-Reply-To: <B688DDF9-C53E-46CC-ACC9-31E5B7EB24D6@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org


On Nov 13, 2013, at 9:14 PM, Haomai Wang <haomaiwang@gmail.com> wrote:

> 
> On Nov 13, 2013, at 10:58 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> 
>> On 11/11/2013 11:10 PM, Haomai Wang wrote:
>>> Hi all,
>>> 
>>> Now OpenStack Nova master branch still exists a bug when you boot a VM which root disk size is specified. The storage backend of Nova also is rbd. For example, you boot a VM and specify 10G as root disk size. But the image is only 1G. Then VM will be spawned and the root disk size will expands to 10G. The filesystem still is 1G.
>>> 
>>> Now I have a way to solve it. When we boot a VM and resize root disk size, we use "fuse-rbd" command to resize filesystem.
>>> 
>>> fuse-rbd -p pool -c /etc/ceph/ceph.conf /tmp-ceph-rbd
>>> cd /tmp-ceph-rbd
>>> resize2fs volume-xxxxxxxxxxx
>>> 
>>> It seemed to work but I want to know whether exists problems when many volumes in a pool. I'm not sure that too many volumes cause performance problem.
>> 
>> fuse-rbd has a 128 image limit at the moment. It's more of a prototype
>> than something I'd recommend relying on.
>> 
>> Interacting with an untrusted filesystem on a compute host is also a
>> bit worrying from a security perspective. If you really need to resize
>> the fs and can't use cloud-init, using libguestfs would be best. This
>> isolates the operations into a vm, so the host kernel isn't interacting
>> with untrusted filesystems.
> 
> I expected libguestfs too. But the pity is that the python binding of
> libguestfs doesn't support "protocol" argument, extra protocols such
> as rbd can't be used.

Oh, sorry. Newer python-libguest supports it. Good news, thanks! :-)

> 
> Maybe cloud-init is the proper choice. I just want to find a way let not
> dependent to image.
> 
>> 
>> Josh
> 
> Best regards,
> Wheats
> 
> 
> 

Best regards,
Wheats



