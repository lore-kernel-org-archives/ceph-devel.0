From: Samuel Just <sam.just@inktank.com>
Subject: Re: set_alloc_hint old osds
Date: Thu, 11 Sep 2014 13:46:13 -0700
Message-ID: <CA+4uBUb_0K35iYGnEfjprZXpM362=qqMmw0esjJqwRnFKESJCw@mail.gmail.com>
References: <CA+4uBUaAW7Umzg=jb-ksWx_ief2f1oq498KrBJY22ZBATU6EMA@mail.gmail.com>
	<CAPYLRziC+VH87z3A2yv1hRQX3H8-jSHuC1Or3T+VF2oe92xE4A@mail.gmail.com>
	<CA+4uBUaKubMmKXV5-ROwkO-CsxW3+bXb-TPmXa9aAnZLgJLtwQ@mail.gmail.com>
	<CAPYLRzigyvOr_1-xYeq-kDVEowS3pXjd_6t7j-=W0sUOsRqHyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:45838 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbaIKUqR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 16:46:17 -0400
Received: by mail-qa0-f44.google.com with SMTP id w8so1583919qac.17
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 13:46:14 -0700 (PDT)
In-Reply-To: <CAPYLRzigyvOr_1-xYeq-kDVEowS3pXjd_6t7j-=W0sUOsRqHyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ilya Dryomov <idryomov@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

No, we don't put the transaction into the pg log.
-Sam

On Thu, Sep 11, 2014 at 1:40 PM, Gregory Farnum <greg@inktank.com> wrote:
> Does the hint not go into the pg log? Which could be retried on an older OSD?
>
> On Thu, Sep 11, 2014 at 1:33 PM, Samuel Just <sam.just@inktank.com> wrote:
>> That part is harmless, the transaction would be recreated for the new
>> acting set taking into account the new acting set features.  It
>> doesn't have any actual affect on the contents of the object.
>> -Sam
>>
>> On Thu, Sep 11, 2014 at 1:30 PM, Gregory Farnum <greg@inktank.com> wrote:
>>> On Thu, Sep 11, 2014 at 1:19 PM, Samuel Just <sam.just@inktank.com> wrote:
>>>> http://tracker.ceph.com/issues/9419
>>>>
>>>> librbd unconditionally sends set_alloc_hint.  Do we require that users
>>>> upgrade the osds first?  Also, should the primary respond with
>>>> ENOTSUPP if any replicas don't support it?
>>>
>>> Something closer to the second option, I think...but then you run into
>>> the problem where maybe the PG gets moved from a set of new OSDs to a
>>> set of old ones that don't support the op. :/ I think for anything
>>> that goes to disk you need to go through a full features-in-the-osdmap
>>> process like we did for erasure coding.
>>> -Greg
>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
