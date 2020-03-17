From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [ceph-client:testing 49/53] fs/ceph/debugfs.c:140: undefined
 reference to `__divdi3'
Date: Tue, 17 Mar 2020 17:09:17 -0400
Message-ID: <7041ef971bd2c7fdb560f933d736ae6755dd1d9b.camel@kernel.org>
References: <202003180447.JrVfA6N9%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQVJU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:09:20 -0400
In-Reply-To: <202003180447.JrVfA6N9%lkp@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>, Xiubo Li <xiubli@redhat.com>
Cc: kbuild-all@lists.01.org, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>

On Wed, 2020-03-18 at 04:35 +0800, kbuild test robot wrote:
> tree:   https://github.com/ceph/ceph-client.git testing
> head:   3188fc411f0c286ac4dc4ea146ddc4bf4f348b39
> commit: dc1961a859fe49cad7a26001bd3e9a53f234bf59 [49/53] ceph: add global read latency metric support
> config: i386-randconfig-e002-20200317 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
> reproduce:
>         git checkout dc1961a859fe49cad7a26001bd3e9a53f234bf59
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: fs/ceph/debugfs.o: in function `metric_show':
> > > fs/ceph/debugfs.c:140: undefined reference to `__divdi3'
> 
> vim +140 fs/ceph/debugfs.c
> 
>    126	
>    127	static int metric_show(struct seq_file *s, void *p)
>    128	{
>    129		struct ceph_fs_client *fsc = s->private;
>    130		struct ceph_mds_client *mdsc = fsc->mdsc;
>    131		int i, nr_caps = 0;
>    132		s64 total, sum, avg = 0;
>    133	
>    134		seq_printf(s, "item          total       sum_lat(us)     avg_lat(us)\n");
>    135		seq_printf(s, "-----------------------------------------------------\n");
>    136	
>    137		total = percpu_counter_sum(&mdsc->metric.total_reads);
>    138		sum = percpu_counter_sum(&mdsc->metric.read_latency_sum);
>    139		sum = jiffies_to_usecs(sum);
>  > 140		avg = total ? sum / total : 0;

Thanks kbuild bot!

Old 32-bit arches can't do division on long long (64-bit) values. The
right fix for this is probably to use do_div(sum, total), instead of
trying to do this with normal integer division.

-- 
Jeff Layton <jlayton@kernel.org>
