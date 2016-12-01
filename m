From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: Re: ceph v10.2.4 QE validation status
Date: Thu, 1 Dec 2016 09:09:25 +0100
Message-ID: <b6503286-7cb6-a8f5-f285-64614e63d6d5@epfl.ch>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
 <87r362tr92.fsf@suse.com>
 <CALqRxCye8KVmkUObT+NOCuKq-7SAD+RL-FLq2SFk0TqnH+h7qw@mail.gmail.com>
 <CAEw75dOwAakFiRpYD-CX1BwGDGR7AsPQVV1Ff4g0ZdozcTNfnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:39248 "EHLO smtp0.epfl.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbcLAIJb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 03:09:31 -0500
In-Reply-To: <CAEw75dOwAakFiRpYD-CX1BwGDGR7AsPQVV1Ff4g0ZdozcTNfnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: Abhishek L <abhishek@suse.com>, Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Yuri Weinstein <yweinste@redhat.com>

Hello,

>> It would be great to get https://github.com/ceph/ceph/pull/12001 in
>> before v10.2.4 as well.
> 
> The current test runs already include 12001,
> once we have a green run we should be having it in 10.2.4

I don't see the pull request 12001 for 10.2.4[1] release, it's in the 10.2.5[2]

1. http://tracker.ceph.com/issues/17487
2. http://tracker.ceph.com/issues/17851

Do you plan to include it in the 10.2.4 ?

Best regards,

-- 
Yoann Moulin
EPFL IC-IT
