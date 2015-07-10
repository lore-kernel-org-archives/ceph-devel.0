From: Gregory Farnum <greg@gregs42.com>
Subject: Re: load-gen from an osd node
Date: Fri, 10 Jul 2015 11:25:15 +0100
Message-ID: <CAC6JEv_YqVb4m8BiTxwwawHxAYmJW36m3kH-ZTdAN34p8=ZGjA@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AEA37@SATLEXDAG01.amd.com>
	<CAC6JEv_pNYxaWs3SFxqYMrYyaWei79x_61g5Nt6D=uQxQh7qnQ@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF91669B1F9A@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35904 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbbGJKZR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 06:25:17 -0400
Received: by iecvh10 with SMTP id vh10so193882872iec.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 03:25:16 -0700 (PDT)
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com. [209.85.223.170])
        by smtp.gmail.com with ESMTPSA id j2sm6181264ioo.43.2015.07.10.03.25.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2015 03:25:16 -0700 (PDT)
Received: by iebmu5 with SMTP id mu5so193087268ieb.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 03:25:15 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669B1F9A@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 8, 2015 at 5:17 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> With the newer rados, just running  rados -p somepool load-gen, we get
>
> preparing 200 objects
> load-gen will run 60 seconds
>     1: throughput=0MB/sec pending data=0
>     2: throughput=0MB/sec pending data=0
>     3: throughput=0MB/sec pending data=0
>     4: throughput=0MB/sec pending data=0
>     5: throughput=0MB/sec pending data=0
>     6: throughput=0MB/sec pending data=0
>
> But I see the change that caused this behavior was explicitly initializing lg.max_ops to 0.
> Before this, max_ops was just whatever happened to be in memory.
>
> So the newer load-gen works fine as long as you explicitly set --max-ops on the command line.

Can you create a ticket on the tracker describing this issue? That's
the kind of thing we'll want to fix. ;)
-Greg

>
> -- Tom Deneau
>
>
>> -----Original Message-----
>> From: Gregory Farnum [mailto:greg@gregs42.com]
>> Sent: Wednesday, July 01, 2015 11:05 AM
>> To: Deneau, Tom
>> Cc: ceph-devel
>> Subject: Re: load-gen from an osd node
>>
>> Hmm, the only changes I see between those two versions are some pretty
>> precise cleanups which shouldn't cause this. But it means that a bisect or
>> determined look should be easy. Can you create a ticket which includes the
>> exact output you're seeing and the exact versions you're running?
>> -Greg
>>
>> On Mon, Jun 29, 2015 at 11:27 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
>> > Oh, I just noticed that the client nodes I spoke of where load-gen
>> > actually worked were running 0.94, not 9.0.1.  And when I upgrade them to
>> 9.0.1, load-gen no longer works.
>> >
>> > So more likely this is just a problem with newer rados load-gens
>> >
>> > -- Tom
>> >
>> >
>> >
>> >> -----Original Message-----
>> >> From: Deneau, Tom
>> >> Sent: Friday, June 26, 2015 7:48 PM
>> >> To: ceph-devel
>> >> Subject: load-gen from an osd node
>> >>
>> >> I am running 9.0.1 and I noticed when I run rados load-gen from one
>> >> of the osd nodes, it creates the objects but then always reports a
>> >> throughput of 0 MB/sec.
>> >>
>> >> But if I run it from a separate client node, it works fine.
>> >> Why would this be?
>> >>
>> >> I'm not sure but I thought in earlier versions load-gen could be run
>> >> from an osd node.
>> >>
>> >> -- Tom Deneau
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > in the body of a message to majordomo@vger.kernel.org More majordomo
>> > info at  http://vger.kernel.org/majordomo-info.html
