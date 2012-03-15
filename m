From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: q. about rbd-header
Date: Thu, 15 Mar 2012 11:21:18 +0100
Message-ID: <4F61C29E.4090300@filoo.de>
References: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de> <89CB135C-CB66-4240-B89C-EFDFCB8AACF4@filoo.de> <4F6114D6.4000809@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:38537 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab2COKVV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Mar 2012 06:21:21 -0400
In-Reply-To: <4F6114D6.4000809@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Josh,

On 03/14/2012 10:59 PM, Josh Durgin wrote:
> On 03/14/2012 01:49 PM, Oliver Francke wrote:
>> Well,
>>
>> nobody able to sched some light in?
>> Did some math and found out how to fill the size bytes.
>
> Sorry I didn't respond faster.
>
>> But, one question never got answered:
>>      - why is - with busy VMs - frequently the first block affected,
>>        with the result of damaged=20
>> grub-loaders/partition-tables/filesystems?
>>        Is this some NULL/zero pointer thingy in case of ceph-failure=
?
>
> My guess is that this is not the first object affected, but it's wher=
e=20
> the loss of an object is most easily noticeable - if an object doesn'=
t=20
> exist, it's treated as being full of zeros, which might go undetected=
=20
> for a long time if it's e.g. some temp or log file that's not reread=20
> and verified.

well, I responded to Sage with some more infos from one of the images=20
where the header is missing... Did not want to bother the list ;)

>
>> If you demand some broken images=85 we have many of them to investig=
ate,
>> unfortunately.
>
> We'd really like to find the root cause of the problem. One=20
> possibility is some bad interaction between osds running different=20
> versions. This caused one issue with recovery stxShadow saw yesterday=
,=20
> for example (http://tracker.newdream.net/issues/2132). Had you been=20
> doing rolling upgrades of osds before these problems appeared? If so,=
=20
> do you know which versions you had running concurrently?
>
> Are your osds often restarting?
>
> What we'd need to diagnose this are osd logs during recovery with:
>
> debug osd =3D 20
> debug ms =3D 1
>
> Once you detect the problem, a log from each replica storing the pg=20
> the bad/missing object is in should be enough.
>
> And just to make sure, you aren't writing to these rbd images from=20
> multiple places, right? This wouldn't cause the missing header=20
> objects, but is likely to cause corruption of the image data. This=20
> could happen, for example, by rolling an image back to a snapshot=20
> while a vm is running on it.

Currently we don't use snapshots. And of course ensure, a VM is running=
=20
once at a time ;-) And we had some "rolling upgrade", but this was=20
_after_ trouble/crashes occured.

Oliver.

>
> Josh
>
>> Maybe this sounds a bit harsh, after the 5th night-shift trying to=20
>> repair images
>> and keep customers calm, I think this is forgivable.
>>
>> Oliver.
>>
>> Am 14.03.2012 um 16:05 schrieb Oliver Francke:
>>
>>> Hey,
>>>
>>> anybody out there who could explain the structure of a rbd-header?=20
>>> After
>>> last crash we have about 10 images with a:
>>>    2012-03-14 15:22:47.998790 7f45a61e3760 librbd: Error reading
>>> header: 2 No such file or directory
>>> error opening image vm-266-disk-1.rbd: 2 No such file or directory
>>> ... error?
>>> I understand the "rb.x.y"-prefix, the 2 ^ 16hex as block-size. But
>>> the size/count encoding is not intuitive ;)
>>>
>>> Besides one file, where I "created" a header and putted it via "rad=
os
>>> put" back into the pool, and got some files
>>> back, many of the other images with lost headers have different siz=
es.
>>>
>>> We got bad luck again, too many crashed VM's, too much data-loss...
>>>
>>> Comments welcome ;)
>>>
>>> Oliver.
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
