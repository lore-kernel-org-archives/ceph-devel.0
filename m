From: Elita Lobo <loboelita@gmail.com>
Subject: Query regarding storage of objects in ceph
Date: Tue, 6 Sep 2016 10:01:55 +0530
Message-ID: <CAA8xDw2jFn_C-Cj1mZ5w9UUxNpe3Z4SeM-2=xcUPJGOg=v4R9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35902 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbcIFEb5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 00:31:57 -0400
Received: by mail-yw0-f177.google.com with SMTP id s85so18366678ywg.3
        for <ceph-devel@vger.kernel.org>; Mon, 05 Sep 2016 21:31:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I am using Ceph in my research project and hence need to know a bit
about how it works internally.  I would be grateful if someone would
answer my queries.

 When chunks of 2 objects have to be stored on an osd, are they put
into the same file or are these chunks stored in separate file. Is
there any way I could see this data using some command? And in which
folder of the osd are they stored in?

Also, is there a way I can see the whole flow of function calls made
when a node repair is going on?

Lastly, could someone please suggest some resources ( other than docs)
which would help me understand the internal implementation and give me
an idea how to debug in ceph. (Attaching gdb to ceph daemons running
in the background etc)

Thanking you,
Yours sincerely,
Elita Lobo
