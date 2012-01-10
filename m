From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: .rgw expand number of pg's
Date: Tue, 10 Jan 2012 22:27:43 +0100
Message-ID: <-5608777025883579446@unknownmsgid>
References: <CAMwB3ThYa0A7iOBNXETbJz5GV29o2u=LKZadvq=yfhT3tdDZ-Q@mail.gmail.com>
 <6752061.143.1326216212374.JavaMail.mobile-sync@vbkn16>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55007 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab2AJV1q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2012 16:27:46 -0500
Received: by wibhm6 with SMTP id hm6so18831wib.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2012 13:27:44 -0800 (PST)
In-Reply-To: <6752061.143.1326216212374.JavaMail.mobile-sync@vbkn16>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Maybe i missunderstood problem, but i see something like this.

My setup is 3 node cluster. 78 osd and 3 mons. At the top of the
cluster working radosgw on every machine. Every pool have a 3
replicas. Default politics for replicas is host in racks, and every
machine is in other rack.

When i do a stress test via s3 client, writing a lot of new object via
balancer to the cluster i discovered, that only 3 osd are involved.
This means that only one osd on every machine working in one time,
when the object are writen via radosgw.

Thats why i write this mail about increase number of pgs in radosgw
pool. Maybe i am wrong, but how i can perform this better, more
parallel, to use power of many drives (osd's) ??

=46or example when i use a rbd in this case, usage of osd devices is
more random, and parallel.

Pozdrawiam

iSS

On 10 sty 2012, at 18:11, Samuel Just <sam.just@dreamhost.com> wrote:

> At the moment, expanding the number of pgs in a pool is not working.
> We hope to get it working in the somewhat near future (probably a few
> months).  Are you attempting to expand the number of osds and running
> out of pgs?
> -Sam
>
> 2012/1/10 S=C5=82awomir Skowron <slawomir.skowron@gmail.com>:
>> How to expand number of pg's in rgw pool ??
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S=C5=82awek "sZiBis" Skowron
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
