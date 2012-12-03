From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: VM Corruption on 0.54 when 'client cache
 =?UTF-8?Q?=3D=20false=27?=
Date: Mon, 03 Dec 2012 02:00:51 -0800
Message-ID: <9cae09be7789e62ef6520f467a223e5b@hq.newdream.net>
References: <38A500831D3DE24B90BD200D6C8701351BAE2396@Exchange2010-2.corit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ps79606.dreamhost.com ([66.33.206.83]:54746 "EHLO
	webmail.hq.newdream.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751291Ab2LCKAv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 05:00:51 -0500
In-Reply-To: <38A500831D3DE24B90BD200D6C8701351BAE2396@Exchange2010-2.corit.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Anderson <matthewa@base3.com.au>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

On 2012-12-02 18:18, Matthew Anderson wrote:
> Hi All,
>
> I've run into a corruption bug when the RBD client cache is set to
> false under QEMU-KVM. With the cache on everything is fine but write
> speeds drop considerably, 4KB sequential goes from 5.1MB/s to 1.8MB/s
> no matter what size the cache is or if writethrough is used. With the
> cache off I am usually able to boot the virtual machine once after
> copying a template to RBD using qemu-img. If I shut the VM down
> completely and boot it up again the virtual machine no longer sees
> it's partitions correctly and boots into restore mode where it can't
> fix itself. The test VM I was using was Windows Server 2012 Standard
> and Ceph is setup as a single node.

That disabling caching improves write speed sounds like something 
strange
is going on. What's the full QEMU/KVM command line and ceph.conf used
when running the VM?

The corruption issue is more serious, and not something I've seen
reported before. Does it occur only with Windows Server 2012 VMs, or
does it happen with a Linux VM as well? More specific debugging
suggestions are below.

> Ceph version is 0.54 
> (commit:60b84b095b1009a305d4d6a5b16f88571cbd3150)
>
> Host setup is -
> Dual Intel 5620, 48GB
> 4x 480GB SSD attached via the onboard SATA.
> Each OSD was setup with a 1GB journal partition and the rest of the
> space as BTRFS
> 40GB Infiniband + 2x 1GBe
> Scientific Linux 6.3 running mainline Kernel 3.6.7 from Elrepo
> QEMU-KVM userspace 1.2.0 compiled from source
>
> I was able to find a reference to a previous bug which was resolved
> by setting "filestore fiemap threshold = 0" and "filestore fiemap =
> false" but this didn't have any effect on the issue. I have also 
> tried
> the latest GIT version (as of 3 days a go) and the issue appeared to
> be there still but I didn't test enough to say conclusively that the
> bug is the exact same.

fiemap is off by default since we discovered that issue, so this is a
different bug.

> Is anyone able to suggest anything that may help? If you need more
> information just let me know.

Since the guest can't find its partitions, could you try exporting
the image to a file (rbd export pool/image filename), and then run
gdisk -l on the file? Doing this before booting, and then again after
the corruption occurs and the VM is shut down might help determine the 
nature
of the corruption, and which parts of the image are corrupted.
If you run the VM with 'debug ms = 1', 'debug objectcacher = 20', 
'debug librbd = 20',
and  'log file = /path/to/file/writeable/by/qemu' in the [client] 
section of ceph.conf,
we might be able to see what's happening to the problematic parts of 
the image.
If the logs are long, you can attach them to a bug report referring to 
this email at
http://tracker.newdream.net.

Another thing to try is running 'ceph osd deep-scrub', which will check
for consistency of objects across OSDs, and report problems in 'ceph 
-s'.

Josh
