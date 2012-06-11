From: John Axel Eriksson <john@insane.se>
Subject: Re: Ceph questions regarding auth and return on PUT from radosgw
Date: Mon, 11 Jun 2012 15:34:06 +0200
Message-ID: <CAMmJxtJZRRuCd2c5ACe2zX04L7LKyPJ_19kK2gYGoSCAGQ-QpA@mail.gmail.com>
References: <CAMmJxtJyzaqwV2+BgrHwMZSWiLJKhM7948MUuEme-MGjZofuWw@mail.gmail.com>
	<4FD5E74A.8070903@widodh.nl>
	<CAMmJxtL_sGx6fSs2+CZet10JVDPJqebkqreJuHQzhgUxngM-nw@mail.gmail.com>
	<4FD5E9D7.5010200@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57355 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2FKNeG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 09:34:06 -0400
Received: by obbtb18 with SMTP id tb18so6744668obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 06:34:06 -0700 (PDT)
In-Reply-To: <4FD5E9D7.5010200@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Ok so that's the reason for the keys then? To be able to stop an osd
from connecting to the cluster? Won't "ceph osd down" or something
like that stop it from connecting?

Also, the rados command - doesn't that use the config file to connect
to the osds? If I have the correct config file won't that stop me from
accidentally connecting to some other cluster?

I can see how it might be more relevant when you have 1000 osds and
lots of people managing the cluster, but in my case the cluster won't
be all that big. At first I guess only 3 osds which may grow quite a
bit of course but I can't see us needing even 30 osds (we're not a
cloud hosting company and won't be giving access directly to the
storage from the outside).

Actually, it wouldn't be entirely necessary for us to run the radosgw,
however we do wan't an http interface and radosgw gives us one. I'm
not aware of any other http interface available right now (apart from
writing one ourselves, but we'd much rather use something that is
tested and works, we're a small company).

On Mon, Jun 11, 2012 at 2:51 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
>
> On 06/11/2012 02:41 PM, John Axel Eriksson wrote:
>>
>> Oh sorry. I don't think I was clear on the auth question. What I mea=
nt
>> was if the admin.keyring and keys for the osd:s are really necessary
>> in a private ceph-cluster.
>
>
> I'd say: Yes
>
> With keys in place you can ensure that a rogue machine starts bringin=
g down
> your cluster.
>
> Scenario: You take a machine offline in a cluster, let it sit in stor=
age for
> some while and a couple of months later somebody wonders what that ma=
chine
> does.
>
> Plugs it into a switch, power and boots. Suddenly this old machine wh=
ich is
> way behind on software starts participating in your cluster again and=
 could
> potentially bring it all down.
>
> But it could even be even more simple. You set up a second Ceph clust=
er for
> some tests, but while playing with the 'rados' command you accidental=
ly
> connect to the wrong cluster and issue a "rmpool". Oops!
>
> With auth in place you have a barrier against such situations.
>
> Wido
>
>
>>
>> On Mon, Jun 11, 2012 at 2:40 PM, Wido den Hollander<wido@widodh.nl>
>> =A0wrote:
>>>
>>> Hi,
>>>
>>>
>>> On 06/11/2012 02:32 PM, John Axel Eriksson wrote:
>>>>
>>>>
>>>> Is there a point to having auth enabled if I run ceph on an intern=
al
>>>> network, only for use with radosgw (i.e the object storage part)?
>>>> It seems to complicate the setup unnecessarily and ceph doesn't us=
e
>>>> encryption anyway as far as I understand, it's only auth.
>>>> If my network is trusted and I know who has access (and I trust th=
em)
>>>> - is there a point to complicate the setup with key-based auth?
>>>>
>>>
>>> The RADOS Gateway uses the S3 protocol and that requires authentica=
tion
>>> and
>>> authorization.
>>>
>>> When creating a bucket/pool and storing objects, it has to be mappe=
d to a
>>> users inside the RADOS GW.
>>>
>>> I don't know what your exact use-case is, but if it's only internal=
,
>>> isn't
>>> it a possibility to use RADOS natively?
>>>
>>>
>>>> Also, when PUTting something through radosgw, does ceph/rgw return=
 as
>>>> soon as all data has been received or does it return
>>>> when it has ensured N replicas? (I've seen quite a delay after all
>>>> data has been sent before my PUT returns). I'm using nginx (1.2) b=
y
>>>> the way.
>>>
>>>
>>>
>>> iirc it returns when all replicas have received and stored the obje=
ct.
>>>
>>> Wido
>>>
>>>>
>>>> Thanks!
>>>>
>>>> John
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
