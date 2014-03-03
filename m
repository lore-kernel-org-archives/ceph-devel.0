From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: [RFC] add rocksdb support
Date: Mon, 03 Mar 2014 07:37:43 -0600
Message-ID: <531485A7.4040408@inktank.com>
References: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47477 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbaCCNhL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 08:37:11 -0500
Received: by mail-ie0-f182.google.com with SMTP id y20so3287255ier.41
        for <ceph-devel@vger.kernel.org>; Mon, 03 Mar 2014 05:37:11 -0800 (PST)
In-Reply-To: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/02/2014 08:07 PM, Shu, Xinxin wrote:
> Hi all,
>
> This patch added rocksdb support for ceph, enabled rocksdb for omap directory.   Rocksdb source code can be get from link. To use use rocksdb, C++11 standard should be enabled, gcc version >= 4.7 is required to get C++11 support. Rocksdb can be installed with instructions described in the INSTALL.md file,  and  rocksdb header files (include/rocksdb/*) and library (librocksdb.so*) need to be copied to corresponding directories.
> To enable rocksdb, add "--with-librocksdb" option to configure. The rocksdb branch is here(https://github.com/xinxinsh/ceph/tree/rocksdb).
>
>
> Performance Test
> Attached file is the performance comparison of rocksdb and leveldb on four nodes with 40 osds,  using 'rados bench' as the test tool. The performance results is quite promising.
>
> Any comments or suggestions are greatly appreciated.

Awesome job!  Excited to look at this!

>
> Rados bench	                       BandWidth(MB/s)	                     Average latency
> 	                                 Leveldb	rocksdb	Leveldb	rocksdb
> write 4 threads	                 263.762	272.549	                    0.061	                 0.059
> write 8 threads	                 449.834	457.811                    0.071	                 0.070
> write 16 threads	 642.100	638.972	                   0.100	                 0.100
> write 32 threads	705.897 	717.598                    0.181	                 0.178
> write 64 threads	705.011 	717.204	                   0.370	                 0.362
> read 4 threads	                873.588	                841.704                    0.073	                 0.076
> read 8 threads	                816.699	                818.451	                   0.078	                 0.078
> read 16 threads	808.810                	798.053	                   0.079	                 0.080
> read 32 threads	798.394 	802.796	                   0.080	                 0.080
> read 64 threads	792.848	                790.593	                   0.081	                 0.081
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
