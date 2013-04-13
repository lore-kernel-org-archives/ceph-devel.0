From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: new ceph-0.60 always crash mds
Date: Sat, 13 Apr 2013 08:19:55 +0800
Message-ID: <CAJiejCS9cgvtGTtYEcmw7DMsP0EsUx_fg10RuLdeGo-rmFmGdw@mail.gmail.com>
References: <CAJiejCRunA9z=L2zTQP=b+=F2Pf17nG1CNoF1EN7rhvLwuqtKA@mail.gmail.com>
 <CAPYLRzgUTOFoiAr-siPKxPr_GgiJs69KgBWSc3Hy-qxqAaTzwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:61546 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab3DMAUQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 20:20:16 -0400
Received: by mail-qc0-f172.google.com with SMTP id b25so1464059qca.31
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 17:20:15 -0700 (PDT)
In-Reply-To: <CAPYLRzgUTOFoiAr-siPKxPr_GgiJs69KgBWSc3Hy-qxqAaTzwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

2013/4/13 Gregory Farnum <greg@inktank.com>:
> Have you made any changes from the default settings? That assert

Do you means one of these settings?
auth cluster required = cephx
auth service required = cephx
auth client required = cephx
cephx require signatures = true
cephx cluster require signatures = true
cephx service require signatures = true
cephx sign messages = true
keyring = /etc/ceph/keyring

yes, these was my testing configs. And the command created the cluster was:
mkcephfs -v -a -c /etc/ceph/ceph.conf --mkfs

I thought it was permission problem, so I grabbed just all keys from
'ceph auth list' into /etc/ceph/keyring, mds still crashs.

I wondering which point I should check for MDS's permission? Is it
just 'ceph auth list' ?

> indicates the MDS couldn't load some data that it needed; the two most
> likely things are that the data doesn't exist or that the MDS isn't
> allowed to access it due to some permissions problem on the pool in
> question.

>
> On Thu, Apr 11, 2013 at 9:01 PM, Drunkard Zhang <gongfan193@gmail.com> wrote:
>> My newly created ceph cluster in ceph-0.60 always crash mds, the last messages:
>>
>>      0> 2013-04-12 11:48:53.034644 7f691cf64700 -1 mds/MDSTable.cc: In
>> function 'void MDSTable::load_2(int, ceph::bufferlist&, Context*)'
>> thread 7f691cf64700 time 2013-04-12 11:48:53.033488
>> mds/MDSTable.cc: 150: FAILED assert(0)
>>
>> I thought it was cephx problem, but after disable cephx and restart
>> whole cluster, it's still that way.
>>
>> auth cluster required = none
>> auth service required = none
>> auth client required = none
>>
>> Previous setting:
>> ;auth cluster required = cephx
>> ;auth service required = cephx
>> ;auth client required = cephx
>> ;cephx require signatures = true
>> ;cephx cluster require signatures = true
>> ;cephx service require signatures = true
>> ;cephx sign messages = true
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
