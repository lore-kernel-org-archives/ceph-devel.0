From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: new wallclock profiler github repo
Date: Mon, 13 Nov 2017 14:37:42 -0600
Message-ID: <51cd7a83-1677-9c68-0d81-b61ad6d58071@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:44281 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755592AbdKMUhp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 15:37:45 -0500
Received: by mail-oi0-f52.google.com with SMTP id a75so6553298oib.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 12:37:44 -0800 (PST)
Received: from [192.168.1.100] (c-68-46-79-22.hsd1.mn.comcast.net. [68.46.79.22])
        by smtp.googlemail.com with ESMTPSA id g18sm5240114otd.81.2017.11.13.12.37.42
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 12:37:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Guys,

A few of you have been playing with the gdbprof fork that I made a while 
back to profile some of the OSD and client side code.  Last week I took 
a day and cleaned the code up.  I made a new repository/name for it here:

https://github.com/markhpc/gdbpmp

Some of the changes include being able to run it directly from the 
commandline or within gdb, settings the sample count and sleep time, 
filtering which threads to monitor, and saving the results so you can 
re-parse the data (not super useful now, but eventually I'll try to 
include different ways to examine the data, possibly things like 
time-based correlation of events in different threads).

Adam is looking at writing a similar wallclock profiler that would use 
libunwind directly and hopefully will be much faster, but for now 
hopefully this will be easier and more useful than the earlier attempt.

Thanks,
Mark
