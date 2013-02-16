From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: [ceph-users] Backups
Date: Sat, 16 Feb 2013 20:50:30 +0100
Message-ID: <CAJH6TXgZXxLC1cHTC016PpRqYSS5H=Wt=2emyzvHbGutrZuTuA@mail.gmail.com>
References: <CAJH6TXjWNmc15TZKEhyPbJ5HPKcL4EC_YBQsQtOfYJOYuk1S9Q@mail.gmail.com>
	<511FDEFB.4070908@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34201 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab3BPTuc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 14:50:32 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so3549950wgd.28
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 11:50:31 -0800 (PST)
In-Reply-To: <511FDEFB.4070908@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

2013/2/16 Stefan Priebe <s.priebe@profihost.ag>:
> I think the bigges problem is that an incremental backup is missing in ceph
> for the rados object. So you can just copy / export the changes rados
> objects from an rbd volume instead the whole volume again and every day.

Could you explain by an example?
