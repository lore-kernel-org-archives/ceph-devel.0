From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: cephfs performance
Date: Tue, 18 Jul 2017 09:41:08 -0700
Message-ID: <CA+2bHPbSeg0t4M41XL+rdjuT2fmz8WnU1N_G0N5a2zhNNqOSng@mail.gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
 <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com>
 <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com>
 <CA+2bHPbbFttvv2Ci6W59g-raZqVCDaZgrQ-BPpYQvs_0XTcdNA@mail.gmail.com> <CAB7xdin_PNRCCqf1nO0LVb4P8fUXMJqwBqXHavrQU_VVi6SuNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36506 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdGRQlj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 12:41:39 -0400
Received: by mail-qt0-f169.google.com with SMTP id 21so20539308qtx.3
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 09:41:39 -0700 (PDT)
In-Reply-To: <CAB7xdin_PNRCCqf1nO0LVb4P8fUXMJqwBqXHavrQU_VVi6SuNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 18, 2017 at 9:17 AM, sheng qiu <herbert1984106@gmail.com> wrote:
> Hi Patrick,
>
> thanks for your quick response.
> just one concern, if disable direct I/O, multiple clients access same
> file via different mount point on different machines, will it cause
> data inconsistency?

No, but you'll still effectively have synchronous I/O because only one
writer will have write capabilities from the MDS.

-- 
Patrick Donnelly
