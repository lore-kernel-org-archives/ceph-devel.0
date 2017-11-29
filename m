From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Fwd: Questions regarding mds early reply
Date: Wed, 29 Nov 2017 10:15:56 +0800
Message-ID: <CAEYCsVJAamRkFeH_3St0dMybks97q09P4b-h0+nVrFNPy_c-BA@mail.gmail.com>
References: <CAEYCsVJCz4ecJNXyKLF0EyovJw8sLHwb_uzMBQaZVfasuuy+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:40929 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbdK2CP5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 21:15:57 -0500
Received: by mail-io0-f176.google.com with SMTP id d21so2101542ioe.7
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 18:15:57 -0800 (PST)
In-Reply-To: <CAEYCsVJCz4ecJNXyKLF0EyovJw8sLHwb_uzMBQaZVfasuuy+cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pdonnell@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

      When reading the early reply logical,  i am not very understand
why we can reply to the client before committing to journal?  Is there
anywhere the change get persisted or we rely on client-replay when MDS
failure happens?
      If this is the case, what if the client also failed during this period?

      Thanks for providing the hints.

Xiaoxi
