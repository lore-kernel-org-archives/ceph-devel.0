From: huang jun <hjwsm1989@gmail.com>
Subject: OSD questions
Date: Wed, 27 Jul 2011 22:39:50 +0800
Message-ID: <CABAwU-YsTz8WjPLzVZrhwJs64fYTPdAHbA2J1S1pdzMULuBM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33378 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab1G0Ojv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 10:39:51 -0400
Received: by wyg8 with SMTP id 8so1029158wyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 07:39:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello
I have two questions about OSD.
1) From the current READ ops, whether the OSD can provide the
readahead strategy? that is : the clients send MOSDOp msg  to read
some objects of a file, the msg  includes many read ops(we can define
the first Op as to read the object we wan at this time, and other Ops
is going to do readahead work), these Ops ask OSD to read some objects
ahead and OSD don't  reply to those Ops, they only need to reply the
client when got the wanted object. So, at the next time to read the
different objects of that file, it can got data from OSDs' cache,that
will promote read performance.  All the readahead work was done
internal OSD cluster.
2) ceph use osd journal to keep perfect stability, but that decrease
the write performance as we see, can we  record just metadata of the
WRITE op in journal write item, but not the whole data buffer,in that
way we can reponse client quickly. If the OSD crashed, we can replay
the journal, but at this time we need to request data from CLIENT,
which increase the complexity.
