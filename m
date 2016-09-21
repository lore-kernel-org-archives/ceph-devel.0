From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: Introducing Tendrl
Date: Wed, 21 Sep 2016 16:23:58 +0300
Message-ID: <83efb133-02bd-ef4e-af3a-db630175275c@redhat.com>
References: <CAOLAhP0dQo1_Dw-6TUxPXh+R+trxjQnLYWh+ax9E4iyV47tCiA@mail.gmail.com>
 <CALe9h7e3e=izA0UTeWF3rhZd_UmShEZs_1eGLRi4XoYY54VNXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932964AbcIUNYD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 09:24:03 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E37F7F7D5
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 13:24:03 +0000 (UTC)
In-Reply-To: <CALe9h7e3e=izA0UTeWF3rhZd_UmShEZs_1eGLRi4XoYY54VNXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Mrugesh Karnik <mkarnik@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 09/21/2016 10:47 AM, John Spray wrote:
> On Tue, Sep 20, 2016 at 8:10 AM, Mrugesh Karnik <mkarnik@redhat.com> wrote:
>> Hi all,
>>
>> I'd like to introduce the Tendrl project. Tendrl aims to build a
>> management interface for Ceph. We've pushed some documentation to the
>> documentation repository[1]. The documentation should provide an
>> understanding of the architecture and the components therein. This is
>> still a work in progress. So please feel free to ask questions and
>> make suggestions via the mailing list[2] and Github Issues[3]. There's
>> an IRC channel[4] as well.
> Thanks Mrugesh, I've opened a series of github issues to ask for more
> details on languages, protocols, security, scaling etc.  Where there
> are still open questions please feel free to say so, I understand that
> not everything is 100% defined.
I am a big fan of debating these choices not just on github, but also on the 
upstream lists. Best to put those choices out early for debate so we get 
feedback before spending too much effort.

>
>> Martin Bukatovic had earlier initiated a discussion around Ceph
>> Manager on this list. I'd like to address that here. Currently, we've
>> repurposed Calamari codebase as the Ceph Bridge. We're also tracking
>> the development of Ceph Manager. We'll be setting up a test bed to
>> check the Ceph Manager functionality and respond to the list with
>> feedback and queries.
> My understanding is that the ceph_bridge code was just a prototype --
> I'd suggest that you go forward either with a ceph-mgr module or using
> a REST API, but the calamari-derived ceph_bridge code should
> definitely go away.
>
> John

I agree that we should be looking at building on ceph-mgr - totally makes sense 
to build on an active project that the ceph community is actively working on.

Regards,

Ric

>
>> Thanks.
>>
>> [1] https://github.com/Tendrl/documentation
>> [2] https://www.redhat.com/mailman/listinfo/tendrl-devel
>> [3] https://github.com/Tendrl/documentation/issues
>> [4] #tendrl-devel on Freenode
>>
>> --
>> Mrugesh
>>

