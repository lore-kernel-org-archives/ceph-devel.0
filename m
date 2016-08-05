From: Brad Hubbard <bhubbard@redhat.com>
Subject: objdump -rdS <executable>
Date: Fri, 5 Aug 2016 18:00:41 +1000
Message-ID: <20160805080041.GE13687@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33278 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758725AbcHEIAv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 04:00:51 -0400
Received: by mail-pf0-f175.google.com with SMTP id y134so95046293pfg.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 01:00:51 -0700 (PDT)
Received: from rskikr.localdomain (211.b.001.sop.iprimus.net.au. [211.27.132.211])
        by smtp.gmail.com with ESMTPSA id r10sm25547714pfk.84.2016.08.05.01.00.47
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Aug 2016 01:00:49 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This command used to take several minutes to run on ceph-mon or ceph-osd.
Currently, on recent versions of Debian and Fedora it can take closer to an
hour to run this command on ceph-osd on my laptop and over half an hour on a
reasonably powerful server.

I believe, but don't know, that this is an issue with objdump and not ceph and
I am happy to pursue this further (and will) but I'm wondering if it is time
to revisit the message we print with every crash dump?

"NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this."

This is not true in all cases such as where we know exactly which binary for
which arch and OS was in use and, at least for now, it would be quicker and
easier to just upload the binary anyway. It is also not true in the event we
have a core file and can determine which binary was in use.

Is it time to take another look at this and perhaps, as Kefu suggested, merely
print the URL of a page which outlines steps and requirements for post-mortem
debugging?

-- 
Cheers,
Brad
