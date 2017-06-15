From: zengran zhang <z13121369189@gmail.com>
Subject: question on asyncmessenger::wait()
Date: Thu, 15 Jun 2017 16:12:52 +0800
Message-ID: <CALi+v182tnn88LCFUs5zu44-2Upv_z0ZAUPVsxLtmL-Tr106VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35164 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbdFOIMy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 04:12:54 -0400
Received: by mail-io0-f171.google.com with SMTP id k93so7269585ioi.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 01:12:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai <haomai@xsky.com>
Cc: ceph-devel@vger.kernel.org

Hi Haomai:

    in current implement why do not call stack->stop() in
asyncmsg::wait(), if so we could join the works. but now the works
will be joined in ~CephContext, and when _associated_objs be
deleted...
    we find that map_cache may leak some osdmapref, maybe because the
works still work when OSD destruct...

    regards!
