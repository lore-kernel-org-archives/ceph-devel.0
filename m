From: Marcus Sorensen <shadowsor@gmail.com>
Subject: ceph/rbd benchmarks
Date: Wed, 24 Aug 2011 09:29:16 -0600
Message-ID: <CALFpzo5NuPHxqtj0qtP7mafy5TG2BTSo-2=Y+jCPsy5xUm42PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60629 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1HXP3S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 11:29:18 -0400
Received: by qwk3 with SMTP id 3so775055qwk.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2011 08:29:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just thought I'd share this basic testing I did, comparing cephfs 0.32
on 3.1-rc1 to nfs as well as rbd to iscsi. I'm sure you guys see a lot
of this. Any feedback would be appreciated.

The data is here:

http://learnitwithme.com/wp-content/uploads/2011/08/ceph-nfs-iscsi-benchmarks.ods

and the writeup is here:

http://learnitwithme.com/?p=303
