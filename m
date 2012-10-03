From: Gregory Farnum <greg@inktank.com>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Wed, 3 Oct 2012 14:26:28 -0700
Message-ID: <CAPYLRziL9_BvUgAAcef12AnLROJyBi4Zu0jxBkAG7UfZiwkLSg@mail.gmail.com>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com>
	<alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net>
	<CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com>
	<CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51721 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab2JCV03 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 17:26:29 -0400
Received: by iagy32 with SMTP id y32so1262158iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 14:26:28 -0700 (PDT)
In-Reply-To: <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@inktank.com>, Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

Sorry I haven't provided any feedback on this either =97=A0it's still i=
n
my queue but I've had a great many things to do since you sent it
along. :)
-Greg

On Wed, Oct 3, 2012 at 12:34 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wro=
te:
> Hi Sage,
>
> I wanted to touch base on this Java bindings patch series to make sur=
e
> this can become a solid foundation for the Hadoop shim clean-up. Were
> there any specific issues with this, other than not yet having a majo=
r
> consumer?
>
> -Noah
>
> On Thu, Sep 6, 2012 at 11:02 AM, Noah Watkins <jayhawk@cs.ucsc.edu> w=
rote:
>> On Thu, Sep 6, 2012 at 8:42 AM, Sage Weil <sage@inktank.com> wrote:
>>>
>>> Also, I noticed the automake patch removes CephException.java, adde=
d in
>>> the previous patch... probably an accident?
>>
>> I left CephException out intentionally because it could be replaced =
by
>> generic exceptions in Java like IOException or FileNotFoundException=
=2E
>> My belief is that CephException (and specializations of this) will
>> need to be re-introduced as more error cases are covered. For exampl=
e,
>> I think we'll want a CephBadFileDescriptor, but currently libcephfs
>> doesn't appear to return -EBADF (the client is crashing do to fd_map
>> assert). So, the Java wrappers should be as stable as the C API, but
>> both seem to need some loose ends tied up.
>>
>>> Can't wait to pull this in!  BTW, Noah, do you know if this is stil=
l an
>>> issue?
>>>
>>>         http://tracker.newdream.net/issues/2778
>>
>> It does appear that -ENOENT is now returned. I added a unit test tha=
t
>> expects FileNotFoundException and that works out nicely.
>>
>> - Noah
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
