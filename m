From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [ceph-client:testing 8/8]
 metric.c:(.text.ceph_update_read_latency+0x180): undefined reference to
 `__divdi3'
Date: Wed, 18 Mar 2020 13:48:30 +0800
Message-ID: <f39fa6cd-f17d-10fb-ee86-77d1758c9e58@redhat.com>
References: <202003181302.3vWy9Yc7%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49772 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgCRFst (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:48:49 -0400
In-Reply-To: <202003181302.3vWy9Yc7%lkp@intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, ceph-devel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>

On 2020/3/18 13:29, kbuild test robot wrote:
> tree:   https://github.com/ceph/ceph-client.git testing
> head:   9707d15b204bb0c87dbb2a8e6ac97d012582510e
> commit: 9707d15b204bb0c87dbb2a8e6ac97d012582510e [8/8] ceph: add standard deviation support for read/write/metadata perf metric
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 9707d15b204bb0c87dbb2a8e6ac97d012582510e
>          # save the attached .config to linux build tree
>          GCC_VERSION=9.2.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     mips-linux-ld: fs/ceph/debugfs.o: in function `metric_show':
>     debugfs.c:(.text.metric_show+0x19c): undefined reference to `__divdi3'
>     mips-linux-ld: debugfs.c:(.text.metric_show+0x340): undefined reference to `__divdi3'
>     mips-linux-ld: debugfs.c:(.text.metric_show+0x4e0): undefined reference to `__divdi3'
>     mips-linux-ld: fs/ceph/metric.o: in function `ceph_update_read_latency':
>>> metric.c:(.text.ceph_update_read_latency+0x180): undefined reference to `__divdi3'
>     mips-linux-ld: fs/ceph/metric.o: in function `ceph_update_write_latency':
>>> metric.c:(.text.ceph_update_write_latency+0x160): undefined reference to `__divdi3'
>     mips-linux-ld: fs/ceph/metric.o:metric.c:(.text.ceph_update_metadata_latency+0x160): more undefined references to `__divdi3' follow

The patch series [1] should have fixed all the __divdi3 issues.

[1] https://patchwork.kernel.org/project/ceph-devel/list/?series=258001

Thanks

BR



> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
