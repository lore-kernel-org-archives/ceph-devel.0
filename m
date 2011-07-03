From: Vineet Jain <vinjvinj@gmail.com>
Subject: Missing kernel client install instructions on wiki?
Date: Sun, 3 Jul 2011 13:33:02 -0400
Message-ID: <CAG_bnfzsj6o6DOgfg9fryu7x4nDJ5ajmaER7_=k30ZdiVxrjLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40010 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab1GCRdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Jul 2011 13:33:03 -0400
Received: by bwd5 with SMTP id 5so3608738bwd.19
        for <ceph-devel@vger.kernel.org>; Sun, 03 Jul 2011 10:33:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm following the steps on the wiki on ubuntu 11.04 (natty).

I added the package:

deb http://ceph.newdream.net/debian-snapshot-amd64/master/ natty main

and was able to install the ceph module but I'm stuck on how to
install the kernel client module. The wiki says that the kernel module
install instructions are outdated and should not be used. I tried them
and they failed. Can someone point me to the steps I need to do
install the latest ceph kernel client.

Also, I have several servers in my cluster. Is it ok to have the ceph
kernel client and ceph store nodes running on the same machine. Since
I have 4 cores on each box?
