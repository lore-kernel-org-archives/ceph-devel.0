From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Wed, 30 Nov 2016 23:09:19 +0100
Message-ID: <CAEw75dOwAakFiRpYD-CX1BwGDGR7AsPQVV1Ff4g0ZdozcTNfnw@mail.gmail.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
 <87r362tr92.fsf@suse.com> <CALqRxCye8KVmkUObT+NOCuKq-7SAD+RL-FLq2SFk0TqnH+h7qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34392 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbcK3WKF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 17:10:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so31521734wme.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 14:09:20 -0800 (PST)
In-Reply-To: <CALqRxCye8KVmkUObT+NOCuKq-7SAD+RL-FLq2SFk0TqnH+h7qw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Abhishek L <abhishek@suse.com>, Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Yuri Weinstein <yweinste@redhat.com>

On Wed, Nov 30, 2016 at 10:56 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Wed, Nov 23, 2016 at 3:39 AM, Abhishek L <abhishek@suse.com> wrote:
>> Do you think we're ready to release 10.2.4 yet?
>
> It would be great to get https://github.com/ceph/ceph/pull/12001 in
> before v10.2.4 as well.

The current test runs already include 12001,
once we have a green run we should be having it in 10.2.4

Best,
Abhishek
