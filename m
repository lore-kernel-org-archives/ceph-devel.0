From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Geo-replication with RBD
Date: Mon, 18 Feb 2013 15:20:29 +0100
Message-ID: <CAMwB3TixO3gOhP5g+47NbSwpBU7PYV8vT2Ymm0-HgDLjh0RHcQ@mail.gmail.com>
References: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
	<CANygib8Z=+ik3WbPNcyXTkSV3o2wC9+06fp58EnhUax3cgJBng@mail.gmail.com>
	<CAMwB3TiWKJ+e+81B4gDSkNnPMWQRzpqCT7pDJU+d_q0iTfjP5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34094 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab3BROUm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 09:20:42 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so7221335iec.32
        for <ceph-devel@vger.kernel.org>; Mon, 18 Feb 2013 06:20:42 -0800 (PST)
In-Reply-To: <CAMwB3TiWKJ+e+81B4gDSkNnPMWQRzpqCT7pDJU+d_q0iTfjP5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, Sorry for very late response, but i was sick.

Our case is to make a failover rbd instance in another cluster. We are
storing block device images, for some services like Database. We need
to have a two clusters, synchronized, for a quick failover, if first
cluster goes down, or for upgrade with restart, or many other cases.

Volumes are in many sizes: 1-500GB
external block device for kvm vm, like EBS.

On Mon, Feb 18, 2013 at 3:07 PM, S=B3awomir Skowron <szibis@gmail.com> =
wrote:
> Hi, Sorry for very late response, but i was sick.
>
> Our case is to make a failover rbd instance in another cluster. We ar=
e
> storing block device images, for some services like Database. We need=
 to
> have a two clusters, synchronized, for a quick failover, if first clu=
ster
> goes down, or for upgrade with restart, or many other cases.
>
> Volumes are in many sizes: 1-500GB
> external block device for kvm vm, like EBS.
>
>
> On Fri, Feb 1, 2013 at 12:27 AM, Neil Levine <neil.levine@inktank.com=
>
> wrote:
>>
>> Skowron,
>>
>> Can you go into a bit more detail on your specific use-case? What ty=
pe
>> of data are you storing in rbd (type, volume)?
>>
>> Neil
>>
>> On Wed, Jan 30, 2013 at 10:42 PM, Skowron S=B3awomir
>> <slawomir.skowron@grupaonet.pl> wrote:
>> > I make new thread, because i think it's a diffrent case.
>> >
>> > We have managed async geo-replication of s3 service, beetwen two c=
eph
>> > clusters in two DC's, and to amazon s3 as third. All this via s3 A=
PI. I love
>> > to see native RGW geo-replication with described features in anoth=
er thread.
>> >
>> > There is another case. What about RBD replication ?? It's much mor=
e
>> > complicated, and for disaster recovery much more important, just l=
ike in
>> > enterprise storage arrays.
>> > One cluster in two DC's, not solving problem, because we need secu=
rity
>> > in data consistency, and isolation.
>> > Do you thinking about this case ??
>> >
>> > Regards
>> > Slawomir Skowron--
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> -----
> Pozdrawiam
>
> S=B3awek "sZiBis" Skowron



--
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
