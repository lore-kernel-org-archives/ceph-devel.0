From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Negative degradation?
Date: Tue, 30 Jul 2013 10:20:58 +0200
Message-ID: <CAN04cT7aidUFqHLPhQcT6s-A51KMQxY8hVNoOBYT9aobxTmjAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:60819 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3G3IU7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 04:20:59 -0400
Received: by mail-oa0-f51.google.com with SMTP id h2so3282984oag.10
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 01:20:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Came across it this morning when booting my development environment,
has anyone seen this before?

It's with 0.67-rc2;

2013-07-30 08:09:09.230349 mon.0 [INF] pgmap v4172: 1216 pgs: 123
active, 219 active+clean, 161 active+clean+replay, 713 peering; 241 MB
data, 630 MB used, 5483 MB / 6114 MB avail; -2/588 degraded (-0.340%)
2013-07-30 08:09:11.967368 mon.0 [INF] pgmap v4173: 1216 pgs: 187
active, 669 active+clean, 161 active+clean+replay, 199 peering; 241 MB
data, 631 MB used, 5482 MB / 6114 MB avail; -2/588 degraded (-0.340%)
2013-07-30 08:09:12.983522 mon.0 [INF] pgmap v4174: 1216 pgs: 64
active, 991 active+clean, 161 active+clean+replay; 241 MB data, 626 MB
used, 5487 MB / 6114 MB avail
2013-07-30 08:09:16.608991 mon.0 [INF] pgmap v4175: 1216 pgs: 1055
active+clean, 161 active+clean+replay; 241 MB data, 626 MB used, 5487
MB / 6114 MB avail
2013-07-30 08:09:47.985946 mon.0 [INF] pgmap v4176: 1216 pgs: 1117
active+clean, 99 active+clean+replay; 241 MB data, 626 MB used, 5487
MB / 6114 MB avail
2013-07-30 08:09:52.457863 mon.0 [INF] pgmap v4177: 1216 pgs: 1204
active+clean, 12 active+clean+replay; 241 MB data, 626 MB used, 5487
MB / 6114 MB avail
2013-07-30 08:09:53.488936 mon.0 [INF] pgmap v4178: 1216 pgs: 1216
active+clean; 241 MB data, 626 MB used, 5487 MB / 6114 MB avail
