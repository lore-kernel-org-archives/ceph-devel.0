From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: .rgw expand number of pg's
Date: Tue, 10 Jan 2012 09:10:56 -0800
Message-ID: <CACLRD_0=RH0arjPsh_d9pJ4j-soMvovG88L89BrjVvZMM0aaGw@mail.gmail.com>
References: <CAMwB3ThYa0A7iOBNXETbJz5GV29o2u=LKZadvq=yfhT3tdDZ-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54537 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab2AJRK6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2012 12:10:58 -0500
Received: by werm1 with SMTP id m1so3653944wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2012 09:10:56 -0800 (PST)
In-Reply-To: <CAMwB3ThYa0A7iOBNXETbJz5GV29o2u=LKZadvq=yfhT3tdDZ-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <slawomir.skowron@gmail.com>
Cc: ceph-devel@vger.kernel.org

At the moment, expanding the number of pgs in a pool is not working.
We hope to get it working in the somewhat near future (probably a few
months).  Are you attempting to expand the number of osds and running
out of pgs?
-Sam

2012/1/10 S=C5=82awomir Skowron <slawomir.skowron@gmail.com>:
> How to expand number of pg's in rgw pool ??
>
> --
> -----
> Pozdrawiam
>
> S=C5=82awek "sZiBis" Skowron
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
