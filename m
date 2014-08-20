From: Craig Lewis <clewis@centraldesktop.com>
Subject: Re: Translating a RadosGW object name into a filename on disk
Date: Wed, 20 Aug 2014 10:25:16 -0700
Message-ID: <CADHZLBaAwXy2XUXnTP-dLwn8gKH1Oh+J9YoFkff5bTRs-xLhmw@mail.gmail.com>
References: <CADHZLBa+5dx+kojiSh+T7GmM_asCwhPTriTNr3ob2SUya+KFhw@mail.gmail.com>
 <CAPYLRzjaOZc+ZG4aibR18N6O3AW1JXU2440J+NSDHmxn4ircag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:42205 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaHTRZi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 13:25:38 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so8253360wev.12
        for <ceph-devel@vger.kernel.org>; Wed, 20 Aug 2014 10:25:36 -0700 (PDT)
In-Reply-To: <CAPYLRzjaOZc+ZG4aibR18N6O3AW1JXU2440J+NSDHmxn4ircag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Ceph Users <ceph-users@lists.ceph.com>

Looks like I need to upgrade to Firefly to get ceph-kvstore-tool
before I can proceed.
I am getting some hits just from grepping the LevelDB store, but so
far nothing has panned out.

Thanks for the help!

On Tue, Aug 19, 2014 at 10:27 AM, Gregory Farnum <greg@inktank.com> wro=
te:
> It's been a while since I worked on this, but let's see what I rememb=
er...
>
> On Thu, Aug 14, 2014 at 11:34 AM, Craig Lewis <clewis@centraldesktop.=
com> wrote:
>> In my effort to learn more of the details of Ceph, I'm trying to
>> figure out how to get from an object name in RadosGW, through the
>> layers, down to the files on disk.
>>
>> clewis@clewis-mac ~ $ s3cmd ls s3://cpltest/
>> 2014-08-13 23:02        14M  28dde9db15fdcb5a342493bc81f91151
>> s3://cpltest/vmware-freebsd-tools.tar.gz
>>
>> Looking at the .rgw pool's contents tells me that the cpltest bucket
>> is default.73886.55:
>> root@dev-ceph0:/var/lib/ceph/osd/ceph-0/current# rados -p .rgw ls | =
grep cpltest
>> cpltest
>> .bucket.meta.cpltest:default.73886.55
>
> Okay, what you're seeing here are two different types, whose names I'=
m
> not going to get right:
> 1) The bucket link "cpltest", which maps from the name "cpltest" to a
> "bucket instance". The contents of cpltest, or one of its xattrs, are
> pointing at ".bucket.meta.cpltest:default.73886.55"
> 2) The "bucket instance" .bucket.meta.cpltest:default.73886.55. I
> think this contains the bucket index (list of all objects), etc.
>
>> The rados objects that belong to that bucket are:
>> root@dev-ceph0:~# rados -p .rgw.buckets ls | grep default.73886.55
>> default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_1
>> default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_3
>> default.73886.55_vmware-freebsd-tools.tar.gz
>> default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_2
>> default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_4
>
> Okay, so when you ask RGW for the object vmware-freebsd-tools.tar.gz
> from the cpltest bucket, it will look up (or, if we're lucky, have
> cached) the cpltest link, and find out that the "bucket prefix" is
> default.73886.55. It will then try and access the object
> "default.73886.55_vmware-freebsd-tools.tar.gz" (whose construction I
> hope is obvious =E2=80=94 bucket instance ID as a prefix, _ as a sepa=
rate,
> then the object name). This RADOS object is called the "head" for the
> RGW object. In addition to (usually) the beginning bit of data, it
> will also contain some xattrs with things like a "tag" for any extra
> RADOS objects which include data for this RGW object. In this case,
> that tag is "RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ". (This construction is
> how we do atomic overwrites of RGW objects which are larger than a
> single RADOS object, in addition to a few other things.)
>
> I don't think there's any way of mapping from a shadow (tail) object
> name back to its RGW name. but if you look at the rados object xattrs=
,
> there might (? or might not) be an attr which contains the parent
> object in one form or another. Check that out.
>
> (Or, if you want to check out the source, I think all the relevant
> bits for this are somewhere in the
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>> I know those shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_ files are the
>> rest of vmware-freebsd-tools.tar.gz.  I can infer that because this
>> bucket only has a single file (and the sum of the sizes matches).
>> With many files, I can't infer the link anymore.
>>
>> How do I look up that link?
>>
>> I tried reading the src/rgw/rgw_rados.cc, but I'm getting lost.
>>
>>
>>
>> My real goal is the reverse.  I recently repaired an inconsistent PG=
=2E
>> The primary replica had the bad data, so I want to verify that the
>> repaired object is correct.  I have a database that stores the SHA25=
6
>> of every object.  If I can get from the filename on disk back to an =
S3
>> object, I can verify the file.  If it's bad, I can restore from the
>> replicated zone.
>>
>>
>> Aside from today's task, I think it's really handy to understand the=
se
>> low level details.  I know it's been handy in the past, when I had
>> disk corruption under my PostgreSQL database.  Knowing (and
>> practicing) ahead of time really saved me a lot of downtime then.
>>
>>
>> Thanks for any pointers.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
