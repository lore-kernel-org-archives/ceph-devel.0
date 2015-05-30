From: shylesh kumar <shylesh.mohan@gmail.com>
Subject: Adding "chance_test_backfill_full" thrasher in the ec tasks
Date: Sat, 30 May 2015 20:57:20 +0530
Message-ID: <CAMxOGo076WPLnvo+peo=KmDpZUY2Qt34_vXMzgMQqF_TAcEWEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37696 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbbE3P1W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 May 2015 11:27:22 -0400
Received: by wifw1 with SMTP id w1so56400127wif.0
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2015 08:27:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, loic@dachary.org
Cc: ceph-devel@vger.kernel.org

Hi ,

As per discussion with loic none of the ec tests have
"chance_test_backfill_full" thrasher in the tasks, do you think it
would be a good idea to add it which can simulate disk space
scenarios.



-- 
Thanks
Shylesh
