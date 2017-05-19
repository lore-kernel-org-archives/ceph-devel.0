From: Sage Weil <sage@newdream.net>
Subject: Re: A question about Ceph's paxos implication
Date: Fri, 19 May 2017 02:37:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705190230060.3646@piezo.novalocal>
References: <CACRPdDQACqOdoFJQMpfNEDY7zgqc6-m+DWG2f8JMHDTu+2HqSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57879 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755210AbdESChK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 22:37:10 -0400
In-Reply-To: <CACRPdDQACqOdoFJQMpfNEDY7zgqc6-m+DWG2f8JMHDTu+2HqSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: fisherman <fisherman.dong@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 19 May 2017, fisherman wrote:
> Hi, Sage and all Cepher
> 
>    I am reading Ceph's implementation of paxos and have a question about it.
>    The question is given by an example below:
> 
>    Assume there are 5 monitor nodes: n1, n2, n3, n4, n5.
> 
> 1) Node n1 is the leader,  all nodes are synchroined with
> Last_committed=100, and there is no pending operation;
> 2) A client, say c1, sends a request R1 to n1;
> 3) Node n1 proposes a value v(for R1) with log version 101, stores
> version 101 and pending_v =101 in its db. But it goes down before
> sending anything to other nodes;
>    Note: only n1 has pending_v == 101.
> 4) Node n2 becomes the leader(without n1) and the cluster become
> active. Client c1 querys n2 for status, and the result shows R1 is
> lost;
> 5) Node n1 recovers and becomes leader again;
> 6) Node n1 finds pending_v == 101 and log version 101, so R1 get
> replicated and applied;
> 7) Client C1 queries again, and finds R1 has been applied.
>     ==>inconsitent with the result of 4)
> 
> Am I right on this point?

IIRC at step 4, as soon as a quorum is formed without n1, the original 
proposal from n1 is rendered obsolete.  (If it isn't explicitly 
invalidated it would also be highly likely to be implicitly as soon as the 
new quorum passed its first proposal.)

sage
