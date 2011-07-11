From: huang jun <hjwsm1989@gmail.com>
Subject: problem of operation "rm -rf "
Date: Mon, 11 Jul 2011 18:21:51 +0800
Message-ID: <CABAwU-ZLw2GTGb4pHUxMttnO23fpwDT_uHWoUE8OVoAaYmpoKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64109 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1GKKVx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 06:21:53 -0400
Received: by wwe5 with SMTP id 5so3772429wwe.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 03:21:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi, developers
we use ceph v0.30, kernel client 2.6.37
mount ceph on /mnt
$ mkdir /mnt/a
$ cd a
$ seq 10 | xargs -i  mkdir {}
$ cd ..
$ rm -rf a
from the debug log of mds.we find
if we want remove one subdirectory in "a", we must execute readdir " a
" operation each time
so we need read dir "a" 10 times.
but in normal way, it should readdir "a" once, and remove all the
subdirectories if we use "rm -rf a".

we'd like to know how did  ceph parse command "rm -rf " ?
