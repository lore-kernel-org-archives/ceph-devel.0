From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph issue
Date: Thu, 17 Nov 2016 14:49:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611171448450.15311@piezo.us.to>
References: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-446390585-1479394200=:15311"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937878AbcKQR2m (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Nov 2016 12:28:42 -0500
In-Reply-To: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marov Aleksey <Marov.A@raidix.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-446390585-1479394200=:15311
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT

[adding ceph-devel]

On Thu, 17 Nov 2016, Marov Aleksey wrote:
> Hello Sage
> 
> My name is Alex. I need some help with resolving issue with ceph. I have
> been testing ceph with rdma messenger and I got an error
> 
> src/log/SubsystemMap.h: 62: FAILED assert(sub < m_subsys.size())
> 
> I have no idea what it means. I noticed that you was the last one who
> committed in SubsystemMap.h so I think you have some understanding of this
> condition in assert
> 
> bool should_gather(unsigned sub, int level) {
> š assert(sub < m_subsys.size());
> š return level <= m_subsys[sub].gather_level ||
> ššš level <= m_subsys[sub].log_level;
> }
> 
> This error occurs only when I use fio benchmark to test rbd. When I use "rbd
> bench-write ..."š it is ok. But fio is much mire flexible . In any case I
> think it is not good to get any assert.
> 
> Can you explain this for me please, or give a hint where to investigate my
> trouble.

Can you generate a core file, and then use gdb to capture the output of 
'thread apply all bt'?

Thanks-
asge

--8323329-446390585-1479394200=:15311--
