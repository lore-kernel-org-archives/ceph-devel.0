From: Jai <jai_97@rediffmail.com>
Subject: Re: make error while building ceph
Date: Sun, 28 Feb 2016 16:25:52 +0530
Message-ID: <CAPpuMWx9Or8ETDKtzFsUUkF0wSDnPEjiKhOSuVT=VrVYiUNohg@mail.gmail.com>
References: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
 <56D2D089.7090109@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33876 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbcB1K4N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Feb 2016 05:56:13 -0500
Received: by mail-lb0-f179.google.com with SMTP id of3so66174115lbc.1
        for <ceph-devel@vger.kernel.org>; Sun, 28 Feb 2016 02:56:13 -0800 (PST)
In-Reply-To: <56D2D089.7090109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Loic,

I did run install-deps before the make, and it completed without
error. I have an Ubuntu (1204) VM (uname shows 3.5.0-30-generic
#51~precise1-Ubuntu)

I ran these as per the README --
=2E/install-deps.sh
=2E/autogen.sh
  ./configure
  make

I found the bugs link on http://ceph.com/community/contribute/ under
"submit issues"

--
Jai

On Sun, Feb 28, 2016 at 4:18 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> You should try to run ./install-deps.sh first so that the required de=
pendencies are all installed. Which operating system are you using ?
> The bug tracker is at http://tracker.ceph.com/. Where did you find a =
link to http://tracker.newdream.net/projects/ceph ? It should be fixed =
:-)
>
> Cheers
>
> On 28/02/2016 17:29, Jai wrote:
>> I followed instructions in the README, but "make" gives me this erro=
r --
>>
>> In file included from ./include/types.h:21:0,
>>                  from kv/LevelDBStore.h:6,
>>                  from kv/KeyValueDB.cc:5:
>> ./include/uuid.h:14:42: fatal error: boost/random/random_device.hpp:
>> No such file or directory
>> compilation terminated.
>>
>> I m compiling on ubuntu, and it looks like I have boost headers
>> (/usr/include/boost), but this file is absent. llibboost appears to =
be
>> 1.46.1
>> appreciate any pointers to resolve this error.
>>
>> Also, I couldn't access the web page for bugs
>> (http://tracker.newdream.net/projects/ceph) - where can I find a lis=
t
>> of bugs/ features ?
>> --
>> Jai
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
