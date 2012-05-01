From: Nick Bartos <nick@pistoncloud.com>
Subject: Disabling logs in the mon data directory?
Date: Tue, 1 May 2012 16:24:11 -0700
Message-ID: <CAPud5_79Vn0xwTSB-2Zhp5sz05DmOgLCWREEP6oV3Frj=QyfCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53658 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934Ab2EAXYM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 May 2012 19:24:12 -0400
Received: by yhmm54 with SMTP id m54so53861yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 May 2012 16:24:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to get all logs going to syslog, and disable all ceph log
files.  I added the following to [global]:

    log file = ""
    log to syslog = true

Which I thought would do the trick, however I see that there are still
logs generated in the monitor data directory.  I also tried adding the
following to [global], but it doesn't seem to help:

    clog to monitors = false
    clog to syslog = true

What is the recommended way to get all logs going to syslog, and
disabling any ceph-specific log files?
