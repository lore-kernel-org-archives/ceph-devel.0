From: David Zafman <dzafman@redhat.com>
Subject: Re: RADOS: Deleting all objects in a namespace
Date: Tue, 23 May 2017 09:30:21 -0700
Message-ID: <42dcb545-5881-5219-7d4e-9eb194873edd@redhat.com>
References: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763219AbdEWQaX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 12:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2DAC8123E
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 16:30:22 +0000 (UTC)
In-Reply-To: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


I imagine an operation similar to PGNLS could be sent that does the same 
thing, but performs deletes instead of returning the names.

David

On 5/23/17 6:09 AM, John Spray wrote:
> Soon, we'll probably be letting multiple CephFS filesystems use the
> same data and metadata pools, where the filesystems are separated by
> rados namespace.
>
> When removing filesystems, in the interests of robustness and speed,
> I'd like to be able to delete all objects in a namespace -- otherwise
> we would have to rely on a "rm -rf" and then some new code to
> explicitly enumerate and delete all metadata objects for that
> filesystem.
>
> I'm pondering whether this should just be a process that happens via
> normal client interfaces (where mon/mgr would be the client), or
> whether it would be feasible/desirable to implement something inside
> the OSD.  Obviously the OSD ultimately has to do the same underlying
> enumeration, but at least it doesn't have to thrash through the whole
> request/response cycle for deleting each object individually -- might
> enable it to throttle internally in the OSD based on how busy it knows
> itself to be, rather than having the client apply some arbitrary "only
> issue N deletions at once" type limit that might make the deletion
> process unecessarily slow.
>
> I have a feeling we must have talked about this at some point but my
> memory is failing me...
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

