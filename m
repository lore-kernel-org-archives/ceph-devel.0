From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: migrating dmcrypt keys ?
Date: Mon, 20 Feb 2017 14:49:37 -0500
Message-ID: <CAGbvivJVPkqdMhWuf=5Lx6DSi9UR9aYnAGtqT7K23NO31y_bPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38869 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdBTTtj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 14:49:39 -0500
Received: by mail-it0-f54.google.com with SMTP id y135so27978380itc.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2017 11:49:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Is it possible to migrate a legacy (i..e pre-Jewel) osd device that
was originally setup with dmcrypt keys in /etc/ceph/dmcrypt-keys to
use the newer osd-lockbox scheme without having to destroy the osd and
re-prepare it?

Thanks
