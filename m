From: Mustafa Muhammad <mustafa1024m@gmail.com>
Subject: Re: High memory usage kills OSD while peering
Date: Mon, 21 Aug 2017 19:05:04 +0300
Message-ID: <CAFehDbB_9NyT4xQX4_a4uLoFMmqi-zUTnZ3UdrJ9fx6E7dfJYg@mail.gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
 <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
 <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com> <59f1de4f-9d5a-323d-2d13-cf5a4cee6f34@gmail.com>
 <CACJqLyYASEkirVm1=o9Ltw+m-YkT7bqJsS554Q4M38dfOEWwgw@mail.gmail.com>
 <93debf2d-12cb-eceb-e9cd-5226ad49cc16@gmail.com> <CACJqLyaHC03P6o+MmMFCgk4-_GYxsOs4B6UVFLK6fXZVt53SCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33333 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbdHUQFG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Aug 2017 12:05:06 -0400
Received: by mail-ua0-f180.google.com with SMTP id q40so9600279uag.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Aug 2017 09:05:05 -0700 (PDT)
In-Reply-To: <CACJqLyaHC03P6o+MmMFCgk4-_GYxsOs4B6UVFLK6fXZVt53SCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Linux Chips <linux.chips@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Do you think changing osd_peering_wq_batch_size help? should we
increase it to delay peering? or that will backfire?

Regards
Mustafa
