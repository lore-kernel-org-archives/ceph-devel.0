From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: New messages in OSD logs.
Date: Wed, 20 Apr 2016 16:51:46 +0200
Message-ID: <87twiwgwot.fsf@suse.com>
References: <57121CDE.3010908@digiware.nl> <2067877477.80383590.1461142063409.JavaMail.zimbra@redhat.com> <57174ECE.8010800@digiware.nl> <CAONhiy74esFG-pSOsUxmJnwW3Ss3JqRD_G4y8ceMxpO_2O5=yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39925 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbcDTOwD (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 20 Apr 2016 10:52:03 -0400
In-reply-to: <CAONhiy74esFG-pSOsUxmJnwW3Ss3JqRD_G4y8ceMxpO_2O5=yA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiselyova <akiselyova@mirantis.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Erwan Velu <evelu@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


Alyona Kiselyova writes:

> Hi,
> I have the same error on last master and my rebased forks, when try t=
o
> use vstart or start any test (on Ubuntu). Change of
> osd_max_object_name_len remove warning, but osds are still dying. So,
> I cannot test anything on developer cluster since yesterday rebase.
> Also I've rebased two PRs on the last master yesterday, and both have
> all tests failed in check, like it happens on my machine. Today's
> master didn't help)

`--short` option in vstart worked for me for just running dev clusters
and such on ext4, though I haven't run the entire make check suite yet.

> -------------------------------
> Best regards,
> Alyona Kiseleva
>
>
> On Wed, Apr 20, 2016 at 12:41 PM, Willem Jan Withagen <wjw@digiware.n=
l> wrote:
>> On 20-4-2016 10:47, Erwan Velu wrote:
>>> I have the exact same trace while running a test on teuthology.
>>
>> And I guess you are not running FreeBSD... :)
>> Teuthology would certainly not.
>>
>>
>> Does you test also ends in error?
>>
>> --WjW
>>
>>> ----- Mail original -----
>>> De: "Willem Jan Withagen" <wjw@digiware.nl>
>>> =C3=80: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Envoy=C3=A9: Samedi 16 Avril 2016 13:07:10
>>> Objet: New messages in OSD logs.
>>>
>>> Hi
>>>
>>> I've recently rebased my fork, and also upgrae FreeBSD to more rece=
nt code.
>>> Now I'm running into this:
>>>
>>> 2016-04-16 03:03:55.891466 805617000 -1
>>> filestore(testdir/test-erasure-eio/0) WARNING: max attr value size =
(1024)
>>> is smaller than osd_max_object_name_len (2048). Your backend filesy=
stem
>>> appears to not support attrs large enough
>>> to handle the configured max rados name size. You may get unexpecte=
d
>>> ENAMETOOLONG errors on rados operations or buggy behavior
>>>
>>> and later on:
>>>
>>> 2016-04-16 03:04:03.287073 805617000  2 osd.0 0 boot
>>> 2016-04-16 03:04:03.287846 805617000 -1 osd.0 0 backend (filestore)=
 is
>>> unable to support max object name[space] le
>>> n
>>> 2016-04-16 03:04:03.287873 805617000 -1 osd.0 0    osd max object n=
ame
>>> len =3D 2048
>>> 2016-04-16 03:04:03.287894 805617000 -1 osd.0 0    osd max object
>>> namespace len =3D 256
>>> 2016-04-16 03:04:03.287931 805617000 -1 osd.0 0 (63) File name too =
long
>>> 2016-04-16 03:04:03.303432 805617000  1 journal close
>>> testdir/test-erasure-eio/0/journal
>>> 2016-04-16 03:04:03.310280 805617000 -1 ^[[0;31m ** ERROR: osd init
>>> failed: (63) File name too long^[[0m
>>>
>>> And the OSD dies....
>>>
>>> I guess that this has the do with the changes in the LFN modules, a=
nd is
>>> also the reason for the debate about ext4 support.
>>>
>>> Uptill now unittest_chain_xattr did work, but that now also fails.
>>> But it fails in a strange way where it tries to delete attributes w=
ith
>>> numerical ends that are certainly not in the attributes.
>>> Maximum xattr name length in FreeBSD seems to be 256 chars, which w=
asn't
>>> a problem yet.
>>>
>>> So is there any chance of continuing on my "old" way to finish a fi=
rst
>>> version of the port?
>>>
>>> Or am I just seeing things, and should I start looking at the FreeB=
SD
>>> side of things?
>>>
>>>
>>> Thanx,
>>> --WjW
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
