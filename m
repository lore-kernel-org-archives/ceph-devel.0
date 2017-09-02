From: Two Spirit <twospirit6905@gmail.com>
Subject: "Unhandled exception in thread started by" ceph-deploy admin
Date: Sat, 2 Sep 2017 08:02:51 -0700
Message-ID: <CAKRxpuvvV9WTuKkWr=_B5dekLw3CqDLF=tzWdgw4fM9Sx7SSCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:38666 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbdIBPCw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Sep 2017 11:02:52 -0400
Received: by mail-io0-f175.google.com with SMTP id q64so1940426iod.5
        for <ceph-devel@vger.kernel.org>; Sat, 02 Sep 2017 08:02:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I upgraded a production server from Ubuntu 15.04 to a fresh install of
16.04 LTS. running luminous

It is a brand new OS. I installed it I think almost identical to
numerous other test OSDs servers that are running. This one system is
spitting out an error "Unhandled exception in thread started by" and
then there is no other output after. The only other change I made
different is remove systemd from one of them due to ceph complaints.

I get this error when executing ceph-deploy admin. right after the
"write cluster configuration to /etc/ceph{cluster}.conf" output

I'm not sure how to trace it further. Googling shows it generally has
been a bug with some python code. it seems to say it is a bug but
Bug#8509 and #9248 are slightly different.
