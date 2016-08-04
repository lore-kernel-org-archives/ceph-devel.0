From: Sugang Li <sugangli@winlab.rutgers.edu>
Subject: Read from replicas
Date: Thu, 4 Aug 2016 14:20:25 -0400
Message-ID: <CAG0LszkWXOE4zoSNuNeKbnWt5MakGVxDhZJ3og6seh7VtwP5Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33636 "EHLO
	mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933852AbcHDSU0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2016 14:20:26 -0400
Received: by mail-qt0-f172.google.com with SMTP id w38so163027171qtb.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Aug 2016 11:20:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I noticed that Ceph provides the capability to read from replica
instead if Primary OSD, but it is not by default. I am just wondering
if there is any configuration/hacking tutorial that I can take a look?

Thanks,

Sugang
