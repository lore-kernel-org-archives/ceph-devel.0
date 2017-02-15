From: Ken Dreyer <kdreyer@redhat.com>
Subject: documenting "nss db path"
Date: Tue, 14 Feb 2017 19:51:12 -0700
Message-ID: <CALqRxCyamzvmvBeSmF21AAfwFiBmjzMenVRdHXBwKxVHwpnPNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36073 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdBOCvO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 21:51:14 -0500
Received: by mail-vk0-f48.google.com with SMTP id t8so91804105vke.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 18:51:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The docs are a little light on the nss_db_path option.
http://docs.ceph.com/docs/master/radosgw/keystone/

I promise to write a PR if someone clues me in!

- What is the default if this option is unset? config_opts.h has an
empty string? what does that imply?

- What do we expect users to set here? /var/lib/ceph/something?

- Is this only used for RGW Keystone tokens, or more?
