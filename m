From: Ding Dinghua <dingdinghua85@gmail.com>
Subject: Confused about SnapMapper::get_prefix
Date: Tue, 3 Feb 2015 20:12:17 +0800
Message-ID: <CANf+_kL0_tYtF+vDvLSTPP5LtP_4P6r9_M5qu7VeyP2GYfFw9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:47506 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932933AbbBCMMT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 07:12:19 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so50815019lab.6
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 04:12:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all:
      I don't understand why SnapMapper::get_prefix   static_cast snap
to unsigned:

string SnapMapper::get_prefix(snapid_t snap)
{
  char buf[100];
  int len = snprintf(
    buf, sizeof(buf),
    "%.*X_", (int)(sizeof(snap)*2),
    static_cast<unsigned>(snap));
  return MAPPING_PREFIX + string(buf, len);
}

Will this limit snapshot count in pool to 2^32 -1 ?

Could anyone clarify ? Thanks

-- 
Ding Dinghua
