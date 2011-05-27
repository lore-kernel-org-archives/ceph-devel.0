From: Sylar Shen <kimulaaa@gmail.com>
Subject: Quota function of radosgw
Date: Sat, 28 May 2011 00:06:37 +0800
Message-ID: <BANLkTikpoxS6ZzPJ6q9iUD9etawm24rApQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44704 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab1E0QGj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2011 12:06:39 -0400
Received: by bwz15 with SMTP id 15so1412591bwz.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 09:06:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi developers,
Recently I am testing radosgw about its functions.
Then I am curious that will radosgw implement the function or API of
quota in the future?
I've checked the mail archives and found that the quota issue had been
discussed.
And also, I know this may affect the performance of write ability.
But in most cases, administrator may want to set the quota of a bucket
for every user.
So would this function be implemented in the future?

On another hand, I know that the kernel of Ceph upgrades gradually.
I would like to know that will the performance of Ceph client and
re-exporting NFS become better if I upgrade the kernel to the latest
version?

Thanks~~~~^^
-- 
Best Regards,
Sylar Shen
