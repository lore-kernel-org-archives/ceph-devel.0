From: Roland Rabben <roland@jotta.no>
Subject: Best way to store billions of files
Date: Sun, 1 Aug 2010 14:08:49 +0200
Message-ID: <AANLkTi=YSaX9tnynEHj4rS=1wOcTrmvAds7XNnZB1sGj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0HAMIv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Aug 2010 08:08:51 -0400
Received: by bwz1 with SMTP id 1so1068377bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 Aug 2010 05:08:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am researching alternatives to GlusterFS that I am currently using.
My need is to store billions of files (big and small), and I am trying
to find out if there are any considerations I should make when
planning folder structure and server config using Ceph.

On my GlusterFS system things seems to slow down dramatically as I
grow the number of files. A simple ls takes forever. So I am looking
for alternatives.

Right now my folder structrure looks like this:

Users are grouped into folders, named /000, /001, ... /999 , using a hash.
Each user has its own folder inside the numbered folders
Inside each user-folder the users files are stored in folders named
/000, /001, ... /999, also using a hash.

Would this folder structure or the ammount of files become a problem using Ceph?

I generally use 4U storage nodes with 36 x 1,5 TB or 2 TB SATA drives,
8 core CPU and 6 GB RAM. My application is write once and read many.
What recommendations would you give with regards to setting up the
filesystem on the storage nodes? ext3? ext4? lvm? RAID?

Today I am mounting all disks as individual ext3 partitions and tying
them together with GlusterFS. Would this work with Ceph or would you
recommend making one large LVM volume on each storage node that you
expose to Ceph?

I know Ceph is not production ready yet, but from the activity on this
mailing list things looks promising.

Best regards
Roland Rabben
