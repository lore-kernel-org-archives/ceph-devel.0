From: Ketor D <d.ketor@gmail.com>
Subject: Performance degrad on big cluster
Date: Fri, 24 Jul 2015 01:49:44 +0800
Message-ID: <CAM9_UU_sKYrnvTeScZYh3Wi-X12zGZYXXevkW_Y-78f7rd2TpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35235 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbbGWRuO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jul 2015 13:50:14 -0400
Received: by obbop1 with SMTP id op1so159568912obb.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2015 10:50:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,
      We meet a performance degrad in one of our cluster. Our
randwrite latency degraded from 1ms to 5ms(fio -ioengine=rbd
iodepth=1)
      The cluster has about 200 osds runing on Intel 3500 SSD, we run
both qemu and ceph-osd on the hosts. The network for ceph is 10GbE.
       While the cluster is smaller and not so many qemu processes,
the IO latency is about 1ms, but now the latency is 5ms.
       I use strace to  get the time for syscall, all syscall (writev,
io_submit, recvfrom,sendmsg,lseek,fgetxattr etc.)  use 300us to 600us.
The syscall time on a small and idle cluster is near to 0us.
       After checked serval clusters, I come to a conclusion:
       num_of_osds     num_of_threads_on_host    time_of_syscall(us)
       200                     10000                                   300-600
       100                       5000                                   200-500
        70                        2500                                   100-300
         9                           750
      20-60

       The threads on one of 200 osds cluster's host is like this:
       name           num_of_processes  num_of_threads
num_of_threads_per_process
       qemu-kvm    49                              9748
        198
       ceph-osd      6                                5707
           951

       We are running Firefly 0.80.7 and 0.80.9, and qemu version is 2.1.

       I think too many threads on the host lead to high latency of
ceph-osd process, and cause to high I/O latency from the client-side.
       Anyone's help is welcome.

Thanks!
