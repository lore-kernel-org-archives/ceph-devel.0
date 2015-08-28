From: Joshua Schmid <jschmid@suse.de>
Subject: Re: Proposal: data-at-rest encryption
Date: Fri, 28 Aug 2015 10:03:41 +0200
Message-ID: <55E015DD.3050201@suse.de>
References: <55DAE0F7.1070905@suse.de>
 <alpine.DEB.2.00.1508261744370.13116@cobra.newdream.net>
 <55DECE66.5000505@suse.de>
 <alpine.DEB.2.00.1508270635300.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46215 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbbH1IBS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Aug 2015 04:01:18 -0400
In-Reply-To: <alpine.DEB.2.00.1508270635300.13116@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org



On 08/27/2015 03:38 PM, Sage Weil wrote:
> On Thu, 27 Aug 2015, Joshua Schmid wrote:
>>
>> On 08/27/2015 02:49 AM, Sage Weil wrote:
>>> Hi Joshua!
>>>
>>
>> Hi Sage,
>>
>>
>>> Overall the ceph-disk changes look pretty good, and it looks like A=
ndrew=20
>>> and David have both reviewed.  My only real concern/request is that=
 the=20
>>> key server be as pluggable as possible.  You're using ftps here, bu=
t we'd=20
>>> also like to allow deo[1], or even the mon config-key service.
>>
>> Thank for having a look!
>> I think this should do:
>>
>> https://github.com/jschmid1/ceph/commit/7dd64c70bcb8d986568d6f379a6f=
bf9a0e40a441
>>
>> Service of choice can now be set in the ceph.conf and will be handle=
d
>> separately. This is currently only for unlocking/mapping but will be
>> extended for locking/new if this solution is acceptable.
>=20
> Yep!  It'd probably be much cleaner to wrap this up in a class with=20
> fetch_key() and create_key(), etc. methods so that there is only one =
place=20
> that has to instantiate the implemetnation based on type.
>=20

I dont know if i understood you correctly here. But, since ceph-disk is
classless wouldn't it be a bit strange to introduce one?
I now put anything associated with fetching/creating key in a seperate
method retrieve_key() and create_key() which will behave accordingly.



>>> With the original mon proposal, we also wanted an additional layer =
of=20
>>> security (beyond simply access to the storage network) by=20
>>> storing some key-fetching-key on the disk.
>>
>> Like deo does it? (From the deo README)
>>
>> """
>> Second, we will add a new random key to the pre-existing LUKS encryp=
ted
>> disk and then encrypt it using Deo in a known location.
>> """
>>
>>
>>   It looks like the ftps
>>> access is unauthenticated... is that right?  I would assume (I'm no=
t hte=20
>>> expert!) that most key management systems require some credentials =
to=20
>>> store/fetch keys?
>>
>> Its totally unauthenticated, thats right. It'd be possible to requir=
e
>> USER/PASS for ftp.
>=20
> Yeah.  If we have a general method to store a key-fetching-key on the=
 disk=20
> (in the LUKS table?  I forget if this was practical) on the LUKS disk=
 the=20
> might work?  Hopefully such that various backends can all use it (e.g=
=2E, as=20
> the ftps password, or as a mon key)..


I guess putting it in the LuksKeySlot[1] might work. But plain-dmcrypt
has to be handled differently then. For compatibility reasons i suggest
to avoid that. But storing it on the root partition is not a good idea
either. This area definitely needs more heavy thinking..


>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
=46reundliche Gr=FC=DFe - Kind regards,
Joshua Schmid
Trainee - Storage
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 N=FCrnberg
-----------------------------------------------------------------------=
---------------------------------------------
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard,
Jennifer Guild, Dilip Upmanyu, Graham Norton, HRB 21284 (AG N=FCrnberg)
-----------------------------------------------------------------------=
---------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
