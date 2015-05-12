From: huang jun <hjwsm1989@gmail.com>
Subject: how to print bad crc data message body to logfile
Date: Tue, 12 May 2015 22:53:59 +0800
Message-ID: <CABAwU-ZNTo==+H-RjsUP8Zp_0FMMGrzH6Ao3uXFOEXSD=8aVZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35416 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbbELOyB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 10:54:01 -0400
Received: by labbd9 with SMTP id bd9so7886630lab.2
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 07:53:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
we see the bad data crc warning and we have set debug_ms=20, but the
message body doesn't logged into /var/log/ceph/ceph-osd.x.log file.
Did i miss something? or i need to change the buffer::list::hexdump()
function and recompile it?

-- 
thanks
huangjun
