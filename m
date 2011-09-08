From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: output file not truncated
Date: Thu, 8 Sep 2011 12:13:57 +0800
Message-ID: <CANExM-M8+-i8f38vGkv2ivQkZGu5U7ba+6S5uxpRB8jOxWOkMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42086 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab1IHEN6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 00:13:58 -0400
Received: by gxk21 with SMTP id 21so649036gxk.5
        for <ceph-devel@vger.kernel.org>; Wed, 07 Sep 2011 21:13:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Finally got some time to play around ceph.
I found that: when I dumped osd status by: ceph osd dump -o
/tmp/dump.json --format=json, I got some garbage data in the end of
file.
Thus, I checked the code. I noticed that the output file was not
truncated in ceph_tool_cli_input:

  // Write to a file. Don't truncate the file.
  int fd = TEMP_FAILURE_RETRY(::open(outfile, O_WRONLY|O_CREAT|O_TRUNC, 0644));

Since it seems intended, I was wondering why. After all, in my case, I
found it causing problems.

Henry
