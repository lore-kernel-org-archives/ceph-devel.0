From: Gregory Farnum <greg@gregs42.com>
Subject: Re: teuthology-suite and priorities
Date: Mon, 23 Mar 2015 07:24:37 -0700
Message-ID: <CAC6JEv_zJFVGf38NE7gJTXXA244adPy3jr3Gb+-oPNnnmck-MQ@mail.gmail.com>
References: <5510211F.3020007@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35508 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbbCWOYi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 10:24:38 -0400
Received: by igcau2 with SMTP id au2so43507263igc.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 07:24:37 -0700 (PDT)
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com. [209.85.223.179])
        by mx.google.com with ESMTPSA id 130sm702327ioz.10.2015.03.23.07.24.37
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 07:24:37 -0700 (PDT)
Received: by ieclw3 with SMTP id lw3so36691275iec.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 07:24:37 -0700 (PDT)
In-Reply-To: <5510211F.3020007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Mar 23, 2015 at 7:20 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> When scheduling suites that are low priority (giant for instance at http://pulpito.ceph.com/loic-2015-03-23_01:09:31-rados-giant---basic-multi/), the --priority 1000 is set because (if I remember correctly) this is the standard priority for nightlies. However, it seems to be different because this morning the giant suite was running although a hammer suite was scheduled before it (for instance http://pulpito.ceph.com/teuthology-2015-03-22_23:18:01-multimds-hammer-testing-basic-multi/) and was still waiting.
>
> The giant suite was killed so that it does not interfere with more urgent jobs. Looking at the teuthology jobs there does not seem to be a trace of the priority, probably stored elsewhere.
>
> I would be very grateful if you could explain how priorities should be used.

I've seen a couple of oddities with suites that you've scheduled
before, and I think something in the system might not be using
timestamps properly. :) Also, the multimds suite is not an important
one right now, so feel free to zap it rather than an LTS point release
run in future.

1000 is definitely the default, and I don't have one handy to look at
right now but I think if you set a non-default priority it will show
up in one of the config files.
-Greg
