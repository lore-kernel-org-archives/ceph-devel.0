From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: [GSOC] ceph-mgr: Cluster Status Dashboard
Date: Sat, 20 May 2017 00:40:10 +0800
Message-ID: <CAEYCsVK-4wSUJb_EBuaJr3+U2Dzbu9ASsJRrgCxJDLN5Fn9Vzg@mail.gmail.com>
References: <CA+b5B08BdnpZvbnWS+ocr2oObG4moc0nGibGwm6Taq9Eh=46wg@mail.gmail.com>
 <CALe9h7esz4MquzA6ZqCniOj8jb=j+7QdhnSkLTj+2d9HCyYtFw@mail.gmail.com>
 <CA+b5B089q0sbcF07Di2-4JroUjZNNekvAa2SeOQvWgB7X8wqaQ@mail.gmail.com>
 <CAEYCsVLV7zA+9-9D-LGe=Myub4Qf49fUDdMOdDrA7DD6411DDw@mail.gmail.com>
 <alpine.DEB.2.11.1705191215090.3646@piezo.novalocal> <CABZ+qqmeEDVQFy3X7YZ1jn8UzgniF+4pi1p77fxcgrNeBCNg0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33452 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdESQkL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 12:40:11 -0400
Received: by mail-yw0-f179.google.com with SMTP id p73so26678171ywp.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 09:40:11 -0700 (PDT)
In-Reply-To: <CABZ+qqmeEDVQFy3X7YZ1jn8UzgniF+4pi1p77fxcgrNeBCNg0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Sage Weil <sage@newdream.net>, saumay agrawal <saumay.agrawal@gmail.com>, John Spray <jspray@redhat.com>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

>(c) makes the nervous.  You shouldn't need to consume daemonperf output;
>the 'ceph daemon <name> perf dump' provides the same (and more) data in
>json form.

Yes, we do use "perf dump" but borrow the code pieces from daemonperf
to parse the result, you may need to sub, max, or calc interval
average, based on the counter's type.

Prometheus is a MUST for such use case as it can do histogram and
enable us to show percentile (like 95% commit latency) on dashboard,
it is the only way to read 1000+ osd's metrics.

2017-05-19 20:22 GMT+08:00 Dan van der Ster <dan@vanderster.com>:
> On Fri, May 19, 2017 at 2:18 PM, Sage Weil <sage@newdream.net> wrote:
>> I'm also curious how the grafana dashboards are built (I haven't used
>> Grafana before).  Is this the sort of thing where the dashboards can be
>> developed and managed in source control?  It would be great to have a
>> bunch of pre-built and collaboratively developed Ceph dashboards!
>
> A grafana dashboard is described by a json file, which can exported
> and shared, e.g. at https://grafana.com/dashboards
>
> -- dan
