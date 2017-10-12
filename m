From: David Galloway <dgallowa@redhat.com>
Subject: Re: major infrastructure outage
Date: Thu, 12 Oct 2017 09:15:35 -0400
Message-ID: <bc4c8883-ab21-a81d-33f4-a4f77f05a8c1@redhat.com>
References: <CAC-Np1xnrr-RXUV3m87bJ6QP-b-xV7KtQrQud5HckEgBQ-fDDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752620AbdJLNPh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Oct 2017 09:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3117768CD
        for <ceph-devel@vger.kernel.org>; Thu, 12 Oct 2017 13:15:37 +0000 (UTC)
In-Reply-To: <CAC-Np1xnrr-RXUV3m87bJ6QP-b-xV7KtQrQud5HckEgBQ-fDDw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Alfredo Deza <adeza@redhat.com>


On 10/12/2017 07:24 AM, Alfredo Deza wrote:
> We are currently going through a severe outage. All critical
> infrastructure services are currently unavailable.
> 
> This includes the following:
> 
> * Both Jenkins masters (one is for Ceph the other one for ceph-ansible)
> * Anything in Shaman
> * All build nodes
> * All repositories (anything *chacra.ceph.com)
> 
> Some services are up, like docs.ceph.com, tracker, and download.ceph.com
> 
> We are currently trying to determine the reason why these are
> completely unreachable with the service provider.
> 
> We will keep updating once we have anything to report.
> 

All services have been restored.  The outage only affected the CI
infrastructure (Jenkins, Shaman, Chacra, etc.).

OVH temporarily suspended our CI public cloud account due to a past due
bill.

I'm currently monitoring a build to verify packages are being created
and pushed to the chacra nodes but I think we're in the clear.
