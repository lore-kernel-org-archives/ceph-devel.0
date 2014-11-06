From: xinxin shu <xinxin.shu5040@gmail.com>
Subject: ceph osd start process
Date: Thu, 6 Nov 2014 15:09:24 +0800
Message-ID: <CAF7cUg1A_k1rtR41Ps27TftGHd7dLDrQ-QqEg+1T1Xagaa7FsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:61226 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaKFHJp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Nov 2014 02:09:45 -0500
Received: by mail-yh0-f45.google.com with SMTP id f10so1110416yha.32
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 23:09:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi all ,

i want to find out how ceph osd daemon start , first i use "mkcephfs"
to initialize the osd data directory , i found that there are some
files and directories (commit_op_seq  meta  nosnap  omap) in current
directory ,  but no pg directories , then i start ceph osd daemon , pg
directories are created , but i do not know when and where these pg
directories are created , can someone tell more details about how
these pg are created and where i can locate the code of pg creation?
any tips will be appreciated.
