From: Vedant Nanda <vedant15114@iiitd.ac.in>
Subject: GSoC: Queries regarding ceph-mgr: Slow OSD identification, Automated
 cluster response
Date: Tue, 28 Mar 2017 23:25:45 +0530
Message-ID: <CAL-vruOv7qmGgSjEyeNvvVw3cOiRn_2qzQo7OYxZ9MckeseSHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33891 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbdC1Rz4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Mar 2017 13:55:56 -0400
Received: by mail-ot0-f194.google.com with SMTP id y88so10093905ota.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Mar 2017 10:55:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: kefu chai <tchaikov@gmail.com>

Hi,

I had a few doubts regarding the project:

1. We need to look at the metrics that will ultimately classify an
OSD. I'm a little confused between a metric and a root cause. Am i
right in saying that I/O stats, Network stats, Number of placement
groups served by an OSD, Number of objects stored in the OSD are all
metrics profiling an OSD?

2. "The python module will also follow predefined policies to help
administrator to address the problem."
What do we mean by predefined policies here ? Would laying down these
possibilities require the knowledge of the root cause of a slow OSD?

Clarifying these doubts will help me improve my proposal.

I have a draft of the proposal
here(https://docs.google.com/document/d/1dPrijkn8-5l4TL6C2TCORivtz_TpeccurNTI4qnFyS0/edit?usp=sharing).
Any feedback is appreciated :)

Cheers,
Vedant
