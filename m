From: Matthew Roy <imjustmatthew@gmail.com>
Subject: "dup inode" error messages on MDS restart
Date: Sat, 20 Oct 2012 09:42:56 -0400
Message-ID: <CADXA5U37_cXeLaYcCC4LM=o9YzqSr3994Jj0kS_XVS7D_1YFdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:44790 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab2JTNm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Oct 2012 09:42:57 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so664608dak.19
        for <ceph-devel@vger.kernel.org>; Sat, 20 Oct 2012 06:42:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm getting some error messages along the lines of:

2012-10-20 09:35:09.038865 mds.0 [ERR] loaded dup inode 1000001d369
[2,head] v18402 at ~mds0/stray8/1000001d369, but inode
1000001d369.head v18204 already exists at [valid file path]
2012-10-20 09:35:09.300528 mds.0 [ERR] loaded dup inode 10000007d44
[2,head] v4493 at ~mds0/stray0/10000007d44, but inode 10000007d44.head
v2220 already exists at [valid file path]
2012-10-20 09:35:09.382147 mds.0 [ERR] loaded dup inode 10000007d30
[2,head] v4462 at ~mds0/stray6/10000007d30, but inode 10000007d30.head
v2216 already exists at [valid file path]

during MDS restart (shortly after the MDS goes up:active). Any
thoughts on what to do about it?

Thanks,
Matthew
