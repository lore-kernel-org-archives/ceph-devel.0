From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Ceph doesn't detect journal failure while the OSD is running
Date: Sun, 26 Aug 2012 20:09:25 +0200
Message-ID: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44790 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376Ab2HZSJq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 Aug 2012 14:09:46 -0400
Received: by lagy9 with SMTP id y9so2111373lag.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 11:09:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi guys!

Ceph doesn't seem to detect a journal failure. The cluster keeps
writing data even if the journal doesn't exist anymore.
I can find anywhere in the log or from the ceph's command output any
information about a journal failure. Obviously if an OSD is restarted
ceph will complain but a failure on fly won't be detected.

It seems that Ceph just writes directly to the backend filesystem
without complaining.

Yes my monitoring system will tell me that the disk which contains my
journals is down... But it's not the point here :)

The really good point for me is that the cluster keeps running even if
the journal is gone. The bad point is obviously that the cluster keeps
writing data to the backend filesystem (without O_DIRECT I guess...).
I'll prefer a 'read only' cluster facility while the journal is down.
Being able to retrieve the data is as crucial as writing data.

Any reaction about that? Roadmap feature maybe?

Cheers!
