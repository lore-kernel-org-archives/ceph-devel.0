From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 00/10] cleanup twice included headers
Date: Mon, 4 Feb 2013 09:27:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302040927330.27333@cobra.newdream.net>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47947 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab3BDR1p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 12:27:45 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

Gitbuilders came back clean; pushed these to master.

Thanks!
sage


On Mon, 4 Feb 2013, Danny Al-Gaaf wrote:

> This patch series cleanup twice included header files.
> 
> Danny Al-Gaaf (10):
>   MDS.cc: remove twice included common/errno.h
>   small_io_bench*.cc: remove twice included <iostream>
>   tp_bench.cc: remove twice included <iostream>
>   test_idempotent.cc: remove twice included "os/FileStore.h"
>   workload_generator.cc: remove twice included "common/debug.h"
>   testxattr.cc: remove twice included <iostream>
>   perf_counters.cc: remove twice included header files
>   testmsgr.cc: remove twice included <sys/stat.h>
>   ceph-filestore-dump.cc: remove twice included <iostream>
>   xattr_bench.cc: remove twice included <time.h>
> 
>  src/mds/MDS.cc                           | 1 -
>  src/test/bench/small_io_bench.cc         | 1 -
>  src/test/bench/small_io_bench_dumb.cc    | 1 -
>  src/test/bench/small_io_bench_fs.cc      | 1 -
>  src/test/bench/small_io_bench_rbd.cc     | 1 -
>  src/test/bench/tp_bench.cc               | 1 -
>  src/test/filestore/test_idempotent.cc    | 1 -
>  src/test/filestore/workload_generator.cc | 1 -
>  src/test/old/testxattr.cc                | 1 -
>  src/test/perf_counters.cc                | 2 --
>  src/test/xattr_bench.cc                  | 1 -
>  src/testmsgr.cc                          | 1 -
>  src/tools/ceph-filestore-dump.cc         | 1 -
>  13 files changed, 14 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> 
