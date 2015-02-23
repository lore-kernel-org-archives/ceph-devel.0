From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore performance
 comparison
Date: Mon, 23 Feb 2015 08:46:41 -0600
Message-ID: <54EB3D51.2080308@redhat.com>
References: <54E37C3D.5030702@redhat.com> <CAC6JEv_WF9BANF_n7fPWmHFNYAKjizfV=0sHwJmKrP-uNGRfCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbbBWOqq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Feb 2015 09:46:46 -0500
In-Reply-To: <CAC6JEv_WF9BANF_n7fPWmHFNYAKjizfV=0sHwJmKrP-uNGRfCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 02/22/2015 11:09 PM, Gregory Farnum wrote:
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

I kind of suspect that some of the user issues might be RBD on the 
client side (or even QEMU).  Certainly possible it's OSD too though. 
With so many different kinds of hardware and so many ways to tune things 
it can be tough to narrow down.  I'm really looking forward to the work 
that's being done on LTTNG tracing.  That will give us much easier 
insight into these kinds of things than we've had in the past.

> -Greg
>
