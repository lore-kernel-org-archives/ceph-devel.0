From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Mon, 12 Jun 2017 16:03:13 -0400 (EDT)
Message-ID: <1396097469.22206951.1497297793862.JavaMail.zimbra@redhat.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com> <73f90019-71aa-2cf1-92e8-0ba7087d62a4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752371AbdFLUDS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Jun 2017 16:03:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D27137E66
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 20:03:18 +0000 (UTC)
In-Reply-To: <73f90019-71aa-2cf1-92e8-0ba7087d62a4@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I agree, though I'm unsure how much this matters either way?

Matt

----- Original Message -----

> 
> Hi John,
> 
> Is there a reason that radosgw can't instantiate its own MgrClient
> instance and report status through that, instead of having to go through
> librados? If we have to report an entity instance, we could choose from
> one of our Rados clients.
> 
> Casey
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
