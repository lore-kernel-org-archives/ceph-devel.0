From: Abhishek L <abhishek@suse.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Tue, 29 Nov 2016 11:46:16 +0100
Message-ID: <87mvgia7if.fsf@suse.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com> <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com> <87r362tr92.fsf@suse.com> <alpine.DEB.2.11.1611231441130.21102@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:49974 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbcK2KqT (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 29 Nov 2016 05:46:19 -0500
In-reply-to: <alpine.DEB.2.11.1611231441130.21102@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Yuri Weinstein <yweinste@redhat.com>


Sage Weil writes:

> On Wed, 23 Nov 2016, Abhishek L wrote:
>>
>> Hi Sage, Greg,
>>
>>
>> Yuri Weinstein writes:
>>
>> > See updated status - http://tracker.ceph.com/issues/17487#note-32
>> >
>> > Outstanding issues:
>> >
>> > knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
>> > pls review/approve, assumed Approved ?)
>> >
>> > upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
>> > pls review/approve, seems persistent, but maybe not a showstopper)
>> >
>> > upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
>> > to make it pass, see issues in the tacker summary above)
>> >
>> > Sage, jewel 10.2.4 can be released as soon as you agree with the
>> > findings/summary.
>>
>> Do you think we're ready to release 10.2.4 yet?
>
> I'm reproducing http://tracker.ceph.com/issues/17847 with logs to make
> sure this isn't a regression.
>
> We can ignore the infernalis runs.
>
> I think we can ignore the knfs selinux issue too.. Greg, can you confirm?
>
Added the prs 12001 & 12167 on top of the jewel branch and scheduled rados runs
at
http://pulpito.ceph.com/abhi-2016-11-29_10:22:25-rados-wip-jewel-10-2-4-distro-basic-smithi/ &

updated the tracker at http://tracker.ceph.com/issues/17851#note-17,
with details of the test. I'll update the progress once the suite goes
through

Best,
Abhishek
