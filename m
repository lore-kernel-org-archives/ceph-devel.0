From: Sebastien HAN <han.sebastien@gmail.com>
Subject: Re: No lock on RBD allow several mount on different servers...
Date: Sun, 12 Aug 2012 10:40:30 +0200
Message-ID: <06A44B2B-FA7F-418C-B9D2-D0602F4EB95B@gmail.com>
References: <CAOLwVUkWEOdo_HjKRZwU0rGi4S8rA33-o5gCMBJvhJahkrLXpQ@mail.gmail.com> <CALFpzo49Urnf8rnFCQ=wQ8eFMR0-8FWh2=9nKrCAxb+0Xm0rVQ@mail.gmail.com> <CAOLwVUnSUpAC69W48gbz-+7L7+p9z5tioODh_hPwVEt39GDvHw@mail.gmail.com> <CALFpzo4X7iL6aEUtqyEBp4AMDxKkK9wtwPx35WQVauYQbe8Hng@mail.gmail.com> <CALFpzo4up8oqKNESWDzm2AVpZ0Z5WyB5PQX-8Cu2+Sga7i=zbQ@mail.gmail.com> <CALFpzo7YicrNh8qCoTAe2hUU+onkci8PbggKWfUjn1TJ635HUw@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59244 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab2HLIkg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Aug 2012 04:40:36 -0400
Received: by wicr5 with SMTP id r5so1658565wic.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Aug 2012 01:40:35 -0700 (PDT)
In-Reply-To: <CALFpzo7YicrNh8qCoTAe2hUU+onkci8PbggKWfUjn1TJ635HUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Marcus,

I completely understand your point and of course I'm agree. Even if thi=
s King of locking occurs with software on top of the block device, it d=
oesn't look impossible to me. And it's more than persistent reservation=
 because it's also fearly depend of the filesystem on top of it. For ex=
ample, you would like to be able to allow a dual-primary mode...

After our brief exchange, I have to admit that this looks harder than I=
 expected. Maybe this would require a little daemon running on the serv=
er where the device is mapped... A little bit overkill and out of the d=
esign...

I'm also curious to hear the output from the devs!=20

Ps: I knew the rbd caching but I never tried it, I will.=20

Thanks you again :-)

Cheers!

On 12 ao=C3=BBt 2012, at 02:53, Marcus Sorensen <shadowsor@gmail.com> w=
rote:

> Oh, and note there's recently been an RBD caching mode added, this
> would mess up any multi-mount or sharing you'd attempt to do of an RB=
D
> device. It's optional, though.
>=20
> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/6402
>=20
> Still, you'd probably need something on top of it to manage sharing,
> just like with any other block device.  I'm interested to see what th=
e
> devs say though.
>=20
> On Sat, Aug 11, 2012 at 6:35 PM, Marcus Sorensen <shadowsor@gmail.com=
> wrote:
>> What I mean is that my understanding of RBD is that it is designed t=
o
>> do no more than to present a block device. In that context, what
>> you're asking is more like whether they will support persistent
>> reservations.  RBD being just a block device is at a lower level, an=
d
>> you'd have to add something on top of it that is aware of
>> sharing/locking.
>>=20
>> On Sat, Aug 11, 2012 at 6:26 PM, Marcus Sorensen <shadowsor@gmail.co=
m> wrote:
>>> But you put a /dev/drbd atop a block device.
>>>=20
>>> On Aug 11, 2012 6:09 PM, "S=C3=A9bastien Han" <han.sebastien@gmail.=
com> wrote:
>>>>=20
>>>> Hi Marcus,
>>>>=20
>>>> I didn't really get your first sentence, but I don't think so, for
>>>> instance DRBD manages his own /dev/drbd device and voluntary puts =
a
>>>> lock on a resource with a 'secondary' state, like the single-prima=
ry
>>>> mode. So I would say that it's even higher than lower...
>>>>=20
>>>> Cheers!
>>>>=20
>>>> On Sun, Aug 12, 2012 at 1:58 AM, Marcus Sorensen <shadowsor@gmail.=
com>
>>>> wrote:
>>>>> Isn't it supposed to be lower level than that? More like just a b=
lock
>>>>> device
>>>>> such as a SAN or iscsi device? DRBD(GFS,OCFS,CLVM) goes on top of=
 that.
>>>>>=20
>>>>> On Aug 11, 2012 5:51 PM, "S=C3=A9bastien Han" <han.sebastien@gmai=
l.com>
>>>>> wrote:
>>>>>>=20
>>>>>> Hi guys,
>>>>>>=20
>>>>>> With RBD images, the theory makes possible to mount them multipl=
e
>>>>>> times on different servers, of course **no one** wants that. If =
you
>>>>>> care about the consistency of your data :D
>>>>>> I was wondering if ceph has any lock ability on the RBD device l=
ike
>>>>>> DRBD does with secondary resource. Apparently not, I was able to=
 mount
>>>>>> an image on multiple server and wrote data on both.
>>>>>>=20
>>>>>> Is this an incoming feature?
>>>>>>=20
>>>>>> I don't really know the difficulty level that this kind of featu=
re
>>>>>> implies, but it would be nice to have it.
>>>>>>=20
>>>>>> Cheers!
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
