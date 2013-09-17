From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [ceph-users] radosgw bucket question
Date: Mon, 16 Sep 2013 19:27:19 -0700
Message-ID: <CABBk=J8o7+2+_gf7=HVkf97_rprwLSpnArOUgr+wC27PgewhTg@mail.gmail.com>
References: <15706d59.2c5d.14129b8dea8.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52395 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab3IQC1U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Sep 2013 22:27:20 -0400
Received: by mail-vc0-f174.google.com with SMTP id gd11so3488598vcb.5
        for <ceph-devel@vger.kernel.org>; Mon, 16 Sep 2013 19:27:19 -0700 (PDT)
In-Reply-To: <15706d59.2c5d.14129b8dea8.Coremail.wkp4666@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6bmP?= <wkp4666@126.com>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 16, 2013 at 7:21 PM, =E9=B9=8F <wkp4666@126.com> wrote:
>
>
> hi
>     So what am I doing wrong? when i run commond:
> radosgw-admin bucket list --uid=3Djohdone   the return is []
> and the commond
> radosgw-admin bucket list --uid=3Dwkp4666 the return is []
> and the commond
> radosgw-admin bucket list    the return  is [mybucket1, mybucket2]
> mybucket1's owner is johdone  , and when i try create a mybucket1 for=
 user
> wkp4666 the result is 409,
> both two users caps is
>
>     "caps" : [{"type": "usages", "perm":"*"}
>                    {"type":"users", "perm":"*"}
>                  ]
>
> does anyone face the same question ? how can i save the question!!!
>
>


What version are you using? What does the following commands return:

$ radosgw-admin  bucket stats --bucket=3Dmybucket1

$ radosgw-admin bucket stats --bucket=3Dmybucket2

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
