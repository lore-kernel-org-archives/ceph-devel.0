From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: v0.48.2 argonaut update released
Date: Mon, 1 Oct 2012 19:48:30 +0200
Message-ID: <C5594A96-3A10-4F94-BCD6-874A2411A88B@filoo.de>
References: <alpine.DEB.2.00.1209200948180.8980@cobra.newdream.net> <50696B2D.7020301@filoo.de> <alpine.DEB.2.00.1210010904240.25178@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:44069 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab2JARsc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 13:48:32 -0400
In-Reply-To: <alpine.DEB.2.00.1210010904240.25178@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Well,

Am 01.10.2012 um 18:07 schrieb Sage Weil <sage@inktank.com>:

> On Mon, 1 Oct 2012, Oliver Francke wrote:
>> Hi *,
>>=20
>> with reference to the below mentioned
>>=20
>> "objecter: misc fixes for op reordering"
>>=20
>>=20
>> I assumed it could have something to do with slow requests not being=
 solved
>> for too long. I just not saw it anymore in 0.51 in our testing-eviro=
nment.
>> But today we took one of our nodes into maintenance, and I see many =
of:
>>=20
>> --- 8-<---
>>=20
>> 2012-10-01 11:58:46.766999 osd.10 [WRN] 38 slow requests, 1 included=
 below;
>> oldest blocked for > 1189.312605 secs
>> 2012-10-01 11:58:46.767013 osd.10 [WRN] slow request 240.183032 seco=
nds old,
>> received at 2012-10-01 11:54:46.583860: osd_op(client.110046.0:21439=
84
>> rb.0.1adf5.6733efe2.00000000061a [write 208384~4096] 6.f511e801) v4 =
currently
>> delayed
>> 2
>>=20
>> --- 8-< ---
>>=20
>> which is bad, as I assume, that some of the VM's are now stalled. An=
ybody else
>> experienced such things?
>=20
> You see this on v0.51?  For v0.52 we merged in a large series of mess=
enger=20
> fixes and cleanups that could very easily explain this.  Can you try=20
> v0.52?
>=20

just checking=85 up to now no "slow req." is lasting for longer than 30=
=85 seconds.

> The same series has not been merged into the argonaut stable series; =
I'm=20
> unsure yet whether that's a good idea (it's a lot of refactoring mixe=
d in=20
> with the fixes).  Perhaps after it has proven itself in v0.52 for lon=
ger,=20
> and/or if we get reports of msgr problems in argonaut deployments.

I think most people are just happy campers these days=85 Not so destruc=
tive as myself ;)

>=20
> sage
>=20

Oliver.

>>=20
>> Thnx n regards,
>>=20
>> Oliver.
>>=20
>> On 09/20/2012 06:52 PM, Sage Weil wrote:
>>> Hi everyone,
>>>=20
>>> Another update to the stable "argonaut" series has been released.  =
This
>>> fixes a few important bugs in rbd and radosgw and includes a series=
 of
>>> changes to upstart and deployment related scripts that will allow t=
he
>>> upcoming 'ceph-deploy' tool to work with the argonaut release.
>>>=20
>>> Upgrading:
>>>=20
>>>  * The default search path for keyring files now includes
>>>    /etc/ceph/ceph.$name.keyring. If such files are present on your
>>>    cluster, be aware that by default they may now be used.
>>>  * There are several changes to the upstart init files. These have =
not
>>>    been previously documented or recommended. Any existing users sh=
ould
>>>    review the changes before upgrading.
>>>  * The ceph-disk-prepare and ceph-disk-active scripts have been upd=
ated
>>>    significantly. These have not been previously documented or
>>>    recommended. Any existing users should review the changes before
>>> upgrading.
>>>=20
>>> Notable changes include:
>>>=20
>>>  * mkcephfs: fix keyring generation for mds, osd when default paths=
 are
>>>    used
>>>  * radosgw: fix bug causing occasional corruption of per-bucket sta=
ts
>>>  * radosgw: workaround to avoid previously corrupted stats from goi=
ng
>>>    negative
>>>  * radosgw: fix bug in usage stats reporting on busy buckets
>>>  * radosgw: fix Content-Range: header for objects bigger than 2 GB.
>>>  * rbd: avoid leaving watch acting when command line tool errors ou=
t
>>>    (avoids 30s delay on subsequent operations)
>>>  * rbd: friendlier use of pool/image options for import (old callin=
g
>>>    convention still works)
>>>  * librbd: fix rare snapshot creation race (could lose a snap when
>>>    creation is concurrent)
>>>  * librbd: fix discard handling when spanning holes
>>>  * librbd: fix memory leak on discard when caching is enabled
>>>  * objecter: misc fixes for op reordering
>>>  * objecter: fix for rare startup-time deadlock waiting for osdmap
>>>  * ceph: fix usage
>>>  * mon: reduce log noise about check_sub
>>>  * ceph-disk-activate: misc fixes, improvements
>>>  * ceph-disk-prepare: partition and format osd disks automatically
>>>  * upstart: start everyone on a reboot
>>>  * upstart: always update the osd crush location on start if specif=
ied in
>>>    the config
>>>  * config: add /etc/ceph/ceph.$name.keyring to default keyring sear=
ch path
>>>  * ceph.spec: don't package crush headers
>>>=20
>>> You can get this release from the usual locations:
>>>=20
>>>  * Git at git://github.com/ceph/ceph.git
>>>  * Tarball at http://ceph.newdream.net/download/ceph-0.48.2.tar.gz
>>>  * For Debian/Ubuntu packages, see
>>> http://ceph.newdream.net/docs/master/install/debian
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>>=20
>> --=20
>>=20
>> Oliver Francke
>>=20
>> filoo GmbH
>> Moltkestra?e 25a
>> 33330 G?tersloh
>> HRB4355 AG G?tersloh
>>=20
>> Gesch?ftsf?hrer: S.Grewing | J.Rehp?hler | C.Kunz
>>=20
>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>=20
>>=20
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
