From: Sylar Shen <kimulaaa@gmail.com>
Subject: Management of radosgw
Date: Fri, 8 Apr 2011 21:18:03 +0800
Message-ID: <BANLkTikFSByoz-BNQFaw7WSh5R0aZEcWew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46236 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab1DHNSF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 09:18:05 -0400
Received: by bwz15 with SMTP id 15so2824662bwz.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2011 06:18:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
Recently I am testing radosgw and there are some questions that came
up in my mind.
I observed that radosgw stores the records of user accounts or
metadata of files in MDS.
But it seems that radosgw stores them in the form of pieces which I
cannot get a readable information by typing a command.
I am curious that is there a way I can manage the records of radosgw?
For example, if I want to know how many users are there in radosgw and
the detail information of each user(ID, access key, secret key).
Or if I want to know a user about the information of directories or
files he created.
Are there some commands that I can use to see the information that I
want to see?
Thank in advance!
ps: please correct me if I said something wrong about radosgw.
-- 
Best Regards,
Sylar Shen
