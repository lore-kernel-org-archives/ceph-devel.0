From: huang jun <hjwsm1989@gmail.com>
Subject: osd deployment affects samba read performance
Date: Tue, 11 Oct 2011 20:14:01 +0800
Message-ID: <CABAwU-afNz4NDyKAGz+9OiFH57WQ0AsPi4HCOTM6B+OjAnsoYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52910 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab1JKMOD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 08:14:03 -0400
Received: by qyk7 with SMTP id 7so6408848qyk.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2011 05:14:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
Recently, we test the samba read performance,and find something strange.
there are two groups to test:
the cluster include 1 MON and 1 MDS,and
1) 2 OSDs on the same machine
2) 2 OSDs on the different machine
when we use samba to test read,
in the first condition  it is about 110MB/s, but in the second
condition it is only 60MB/s.

we anlysed it from the debug log /var/log/ceph/osd.*.log,
in the condition 1), the OSD spends about 7~8ms (from sending
osd_op_reply to getting the next client read request)
but in 2) we spends about 12~14ms.
we can not find anything else that would result in the different read
performance between  the two conditions.
so if you, the developers have tested it?
is it related to the connection(session) type between client and OSD?
now the clients only have the short connection with OSD.

thanks!
