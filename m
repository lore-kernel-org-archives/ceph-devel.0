From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: Fwd: S3 API Compatibility support
Date: Tue, 12 Aug 2014 22:47:00 +0530
Message-ID: <CANA9Uk5juQrjhn--tsKRaxYDJvML_6uLCYhEhHOgrxry4yYb-A@mail.gmail.com>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com>
	<CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
	<alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
	<CANA9Uk468XOE1cr935HY1y+tSnu-xp6QPaj7uCpZNQbJhg-pOA@mail.gmail.com>
	<CABBk=J8+3K28M-RNf+ULx0TnTMmGxdymJDLeFMft-EX8PhS_4A@mail.gmail.com>
	<CANA9Uk58WqPoH-mGiuNiXwfJK1YJtozxOjhgmDeKDq585xqx9w@mail.gmail.com>
	<CANA9Uk5u5q4CGDPat+rdPVY=e-bYA6gG+aii6zMAoxUdK+CQuA@mail.gmail.com>
	<CABBk=J9Au5aX7AKnbM5d=1HOpd2EAdcteyn=uNSZ2jn9UK9HJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:49223 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaHLRRC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 13:17:02 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so8251312lab.35
        for <ceph-devel@vger.kernel.org>; Tue, 12 Aug 2014 10:17:00 -0700 (PDT)
In-Reply-To: <CABBk=J9Au5aX7AKnbM5d=1HOpd2EAdcteyn=uNSZ2jn9UK9HJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks Yehuda. I am testing the S3 APIs suing the openstack+ceph.
Could able test a couple of APIs like put/get/delete bucket (using the
boto python libraries). When I tried for get bucket location I got an
error mentioned in my previous email.

And explored the ceph source code and not able see the appropriate
code/function for "get_bucket_location". But as per the previous email
discuss,
the bucket_location supported as part multi-region support.
Let me know, if I miss something here.

Thanks
Swami
