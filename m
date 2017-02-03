From: Ming Lin <minggr@gmail.com>
Subject: understand ceph packets on the wire
Date: Fri, 3 Feb 2017 15:18:18 -0800
Message-ID: <CAF1ivSZtbb_mrSB7gdgO0sszWwZA+r95btd6_AM4VXffNyXq8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37099 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbdBCXSU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 18:18:20 -0500
Received: by mail-it0-f46.google.com with SMTP id r185so22969897ita.0
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2017 15:18:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

With a one monitor one OSD test setup(osd pool default size = 1), I
captured the packets with tshark.
pcap.out file: https://ufile.io/43c78

The test I did was:
dd if=tmp.txt bs=512 count=1 of=/dev/rbd0 oflag=direct

About 350 packets were captured just for above simple "dd" command.

If you open the file with wireshark, you'll see packet #41 is the data packet.
"192.168.122.1" is the OSD and "192.168.122.131" is the rbd client.

What are other packets?

Thanks.
