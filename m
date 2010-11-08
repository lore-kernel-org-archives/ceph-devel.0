From: Ravi Pinjala <pstatic@gmail.com>
Subject: questions about weight
Date: Sun, 7 Nov 2010 23:52:54 -0800
Message-ID: <AANLkTi=_qKOzX4KgB8eA1b+Gq-A1botpix=vv-9WCYQS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39174 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab0KHHwz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Nov 2010 02:52:55 -0500
Received: by bwz11 with SMTP id 11so4533605bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 07 Nov 2010 23:52:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

First off: what does weight actually mean in a CRUSH map? I had
assumed it was there to balance capacity, and should be set to
something proportional to the size of the disk. However, the page on
the wiki about osd_auto_weight seems to indicate that it's related to
disk performance, not size. Is it one of these, or something
completely different?

Also: when defining several levels of buckets, how does the weight on
the higher levels of buckets affect the overall distribution? I've got
the beginning of a cluster running now, with one host with a 640GB
drive and a 1TB drive, and another host with a 640GB drive. I've been
playing with the weights to try and get the amount of data on each
disk proportional to its size, to maximize the space I have available.
I have my CRUSH map set up like this right now:

host0 {
    item device 0 weight 0.640
    item device 1 weight 1.000
}

host1 {
    item device 2 weight 0.640
}

root {
    item host0 weight 1.640
    item host1 weight 0.640
}

Will this do what I'm expecting, and maximize the amount of data I can
store before any of the disks fill up?

Thanks,
--Ravi
