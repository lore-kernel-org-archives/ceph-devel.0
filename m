From: Sage Weil <sage@newdream.net>
Subject: Re: Question about ceph paxos implementation
Date: Tue, 28 Nov 2017 13:06:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711281302400.19791@piezo.novalocal>
References: <C3CABE81-22E1-4B8E-AA5A-22CEBF5D45A9@gmail.com> <alpine.DEB.2.11.1711271426100.28240@piezo.novalocal> <A3CDC94E-4353-45F1-86BF-9F334D499EB6@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-465327521-1511874405=:19791"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:47454 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdK1NGp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 08:06:45 -0500
In-Reply-To: <A3CDC94E-4353-45F1-86BF-9F334D499EB6@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kang Wang <beijingwangkang@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-465327521-1511874405=:19791
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Sorry, I misread the scenario before.  I think what will actually happen 
is that in step 3, when "2" is recovered, it will be re-proposed, so 
let's actually call it "2'" (it will have the round 3 pn associated with 
it).  That means that in step 4, "3" wouldn't be reproposed or 
committed, because m4 has "2'" with a higher pn... "2'" would be 
re-proposed.

You might rewrite out the scenario with parens for uncommited, and 
something like (n pn=123) so that the proposal number is indicated.  
Seeing uncomitted vs committed and the pn will make the sequence more 
clear!

sage



On Tue, 28 Nov 2017, Kang Wang wrote:

> You mean value ‘2’ wouldn’t be used at the 3rd step?
> 
> 3, Then m2 goes down before send anything to others, then m1, m3 recovered and commit value ‘2’ with the quorum m1, m3, m4
> m1:   1 2
> m2:   1 3  down
> m3:   1 2
> m4:   1 2
> m5:   1	
> 
> 
> but as I assume that m2 goes down before it could send  MMonPaxos::OP_BEGIN message to others,
> so the new leader m1 has no chance to know there exists a newer uncommited value ‘3'
> 
> 
> 
> Thanks
> WANG KANG
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > On 27 Nov 2017, at 10:27 PM, Sage Weil <sage@newdream.net> wrote:
> > 
> > On Mon, 27 Nov 2017, Kang Wang wrote:
> >> hi
> >> 
> >> I read the code of ceph paxos recently, and have a question about it, which, in my opinion, may violate the consistency.
> >> 
> >> Assume we have five monitor node m1, m2, m3, m4, m5, the prior one has larger rank than the back one. 
> >> 
> >> Consider the situation as below:
> >> 
> >> 1, m1 as the leader, and all node have the same last_commited at begin, then m1 propose a new value ‘2', which then be accept by m1 and m3:
> >> m1:   1 2
> >> m2:   1
> >> m3:   1 2
> >> m4:   1
> >> m5:   1	
> >> 
> >> 2, Unfortunatly, both m1 and m3 go down, and m2 become leader without knowledge about the propse, and it propose a new value ‘3' 
> >> m1:   1 2  down 
> >> m2:   1 3
> >> m3:   1 2  down
> >> m4:   1
> >> m5:   1	
> >> 
> >> 3, Then m2 goes down before send anything to others, then m1, m3 recovered and commit value ‘2’ with the quorum m1, m3, m4
> >> m1:   1 2
> >> m2:   1 3  down
> >> m3:   1 2
> >> m4:   1 2
> >> m5:   1	
> >> 
> >> 4, Before the commit message sent to others, m1 and m3 go down again. So value ‘3’ only commit on m1. Then m2 become leader once more.
> >> m1:   1 2  down
> >> m2:   1 3
> >> m3:   1 2  down
> >> m4:   1 2
> >> m5:   1
> >> 
> >> 5, Leader m2 see the uncommited value ‘2’, but discard it by compare uncommitted_pn in function handle_last, so it commit value ‘3’ with the quorum m2, m4, m5
> >> m1:   1 2  down
> >> m2:   1 3
> >> m3:   1 2  down
> >> m4:   1 3
> >> m5:   1 3
> > 
> > This is what the last->uncommitted_pn value is for.  I believe this 
> > prevents us from using 2's pn (and uncommitted value) because 3's pn is 
> > larger.  Can you verify?
> > 
> > Thanks!
> > sage
> > 
> > 
> >> 
> >> Now we see the value ‘2’ has been commited, but lost soon. Am I right on it?
> >> 
> >> 
> >> Thanks
> >> WANG KANG
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-465327521-1511874405=:19791--
