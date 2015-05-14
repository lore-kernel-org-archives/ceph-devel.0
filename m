From: Michal Jarzabek <stiopa@gmail.com>
Subject: Problem running make check
Date: Thu, 14 May 2015 21:24:23 +0100
Message-ID: <CAEFDAA5BroNoMvR8Yyvf+nj_0RJa20gkCUhJo3zrbvYNYa5w1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34975 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965178AbbENUYY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 16:24:24 -0400
Received: by wicmx19 with SMTP id mx19so31876588wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 13:24:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

After cloning ceph repo and then running:
./autogen.sh
./configure
make -j 8
make check

make check always hangs after following lines:
LD_PRELOAD=liblttng-ust-fork.so
PASS: unittest_texttable
LD_PRELOAD=liblttng-ust-fork.so
PASS: unittest_on_exit
LD_PRELOAD=liblttng-ust-fork.so
PASS: unittest_readahead
LD_PRELOAD=liblttng-ust-fork.so
PASS: unittest_tableformatter
LD_PRELOAD=liblttng-ust-fork.so
PASS: unittest_bit_vector
LD_PRELOAD=liblttng-ust-fork.so
PASS: ceph-detect-init/run-tox.sh
LD_PRELOAD=liblttng-ust-fork.so

Any idea what might be a problem?

Thanks,
Michal
