From: John Spray <jspray@redhat.com>
Subject: Re: Brewer's theorem also known as CAP theorem
Date: Tue, 15 Sep 2015 14:50:13 +0100
Message-ID: <CALe9h7fgrsctv=RW87n0AcByDMBV8t18y=68M0p9m0mLo+6hUw@mail.gmail.com>
References: <1CB94550540AE44E9CAAE8CD5AF40BF846CEB60D@H3CMLB12-EX.srv.huawei-3com.com>
 <CABAwU-bw_65HXAxNCVMkmCXZw4c5F0UBNwNUQwf9wOXbCt=VeA@mail.gmail.com>
 <1CB94550540AE44E9CAAE8CD5AF40BF846CEB6A5@H3CMLB12-EX.srv.huawei-3com.com>
 <CABAwU-YFhMbrvT7ao6c605aJXi2kLiC7wjr3eSAQvAqrNNzCmg@mail.gmail.com>
 <6F3FA899187F0043BA1827A69DA2F7CC0361EE09@shsmsx102.ccr.corp.intel.com>
 <1CB94550540AE44E9CAAE8CD5AF40BF846CEC8F1@H3CMLB12-EX.srv.huawei-3com.com>
 <CAJ4mKGY7p+vDmSaPa5=WjbMHT4XXNK8a9RT19R6ir=A7SvsmRQ@mail.gmail.com> <20150915143820.700c62d0@linux-520c.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33026 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbIONud (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 09:50:33 -0400
Received: by obbbh8 with SMTP id bh8so135069630obb.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 06:50:33 -0700 (PDT)
In-Reply-To: <20150915143820.700c62d0@linux-520c.site>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, "zhao.mingyue@h3c.com" <zhao.mingyue@h3c.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, huang jun <hjwsm1989@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 15, 2015 at 1:38 PM, Owen Synge <osynge@suse.com> wrote:
> On Mon, 14 Sep 2015 13:57:26 -0700
> Gregory Farnum <gfarnum@redhat.com> wrote:
>
>> The OSD is supposed to stay down if any of the networks are missing.
>> Ceph is a CP system in CAP parlance; there's no such thing as a CA
>> system. ;)
>
> I know I am being fussy, but within my team your email was sited that
> you cannot consider ceph as a CA system. Hence I make my argument in
> public so I can be humbled in public.
>
> Just to clarify your opinion I site
>
> http://www.infoq.com/articles/cap-twelve-years-later-how-the-rules-have-changed
>
> suggests:
>
> <quote>
> The CAP theorem states that any networked shared-data system can have
> at most two of three desirable properties.
>
> * consistency (C) equivalent to having a single up-to-date copy of
>     the data;
> * high availability (A) of that data (for updates)
> * tolerance to network partitions (P).
> </quote>
>
> So I dispute that a CA system cannot exist.
>
> I think you are too absolute even in interpretation of this vague
> theory. A further quote from the author of said theorem from the same
> article:
>
> <quote>
> The "2 of 3" formulation was always misleading because it tended to
> oversimplify the tensions among properties.
> </quote>
>
> As I understand it:
>
> Ceph as a cluster always provides "Consistency". (or else you found a
> bug)
>
> If a ceph cluster is operating it will always provide acknowledgment
> (it may block) to the client if the operation has succeeded
> or failed hence provides "availability".
>
> if a ceph cluster is partitioned, only one partition will continue
> operation, hence you cannot consider the system "partition" tolerant
> as multiple parts of the system cannot operate when partitioned.

The technical meaning of partition tolerance is that the system
continues to provide a service to clients in the face of a partition,
not that it splits into multiple separately operating units.

Given the general definition of partition (any network failure, any
host failure), any real physical network has the 'P' part, so only CP
and AP systems are physically meaningful.  In order to imagine a CA
system you have to imagine a perfect network.

There has been plenty of confusion in the past as CAP terminology went
mainstream, so there are also plenty of blogs providing longer
explanations:
http://codahale.com/you-cant-sacrifice-partition-tolerance/
http://www.quora.com/Whats-the-difference-between-CA-and-CP-systems-in-the-context-of-CAP-Consistency-Availability-and-Partition-Tolerance


> Hence as a cluster ceph is CA.
>
> Alternatively if you look at it from an OSD rather than cluster
> perspective, you can get the perspective you take, OSD's are CP system
> in CAP parlance.
>
> I would argue it is all a matter of perspective

Not so much a matter of perspective, more that the words involved are
used in quite specific technical ways.  If you try to understand it in
plain english it seems ambiguous, but the way the terms are used
within this field it's quite clear cut.

John

, and believe that to
> call Brewer's theorem anything other than guidance without strong
> discussion of your understanding of consistency and its interaction with
> partitioning is to confuse and over simplify.
>
> Best regards
>
> Owen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
