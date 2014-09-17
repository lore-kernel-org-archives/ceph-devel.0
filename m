From: Cheng Wei-Chung <freeze.vicente.cheng@gmail.com>
Subject: is function get_net_marked_down right?
Date: Wed, 17 Sep 2014 13:03:24 +0800
Message-ID: <CABF_e-H+qqq+ig7KDvwwgDbnuwVVwJ_K3hspaCWozaZC8jM9qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:55371 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaIQFDY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 01:03:24 -0400
Received: by mail-oi0-f43.google.com with SMTP id v63so496003oia.16
        for <ceph-devel@vger.kernel.org>; Tue, 16 Sep 2014 22:03:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear all:

I have seen this function few days.
OSDMap::Incremental::get_net_marked_down

There is something strange I don't know why.

why we increase n when we got state and previous state is UP?
if (p->second & CEPH_OSD_UP) {
      if (previous->is_up(p->first))
        n++;  // marked down
      else
        n--;  // marked up
}

This function aims to help check whether the osd can be mark down or not, right?

For counting the osd that state is down, the above function is
counting the osd that state is up?

I would like to know there is some minor error or something I don't
really understand.

Thanks!!!!
