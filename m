From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: Is it possible to restrict to map rbd image on different client hosts
 same time?
Date: Tue, 8 Aug 2017 12:42:25 +0300
Message-ID: <95c441d8-007c-8e2e-3767-1b85ec8453f0@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:32900 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdHHJm3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 05:42:29 -0400
Received: by mail-lf0-f51.google.com with SMTP id d17so12469990lfe.0
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 02:42:28 -0700 (PDT)
Received: from [172.20.8.235] ([86.57.155.118])
        by smtp.gmail.com with ESMTPSA id f78sm137206lji.45.2017.08.08.02.42.26
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 02:42:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello

I've just created a bug about list of watchers of rbd image and list of 
clients actually using this rbd image: http://tracker.ceph.com/issues/20943

During reproducing of this bug several questions raised:

1) Does watcher in rbd status output should be treated as 100% reliable 
mark that disk was mapped?

2) And in other way: Does watcher absence should be treated as 100% 
reliable mark that disk was not mapped?

3) And finally: Is it possible to restrict to map disk on several 
clients in the same time (exclusive mapping)?



Thanks!

-- 
Aleksei
