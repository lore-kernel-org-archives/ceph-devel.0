From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Proposition - latency histogram
Date: Mon, 28 Nov 2016 18:43:46 -0800
Message-ID: <fd59f41f-3ce4-eb9d-32bd-11e5d1845647@redhat.com>
References: <69bf4eec-3959-f021-ad8f-d1b6d3e2ceaf@corp.ovh.com>
 <alpine.DEB.2.11.1611281648510.28496@piezo.us.to>
 <CALe9h7fNkuNvocbhkonMOE13O1G4ygW-c0HccK-fXtX-C8CT7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753204AbcK2Cns (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 28 Nov 2016 21:43:48 -0500
In-Reply-To: <CALe9h7fNkuNvocbhkonMOE13O1G4ygW-c0HccK-fXtX-C8CT7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Sage Weil <sage@newdream.net>
Cc: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 11/28/2016 09:43 AM, John Spray wrote:
> On Mon, Nov 28, 2016 at 4:51 PM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 28 Nov 2016, Bartłomiej Święcki wrote:
>>> Hi,
>>>
>>> Currently we can query OSD for op latency but it's given as an average.
>>> Average may not give the bets information in this case - i.e. spikes can
>>> easily get hidden there.
>>>
>>> Instead of an average we could easily do a simple histogram - quantize
>>> the latency into predefined set of time intervals, for each of them have
>>> a simple performance counter, at each op increase one of them. Since
>>> those are per OSD, we could have pretty high resolution with fractional
>>> memory usage, performance impact should be negligible since only one
>>> (two if split into read and write) of those counters would be
>>> incremented per one osd op.
>>>
>>> In addition we could also do this in 2D - each counter matching given
>>> latency range and op size range. having such 2D table would show both
>>> latency histogram, request size histogram and combinations of those
>>> (i.e. latency histogram of ~4k ops only).
>>>
>>> What do you think about this idea? I can prepare some code - a simple proof of
>>> concept looks really
>>> straightforward to implement.
>>
>> This sounds like a great idea.  I think the main issue is that the data
>> won't be easily exposed via the perfcounter interface... at least not in a
>> way that generic tools can visualize.  Unless there is a standardish way
>> to report histogram metrics?
>
> Newer tools are waking up to the need for histograms, e.g. Prometheus
> has a histogram datatype:
> https://prometheus.io/docs/concepts/metric_types/#histogram
>
> Someone has done some work on adding support in grafana:
> https://github.com/grafana/grafana/issues/600
>
> Should be reasonably straightforward to add a histogram type to the
> perf counters: people might end up flattening it to a series of scalar
> time series with _bucket suffixes or whatever, but I'd definitely be
> in favour of us adding an explicit histogram type internally.

There are also existing libraries like HdrHistogram that have nice
serialized formats that could be extracted in windowed intervals for
monitoring systems, or later analysis, and have existing scripts for
graphing [0].

It also has support for correcting reporting of outliers in common 
benchmark architectures ("coordinated omission"), which would be handy
for a number of our benchmarks [1][2][3].

Josh

[0] https://hdrhistogram.github.io/HdrHistogram/
[1] 
http://psy-lob-saw.blogspot.com/2015/02/hdrhistogram-better-latency-capture.html
[2] 
http://repository.cmu.edu/cgi/viewcontent.cgi?article=1872&context=compsci
[3] 
http://www.azulsystems.com/sites/default/files/images/HowNotToMeasureLatency_LLSummit_NYC_12Nov2013.pdf
