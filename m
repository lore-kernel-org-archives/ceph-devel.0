From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Is there any way to collect object-level I/O access traces in Ceph?
Date: Fri, 16 Jan 2015 17:20:07 -0800
Message-ID: <CAC6JEv-zgUxE3h8RwYHc3TajVySrgbCczJChPHncBCJ33F6rXw@mail.gmail.com>
References: <CAJqA8gsUn19CDswyeYiQj9Ex0vaQeybvBVDOx3nG2w70_esCAg@mail.gmail.com>
	<CAC6JEv8-BE=+p_h54z__bAf5vev8jJttBf5nBw8PNm6w8nJw9Q@mail.gmail.com>
	<CAJqA8gu1bdgEzR29k0Z4JaRrweYhc2=vXW9KDKrqX1yEGVxsxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:52965 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbbAQBUJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 20:20:09 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so6324616igj.4
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 17:20:08 -0800 (PST)
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com. [209.85.223.170])
        by mx.google.com with ESMTPSA id n4sm2353786igr.15.2015.01.16.17.20.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 17:20:07 -0800 (PST)
Received: by mail-ie0-f170.google.com with SMTP id rd18so23679993iec.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 17:20:07 -0800 (PST)
In-Reply-To: <CAJqA8gu1bdgEzR29k0Z4JaRrweYhc2=vXW9KDKrqX1yEGVxsxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lipeng Wan <lipengwan86@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

If you're looking at what objects the MDS touches, it's probably
easiest to set "debug ms = 1" in the mds config file. Then you can
grep out the outgoing message lines and sed out the actual objects
they're hitting.

Something like the upcoming tracepoints would be easier to program
against, but the MDS hits the Objecter directly so I'm not sure if
they'd work.
-Greg

On Fri, Jan 16, 2015 at 4:06 PM, Lipeng Wan <lipengwan86@gmail.com> wrote:
> Hi Greg,
>
> Thanks for your reply.
> I found that in /var/log/ceph directory on each node, there are
> several log files in it,
> such as ceph-client.admin.log, ceph-mds.ceph-node1.log, etc., which
> log file should I look at? Maybe the "ceph-mds.ceph-node1.log"?
> Specifically, is there any keyword I can search in the log file to
> locate the object operations?
> Thanks!
> LW
>
> On Fri, Jan 16, 2015 at 4:21 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> On Fri, Jan 16, 2015 at 11:28 AM, Lipeng Wan <lipengwan86@gmail.com> wrote:
>>> Dear all,
>>>
>>> Does Ceph provide a way to collect object-level I/O access traces?
>>> Specifically, can we collect the traces to record how many times each
>>> object has been accessed (read, write, etc.) during a fixed period of
>>> time?
>>
>> I don't think we have any programmatic access, but depending on what
>> you need it for you could enable messenger logging (or filestore
>> logging, depending on what exactly you want) and count the references
>> there.
>> -Greg
