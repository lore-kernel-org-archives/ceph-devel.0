From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: ceph-fs tests
Date: Fri, 07 Sep 2012 01:22:38 +0200
Message-ID: <5049303E.4010005@smart-weblications.de>
References: <50468E0E.6070807@smart-weblications.de> <CADvuQRGy9gCSwy3jMw+DGAF0MfoeohhYNgR2PJ+vDU1WW9cM+A@mail.gmail.com> <504780FF.6020305@smart-weblications.de> <CAPYLRzgw00hKRHj16YJdmffrvECfsBotKPUEbJ1nRqQEPF7taA@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:36144 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755019Ab2IFXXN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 19:23:13 -0400
In-Reply-To: <CAPYLRzgw00hKRHj16YJdmffrvECfsBotKPUEbJ1nRqQEPF7taA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 05.09.2012 18:52, schrieb Gregory Farnum:
> On Wed, Sep 5, 2012 at 9:42 AM, Smart Weblications GmbH - Florian
> Wiessner <f.wiessner@smart-weblications.de> wrote:
>> Am 05.09.2012 18:22, schrieb Tommi Virtanen:
>>> On Tue, Sep 4, 2012 at 4:26 PM, Smart Weblications GmbH - Florian
>>> Wiessner <f.wiessner@smart-weblications.de> wrote:
>>>> i set up a 3 node ceph cluster 0.48.1argonaut to test ceph-fs.
>>>>
>>>> i mount ceph via fuse, then i downloaded kernel tree and decompres=
sed a few
>>>> times, then stopping one osd (osd.1), afer a while of recovering, =
suddenly:
>>
>>>
>>> Please provide English error messages when you share things with th=
e
>>> list. In this case I can figure out what the message is, but really=
,
>>> we're all pattern matching animals and the specific strings in
>>> /usr/include/asm-generic/errno.h are what we know.
>>>
>>
>> OK, will change locales.
>>
>>>> no space left on device, but:
>>>>
>>>> 2012-09-04 18:46:38.242840 mon.0 [INF] pgmap v2883: 576 pgs: 512 a=
ctive+clean,
>>>> 64 active+recovering; 1250 MB data, 14391 MB used, 844 MB / 15236 =
MB avail;
>>>> 36677/215076 degraded (17.053%)
>>>>
>>>> there is space left?
>>>
>>> Only 844 MB available, with the pseudo-random placement policies,
>>> means you practically are out of space.
>>>
>>> It looks like you had only 15GB to begin with, and with typical
>>> replication, that's <5GB usable space. That is dangerously small fo=
r
>>> any real use; Ceph currently does not cope very well with running o=
ut
>>> of space.
>>>
>>
>> It is a test-cluster running on my thinkpad, its main purpose is to =
test cephfs,
>> there is no need for real space. I added osd.1 again, then after rec=
overy the
>> problem went away. I forced this situation to check how cephfs will =
behave when
>> cluster is near-full, osd fails and ceph tries to recover until back=
fill fills
>> up other osds so ceph is full.
>>
>> I observed on the client that no IO was possible anymore so that the=
 client was
>> unusable.
>>
>> Is there a smarter way to handle this? It is bad that cephfs then st=
alls, it
>> would be better if it just returns that there is no space left, but =
still allow
>> read access... can this be tuned somewhere?
>=20
> What client were you using? I believe it does allow reads while full =
=97
> but your client can pretty easily get itself into a situation where i=
t
> needs to perform writes in order to continue doing reads.
>=20

ceph-fuse argonaut 0.48.1

ls, mount, df -h etc all hanged, i had to reboot the client...

--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
