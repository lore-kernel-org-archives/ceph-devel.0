From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore
 performance comparison
Date: Sun, 22 Feb 2015 21:09:39 -0800
Message-ID: <CAC6JEv_WF9BANF_n7fPWmHFNYAKjizfV=0sHwJmKrP-uNGRfCQ@mail.gmail.com>
References: <54E37C3D.5030702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44450 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbbBWFJk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Feb 2015 00:09:40 -0500
Received: by iecar1 with SMTP id ar1so20786879iec.11
        for <ceph-devel@vger.kernel.org>; Sun, 22 Feb 2015 21:09:39 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id t1sm7274323igs.0.2015.02.22.21.09.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2015 21:09:39 -0800 (PST)
Received: by iecrp18 with SMTP id rp18so20861638iec.1
        for <ceph-devel@vger.kernel.org>; Sun, 22 Feb 2015 21:09:39 -0800 (PST)
In-Reply-To: <54E37C3D.5030702@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Feb 17, 2015 at 9:37 AM, Mark Nelson <mnelson@redhat.com> wrote:
> Hi All,
>
> I wrote up a short document describing some tests I ran recently to look at
> how SSD backed OSD performance has changed across our LTS releases. This is
> just looking at RADOS performance and not RBD or RGW.  It also doesn't offer
> any real explanations regarding the results.  It's just a first high level
> step toward understanding some of the behaviors folks on the mailing list
> have reported over the last couple of releases.  I hope you find it useful.

Do you have any work scheduled to examine the synchronous IO latency
changes across versions? I suspect those are involved with the loss of
performance some users have reported, and I've not heard any
believable theories as to the cause. Since this is the first set of
results pointing that way on hardware available for detailed tests I
hope we can dig into it. And those per-op latencies are the next thing
we'll need to cut down on, since they correspond pretty directly with
CPU costs that we want to scale down! :)
-Greg
