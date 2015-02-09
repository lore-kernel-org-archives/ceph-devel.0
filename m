From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Bucket lifecycle (object expiration)
Date: Mon, 9 Feb 2015 07:48:43 -0800
Message-ID: <CAC6JEv91Sf=RGkQpvp_bZatkq7KFTkLoVsrkfXQY_BBNXWtzjg@mail.gmail.com>
References: <1033454365.478048.1423259167886.JavaMail.zimbra@redhat.com>
	<alpine.DEB.2.00.1502090335140.5710@cobra.newdream.net>
	<1478158629.1804470.1423496019494.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:55082 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961AbbBIPsp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 10:48:45 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so17198270igq.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Feb 2015 07:48:44 -0800 (PST)
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com. [209.85.223.172])
        by mx.google.com with ESMTPSA id 16sm6558797ion.23.2015.02.09.07.48.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Feb 2015 07:48:43 -0800 (PST)
Received: by iebtr6 with SMTP id tr6so17333349ieb.2
        for <ceph-devel@vger.kernel.org>; Mon, 09 Feb 2015 07:48:43 -0800 (PST)
In-Reply-To: <1478158629.1804470.1423496019494.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 9, 2015 at 7:33 AM, Yehuda Sadeh-Weinraub <yehuda@redhat.co=
m> wrote:
>
>
> ----- Original Message -----
>> From: "Sage Weil" <sage@newdream.net>
>> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Monday, February 9, 2015 3:42:40 AM
>> Subject: Re: Bucket lifecycle (object expiration)
>>
>> On Fri, 6 Feb 2015, Yehuda Sadeh-Weinraub wrote:
>> > I have been recently looking at implementing object expiration in =
rgw.
>> > First, a brief description of the feature:
>> >
>> > S3 provides mechanisms to expire objects, and/or to transition the=
m into
>> > different storage class. The feature works at the bucket level. Ru=
les can
>> > be set as to which objects will expire and/or transitioned , and w=
hen.
>> > Objects are specified by using prefixes, the configuration is not
>> > per-object. Time is set in days (since object creation), and event=
s are
>> > always rounded to the start of the next day.
>> > The rules can also work in conjuction with object versioning. When=
 a
>> > versioned object (a current object) expires, a delete marker is cr=
eated.
>> > Non-current versioned objects can be set to be removed after a spe=
cific
>> > amount of time since the point where they became non-current.
>> > As mentioned before, objects can be configured to transition to a =
different
>> > storage class (e.g., Amazon Glacier). It is possible to configure =
an
>> > object to be transitioned after a specific period, and after anoth=
er
>> > period to be completely removed.
>> > When reading object information, it will specify when it is schedu=
led for
>> > removal. It is not yet clear to me whether an object can be access=
ed after
>> > that time, or whether it appears as gone immediately (either when =
trying
>> > to access it, or when listing the bucket).
>> > Rules cannot intersect. Each object cannot be affected by more tha=
n one
>> > rule.
>> >
>> > Swift provides a completely different object expiration system. In=
 swift
>> > the expiration is set per object, and with an explicit time for it=
 to be
>> > removed.
>> >
>> > In accordance with previous work, I'll currently focus on an S3
>> > implementation. We do not yet support object transition to a diffe=
rent
>> > storage class, so either we implement that first, or out first lif=
ecycle
>> > implementation will not include that.
>>
>> While the tier transition seems like the most interesting part to me=
, it
>> shares some overlap with the current cache tiering ("move older obje=
cts to
>> an EC backend").  it also quickly snowballs (migrate object to a dif=
ferent
>> rados pool, from the same set you can pick when creating the bucket?
>> migrate to different zone/region?  migrate to an external service li=
ke
>> glacier?)
>>
>> Expiration sounds like a good first step...
>
> I agree. Thinking about migration, I don't think we're that far off. =
We'll add the ability to define new storage classes that will map to sp=
ecified rados pools (or override existing placement targets -- storage =
policies?). The manifest will need to reflect where the object's data i=
s located. We'll be able to copy the object into different storage clas=
ses, and it'll require a new service thread to do the migration. We mig=
ht need to update the bucket index about the new object location.
>
>>
>> > 1. Lifecycle rules will be configured on the bucket instance info
>> >
>> > We hold the bucket instance info whenever we read an object, and i=
t is
>> > cached. Since rules are configured to affect specific object prefi=
xes, it
>> > will be quick and easy to determine whether an object is affected =
by any
>> > lifecycle rule.
>> >
>> > 2. New bucket index objclass operation to list objects that need t=
o be
>> > expired / transitioned
>> >
>> > The operation will get the existing rules as input, and will retur=
n the
>> > list of objects that need to be handled. The request will be paged=
=2E Note
>> > that number of rules is constrained, so we only need to limit the =
number
>> > of returned entries.
>>
>> Will this be an O(n) scan over the index keys, or would we add some
>> time-based keys or something to make it faster?
>
> It will be a scan over index keys that match the prefixes, for each r=
ule. Not sure if time based keys can help in any way as we'd need to in=
tersect time and prefixes in order to make it worthwhile, but the prefi=
xes are created willy nilly.

It is at least restricted to bucket indexes which are using
expiration, but I suspect a lot of those rules are going to be based
on the empty prefix and need to scan over the whole index. I'm not at
all clear on how expensive that is, but I'm thinking "very".
Unfortunately the best way to avoid that which I can think of is to
insert time-sorted expiration keys whenever we create an object along
with a "rule version", and bump that version whenever we create a
rule. Then when we do an expiration scan we could avoid doing the full
scan as long as the bucket's rule version isn't out of date =E2=80=94 b=
ut if
it is we'd need to do a linear scan again. :/
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
