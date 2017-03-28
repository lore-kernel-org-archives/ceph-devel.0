From: Kefu Chai <kchai@redhat.com>
Subject: Re: Regarding projects ideas in Ceph
Date: Tue, 28 Mar 2017 09:19:18 -0400 (EDT)
Message-ID: <733381147.6747251.1490707158110.JavaMail.zimbra@redhat.com>
References: <CAB649VCaiSrXkHYzMguf5H9fkZcc93-LEEqwRXOJJOG4ROahUg@mail.gmail.com> <alpine.DEB.2.11.1703251754070.10776@piezo.novalocal> <CAN_nQV59J8M6_fHZO__uaMqxSGozJ-3jqWU0-phhDjG033QOJg@mail.gmail.com> <alpine.DEB.2.11.1703261429530.10776@piezo.novalocal> <CAN_nQV6VBDywFmQ0BnCjc0naoS3yUmRs3=wWykRFV-HthOnerQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932510AbdC1NTd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Mar 2017 09:19:33 -0400
In-Reply-To: <CAN_nQV6VBDywFmQ0BnCjc0naoS3yUmRs3=wWykRFV-HthOnerQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sphoorti Joglekar <scjoglek@andrew.cmu.edu>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, Priya Avhad <pavhad@andrew.cmu.edu>

+ ceph-devel


Sphoorti, please send your questions to the ceph-devel mailing list instead of
sending it in private. that would help you to get more help from the community.

----- Original Message -----
> From: "Sphoorti Joglekar" <scjoglek@andrew.cmu.edu>
> To: "Sage Weil" <sweil@redhat.com>
> Cc: "Priya Avhad" <pavhad@andrew.cmu.edu>, "Kefu Chai" <kchai@redhat.com>
> Sent: Tuesday, March 28, 2017 1:30:36 AM
> Subject: Re: Regarding projects ideas in Ceph
> 
> Hi Sage,
> 
> The infrastructure that we are currently using is a 4GB RAM ubuntu vm
> running on virtualbox and we tried following the above steps but the
> compilation is very slow and does not succeed in the end. We even tried on

4GB RAM could be a little bit small for compiling Ceph. maybe we can fix the
compilation failure if the compiling process was not killed by kernel due to
out of memory. but you need to pastebin the error messages.

> an ec2 instance but were unable to get it working there too owing to lower
> RAM and memory constraints. (t2.micro we used as it is available on student
> account).
> 
> We would be willing to do the preliminary work for auto_tuning or any other
> smaller module and later develop on it.

i think you could take a look at http://libcrush.org/main/python-crush, which
allows a developer to perform experiments on CRUSH with different settings.

> 
> Best Regards,
> Sphoorti Joglekar
> 
> 
