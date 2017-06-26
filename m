From: Piotr Dalek <piotr.dalek@corp.ovh.com>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Mon, 26 Jun 2017 11:59:16 +0000
Message-ID: <9453529f-4110-185c-a95f-2be652a25649@corp.ovh.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
 <d4bde447-f179-aeca-bac5-636fa40ccba5@corp.ovh.com>
 <415c9590-ab96-01b6-3c49-553b0d9529fa@sadziu.pl>
 <alpine.DEB.2.11.1706141340520.3646@piezo.novalocal>
 <e89cc0ed-14f0-b092-784f-784c8c967e9d@corp.ovh.com>
 <alpine.DEB.2.11.1706211322360.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo302.mail-out.ovh.net ([137.74.110.75]:56006 "EHLO
        2.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdFZL7S (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jun 2017 07:59:18 -0400
In-Reply-To: <alpine.DEB.2.11.1706211322360.32269@piezo.novalocal>
Content-Language: en-US
Content-ID: <F4C7DDBFDBA3A14491AD88238613F9B5@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?iso-8859-2?Q?Pawe=B3_Sadowski?= <ceph@sadziu.pl>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On 17-06-21 03:24 PM, Sage Weil wrote:
> On Wed, 21 Jun 2017, Piotr Da=B3ek wrote:
>> On 17-06-14 03:44 PM, Sage Weil wrote:
>>> On Wed, 14 Jun 2017, Pawe=B3 Sadowski wrote:
>>>> [snip]
>>>>
>>>> Is it safe to enable "filestore seek hole", are there any tests that
>>>> verifies that everything related to RBD works fine with this enabled?
>>>> Can we make this enabled by default?
>>>
>>> We would need to enable it in the qa environment first.  The risk here =
is
>>> that users run a broad range of kernels and we are exposing ourselves t=
o
>>> any bugs in any kernel version they may run.  I'd prefer to leave it of=
f
>>> by default.
>>
>> That's a common regression? If not, we could blacklist particular kernel=
s and
>> call it a day.

>>> We can enable it in the qa suite, though, which covers
>>> centos7 (latest kernel) and ubuntu xenial and trusty.
>>
>> +1. Do you need some particular PR for that?
>=20
> Sure.  How about a patch that adds the config option to several of the
> files in qa/suites/rados/thrash/thrashers?

Does=20
https://github.com/ovh/ceph/commit/fe65e3a19470eea16c9d273d1aac1c7eff7d2ff1=
=20
look reasonably?

--=20
Piotr Da=B3ek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
