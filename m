From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: q. about rbd-header
Date: Wed, 14 Mar 2012 14:59:50 -0700
Message-ID: <4F6114D6.4000809@dreamhost.com>
References: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de> <89CB135C-CB66-4240-B89C-EFDFCB8AACF4@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47236 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab2CNV75 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 17:59:57 -0400
In-Reply-To: <89CB135C-CB66-4240-B89C-EFDFCB8AACF4@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

On 03/14/2012 01:49 PM, Oliver Francke wrote:
> Well,
>
> nobody able to sched some light in?
> Did some math and found out how to fill the size bytes.

Sorry I didn't respond faster.

> But, one question never got answered:
>      - why is - with busy VMs - frequently the first block affected,
>        with the result of damaged grub-loaders/partition-tables/files=
ystems?
>        Is this some NULL/zero pointer thingy in case of ceph-failure?

My guess is that this is not the first object affected, but it's where=20
the loss of an object is most easily noticeable - if an object doesn't=20
exist, it's treated as being full of zeros, which might go undetected=20
for a long time if it's e.g. some temp or log file that's not reread an=
d=20
verified.

> If you demand some broken images=85 we have many of them to investiga=
te,
> unfortunately.

We'd really like to find the root cause of the problem. One possibility=
=20
is some bad interaction between osds running different versions. This=20
caused one issue with recovery stxShadow saw yesterday, for example=20
(http://tracker.newdream.net/issues/2132). Had you been doing rolling=20
upgrades of osds before these problems appeared? If so, do you know=20
which versions you had running concurrently?

Are your osds often restarting?

What we'd need to diagnose this are osd logs during recovery with:

debug osd =3D 20
debug ms =3D 1

Once you detect the problem, a log from each replica storing the pg the=
=20
bad/missing object is in should be enough.

And just to make sure, you aren't writing to these rbd images from=20
multiple places, right? This wouldn't cause the missing header objects,=
=20
but is likely to cause corruption of the image data. This could happen,=
=20
for example, by rolling an image back to a snapshot while a vm is=20
running on it.

Josh

> Maybe this sounds a bit harsh, after the 5th night-shift trying to re=
pair images
> and keep customers calm, I think this is forgivable.
>
> Oliver.
>
> Am 14.03.2012 um 16:05 schrieb Oliver Francke:
>
>> Hey,
>>
>> anybody out there who could explain the structure of a rbd-header? A=
fter
>> last crash we have about 10 images with a:
>>    2012-03-14 15:22:47.998790 7f45a61e3760 librbd: Error reading
>> header: 2 No such file or directory
>> error opening image vm-266-disk-1.rbd: 2 No such file or directory
>> ... error?
>> I understand the "rb.x.y"-prefix, the 2 ^ 16hex as block-size. But
>> the size/count encoding is not intuitive ;)
>>
>> Besides one file, where I "created" a header and putted it via "rado=
s
>> put" back into the pool, and got some files
>> back, many of the other images with lost headers have different size=
s.
>>
>> We got bad luck again, too many crashed VM's, too much data-loss...
>>
>> Comments welcome ;)
>>
>> Oliver.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
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
