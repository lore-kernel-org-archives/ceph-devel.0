From: Ning Yao <zay11022@gmail.com>
Subject: Why should we need trim_pushed_data() in handle_pull_response()
Date: Wed, 24 Feb 2016 12:00:10 +0800
Message-ID: <CALZt5jxbXJ9hit8_cvw7Fmo-VSZ5OJSyVWCyz8YrXjfgy3YDMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35473 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658AbcBXEAM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Feb 2016 23:00:12 -0500
Received: by mail-wm0-f44.google.com with SMTP id c200so250409161wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 Feb 2016 20:00:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "sjust@redhat.com" <sjust@redhat.com>

Hi, Sam
  why we need trim_pushed_data() in handle_pull_response(). I think
data_included is always a subset of recovery_info.copy_subset since
the logic in build_push_op tells us that, isn't it?


Regards
Ning Yao
