From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: No lock on RBD allow several mount on different servers...
Date: Sat, 11 Aug 2012 18:53:10 -0600
Message-ID: <CALFpzo7YicrNh8qCoTAe2hUU+onkci8PbggKWfUjn1TJ635HUw@mail.gmail.com>
References: <CAOLwVUkWEOdo_HjKRZwU0rGi4S8rA33-o5gCMBJvhJahkrLXpQ@mail.gmail.com>
	<CALFpzo49Urnf8rnFCQ=wQ8eFMR0-8FWh2=9nKrCAxb+0Xm0rVQ@mail.gmail.com>
	<CAOLwVUnSUpAC69W48gbz-+7L7+p9z5tioODh_hPwVEt39GDvHw@mail.gmail.com>
	<CALFpzo4X7iL6aEUtqyEBp4AMDxKkK9wtwPx35WQVauYQbe8Hng@mail.gmail.com>
	<CALFpzo4up8oqKNESWDzm2AVpZ0Z5WyB5PQX-8Cu2+Sga7i=zbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34085 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab2HLAxM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Aug 2012 20:53:12 -0400
Received: by wibhr14 with SMTP id hr14so2394555wib.1
        for <ceph-devel@vger.kernel.org>; Sat, 11 Aug 2012 17:53:11 -0700 (PDT)
In-Reply-To: <CALFpzo4up8oqKNESWDzm2AVpZ0Z5WyB5PQX-8Cu2+Sga7i=zbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Oh, and note there's recently been an RBD caching mode added, this
would mess up any multi-mount or sharing you'd attempt to do of an RBD
device. It's optional, though.

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/6402

Still, you'd probably need something on top of it to manage sharing,
just like with any other block device.  I'm interested to see what the
devs say though.

On Sat, Aug 11, 2012 at 6:35 PM, Marcus Sorensen <shadowsor@gmail.com> =
wrote:
> What I mean is that my understanding of RBD is that it is designed to
> do no more than to present a block device. In that context, what
> you're asking is more like whether they will support persistent
> reservations.  RBD being just a block device is at a lower level, and
> you'd have to add something on top of it that is aware of
> sharing/locking.
>
> On Sat, Aug 11, 2012 at 6:26 PM, Marcus Sorensen <shadowsor@gmail.com=
> wrote:
>> But you put a /dev/drbd atop a block device.
>>
>> On Aug 11, 2012 6:09 PM, "S=E9bastien Han" <han.sebastien@gmail.com>=
 wrote:
>>>
>>> Hi Marcus,
>>>
>>> I didn't really get your first sentence, but I don't think so, for
>>> instance DRBD manages his own /dev/drbd device and voluntary puts a
>>> lock on a resource with a 'secondary' state, like the single-primar=
y
>>> mode. So I would say that it's even higher than lower...
>>>
>>> Cheers!
>>>
>>> On Sun, Aug 12, 2012 at 1:58 AM, Marcus Sorensen <shadowsor@gmail.c=
om>
>>> wrote:
>>> > Isn't it supposed to be lower level than that? More like just a b=
lock
>>> > device
>>> > such as a SAN or iscsi device? DRBD(GFS,OCFS,CLVM) goes on top of=
 that.
>>> >
>>> > On Aug 11, 2012 5:51 PM, "S=E9bastien Han" <han.sebastien@gmail.c=
om>
>>> > wrote:
>>> >>
>>> >> Hi guys,
>>> >>
>>> >> With RBD images, the theory makes possible to mount them multipl=
e
>>> >> times on different servers, of course **no one** wants that. If =
you
>>> >> care about the consistency of your data :D
>>> >> I was wondering if ceph has any lock ability on the RBD device l=
ike
>>> >> DRBD does with secondary resource. Apparently not, I was able to=
 mount
>>> >> an image on multiple server and wrote data on both.
>>> >>
>>> >> Is this an incoming feature?
>>> >>
>>> >> I don't really know the difficulty level that this kind of featu=
re
>>> >> implies, but it would be nice to have it.
>>> >>
>>> >> Cheers!
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>> >> in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
