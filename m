From: Mykola Golub <mgolub@mirantis.com>
Subject: osd: new pool flags: noscrub, nodeep-scrub
Date: Fri, 11 Sep 2015 09:42:57 +0300
Message-ID: <20150911064256.GA12899@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38841 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbIKGnA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 02:43:00 -0400
Received: by wiclk2 with SMTP id lk2so46716713wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2015 23:42:59 -0700 (PDT)
Received: from localhost ([93.183.239.2])
        by smtp.gmail.com with ESMTPSA id gc19sm612798wic.19.2015.09.10.23.42.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2015 23:42:58 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I would like to add new pool flags: noscrub and nodeep-scrub, to be
able to control scrubbing on per pool basis. In our case it could be
helpful in order to disable scrubbing on cache pools, which does not
work well right now, but I can imagine other scenarios where it could
be useful too.

Before I created a pull request, I would like to see if other people
consider this useful or may be have some other suggestions?

-- 
Mykola Golub
