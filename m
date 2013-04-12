From: Gregory Farnum <greg@inktank.com>
Subject: Re: new ceph-0.60 always crash mds
Date: Fri, 12 Apr 2013 09:06:25 -0700
Message-ID: <CAPYLRzgUTOFoiAr-siPKxPr_GgiJs69KgBWSc3Hy-qxqAaTzwg@mail.gmail.com>
References: <CAJiejCRunA9z=L2zTQP=b+=F2Pf17nG1CNoF1EN7rhvLwuqtKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:50973 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab3DLQG0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 12:06:26 -0400
Received: by mail-qe0-f45.google.com with SMTP id 1so1606571qee.18
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 09:06:25 -0700 (PDT)
In-Reply-To: <CAJiejCRunA9z=L2zTQP=b+=F2Pf17nG1CNoF1EN7rhvLwuqtKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

Have you made any changes from the default settings? That assert
indicates the MDS couldn't load some data that it needed; the two most
likely things are that the data doesn't exist or that the MDS isn't
allowed to access it due to some permissions problem on the pool in
question.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Apr 11, 2013 at 9:01 PM, Drunkard Zhang <gongfan193@gmail.com> wrote:
> My newly created ceph cluster in ceph-0.60 always crash mds, the last messages:
>
>      0> 2013-04-12 11:48:53.034644 7f691cf64700 -1 mds/MDSTable.cc: In
> function 'void MDSTable::load_2(int, ceph::bufferlist&, Context*)'
> thread 7f691cf64700 time 2013-04-12 11:48:53.033488
> mds/MDSTable.cc: 150: FAILED assert(0)
>
> I thought it was cephx problem, but after disable cephx and restart
> whole cluster, it's still that way.
>
> auth cluster required = none
> auth service required = none
> auth client required = none
>
> Previous setting:
> ;auth cluster required = cephx
> ;auth service required = cephx
> ;auth client required = cephx
> ;cephx require signatures = true
> ;cephx cluster require signatures = true
> ;cephx service require signatures = true
> ;cephx sign messages = true
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
