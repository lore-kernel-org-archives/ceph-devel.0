From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: How to increase the number of pgs at pool creation time?
Date: Thu, 23 Aug 2012 14:26:52 -0700
Message-ID: <CANLRBozjtrpsKJ-cE=RxP0ihdkO4cYjV9bx=c+rb+F8HzZ=zmw@mail.gmail.com>
References: <CANLRBoxdu7iPvBU45T5Nk0zDYT1QSX9-oyo4g1nEav-+ybGA4g@mail.gmail.com>
	<50369DDB.8020905@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62571 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab2HWV0y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 17:26:54 -0400
Received: by vbbff1 with SMTP id ff1so1348631vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Aug 2012 14:26:52 -0700 (PDT)
In-Reply-To: <50369DDB.8020905@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 23, 2012 at 2:17 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 08/23/2012 02:39 PM, Tren Blackburn wrote:
>>
>> 2) Increase the number of pgs via ceph.conf (osd pg bits = 7) and
>> create the cluster. This does not work either as the cluster comes up
>> with 6 pgs bits per osd still.
>>      re:http://ceph.com/docs/master/config-cluster/osd-config-ref/
>
>
> I use this regularly.  Do you have that in your global section, i.e.
>
> [global]
>         osd pg bits = 7
>         osd pgp bits = 7
>
Hi Jim;

Sorry about the direct reply. I have cc'ed the list. To answer your
question I put that setting in the [osd] section, not the [global]
section. How would a person know these settings go in [global]? Also,
I could not find documentation about "pgp bits" What is a "placement
group p bit"?

Thank you in advance!

Regards,

Tren
