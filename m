From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: os recommendations
Date: Tue, 26 Nov 2013 11:43:07 +0100
Message-ID: <CAMNMNTz+whZWk55qCxx_8JCRWAruoHYz+stHYS93gBiU3qz3SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44502 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab3KZKnI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 05:43:08 -0500
Received: by mail-oa0-f46.google.com with SMTP id o6so5795960oag.33
        for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 02:43:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,
I found in doc: http://ceph.com/docs/master/start/os-recommendations/
"Putting multiple ceph-osd daemons using XFS or ext4 on the same host
will not perform as well as they could."

For now recommended filesystem is XFS.
This means that for the best performance setup should be 1 OSD per host?

-- 
Regards
Dominik
