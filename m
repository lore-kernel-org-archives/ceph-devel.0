From: Andy Yao <andyzzyao@gmail.com>
Subject: rgw_dynamic_resharding default enabled?
Date: Tue, 10 Oct 2017 21:59:43 +0800
Message-ID: <CAK7dNzt14ONRhSn612ahnJC3sidbkS2KwUCVh=uhcHfdy8kveA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:52102 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbdJJN7p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 09:59:45 -0400
Received: by mail-qt0-f177.google.com with SMTP id q4so51409680qtq.8
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 06:59:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

When a bucket's resharding is in progress, operations on this bucket
like putting objects will be blocked until the resharding has been
finished. It will have huge impacts on user's experience.

So is it suitable for rgw_dynamic_resharding default enabled? Would be
it better to set rgw_dynamic_resharding default value to false, and
resharding processed by hand at business suitable time?

Best wishes,
Any
