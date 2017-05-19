From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: A question about Ceph's paxos implication
Date: Fri, 19 May 2017 14:31:49 -0700
Message-ID: <CAJ4mKGZ1ktN03N4u=Euj4JjYyjgkjLdRtPc8_MpDB9aJSvdyKg@mail.gmail.com>
References: <CACRPdDQACqOdoFJQMpfNEDY7zgqc6-m+DWG2f8JMHDTu+2HqSg@mail.gmail.com>
 <alpine.DEB.2.11.1705190230060.3646@piezo.novalocal> <CACRPdDSAFOpLneXfCuT10ppfSovQwm7k95UEjZYSjHhumgKTtA@mail.gmail.com>
 <alpine.DEB.2.11.1705191636070.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33833 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdESVcJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 17:32:09 -0400
Received: by mail-io0-f173.google.com with SMTP id k91so54888147ioi.1
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 14:31:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705191636070.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: fisherman <fisherman.dong@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 19, 2017 at 9:38 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 19 May 2017, fisherman wrote:
>> On Fri, May 19, 2017 at 10:37 AM, Sage Weil <sage@newdream.net> wrote:
>> > On Fri, 19 May 2017, fisherman wrote:
>> >> Hi, Sage and all Cepher
>> >>
>> >>    I am reading Ceph's implementation of paxos and have a question about it.
>> >>    The question is given by an example below:
>> >>
>> >>    Assume there are 5 monitor nodes: n1, n2, n3, n4, n5.
>> >>
>> >> 1) Node n1 is the leader,  all nodes are synchroined with
>> >> Last_committed=100, and there is no pending operation;
>> >> 2) A client, say c1, sends a request R1 to n1;
>> >> 3) Node n1 proposes a value v(for R1) with log version 101, stores
>> >> version 101 and pending_v =101 in its db. But it goes down before
>> >> sending anything to other nodes;
>> >>    Note: only n1 has pending_v == 101.
>> >> 4) Node n2 becomes the leader(without n1) and the cluster become
>> >> active. Client c1 querys n2 for status, and the result shows R1 is
>> >> lost;
>> >> 5) Node n1 recovers and becomes leader again;
>> >> 6) Node n1 finds pending_v == 101 and log version 101, so R1 get
>> >> replicated and applied;
>> >> 7) Client C1 queries again, and finds R1 has been applied.
>> >>     ==>inconsitent with the result of 4)
>> >>
>> >> Am I right on this point?
>> >
>> > IIRC at step 4, as soon as a quorum is formed without n1, the original
>> > proposal from n1 is rendered obsolete.  (If it isn't explicitly
>> > invalidated it would also be highly likely to be implicitly as soon as the
>> > new quorum passed its first proposal.)
>>    Maybe the original proposal should be rendered obsolete in
>> handle_last function, after having got ack from everyone in quorum,
>> but I can't find the code.
>>    It can be invalidated by the first proposal of the new quorum. The
>> inconsistency problem I described only occurs when read happens before
>> any new proposal.
>
> Yeah, I think the simplest fix is to *always* propose from
> handle_last.  If a previously proposed value wasn't learned, we can
> do a 'null' proposal that still bumps up last_committed.  That happens
> before the lease is extended so we avoid any window of readability
> before the quorum could fail and a new round including n1 could re-propose
> the old value.  This guard
>
>       // did we learn an old value?
>       if (uncommitted_v == last_committed+1 &&
>           uncommitted_value.length()) {
>
> would prevent it from being used because last_committed would have
> advanced.
>
> Does that seem reasonable?

I'm confused. Don't we consider any node with a higher election number
to have the longer log, and trim whoever has commits which don't match
that?

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
