From: huang jun <hjwsm1989@gmail.com>
Subject: rm directory slow, client read it local cache
Date: Wed, 20 Jul 2011 19:16:07 +0800
Message-ID: <CABAwU-YcMdTpZy9iCjPyDn_+Vp+4wWzEo1WqocghH3no-s0gtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57284 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1GTLQI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2011 07:16:08 -0400
Received: by wwg11 with SMTP id 11so4633278wwg.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2011 04:16:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
we do test about "rm directories" repeatedly, and the result confused us a lot.
build ceph v0.30 on linux-2.6.37
folllow below steps:
$ mount -t ceph 192.168.0.11:/ /mnt
$ mkdir /mnt/a
$ cd /mnt
$ rm -rf a
from the kernel client debug log, in the process "readdir a", we can't
read directory "a" in client's cache,
 trace to  soruce code , we find "(ci->i_ceph_flags &
CEPH_I_COMPLETE)" is false, so client can't do "__dcache_readdir"
function(Dir.c line 262),which was used to read data from cache.
so client sends a request to MDS to get infomation of dir "a", that
consumes much time, we can not tolerate if it needs 10s to remove 10
dirs. we are not clear that why client can't read dir "a" from it
local cache?

thanks !
