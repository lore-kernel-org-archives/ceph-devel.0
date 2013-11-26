From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: [radosgw] increase avg get time after sharding
Date: Tue, 26 Nov 2013 22:27:13 +0100
Message-ID: <CAMNMNTz8g3huG53E8pEzB5oEDqMFmRkypegZmjJ4jCzUH=5E6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:63027 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab3KZV1N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 16:27:13 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so6585944oag.26
        for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 13:27:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
We have 2 clusters with copy of objects.
On one of them we splited all large buckets (largest 17mln objects) to
256 buckets each (shards) and we have added 3 extra servers (6->9).
Old bucket was created in ceph argonaut.
Now we have dumpling.
After this operation get avg time increased almost twice:
https://www.dropbox.com/s/lbrpk6ias6r4459/avg_get_time.PNG
I found that also increased 'get_initial_lat'
Sum of this parametr on all servers in cluster:
https://www.dropbox.com/s/l90a43vf9ivw639/get_initial_lat_sum.png

Do you have an idea what is the reason?
Where can I start to search?

-- 
Regards
Dominik
