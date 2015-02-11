From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Standardization of perf counters comments
Date: Wed, 11 Feb 2015 10:02:49 -0800
Message-ID: <CAC6JEv-YDNstmoGBFG0yNhgw5DOkTCDY2=2bKK1z-5Az4hqfKQ@mail.gmail.com>
References: <loom.20150211T183150-492@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35215 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbbBKSCu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 13:02:50 -0500
Received: by iecrl12 with SMTP id rl12so3506159iec.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 10:02:50 -0800 (PST)
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com. [209.85.213.180])
        by mx.google.com with ESMTPSA id w9sm6516564igl.0.2015.02.11.10.02.49
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 10:02:49 -0800 (PST)
Received: by mail-ig0-f180.google.com with SMTP id b16so6184219igk.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 10:02:49 -0800 (PST)
In-Reply-To: <loom.20150211T183150-492@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiseleva <akiselyova@mirantis.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 11, 2015 at 9:33 AM, Alyona Kiseleva
<akiselyova@mirantis.com> wrote:
> Hi,
> I would like to propose something.
>
> There are a lot of perf counters in different places in code, but the most
> of them are undocumented. I found only one commented counter in OSD.cc code,
> but not for all metrics. Name of counter is not very clear as it's
> description, sometimes isn't at all.
>
> So, I have an idea, that it would be great, if perf schema would contain not
> only the counter type, but some description too. It can be added in
> PerfCountersBuilder methods - at first as optional parameter with empty
> string by default, later, may be, as required parameter. This short
> description could be saved in perf_counter_data_any_d struct together with
> other counter properties and appear in perf schema as the second counter
> property.

I actually suspect that we'll be more successful if the description is
not optional. That way people are forced to provide a string of some
kind, instead of not knowing that it's even an option to do so. It's
more up-front work to provide a description for all the counters but
should make everything a lot more accessible to users than saying
"well, *some* of them have descriptions, if we were feeling
conscientious that day and knew about doing so". ;)
-Greg
