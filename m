From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal,
 normal behaviour ?
Date: Mon, 18 Jun 2012 09:22:25 -0500
Message-ID: <4FDF39A1.4060905@inktank.com>
References: <1442f6d7-6fd3-4518-89f3-2bcaa21f1949@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40529 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2FROW2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 10:22:28 -0400
Received: by yenl2 with SMTP id l2so3245659yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 07:22:28 -0700 (PDT)
In-Reply-To: <1442f6d7-6fd3-4518-89f3-2bcaa21f1949@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On 6/18/12 9:04 AM, Alexandre DERUMIER wrote:
> Hi Mark,
>
>>> Sorry I got behind at looking at your output last week. I've create=
d a
>>> seekwatcher movie of your blktrace results here:
>>>
>>> http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg
>
> how do you create seekwatcher movie from blktrace ? (I'd like to crea=
te them myself, seem good to debug)

You'll need to download seekwatcher from Chris Mason's website.  Get th=
e=20
newest unstable version.  To make movies you'll need mencoder.  (It als=
o=20
needs numpy and matplotlib).  There is a small bug in the code where "&=
>=20
/dev/null" should be changed to "> /dev/null 2>&1".  If you have troubl=
e=20
let me know and I can send you a fixed version of the script.

>
>
>>> The results match up well with your iostat output. Peaks and valley=
s in
>>> the writes every couple of seconds. Low numbers of seeks, so probab=
ly
>>> not limited by the filestore (a quick "osd tell X bench" might conf=
irm
>>> that).
>
> yet, i'm pretty sure that the limitation if not hardware. (each osd a=
re 15k drive, handling around 10MB/S during the test, so I think it sho=
uld be ok ^_^ )
> how do you use "osd tell X bench" ?

Yeah, I just wanted to make sure that the constant writes weren't=20
because the filestore was falling behind.  You may want to take a look=20
at some of the information that is provided by the admin socket for the=
=20
OSD while the test is running. dump_ops_in_flight, perf schema, and per=
f=20
dump are all useful.

Try:

ceph --admin-daemon <socket> help

The osd admin sockets should be available in /var/run/ceph.

>
>>> I'm wondering if you increase "filestore max sync interval" to some=
thing
>>> bigger (default is 5s) if you'd see somewhat different behavior. Ma=
ybe
>>> try something like 30s and see what happens?
>
> I have done test with 30s, that doesn't change nothing.
> I have try with filestore min sync interval =3D 29  + filestore max s=
ync interval =3D 30
>

Nuts.  Do you still see the little peaks/valleys every couple seconds?

>
>
>
> ----- Mail original -----
>
> De: "Mark Nelson"<mark.nelson@inktank.com>
> =C3=80: "Alexandre DERUMIER"<aderumier@odiso.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Lundi 18 Juin 2012 15:29:58
> Objet: Re: iostat show constants write to osd disk with writeahead jo=
urnal, normal behaviour ?
>
> On 6/18/12 7:34 AM, Alexandre DERUMIER wrote:
>> Hi,
>>
>> I'm doing test with rados bench, and I see constant writes to osd di=
sks.
>> Is it the normal behaviour ? with write-ahead should write occur eac=
h 20-30 seconde ?
>>
>>
>> Cluster is
>> 3 nodes (ubuntu precise - glibc 2.14 - ceph 0.47.2) with each node 1=
 journal on tmpfs 8GB - 1 osd (xfs) on sas disk - 1 gigabit link
>>
>>
>> 8GB journal can handle easily 20s of write (1 gigabit link)
>>
>> [osd]
>> osd data =3D /srv/osd.$id
>> osd journal =3D /tmpfs/osd.$id.journal
>> osd journal size =3D 8000
>> journal dio =3D false
>> filestore journal parallel =3D false
>> filestore journal writeahead =3D true
>> filestore fiemap =3D false
>>
>>
>>
>>
>> I have done tests with differents kernel (3.0,3.2,3.4) , differents =
filesystem (xfs,btrfs,ext4), forced journal mode to writeahead.
>> Bench were done write rados bench and fio.
>>
>> I always have constant write since the first second of bench start.
>>
>> Any idea ?
>
> Hi Alex,
>
> Sorry I got behind at looking at your output last week. I've created =
a
> seekwatcher movie of your blktrace results here:
>
> http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg
>
> The results match up well with your iostat output. Peaks and valleys =
in
> the writes every couple of seconds. Low numbers of seeks, so probably
> not limited by the filestore (a quick "osd tell X bench" might confir=
m
> that).
>
> I'm wondering if you increase "filestore max sync interval" to someth=
ing
> bigger (default is 5s) if you'd see somewhat different behavior. Mayb=
e
> try something like 30s and see what happens?
>
> Mark
>
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
