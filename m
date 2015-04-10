From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: partial acks when send reply to client to reduce write latency
Date: Fri, 10 Apr 2015 14:38:09 +0800
Message-ID: <CANE=7sWb_0o=NPR3O-yVjoGJyy_Oye0TFXt82FsTccH4R0BBcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vn0-f44.google.com ([209.85.216.44]:43859 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbbDJGiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Apr 2015 02:38:10 -0400
Received: by vnbg7 with SMTP id g7so3174953vnb.10
        for <ceph-devel@vger.kernel.org>; Thu, 09 Apr 2015 23:38:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

    Now, ceph should received all ack message from remote and then
reply ack to client, What

about directly reply to client if primary has been received some of
them. Below is the request

trace among osd. Primary wait for second sub_op_commit_rec msg for a long time.

    Does it make sense?

                [
                    { "time": "2015-04-10 10:40:15.373835",
                      "event": "waiting_for_osdmap"},
                    { "time": "2015-04-10 10:40:15.375143",
                      "event": "reached_pg"},
                    { "time": "2015-04-10 10:40:15.375210",
                      "event": "started"},
                    { "time": "2015-04-10 10:40:15.375234",
                      "event": "started"},
                    { "time": "2015-04-10 10:40:15.375432",
                      "event": "waiting for subops from [34,20]"},
                    { "time": "2015-04-10 10:40:15.375846",
                      "event": "commit_queued_for_journal_write"},
                    { "time": "2015-04-10 10:40:15.381176",
                      "event": "write_thread_in_journal_buffer"},
                    { "time": "2015-04-10 10:40:15.384739",
                      "event": "journaled_completion_queued"},
                    { "time": "2015-04-10 10:40:15.384838",
                      "event": "op_commit"},
                    { "time": "2015-04-10 10:40:15.387949",
                      "event": "op_applied"},
                    { "time": "2015-04-10 10:40:15.389616",
                      "event": "sub_op_commit_rec"},
                    { "time": "2015-04-10 10:40:20.946123",
                      "event": "sub_op_commit_rec"},
                    { "time": "2015-04-10 10:40:20.946142",
                      "event": "commit_sent"},
                    { "time": "2015-04-10 10:40:20.946157",
                      "event": "done"}]]},
-- 
Regards,
xinze
