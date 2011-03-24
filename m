From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: a question about laggy mds
Date: Wed, 23 Mar 2011 19:55:21 -0700
Message-ID: <AANLkTin01idiMLVDb9R9OCg+g8hj867GoWxp9W9DXsWw@mail.gmail.com>
References: <AANLkTikFcmEcyEjoVcT_s-3dTvqLsiy8MhmXW-ZSD6to@mail.gmail.com>
	<AANLkTimecWXyouv-0R8RuZampTyf=zQq3-UBBvJZ=axE@mail.gmail.com>
	<AANLkTinZqb4RxQMxa0QuVc5Cruf1Pj9Ky+dXuaQBWBrY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54846 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab1CXCzX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 22:55:23 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3DB47C064
	for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:55:23 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id DEF5CC062
	for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:55:22 -0700 (PDT)
Received: by ewy4 with SMTP id 4so2330921ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:55:21 -0700 (PDT)
In-Reply-To: <AANLkTinZqb4RxQMxa0QuVc5Cruf1Pj9Ky+dXuaQBWBrY@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/3/23 huang jun <hjwsm1989@gmail.com>:
> hi=A3=AC
> yes=A3=ACthe mds is overloaded. there are four clients in the ceph
> cluster=A3=ACand each of them send a great many of requests to the md=
s.  i
> think the standby should become active and share the workload rather
> than take over the laggy one in this case. what do you think about=A3=
=BF
You can do that by setting the max_mds_num to 2 to see if it will help.=
 :)
http://ceph.newdream.net/wiki/MDS_cluster_expansion

As a configuration issue, that's not something that the cluster is
going to do dynamically, though. Also note that if all your activity
is in a single directory then multiple MDSes won't help much yet --
directory fragmentation (which allows splitting a directory across
more than one MDS) isn't enabled by default yet but should be in a
release or two.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
