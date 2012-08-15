From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: No lock on RBD allow several mount on different servers...
Date: Wed, 15 Aug 2012 10:18:38 +0200
Message-ID: <CAOLwVUmbK45Vz7H16ZFt6xHm-4R6PNAZ8k0zE7=i4v=ze7yW0w@mail.gmail.com>
References: <CAOLwVUkWEOdo_HjKRZwU0rGi4S8rA33-o5gCMBJvhJahkrLXpQ@mail.gmail.com>
 <CALFpzo49Urnf8rnFCQ=wQ8eFMR0-8FWh2=9nKrCAxb+0Xm0rVQ@mail.gmail.com>
 <CAOLwVUnSUpAC69W48gbz-+7L7+p9z5tioODh_hPwVEt39GDvHw@mail.gmail.com>
 <CALFpzo4X7iL6aEUtqyEBp4AMDxKkK9wtwPx35WQVauYQbe8Hng@mail.gmail.com>
 <CALFpzo4up8oqKNESWDzm2AVpZ0Z5WyB5PQX-8Cu2+Sga7i=zbQ@mail.gmail.com>
 <CALFpzo7YicrNh8qCoTAe2hUU+onkci8PbggKWfUjn1TJ635HUw@mail.gmail.com>
 <06A44B2B-FA7F-418C-B9D2-D0602F4EB95B@gmail.com> <alpine.DEB.2.00.1208120825320.19162@cobra.newdream.net>
 <CAPYLRzhXmwt2AzvmUPZQWeHn75ViFTuCVq5EFwmiG+wV8cjKDQ@mail.gmail.com>
 <502937E1.6010000@inktank.com> <CAC-hyiE_iOcSVqnq9rsy0WFZErbCBmMGAK1hjeUrBoUbLE5mDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41745 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab2HOITA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Aug 2012 04:19:00 -0400
Received: by lbbgj3 with SMTP id gj3so721756lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Aug 2012 01:18:59 -0700 (PDT)
In-Reply-To: <CAC-hyiE_iOcSVqnq9rsy0WFZErbCBmMGAK1hjeUrBoUbLE5mDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Marcus Sorensen <shadowsor@gmail.com>

Hi guys,

Thank you for the tremendous answers :D
How far are we to see this feature in the stable branch? Part of the
0.48.x or far away from that?

Cheers!

On Mon, Aug 13, 2012 at 7:49 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Mon, Aug 13, 2012 at 10:22 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> On 08/13/2012 09:55 AM, Gregory Farnum wrote:
>>>
>>> We've discussed some of the issues here a little bit before. See
>>> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/7094 if
>>> you're interested.
>>>
>>> Josh, can you discuss the current status of the advisory locking?
>>> -Greg
>>
>>
>> Yehuda reworked it into a generic rados class so it can be used outside
>> of rbd. It hasn't been re-integrated with rbd yet, and I haven't looked
>> at it closely since the generalization. Yehuda could describe it in
>> more detail.
>>
>
> The lock objclass provides a generic way to set locks on objects. It
> is a cooperative scheme. The following operations are available:
>  - lock (exclusive or shared)
>  - unlock -- remove a lock that was set by the same client instance
>  - break -- remove a lock that was set by a different client instance
>
> A lock can be set indefinitely, or can be timed out after a specified
> period. A lock can be renewed.
>
> For the use of rbd, a client will have to set an exclusive lock on the
> rbd header, with a specified (and relatively short timeout). It
> shouldn't do any I/O operations without holding that lock. It'll have
> to renew that lock, and failing to do so (meaning the lock was broken
> by another client) will require it to stop any I/O operations. The
> overriding client should wait for the original client's lock period
> timeout before initiating a new new I/O. As I said, this is a
> cooperative scheme, it doesn't prevent a buggy/bad client to send
> unwanted I/Os to the osds. A client cannot know that its lock was
> broken without explicitly checking it, or trying to renew it (when
> it's an exclusive lock). We can achieve that using watch/notify,
> though I'm not sure it's worth the extra trouble (watch/notify doesn't
> solve everything either).
>
>
> Yehuda
