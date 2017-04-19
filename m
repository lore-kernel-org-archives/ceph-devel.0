From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Smarter blacklisting?
Date: Wed, 19 Apr 2017 16:26:08 -0700
Message-ID: <f354a27c-931d-ce64-4fa4-e4f6d802998d@redhat.com>
References: <CALe9h7dh2=BYjSdSuPXKE457TWg06xrw6QOjmbk_tLvU5fd69w@mail.gmail.com>
 <alpine.DEB.2.11.1704181638530.6579@piezo.novalocal>
 <CAJ4mKGZxf3RcZGub7PKkpDV_GDZPBXACtX1tVwxdw2SpS1cooA@mail.gmail.com>
 <CALe9h7e6qY_yqzsFzsGNNVi2DG_JwNEti=gP-pkB_LZiXu5_ig@mail.gmail.com>
 <alpine.DEB.2.11.1704191315210.6575@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966081AbdDSX0L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Apr 2017 19:26:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9C898049E
        for <ceph-devel@vger.kernel.org>; Wed, 19 Apr 2017 23:26:10 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1704191315210.6575@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Jason Dillaman <dillaman@redhat.com>, Mike Christie <mchristi@redhat.com>

On 04/19/2017 06:16 AM, Sage Weil wrote:
> On Wed, 19 Apr 2017, John Spray wrote:
>> I was already pondering where the more detailed blacklist info (e.g.
>> ids of clients) should go, as it's not something that actually needs
>> to be shared with all the normal OSDMap subscribers (it's only the
>> entity that does the blacklist removal that needs to see that).  It's
>> already not ideal imho that we expose the list of all blacklisted
>> clients to all the other clients -- in general they shouldn't be able
>> to e.g. learn one another's addresses like this.
>
> We already break the OSDMap encoding into two sections: the first part
> that clients care about, and the second part that is only used by OSDs.
> (The kernel client doesn't bother to decode the second half.)
>
> I suspect it wouldn't take much to send abbreviated maps (and
> incrementals) to clients that don't include that second half at all...

I was talking to Jason and Mike about another use of more generalized
blacklisting at Vault, but I can't remember the details - do you guys?

IIRC it sounded like that use would make sense as a separate map that
osds and clients would subscribe to.

Josh
