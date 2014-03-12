From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 0/3] patches for rbd
Date: Wed, 12 Mar 2014 12:24:42 +0800
Message-ID: <1394598285-17225-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33626 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbaCLEYz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 00:24:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id kp14so526868pab.33
        for <ceph-devel@vger.kernel.org>; Tue, 11 Mar 2014 21:24:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com

Hi,

I am sorry that didn't notice Jean-Tiare's mail at all, just sage's
reminds me. 

There are 3 patches, the first is optimization for rbd writing, the
remaining two are support for rbd discard. If you have completed the 
discard things, just ignore them.

Guangliang Zhao (3):
  rbd: skip the copyup when an entire object writing
  rbd: extend the operation type
  rbd: add discard support for rbd

 drivers/block/rbd.c |  190 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 154 insertions(+), 36 deletions(-)

-- 
1.7.9.5

