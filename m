From: Sylar Shen <kimulaaa@gmail.com>
Subject: The relationship between the number of cosd and memory cache
Date: Fri, 13 May 2011 16:00:05 +0800
Message-ID: <BANLkTik4ZkyWzWNKCt2LqOgy9cqjELaw2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56988 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757767Ab1EMIAG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 04:00:06 -0400
Received: by bwz15 with SMTP id 15so1925027bwz.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2011 01:00:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi developers,
I have a question between the numbers of cosd and memory cache in a server.
Here is my environment....
I got 15 servers as OSDes and each one has 8 cores CPU, 16GB RAM and
1TB*12 Disks.
I only have 1 MDS and 3 MONs(4 servers as total) and the
specifications are the same as OSDes.

I know that each cosd process would consume some memories and so does
data transmission.
In my environment, I set 10 cosd processes on each server.
My assumption is that based on my scenario, the buffer used by each
cosd would be (Total RAM-N*cosd used)/N .....(N is the number of cosd)
That is,if I assume each cosd would use 200MB RAM, so each cosd would
have about (16GB-10*200MB)/10 = 1.4GB RAM to use as buffer.
I don't know if my assumption is right or not. Please correct me if it's wrong.
"IF" my theory is right, would it be better if I set the number of
cosd to be less?
What I mean is that when I get less cosd process, each cosd would have
more memories to use as buffer and it's better?

In other words, based on my environment with 12 disks in a server, how
many numbers of cosd should I set to get the best usage of memories?
I know the more RAM, the better performance. But are there some kind
of formulas to calculate the proportions between cosd and RAM?
Thanks in advance!

-- 
Best Regards,
Sylar Shen
