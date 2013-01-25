From: Sam Lang <sam.lang@inktank.com>
Subject: Re: RadosGW performance and disk space usage
Date: Fri, 25 Jan 2013 17:14:03 -0600
Message-ID: <CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:48989 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab3AYXOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 18:14:05 -0500
Received: by mail-ob0-f181.google.com with SMTP id wc18so1070554obb.40
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 15:14:03 -0800 (PST)
In-Reply-To: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 24, 2013 at 9:27 AM, Cesar Mello <cmello@gmail.com> wrote:
> Hi!
>
> I have successfully prototyped read/write access to ceph from Windows
> using the S3 API, thanks so much for the help.
>
> Now I would like to do some prototypes targeting performance
> evaluation. My scenario typically requires parallel storage of data
> from tens of thousands of loggers, but scalability to hundreds of
> thousands is the main reason for investigating ceph.
>
> My tests using a single laptop running ceph with 2 local OSDs and
> local radosgw allows writing in average 2.5 small objects per second
> (100 objects in 40 seconds). Is this the expected performance? It
> seems to be I/O bound because the HDD led keeps on during the
> PutObject requests. Any suggestion or documentation pointers for
> profiling are very appreciated.

Hi Mello,

2.5 objects/sec seems terribly slow, even on your laptop.  How "small"
are these objects?  You might try to benchmark without the disk as a
potential bottleneck, by putting your osd data and journals in /tmp
(for benchmarking only of course) or create/mount a tmpfs and point
your osd backends there.

>
> I am afraid the S3 API is not good for my scenario, because there is
> no way to append data to existing objects (so I won't be able to model
> a single object for each data collector). If this is the case, then I
> would need to store billions of small objects. I would like to know
> how much disk space each object instance requires other than the
> object content length.
>
> If the S3 API is not well suited to my scenario, then my effort should
> be better directed to porting or writing a native ceph client for
> Windows. I just need an API to read and write/append blocks to files.
> Any comments are really appreciated.

Hopefully someone with more windows experience will give you better
info/advice than I can.

You could try to port the rados API to windows.  Its purely userspace,
but does rely on pthreads and other libc/gcc specifics.  With
something like cygwin a port might not be too hard though.  If you
decide to go that route, let us know how you progress!

-sam


>
> Thank you a lot for the attention!
>
> Best regards
> Mello
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
