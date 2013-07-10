From: Ranjan Sarpangala Venkatesh <ranjansv@soe.ucsc.edu>
Subject: Using valgrind_osd option
Date: Tue, 9 Jul 2013 18:10:42 -0700
Message-ID: <CA+bvTtnt_GZEiwHgsmW_uWvjhFxE3QxyUTWX=nM6hs5E6ikLuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:49049 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3GJBLE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 21:11:04 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so11845451wiw.4
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jul 2013 18:11:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am trying to collect memory of the OSD daemon with the following

./vstart.sh -n -x -l --valgrind_osd 'massif'

However, when I print massif.out file there is nothing

cat massif.out.15391

desc: (none)
cmd: ./ceph-osd -i 0 -c ceph.conf -f
time_unit: i
#-----------
snapshot=0
#-----------
time=0
mem_heap_B=0
mem_heap_extra_B=0
mem_stacks_B=0
heap_tree=empty

--
With regards,
Ranjan
