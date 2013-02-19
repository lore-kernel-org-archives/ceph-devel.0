From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Geo-replication with RBD
Date: Tue, 19 Feb 2013 10:22:50 +0100
Message-ID: <CAOLwVU=L2SK=uHh+9nRihsPN3gawyHnnTtyBm98oKXNMZ_U9Aw@mail.gmail.com>
References: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
 <CANygib8Z=+ik3WbPNcyXTkSV3o2wC9+06fp58EnhUax3cgJBng@mail.gmail.com>
 <CAMwB3TiWKJ+e+81B4gDSkNnPMWQRzpqCT7pDJU+d_q0iTfjP5A@mail.gmail.com> <CAMwB3TixO3gOhP5g+47NbSwpBU7PYV8vT2Ymm0-HgDLjh0RHcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:52003 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758376Ab3BSJXK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 04:23:10 -0500
Received: by mail-oa0-f51.google.com with SMTP id h2so6720187oag.10
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 01:23:10 -0800 (PST)
In-Reply-To: <CAMwB3TixO3gOhP5g+47NbSwpBU7PYV8vT2Ymm0-HgDLjh0RHcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: Neil Levine <neil.levine@inktank.com>, =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

=46or of all, I have some questions about your setup:

* What are your requirements?
* Are the DCs far from each others?

If they are reasonably close to each others, you can setup a single
cluster, with replicas across both DCs and manage the RBD devices with
pacemaker.

Cheers.

--
Regards,
S=C3=A9bastien Han.


On Mon, Feb 18, 2013 at 3:20 PM, S=C5=82awomir Skowron <szibis@gmail.co=
m> wrote:
> Hi, Sorry for very late response, but i was sick.
>
> Our case is to make a failover rbd instance in another cluster. We ar=
e
> storing block device images, for some services like Database. We need
> to have a two clusters, synchronized, for a quick failover, if first
> cluster goes down, or for upgrade with restart, or many other cases.
>
> Volumes are in many sizes: 1-500GB
> external block device for kvm vm, like EBS.
>
> On Mon, Feb 18, 2013 at 3:07 PM, S=C5=82awomir Skowron <szibis@gmail.=
com> wrote:
>> Hi, Sorry for very late response, but i was sick.
>>
>> Our case is to make a failover rbd instance in another cluster. We a=
re
>> storing block device images, for some services like Database. We nee=
d to
>> have a two clusters, synchronized, for a quick failover, if first cl=
uster
>> goes down, or for upgrade with restart, or many other cases.
>>
>> Volumes are in many sizes: 1-500GB
>> external block device for kvm vm, like EBS.
>>
>>
>> On Fri, Feb 1, 2013 at 12:27 AM, Neil Levine <neil.levine@inktank.co=
m>
>> wrote:
>>>
>>> Skowron,
>>>
>>> Can you go into a bit more detail on your specific use-case? What t=
ype
>>> of data are you storing in rbd (type, volume)?
>>>
>>> Neil
>>>
>>> On Wed, Jan 30, 2013 at 10:42 PM, Skowron S=C5=82awomir
>>> <slawomir.skowron@grupaonet.pl> wrote:
>>> > I make new thread, because i think it's a diffrent case.
>>> >
>>> > We have managed async geo-replication of s3 service, beetwen two =
ceph
>>> > clusters in two DC's, and to amazon s3 as third. All this via s3 =
API. I love
>>> > to see native RGW geo-replication with described features in anot=
her thread.
>>> >
>>> > There is another case. What about RBD replication ?? It's much mo=
re
>>> > complicated, and for disaster recovery much more important, just =
like in
>>> > enterprise storage arrays.
>>> > One cluster in two DC's, not solving problem, because we need sec=
urity
>>> > in data consistency, and isolation.
>>> > Do you thinking about this case ??
>>> >
>>> > Regards
>>> > Slawomir Skowron--
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S=C5=82awek "sZiBis" Skowron
>
>
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
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
