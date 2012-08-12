From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: No lock on RBD allow several mount on different servers...
Date: Sat, 11 Aug 2012 18:35:29 -0600
Message-ID: <CALFpzo4up8oqKNESWDzm2AVpZ0Z5WyB5PQX-8Cu2+Sga7i=zbQ@mail.gmail.com>
References: <CAOLwVUkWEOdo_HjKRZwU0rGi4S8rA33-o5gCMBJvhJahkrLXpQ@mail.gmail.com>
	<CALFpzo49Urnf8rnFCQ=wQ8eFMR0-8FWh2=9nKrCAxb+0Xm0rVQ@mail.gmail.com>
	<CAOLwVUnSUpAC69W48gbz-+7L7+p9z5tioODh_hPwVEt39GDvHw@mail.gmail.com>
	<CALFpzo4X7iL6aEUtqyEBp4AMDxKkK9wtwPx35WQVauYQbe8Hng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36489 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2HLAfa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Aug 2012 20:35:30 -0400
Received: by weyx8 with SMTP id x8so1761514wey.19
        for <ceph-devel@vger.kernel.org>; Sat, 11 Aug 2012 17:35:29 -0700 (PDT)
In-Reply-To: <CALFpzo4X7iL6aEUtqyEBp4AMDxKkK9wtwPx35WQVauYQbe8Hng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

What I mean is that my understanding of RBD is that it is designed to
do no more than to present a block device. In that context, what
you're asking is more like whether they will support persistent
reservations.  RBD being just a block device is at a lower level, and
you'd have to add something on top of it that is aware of
sharing/locking.

On Sat, Aug 11, 2012 at 6:26 PM, Marcus Sorensen <shadowsor@gmail.com> =
wrote:
> But you put a /dev/drbd atop a block device.
>
> On Aug 11, 2012 6:09 PM, "S=E9bastien Han" <han.sebastien@gmail.com> =
wrote:
>>
>> Hi Marcus,
>>
>> I didn't really get your first sentence, but I don't think so, for
>> instance DRBD manages his own /dev/drbd device and voluntary puts a
>> lock on a resource with a 'secondary' state, like the single-primary
>> mode. So I would say that it's even higher than lower...
>>
>> Cheers!
>>
>> On Sun, Aug 12, 2012 at 1:58 AM, Marcus Sorensen <shadowsor@gmail.co=
m>
>> wrote:
>> > Isn't it supposed to be lower level than that? More like just a bl=
ock
>> > device
>> > such as a SAN or iscsi device? DRBD(GFS,OCFS,CLVM) goes on top of =
that.
>> >
>> > On Aug 11, 2012 5:51 PM, "S=E9bastien Han" <han.sebastien@gmail.co=
m>
>> > wrote:
>> >>
>> >> Hi guys,
>> >>
>> >> With RBD images, the theory makes possible to mount them multiple
>> >> times on different servers, of course **no one** wants that. If y=
ou
>> >> care about the consistency of your data :D
>> >> I was wondering if ceph has any lock ability on the RBD device li=
ke
>> >> DRBD does with secondary resource. Apparently not, I was able to =
mount
>> >> an image on multiple server and wrote data on both.
>> >>
>> >> Is this an incoming feature?
>> >>
>> >> I don't really know the difficulty level that this kind of featur=
e
>> >> implies, but it would be nice to have it.
>> >>
>> >> Cheers!
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>> >> in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
