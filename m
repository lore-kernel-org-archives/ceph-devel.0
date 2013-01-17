From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph from poc to production
Date: Thu, 17 Jan 2013 19:58:54 +0100
Message-ID: <204CEFAF-7388-48AA-9E5C-48D09D6A777A@profihost.ag>
References: <50F6F471.7030108@profihost.ag> <CAOLwVU=1vjeoFBa84doczbEeJ5nAasBLE2z9YAR-oUd5+wANrw@mail.gmail.com> <50F82705.50502@inktank.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:48339 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab3AQS66 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 13:58:58 -0500
In-Reply-To: <50F82705.50502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Great! Any ETA?

Am 17.01.2013 um 17:29 schrieb Mark Nelson <mark.nelson@inktank.com>:

> On 01/17/2013 10:24 AM, S=C3=A9bastien Han wrote:
>> Hi Stephan,
>>=20
>>> - Increase the osdmax value
>>=20
>> Well actually this doesn't seem to be necessary because when you iss=
ue
>> a "ceph osd create" the osdmax value is automatically incremented. I=
t
>> just that a while ago I saw on the ML or IRC that it was a good
>> practice to do this. And this documentation
>> http://ceph.com/docs/master/rados/operations/control/ says:
>>=20
>> "Set the max_osd parameter in the osd map. This is necessary when
>> expanding the storage cluster."
>>=20
>> Maybe the doc is outdated on this option, I don't know.
>>=20
>>> - Set =E2=80=9Cfilestore flusher=E2=80=9D option to false, in your =
[osd] section
>>=20
>> During my benchmarks sessions I noticed that disabling this option
>> brought way better performance, at least for old hardware. Fo recent
>> hardware I haven't seen any difference, but I kept the habit to
>> disable it. There are some discussions about this option on the ML. =
As
>> far as I can remember, it's harmless to disable it.
>> From the doc here
>> http://ceph.com/docs/master/rados/configuration/filestore-config-ref=
/:
>=20
> I actually have been doing parametric sweeps over the various ceph tu=
nables to try to see what affects performance.  I'll have an article co=
ming out soonish documenting some of the findings.  Typically disabling=
 the flusher seems to be beneficial on XFS and BTRFS, but it seems to b=
e the opposite on EXT4.
>=20
>>=20
>> "The filestore flusher forces data from large writes to be written o=
ut
>> using sync file range before the sync in order to (hopefully) reduce
>> the cost of the eventual sync. In practice, disabling =E2=80=98files=
tore
>> flusher=E2=80=99 seems to improve performance in some cases."
>>=20
>> Cheers,
>>=20
>> --
>> Regards,
>> S=C3=A9bastien Han.
>>=20
>>=20
>> On Wed, Jan 16, 2013 at 7:41 PM, Stefan Priebe <s.priebe@profihost.a=
g> wrote:
>>>=20
>>> Hello Sebastien,
>>>   hello list,
>>>=20
>>> first nice article sebastien ;-) thanks for contributing.
>>>=20
>>> I've two question regarding the tips:
>>>=20
>>> Can somebody explain me why i should do this?:
>>> - Increase the osdmax value
>>> - Set =E2=80=9Cfilestore flusher=E2=80=9D option to false, in your =
[osd] section
>>>=20
>>> Greets,
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
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
