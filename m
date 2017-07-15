From: saumay agrawal <saumay.agrawal@gmail.com>
Subject: UI/UX Improvement of dashboard
Date: Sat, 15 Jul 2017 12:24:11 +0530
Message-ID: <CA+b5B0-pR1GA_veBD6Jy4qBgN=ObULdZg80r2qsAyiza-RUx4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34595 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdGOGyc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Jul 2017 02:54:32 -0400
Received: by mail-io0-f175.google.com with SMTP id r36so24220138ioi.1
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jul 2017 23:54:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Thanks, Sage and John for your suggestions. I have created mockups for
the same. I'm sorry, it took time to get back with these mock-ups. I
had got stuck due to some unfortunate reasons.

For the Latency graphs, I have prepared two mock-ups.
1. https://drive.google.com/open?id=0ByXy5gIBzlhYNlh4bGVVc0dnUkE
2. https://drive.google.com/open?id=0ByXy5gIBzlhYOG15XzJtelhWcGM

In both of the mock-ups, I have taken into consideration two stdevs on
both sides of the mean. This divides the graph into five areas. Any
values in the top most area may be considered as an indicator of poor
performance. Similarly, any values in the lower most region can be
taken as a good performance indicator. The middle region shows the
values close to the average value.

The first mock-up shows the stdevs for each set of latency values of
all osds at a given time instant. However, this creates a very
confusing graph. The second mockup solves this issue but I don't know
how to achieve that. For illustration purposes, I have taken the
average of the four stdevs respectively from my sample data which
corresponds to 20 instants of time. Since we can't set any specific
values for categorization of latency values, we cannot create such
divisions. The chart will keep on fetching the values and will be
presenting them. I can't use the average technique for such
representation, as every time the graph will fetch a value, the
average values will also change. Thus ultimately, we get the graph
like first mockup only. Any suggestions to make something even nearly
like the second mock-up possible will be helpful.

Another set of mockups is for the version report, which John asked me to do.
1. https://drive.google.com/open?id=0ByXy5gIBzlhYWUppWnB4cVd3NzQ
2. https://drive.google.com/open?id=0ByXy5gIBzlhYUFRmbzFrY2piemc

The dashboard will link to this page in case of a health warning. In
the first section, we can show a summary of the versions detected like
date of release, major improvements made since that version (for old
versions) etc. Whenever the user hovers or clicks over a slice of a
chart, we can display the list of clients having that version (similar
to a table already present in the dashboard). The way of showing the
list is at our discretion. It can be a pop-up, a collapsible drop down
element or a permanent information box. Suggestions for improvement on
this too are welcomed.

Regards,
Saumay.
