From: John Spray <jspray@redhat.com>
Subject: Re: Introducing Tendrl
Date: Wed, 21 Sep 2016 08:47:06 +0100
Message-ID: <CALe9h7e3e=izA0UTeWF3rhZd_UmShEZs_1eGLRi4XoYY54VNXA@mail.gmail.com>
References: <CAOLAhP0dQo1_Dw-6TUxPXh+R+trxjQnLYWh+ax9E4iyV47tCiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33401 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbcIUHr2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 03:47:28 -0400
Received: by mail-qk0-f177.google.com with SMTP id w204so37799567qka.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 00:47:27 -0700 (PDT)
In-Reply-To: <CAOLAhP0dQo1_Dw-6TUxPXh+R+trxjQnLYWh+ax9E4iyV47tCiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mrugesh Karnik <mkarnik@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 20, 2016 at 8:10 AM, Mrugesh Karnik <mkarnik@redhat.com> wrote:
> Hi all,
>
> I'd like to introduce the Tendrl project. Tendrl aims to build a
> management interface for Ceph. We've pushed some documentation to the
> documentation repository[1]. The documentation should provide an
> understanding of the architecture and the components therein. This is
> still a work in progress. So please feel free to ask questions and
> make suggestions via the mailing list[2] and Github Issues[3]. There's
> an IRC channel[4] as well.

Thanks Mrugesh, I've opened a series of github issues to ask for more
details on languages, protocols, security, scaling etc.  Where there
are still open questions please feel free to say so, I understand that
not everything is 100% defined.

> Martin Bukatovic had earlier initiated a discussion around Ceph
> Manager on this list. I'd like to address that here. Currently, we've
> repurposed Calamari codebase as the Ceph Bridge. We're also tracking
> the development of Ceph Manager. We'll be setting up a test bed to
> check the Ceph Manager functionality and respond to the list with
> feedback and queries.

My understanding is that the ceph_bridge code was just a prototype --
I'd suggest that you go forward either with a ceph-mgr module or using
a REST API, but the calamari-derived ceph_bridge code should
definitely go away.

John

>
> Thanks.
>
> [1] https://github.com/Tendrl/documentation
> [2] https://www.redhat.com/mailman/listinfo/tendrl-devel
> [3] https://github.com/Tendrl/documentation/issues
> [4] #tendrl-devel on Freenode
>
> --
> Mrugesh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
