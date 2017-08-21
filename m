From: saumay agrawal <saumay.agrawal@gmail.com>
Subject: Re: Ideas on the UI/UX improvement of ceph-mgr: Cluster Status Dashboard
Date: Tue, 22 Aug 2017 05:15:52 +0530
Message-ID: <CA+b5B08Sf5jbqN4HqjL_yg8jtAV0DU2KqRhKG2ZGGBPTe2ci+w@mail.gmail.com>
References: <CA+b5B08h7CALL-mC=O3PtFNhWeFQ113CVdEj-TNneZzy8TRVJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35675 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbdHUXqN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Aug 2017 19:46:13 -0400
Received: by mail-it0-f42.google.com with SMTP id 76so37878703ith.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Aug 2017 16:46:13 -0700 (PDT)
In-Reply-To: <CA+b5B08h7CALL-mC=O3PtFNhWeFQ113CVdEj-TNneZzy8TRVJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

As a part of my project, I have been working on the visualisation of
the OSD performance on the dashboard. Based on the community feedback
I realised that the visualisation of perf counter values against the
first few stdevs was the most needed feature for performance graphs,
along with the visualisation of minimum and maximum values.

For this, I have created a generalised prototype page, which shows the
prototypes of various graphs for a given performance counter. I also
added a separate page to the dashboard, which visualises the read and
write latency distribution of a ceph cluster.

As of now, this is a PR at https://github.com/ceph/ceph/pull/16621.
Any suggestions are welcome.

Thanks,
Saumay
