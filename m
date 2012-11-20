From: hemant surale <hemant.surale@gmail.com>
Subject: OSD daemon changes port no
Date: Tue, 20 Nov 2012 17:09:50 +0530
Message-ID: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53744 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2KTLju (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 06:39:50 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so2243552vcm.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 03:39:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Community,
   I have question about port number used by ceph-osd daemon . I
observed traffic (inter -osd communication while data ingest happened)
on port 6802 and then after some time when I ingested second file
after some delay port no 6804 was used . Is there any specific reason
to change port no here?

   and one more thing how can it be possible to read from one osd and
then simultaneous write to direct on other osd with less/no traffic?


Regards,
Hemant Surale.
