From: Lipeng Wan <lipengwan86@gmail.com>
Subject: Re: Is there any way to collect object-level I/O access traces in Ceph?
Date: Fri, 16 Jan 2015 19:06:18 -0500
Message-ID: <CAJqA8gu1bdgEzR29k0Z4JaRrweYhc2=vXW9KDKrqX1yEGVxsxw@mail.gmail.com>
References: <CAJqA8gsUn19CDswyeYiQj9Ex0vaQeybvBVDOx3nG2w70_esCAg@mail.gmail.com>
	<CAC6JEv8-BE=+p_h54z__bAf5vev8jJttBf5nBw8PNm6w8nJw9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:65141 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbAQAGT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 19:06:19 -0500
Received: by mail-yh0-f48.google.com with SMTP id i57so11487480yha.7
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 16:06:18 -0800 (PST)
In-Reply-To: <CAC6JEv8-BE=+p_h54z__bAf5vev8jJttBf5nBw8PNm6w8nJw9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Greg,

Thanks for your reply.
I found that in /var/log/ceph directory on each node, there are
several log files in it,
such as ceph-client.admin.log, ceph-mds.ceph-node1.log, etc., which
log file should I look at? Maybe the "ceph-mds.ceph-node1.log"?
Specifically, is there any keyword I can search in the log file to
locate the object operations?
Thanks!
LW

On Fri, Jan 16, 2015 at 4:21 PM, Gregory Farnum <greg@gregs42.com> wrote:
> On Fri, Jan 16, 2015 at 11:28 AM, Lipeng Wan <lipengwan86@gmail.com> wrote:
>> Dear all,
>>
>> Does Ceph provide a way to collect object-level I/O access traces?
>> Specifically, can we collect the traces to record how many times each
>> object has been accessed (read, write, etc.) during a fixed period of
>> time?
>
> I don't think we have any programmatic access, but depending on what
> you need it for you could enable messenger logging (or filestore
> logging, depending on what exactly you want) and count the references
> there.
> -Greg
