From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: Proposal: data-at-rest encryption
Date: Fri, 28 Aug 2015 08:29:35 -0400 (EDT)
Message-ID: <697660291.9953805.1440764975873.JavaMail.zimbra@redhat.com>
References: <55DAE0F7.1070905@suse.de> <alpine.DEB.2.00.1508261744370.13116@cobra.newdream.net> <55DECE66.5000505@suse.de> <alpine.DEB.2.00.1508270635300.13116@cobra.newdream.net> <CAFdRU70jHtfh84zzAnyffvEpqFHAQ1=413Xok_gxpBcVX1NhKw@mail.gmail.com> <55E017B6.1000302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55296 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbH1M3i convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Aug 2015 08:29:38 -0400
In-Reply-To: <55E017B6.1000302@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joshua Schmid <jschmid@suse.de>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Thanks for your good comeback!

 > to your KSS -;

Shinobu

----- Original Message -----
=46rom: "Joshua Schmid" <jschmid@suse.de>
To: skinjo@redhat.com, "Sage Weil" <sage@newdream.net>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Friday, August 28, 2015 5:11:34 PM
Subject: Re: Proposal: data-at-rest encryption



On 08/28/2015 01:32 AM, Shinobu wrote:
> Hello,
>=20
> Just question.
> If the key is broken, how could ceph (maybe named kss standing for ke=
y
> store server :0) recover, and where information to restore it could b=
e
> retrieved?
> Any blueprint?

Hi,

i don't know if i got your question right.
Are you asking what ceph will do if the keyserver is down and where to
get the information from on how to restore the OSD?

Well, there will be a timeout if the KSS is unreachable. But in a
productive environment it might not be a bad idea to add HA to your KSS=
=2E

>=20
> Shinobu
>=20
> On Thu, Aug 27, 2015 at 10:38 PM, Sage Weil <sage@newdream.net> wrote=
:
>=20
>> On Thu, 27 Aug 2015, Joshua Schmid wrote:
>>>
>>> On 08/27/2015 02:49 AM, Sage Weil wrote:
>>>> Hi Joshua!
>>>>
>>>
>>> Hi Sage,
>>>
>>>
>>>> Overall the ceph-disk changes look pretty good, and it looks like
>> Andrew
>>>> and David have both reviewed.  My only real concern/request is tha=
t the
>>>> key server be as pluggable as possible.  You're using ftps here, b=
ut
>> we'd
>>>> also like to allow deo[1], or even the mon config-key service.
>>>
>>> Thank for having a look!
>>> I think this should do:
>>>
>>>
>> https://github.com/jschmid1/ceph/commit/7dd64c70bcb8d986568d6f379a6f=
bf9a0e40a441
>>>
>>> Service of choice can now be set in the ceph.conf and will be handl=
ed
>>> separately. This is currently only for unlocking/mapping but will b=
e
>>> extended for locking/new if this solution is acceptable.
>>
>> Yep!  It'd probably be much cleaner to wrap this up in a class with
>> fetch_key() and create_key(), etc. methods so that there is only one=
 place
>> that has to instantiate the implemetnation based on type.
>>
>>>> With the original mon proposal, we also wanted an additional layer=
 of
>>>> security (beyond simply access to the storage network) by
>>>> storing some key-fetching-key on the disk.
>>>
>>> Like deo does it? (From the deo README)
>>>
>>> """
>>> Second, we will add a new random key to the pre-existing LUKS encry=
pted
>>> disk and then encrypt it using Deo in a known location.
>>> """
>>>
>>>
>>>   It looks like the ftps
>>>> access is unauthenticated... is that right?  I would assume (I'm n=
ot
>> hte
>>>> expert!) that most key management systems require some credentials=
 to
>>>> store/fetch keys?
>>>
>>> Its totally unauthenticated, thats right. It'd be possible to requi=
re
>>> USER/PASS for ftp.
>>
>> Yeah.  If we have a general method to store a key-fetching-key on th=
e disk
>> (in the LUKS table?  I forget if this was practical) on the LUKS dis=
k the
>> might work?  Hopefully such that various backends can all use it (e.=
g., as
>> the ftps password, or as a mon key)..
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20
>=20

--=20
=46reundliche Gr=C3=BC=C3=9Fe - Kind regards,
Joshua Schmid
Trainee - Storage
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 N=C3=BCrnberg
-----------------------------------------------------------------------=
---------------------------------------------
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Jennifer Guild, Dilip Upmanyu, Graham Norton, HRB 21284 (AG N=C3=BCrnbe=
rg)
-----------------------------------------------------------------------=
---------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
