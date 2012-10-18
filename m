From: Christian Huang <ythuang@gmail.com>
Subject: limit of maximum number of rbd devices that can be mapped
Date: Thu, 18 Oct 2012 10:15:14 +0800
Message-ID: <CAP5wSLc0fGo03Sh0mric3pb_yNkOY=0bEkMHR0Nmq2u8F0nJAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53419 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab2JRCPP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 22:15:15 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so12991972iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 19:15:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
    what is the maximum number of rbd devices that can be mapped on a
single host?
    we recently did a test to mount a large number of rbd devices and
hit a wall around 230
    with the following message

with 230 rbd devices already mapped, the next one yielded this.
Console output
wistor@wistor-002:~$ sudo rbd map test299
add failed: (16) Device or resource busy

dmesg
[77962.346749] register_blkdev: failed to get major for rbd229

Chris.
