From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore
 performance comparison
Date: Mon, 23 Feb 2015 13:34:51 +0800
Message-ID: <CACJqLyZBKEcOxwcWEw631fUgEvVi6au1gh-7tu9BpDvqkQQF-Q@mail.gmail.com>
References: <54E37C3D.5030702@redhat.com>
	<CAC6JEv_WF9BANF_n7fPWmHFNYAKjizfV=0sHwJmKrP-uNGRfCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34285 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbBWFew (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Feb 2015 00:34:52 -0500
Received: by pdjg10 with SMTP id g10so22941029pdj.1
        for <ceph-devel@vger.kernel.org>; Sun, 22 Feb 2015 21:34:52 -0800 (PST)
In-Reply-To: <CAC6JEv_WF9BANF_n7fPWmHFNYAKjizfV=0sHwJmKrP-uNGRfCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I don't have detail perf number for sync io latency now.

But a few days ago I did single OSD single io depth benchmark. In
short, Firefly > Dumpling > Hammer per op latency.

It's great to see Mark's benchmark result! As for pcie ssd, I think
ceph can't make full use of it currently for one OSD. We may need to
mainly focus on sata-ssd improvments.

On Mon, Feb 23, 2015 at 1:09 PM, Gregory Farnum <greg@gregs42.com> wrote:
> On Tue, Feb 17, 2015 at 9:37 AM, Mark Nelson <mnelson@redhat.com> wrote:
>> Hi All,
>>
>> I wrote up a short document describing some tests I ran recently to look at
>> how SSD backed OSD performance has changed across our LTS releases. This is
>> just looking at RADOS performance and not RBD or RGW.  It also doesn't offer
>> any real explanations regarding the results.  It's just a first high level
>> step toward understanding some of the behaviors folks on the mailing list
>> have reported over the last couple of releases.  I hope you find it useful.
>
> Do you have any work scheduled to examine the synchronous IO latency
> changes across versions? I suspect those are involved with the loss of
> performance some users have reported, and I've not heard any
> believable theories as to the cause. Since this is the first set of
> results pointing that way on hardware available for detailed tests I
> hope we can dig into it. And those per-op latencies are the next thing
> we'll need to cut down on, since they correspond pretty directly with
> CPU costs that we want to scale down! :)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
