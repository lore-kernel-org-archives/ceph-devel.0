From: Cesar Mello <cmello@gmail.com>
Subject: Re: RadosGW performance and disk space usage
Date: Sat, 26 Jan 2013 12:20:14 -0200
Message-ID: <CAJVE5RXpqJ3ZcbxAOCSD0f5OwN6Nre_TuhjY1BUveJTb=cga9A@mail.gmail.com>
References: <CAJVE5RXTM4iARw=wpaUX_ofZgP6tHLjiG6JoakpbhEXf7ZgVLQ@mail.gmail.com>
	<CAKMAVE-JJVsinn4ys2o-p=b-7-_u9KGvd1fxwfMX0=44fS4T8w@mail.gmail.com>
	<CALFpzo4u2PspjkvSig3LL821YY_XA2iHBjAh30JxgwWTFGsgcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:59412 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3AZOUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Jan 2013 09:20:17 -0500
Received: by mail-vc0-f177.google.com with SMTP id m18so964904vcm.36
        for <ceph-devel@vger.kernel.org>; Sat, 26 Jan 2013 06:20:16 -0800 (PST)
In-Reply-To: <CALFpzo4u2PspjkvSig3LL821YY_XA2iHBjAh30JxgwWTFGsgcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear Sam, Dan and Marcus,

Thank you a lot for the replies. I'll do more tests today.

The length of each object used in my test is just 20 bytes. I'm glad
you got 400 objects/s! Iif I get that with a length of 8 KB using a
2-node cluster, then ceph with rados will be already faster than my
current solution. And then I will be able to present it to my boss.
:-)

I'll try rest-bench later. Thanks for the help!

Best regards
Mello

On Sat, Jan 26, 2013 at 3:43 AM, Marcus Sorensen <shadowsor@gmail.com> wrote:
> Have you tried rest-bench on localhost at the rados gateway? I was playing
> with the rados gateway in a VM the other day, and was getting up to 400/s on
> 4k objects. Above that I was getting connection failures, but I think it was
> just due to a default max connections setting somewhere or something. My VM
> is on SSD though. I was just thinking it may help isolate the issue.
>
>
> On Fri, Jan 25, 2013 at 4:14 PM, Sam Lang <sam.lang@inktank.com> wrote:
>>
>> On Thu, Jan 24, 2013 at 9:27 AM, Cesar Mello <cmello@gmail.com> wrote:
>> > Hi!
>> >
>> > I have successfully prototyped read/write access to ceph from Windows
>> > using the S3 API, thanks so much for the help.
>> >
>> > Now I would like to do some prototypes targeting performance
>> > evaluation. My scenario typically requires parallel storage of data
>> > from tens of thousands of loggers, but scalability to hundreds of
>> > thousands is the main reason for investigating ceph.
>> >
>> > My tests using a single laptop running ceph with 2 local OSDs and
>> > local radosgw allows writing in average 2.5 small objects per second
>> > (100 objects in 40 seconds). Is this the expected performance? It
>> > seems to be I/O bound because the HDD led keeps on during the
>> > PutObject requests. Any suggestion or documentation pointers for
>> > profiling are very appreciated.
>>
>> Hi Mello,
>>
>> 2.5 objects/sec seems terribly slow, even on your laptop.  How "small"
>> are these objects?  You might try to benchmark without the disk as a
>> potential bottleneck, by putting your osd data and journals in /tmp
>> (for benchmarking only of course) or create/mount a tmpfs and point
>> your osd backends there.
>>
>> >
>> > I am afraid the S3 API is not good for my scenario, because there is
>> > no way to append data to existing objects (so I won't be able to model
>> > a single object for each data collector). If this is the case, then I
>> > would need to store billions of small objects. I would like to know
>> > how much disk space each object instance requires other than the
>> > object content length.
>> >
>> > If the S3 API is not well suited to my scenario, then my effort should
>> > be better directed to porting or writing a native ceph client for
>> > Windows. I just need an API to read and write/append blocks to files.
>> > Any comments are really appreciated.
>>
>> Hopefully someone with more windows experience will give you better
>> info/advice than I can.
>>
>> You could try to port the rados API to windows.  Its purely userspace,
>> but does rely on pthreads and other libc/gcc specifics.  With
>> something like cygwin a port might not be too hard though.  If you
>> decide to go that route, let us know how you progress!
>>
>> -sam
>>
>>
>> >
>> > Thank you a lot for the attention!
>> >
>> > Best regards
>> > Mello
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
