From: Victor Denisov <vdenisov@mirantis.com>
Subject: Questions about profiling ceph
Date: Tue, 22 Nov 2016 11:42:48 -0800
Message-ID: <CA+hcxJQQHfhGBHZkfcwn4m3Zfxwh7dPXK=tyVg1d5rw26WNp3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36013 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933961AbcKVTmt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 14:42:49 -0500
Received: by mail-ua0-f181.google.com with SMTP id b35so23592014uaa.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 11:42:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello ceph developers,

I'm learning how to profile ceph and came across this page:
http://docs.ceph.com/docs/giant/rados/troubleshooting/cpu-profiling/

The page suggests to use oprofile. I compiled oprofile version
1.1.0(http://oprofile.sourceforge.net/faq/), but it doesn't have
opcontrol binary.

Am I doing something wrong? Is it an outdated procedure for profiling?
Is there a newer one?

Thanks,
Victor.
