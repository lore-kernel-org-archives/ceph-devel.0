From: Derek Su <dereksu@qnap.com>
Subject: About the Ceph erasure pool with ISA plugin on Intel xeon CPU
Date: Thu, 6 Aug 2015 19:25:22 +0800
Message-ID: <CAKEOLWVxuURSgYP3FLRhHs=THuYK0Qy084hNxZAqERyAYy2J4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35130 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbbHFLZX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 07:25:23 -0400
Received: by pabxd6 with SMTP id xd6so42983534pab.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 04:25:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: loic@dachary.org
Cc: ceph-devel@vger.kernel.org

Dear Mr. Dachary and all,

Recently, I found your blog show the performance tests of erasure
pools (http://dachary.org/?p=3042 , http://dachary.org/?p=3665).
The results indicates the write throughput can be enhanced
significantly using Intel xeon CPU.

I tried to create an erasure pool with isa plugin, reed_sol_van
technique, and k/m=4/2 on the Intel(R) Xeon(R) CPU E3-1245 v3 @
3.40GHz machines.

However, the results of the rados benchmark showed that there was no
any difference between the jerasure and isa plugins. It seems very
strange.

Do I need to do other configurations in addition to only setting the
erasure profile?
In addition, how can I know the erasure pool is accelerated by ISA
plugin exactly? Is there any command I can use?

Thanks, :)

Derek Su.
