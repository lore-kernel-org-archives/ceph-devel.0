From: John Spray <jspray@redhat.com>
Subject: Re: [sepia] how to use teuthology-suite in the new world
Date: Thu, 15 Dec 2016 15:46:10 +0000
Message-ID: <CALe9h7dSLTd7QnBwmQU_wmC7NVQxPwGpxeJknOcWvOtfbHv0-A@mail.gmail.com>
References: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
 <20161215145143.GA1451@gmail.com> <20161215150026.GB1451@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:32983 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbcLOPrW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 10:47:22 -0500
Received: by mail-qt0-f176.google.com with SMTP id p16so58242407qta.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 07:46:31 -0800 (PST)
In-Reply-To: <20161215150026.GB1451@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <trociny@freebsd.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "sepia@ceph.com" <sepia@ceph.com>

On Thu, Dec 15, 2016 at 3:00 PM, Mykola Golub <trociny@freebsd.org> wrote:
> On Thu, Dec 15, 2016 at 04:51:44PM +0200, Mikolaj Golub wrote:
>> Hi, Sage,
>>
>> It looks like we still need to push testing branches to ceph.git for
>> things like below?
>>
>> qa/workunits/rbd/test_librbd_python.sh:
>>
>> wget -O test_rbd.py "https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=$CEPH_REF;f=src/test/pybind/test_rbd.py" || \
>>     wget -O test_rbd.py "https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=ref/heads/$CEPH_REF;f=src/test/pybind/test_rbd.py"
>>
>> Do we have some env variable (CEPH_REPO?) we could use simirlaly to
>> CEPH_REF here?
>
> Or rather may be now we can avoid such hacks at all?

Exactly - as you notice bits like that, let's convert them to just
read their files locally instead of trying to fetch them from git.  I
guess the workunit task will be the major one here, if nobody already
adjusted it.

John

> --
> Mykola Golub
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
