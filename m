From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: lttng broken on i386 trusty
Date: Wed, 8 Apr 2015 16:25:43 -0700
Message-ID: <CAFkUHxeJF=6y3oym-vF1XEGSWs9MWWCt1nJ0X90H8k1KfuWPiA@mail.gmail.com>
References: <55152926.9000400@dachary.org>
	<CAFkUHxckG3r05gbgaHQzYagU8BhjCNjApwj8iWAiyGu1U4Ub-A@mail.gmail.com>
	<5525B7B1.9000903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33123 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454AbbDHXZn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 19:25:43 -0400
Received: by pdbnk13 with SMTP id nk13so131520299pdb.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Apr 2015 16:25:43 -0700 (PDT)
In-Reply-To: <5525B7B1.9000903@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

Thats because its being run with --without-lttng

as per the log in
http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-i386-ba=
sic/log.cgi?log=3D21f60a9d26f821ba1cd1db8bb79f8aff2a028582:

=2E/configure --with-debug --with-radosgw --with-libatomic-ops
--without-lttng --disable-static --without-cryptopp --with-tcmalloc

if you change it to --with-lttng it will fail

-Neo

On Wed, Apr 8, 2015 at 4:20 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> Are you still seeing the same error on the latest master?
> The gitbuilder is building successfully now:
>
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-i386-=
basic/log.cgi?log=3D21f60a9d26f821ba1cd1db8bb79f8aff2a028582
>
>
> On 04/08/2015 04:07 PM, kernel neophyte wrote:
>>
>> Need help! This is still broken!
>>
>> -Neo
>>
>> On Fri, Mar 27, 2015 at 2:55 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>>
>>> Hi,
>>>
>>> In case you did not notice:
>>>
>>>
>>> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-i38=
6-basic/log.cgi?log=3Ddca722ec7b2a7fc9214844ec92310074b5cb2faa
>>>
>>> CXXLD radosgw-admin
>>> CXXLD rados
>>> /usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-us=
t.so:
>>> undefined reference to `dlclose'
>>> /usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-us=
t.so:
>>> undefined reference to `dlsym'
>>> /usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-us=
t.so:
>>> undefined reference to `dlopen'
>>>
>>>      error: collect2: ld returned 1 exit status
>>>
>>> make[3]: *** [ceph_tpbench] Error 1
>>> make[3]: *** Waiting for unfinished jobs....
>>> CXXLD ceph-objectstore-tool
>>> make[3]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/buil=
d/src'
>>> make[2]: *** [all-recursive] Error 1
>>> make[2]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/buil=
d/src'
>>> make[1]: *** [all] Error 2
>>> make[1]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/buil=
d/src'
>>>
>>>      make: *** [all-recursive] Error 1
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
