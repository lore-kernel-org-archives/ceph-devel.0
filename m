From: Jin Cai <caijin.laurence@gmail.com>
Subject: Wrong crush map after all OSDs down
Date: Sat, 14 Jan 2017 23:59:06 +0800
Message-ID: <CAGRcXKaE8LDzbAvwOBy1uWsaDRd_phOdA8Ek6NNMQ8spJvs_PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34364 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdANP7I (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2017 10:59:08 -0500
Received: by mail-ua0-f175.google.com with SMTP id 35so56241641uak.1
        for <ceph-devel@vger.kernel.org>; Sat, 14 Jan 2017 07:59:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@redhat.com

Hi all,
I deployed a ceph cluster with jewel in four physical machines.
Three physical machines were used for OSD and each of them had eight
OSDs. The left one was used to serve as a monitor.
At first, everything worked well.
By the reason of test, I stopped all the OSD daemon and double checked
no OSD process running.
After that, I executed ceph -s and got the following output:
 osdmap e164: 24 osds: 7 up, 7 in
No matter how much time elapsed, the output didn't change.

The expected output should be:
osdmap e164: 24 osds: 0 up, 0 in

I think it is the matter of synchronisation between OSDs and monitor
Would you like you explain this strange phenomenon for me.
Thanks a bunch in advance.
