From: Dan Mick <dmick@redhat.com>
Subject: Re: ceph-mgr is in master
Date: Mon, 3 Oct 2016 20:16:56 -0700
Message-ID: <b9e30685-d37d-f019-79cc-dbe5c77b71b8@redhat.com>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
 <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbcJDDQ5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 3 Oct 2016 23:16:57 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7952D7EAB7
        for <ceph-devel@vger.kernel.org>; Tue,  4 Oct 2016 03:16:56 +0000 (UTC)
In-Reply-To: <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10/03/2016 10:45 AM, Gregory Farnum wrote:

> 3) It uses "ceph tell" syntax. I thought we were moving away from
> top-level "tell" commands and towards making them part of the
> sub-command (eg "ceph osd tell", "ceph mgr tell"); is this a
> deliberate new lease on life for that? Unintended? Something I just
> made up?

Actually it's the other way around; 'osd tell', for example, says:

"osd tell" is deprecated; try "tell osd.<id> <command> [options...]"
instead (id can be "*")
