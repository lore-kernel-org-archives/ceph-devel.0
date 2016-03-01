From: Rajath Shashidhara <rajath.shashidhara@gmail.com>
Subject: Interest in Implementing Cache layer on top of NVME Driver [GSoC]
Date: Tue, 1 Mar 2016 14:01:07 +0530
Message-ID: <CAFjGuFSazLzQq-AAhXyn_gyZv=fJspQuB+dA0-CY4-JjZ9gMSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34663 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcCAIbI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Mar 2016 03:31:08 -0500
Received: by mail-vk0-f53.google.com with SMTP id e185so160174104vkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 Mar 2016 00:31:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: haomai@xsky.com

Hello,

I am a GSoC' 2016 aspirant. I have browsed through your ideas page and
I find that the above project best aligns with my experience and
interest.

During the course of my academics, I have developed an interest in
development of performance critical software development. I am
familiar with the parallel and distributed computing paradigms and I
would like to gain further experience in this field.

I have experience in the development of Page buffers for efficient I/O
from secondary storage. I lead the development of External Memory
(secondary storage) data structures [1] for C++ over the last few
months. We have implemented custom buffering (modifications of the LRU
strategy) specific to each data structure. Some features of the page
buffer include - support for page pinning, priority paging (pages with
higher priority are harder to replace as compared to pages with low
priority of comparable recent access time), prefetching (strategy
specific to data structure). (It is an ongoing project and we are
expanding the number of Data structures and corresponding
optimizations)

I will familiarize myself with the architecture of Ceph, the userspace
NVME driver and the cache requirements. Please point me to the right
resources and the documentation related to this problem. It would be
great if you can suggest me a bug to fix or any contribution that
would help me understand the underlying source code.

Note : I have successfully completed GSoC' 2013 with Apache OpenOffice.

Thank you,
Rajath Shashidhara

[1] https://github.com/ExternalMemoryDS/external-mem-ds
