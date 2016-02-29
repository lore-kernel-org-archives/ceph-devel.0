From: Jai <jai_97@rediffmail.com>
Subject: Re: make error while building ceph
Date: Mon, 29 Feb 2016 20:04:59 +0530
Message-ID: <CAPpuMWyePM_TvmO1MHFRF=jQMw5KRqyy4FA3+QRU2pAq97UwSw@mail.gmail.com>
References: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
 <56D2D089.7090109@dachary.org> <CAPpuMWx9Or8ETDKtzFsUUkF0wSDnPEjiKhOSuVT=VrVYiUNohg@mail.gmail.com>
 <56D2D55C.7060603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34889 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbcB2OfU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 09:35:20 -0500
Received: by mail-lf0-f52.google.com with SMTP id j186so18198188lfg.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 06:35:19 -0800 (PST)
In-Reply-To: <56D2D55C.7060603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Loic,

With centos 7, I ve moved further .. The build is stuck however at this=
 --

=2E/make_version -g ./.git_version
if [ -n "$NO_VERSION" ] ; then \
        ./make_version -g ./.git_version -c ./ceph_ver.h -n ; \
else \
        ./make_version -g ./.git_version -c ./ceph_ver.h ; \
fi
  CXX      test/encoding/ceph_dencoder-ceph_dencoder.o

I ve tried restarting the make a few times after cleaning up, but it
comes back to this point. Could this be a failed/hung test ?

--
Jai

On Sun, Feb 28, 2016 at 4:39 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Ubuntu 12.04 is no longer supported, reason why you're having trouble=
s. I recommend CentOS 7 or Ubunut 14.04 instead.
>
> Cheers
>
> On 28/02/2016 17:55, Jai wrote:
>> Loic,
>>
>> I did run install-deps before the make, and it completed without
>> error. I have an Ubuntu (1204) VM (uname shows 3.5.0-30-generic
>> #51~precise1-Ubuntu)
>>
>> I ran these as per the README --
>> ./install-deps.sh
>> ./autogen.sh
>>   ./configure
>>   make
>>
>> I found the bugs link on http://ceph.com/community/contribute/ under
>> "submit issues"
>>
>> --
>> Jai
>>
>> On Sun, Feb 28, 2016 at 4:18 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi,
>>>
>>> You should try to run ./install-deps.sh first so that the required =
dependencies are all installed. Which operating system are you using ?
>>> The bug tracker is at http://tracker.ceph.com/. Where did you find =
a link to http://tracker.newdream.net/projects/ceph ? It should be fixe=
d :-)
>>>
>>> Cheers
>>>
>>> On 28/02/2016 17:29, Jai wrote:
>>>> I followed instructions in the README, but "make" gives me this er=
ror --
>>>>
>>>> In file included from ./include/types.h:21:0,
>>>>                  from kv/LevelDBStore.h:6,
>>>>                  from kv/KeyValueDB.cc:5:
>>>> ./include/uuid.h:14:42: fatal error: boost/random/random_device.hp=
p:
>>>> No such file or directory
>>>> compilation terminated.
>>>>
>>>> I m compiling on ubuntu, and it looks like I have boost headers
>>>> (/usr/include/boost), but this file is absent. llibboost appears t=
o be
>>>> 1.46.1
>>>> appreciate any pointers to resolve this error.
>>>>
>>>> Also, I couldn't access the web page for bugs
>>>> (http://tracker.newdream.net/projects/ceph) - where can I find a l=
ist
>>>> of bugs/ features ?
>>>> --
>>>> Jai
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
