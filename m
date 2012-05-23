From: Guilhem LETTRON <guilhem.lettron@gmail.com>
Subject: Re: RGW, future directions
Date: Wed, 23 May 2012 18:12:48 +0200
Message-ID: <CAMQoE_0MYWyBGfNkv51QMh18t6HbaA6scrVSNwrmHrUW0aiRCg@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50392 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965054Ab2EWQNJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 12:13:09 -0400
Received: by yhmm54 with SMTP id m54so6735790yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 09:13:08 -0700 (PDT)
In-Reply-To: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

2012/5/22 Yehuda Sadeh <yehuda@inktank.com>:
> RGW is maturing. Beside looking at performance, which highly ties int=
o
> RADOS performance, we'd like to hear whether there are certain pain
> points or future directions that you (you as in the ceph community)
> would like to see us taking.
>
> There are a few directions that we were thinking about:

> 3. New features
>
> Some examples:
>
> =A0- multitenancy: api for domains and user management
> =A0- snapshots
> =A0- computation front end: upload object, then do some data
> transformation/calculation.
> =A0- simple key-value api

+1 any new feature can be a new solution for futur needs.

> 5. Native apache/nginx module or embedded web server
>
> We still need to prove that the web server is a bottleneck, or poses
> scaling issues. Writing a correct native nginx module will require
> turning rgw process model into event driven, which is not going to be
> easy.

It is, for me the #1 feature :
- I only use Nginx for everythings... instead radosgw
- another process / another deamon / another problem
- resolve once for all the "buffering" problem : only apache/fastcgi
can send without buffering. And when you send BIG files, it's not an
option.

> 8. Administration tools improvement
>
> We can always do better there.

Agree, bucket / pool management is quite an ordeal.
It come (of course) with a better documentation.

> Thanks,
> Yehuda

Thanks,
Guilhem Lettron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
