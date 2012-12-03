From: Matthew Anderson <matthewa@base3.com.au>
Subject: VM Corruption on 0.54 when 'client cache = false'
Date: Mon, 3 Dec 2012 02:18:05 +0000
Message-ID: <38A500831D3DE24B90BD200D6C8701351BAE2396@Exchange2010-2.corit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.base3.com.au ([27.106.198.3]:30247 "EHLO mail.base3.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359Ab2LCCXe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Dec 2012 21:23:34 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

Hi All,

I've run into a corruption bug when the RBD client cache is set to false under QEMU-KVM. With the cache on everything is fine but write speeds drop considerably, 4KB sequential goes from 5.1MB/s to 1.8MB/s no matter what size the cache is or if writethrough is used. With the cache off I am usually able to boot the virtual machine once after copying a template to RBD using qemu-img. If I shut the VM down completely and boot it up again the virtual machine no longer sees it's partitions correctly and boots into restore mode where it can't fix itself. The test VM I was using was Windows Server 2012 Standard and Ceph is setup as a single node.

Ceph version is 0.54 (commit:60b84b095b1009a305d4d6a5b16f88571cbd3150)

Host setup is -
Dual Intel 5620, 48GB 
4x 480GB SSD attached via the onboard SATA.
Each OSD was setup with a 1GB journal partition and the rest of the space as BTRFS
40GB Infiniband + 2x 1GBe
Scientific Linux 6.3 running mainline Kernel 3.6.7 from Elrepo
QEMU-KVM userspace 1.2.0 compiled from source

I was able to find a reference to a previous bug which was resolved by setting "filestore fiemap threshold = 0" and "filestore fiemap = false" but this didn't have any effect on the issue. I have also tried the latest GIT version (as of 3 days a go) and the issue appeared to be there still but I didn't test enough to say conclusively that the bug is the exact same. 

Is anyone able to suggest anything that may help? If you need more information just let me know.

Thanks
-Matt

