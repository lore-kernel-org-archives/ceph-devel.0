From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: CBT: New RGW getput benchmark and testing diary
Date: Mon, 6 Feb 2017 19:02:38 +0200
Message-ID: <CABo9giR1f1SvSjd=A35UkcxAr-Z8iAjNSn16ek6NnTPLfn3MyA@mail.gmail.com>
References: <8700753c-8440-695e-d529-e83b0fb2ba90@redhat.com>
 <1143254675.101053582.1486395206606.JavaMail.zimbra@redhat.com>
 <c95df184-aa53-a1a0-a448-0fd0085404d9@redhat.com> <968924677.101057209.1486395840825.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35255 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbdBFRCk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 12:02:40 -0500
Received: by mail-lf0-f47.google.com with SMTP id n124so48223737lfd.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 09:02:39 -0800 (PST)
In-Reply-To: <968924677.101057209.1486395840825.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com, Mark Seger <mjseger@gmail.com>, Kyle Bader <kbader@redhat.com>, Karan Singh <karan@redhat.com>, Brent Compton <bcompton@redhat.com>

On Mon, Feb 6, 2017 at 5:44 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Keep in mind, RGW does most of its request processing work in civetweb threads, so high utilization there does not necessarily imply civetweb-internal processing.
>

True but the request processing is not a CPU intensive operation.
It does seems to indicate that the civetweb threading model simply
doesn't scale (we already noticed it already) or maybe it can point to
some locking issue. We need to run a profiler to understand what is
consuming CPU.
It maybe a simple fix until we move to asynchronous frontend.
It worth investigating as the CPU usage mark is seeing  is really high.

Mark,
How many concurrent request were handled?

Orit

> Matt
>
> ----- Original Message -----
>> From: "Mark Nelson" <mnelson@redhat.com>
>> To: "Matt Benjamin" <mbenjamin@redhat.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com, "Mark Seger" <mjseger@gmail.com>, "Kyle Bader"
>> <kbader@redhat.com>, "Karan Singh" <karan@redhat.com>, "Brent Compton" <bcompton@redhat.com>
>> Sent: Monday, February 6, 2017 10:42:04 AM
>> Subject: Re: CBT: New RGW getput benchmark and testing diary
>>
>> Just based on what I saw during these tests, it looks to me like a lot
>> more time was spent dealing with civetweb's threads than RGW.  I didn't
>> look too closely, but it may be worth looking at whether there's any low
>> hanging fruit in civetweb itself.
>>
>> Mark
>>
>> On 02/06/2017 09:33 AM, Matt Benjamin wrote:
>> > Thanks for the detailed effort and analysis, Mark.
>> >
>> > As we get closer to the L time-frame, it should become relevant to look at
>> > the relative boost::asio frontend rework i/o paths, which are the open
>> > effort to reduce CPU overhead/revise threading model, in general.
>> >
>> > Matt
>> >
>> > ----- Original Message -----
>> >> From: "Mark Nelson" <mnelson@redhat.com>
>> >> To: "ceph-devel" <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com
>> >> Cc: "Mark Seger" <mjseger@gmail.com>, "Kyle Bader" <kbader@redhat.com>,
>> >> "Karan Singh" <karan@redhat.com>, "Brent
>> >> Compton" <bcompton@redhat.com>
>> >> Sent: Monday, February 6, 2017 12:55:20 AM
>> >> Subject: CBT: New RGW getput benchmark and testing diary
>> >>
>> >> Hi All,
>> >>
>> >> Over the weekend I took a stab at improving our ability to run RGW
>> >> performance tests in CBT.  Previously the only way to do this was to use
>> >> the cosbench plugin, which required a fair amount of additional
>> >> setup and while quite powerful can be overkill in situations where you
>> >> want to rapidly iterate over tests looking for specific issues.  A while
>> >> ago Mark Seger from HP told me he had created a swift benchmark called
>> >> "getput" that is written in python and is much more convenient to run
>> >> quickly in an automated fashion.  Normally getput is used in conjunction
>> >> with gpsuite, a tool for coordinating benchmarking multiple getput
>> >> processes.  This is how you would likely use getput on a typical ceph or
>> >> swift cluster, but since CBT builds the cluster and has it's own way for
>> >> launching multiple benchmark processes, it uses getput directly.
>> >>
>> >
>> >
>>
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
