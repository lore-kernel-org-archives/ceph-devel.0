From: Ugis <ugis22@gmail.com>
Subject: how to get io statistics data
Date: Fri, 16 Feb 2018 13:21:55 +0200
Message-ID: <CAE63xUOJzZnQ9DGrvXM2p2a8OtB3dRRg5zgxw8Z4P0fUYtR_pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:39643 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935464AbeBPLV5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Feb 2018 06:21:57 -0500
Received: by mail-it0-f50.google.com with SMTP id l187so1528357ith.4
        for <ceph-devel@vger.kernel.org>; Fri, 16 Feb 2018 03:21:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm working on zabbix template for ceph(I am aware of several existing
ones but those do not fit well for our needs).

Data form ceph is gathered from cli commands with output in format "-f
json-pretty", this works nice, but I cannot find a way to read:
1) cluster "io" data from "ceph -s" - it does not appear in
json-pretty format. This is example data:
"  io:
    client:   112 kB/s rd, 41058 B/s wr, 6162 op/s rd, 8 op/s wr"
Is there any cli command to get that "global cluster io" data in json?

2) In web GUI (monitorIP:7000/->OSD->OSDs) we see nice "Read bytes",
"Write bytes", "Read ops", "Write ops".
How can we get that data per osd in cli in json-pretty format?
I browsed the source of dashborad here
https://github.com/ceph/ceph/blob/66838565bd0830a397a4d673bb5584023ee603a5/src/pybind/mgr/dashboard/osds.html
but did not get clue are there any cli commands related.

Best regards,
Ugis
