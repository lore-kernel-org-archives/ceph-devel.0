From: Ning Yao <zay11022@gmail.com>
Subject: About BUG #16279
Date: Fri, 2 Sep 2016 10:44:30 +0800
Message-ID: <CALZt5jygWSRUBh4uJS1O69zw4ZageJ+pg4nkxUuByyRrqsQsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36357 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbcIBCoc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Sep 2016 22:44:32 -0400
Received: by mail-qt0-f175.google.com with SMTP id 52so52010090qtq.3
        for <ceph-devel@vger.kernel.org>; Thu, 01 Sep 2016 19:44:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

we got the same issue http://tracker.ceph.com/issues/16279

I think it is possible objiter->second->version == last_divergent_update?

If olog is [200'5 ~ 200'10, 202'11~ 202'20] with object A: [200'5, 200'8]
   log is [200'3 ~ 200'11], object A : [200'5, 200'8]

Then after merge log os [200'3 ~ 200'10, 202'11~202'20] with divergent entry:
object A: 200'5 and 200'8

first_divergent_update will be 200'5 and last_divergent_update will be
200'8 for object A. If can find it in current log, and the possible
version the object A is equal or greater than 200'8.  So I am not sure
it must be greater than last_divergent_update but may be equal?

Am I missing something else?

Regards
Ning Yao
