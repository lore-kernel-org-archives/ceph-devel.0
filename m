From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: build errors centos 6.2
Date: Tue, 22 May 2012 13:50:00 -0700
Message-ID: <CAC-hyiEp=wNvr-ia8=_gGEgb3USMGekDbif62-Mtwtzf+Cg+pQ@mail.gmail.com>
References: <4FBBA38B.2070203@genome.wustl.edu>
	<CAC-hyiH05vJSA6d-NxfoM88uAwAFvhE3GKrD8KRCVcag6yW6Kw@mail.gmail.com>
	<4FBBEC32.60206@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50316 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626Ab2EVUuB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 16:50:01 -0400
Received: by bkcji2 with SMTP id ji2so5375234bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 13:50:00 -0700 (PDT)
In-Reply-To: <4FBBEC32.60206@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 22, 2012 at 12:42 PM, Matt Weil <mweil@genome.wustl.edu> wr=
ote:
>
>> build/obj/util.do: Compiling dynamic object
>> src/simplexml.c:27:27: error: libxml/parser.h: No such file or direc=
tory
>> src/simplexml.c:48: error: expected '=3D', ',', ';', 'asm' or
>> '__attribute__' before 'saxGetEntity'
>> cc1: warnings being treated as errors
>> src/simplexml.c:56: error: type defaults to 'int' in declaration of
>> 'xmlChar'
>> src/simplexml.c:56: error: expected ';', ',' or ')' before '*' token
>> src/simplexml.c:88: error: type defaults to 'int' in declaration of
>> 'xmlChar'
>> src/simplexml.c:88: error: expected ';', ',' or ')' before '*' token
>> src/simplexml.c:111: error: type defaults to 'int' in declaration of
>> 'xmlChar'
>> src/simplexml.c:111: error: expected ';', ',' or ')' before '*' toke=
n
>> src/simplexml.c:138: error: variable 'saxHandlerG' has initializer b=
ut
>> incomplete type
>
>
> sorry I did trim it.
>
>
> On 5/22/12 11:06 AM, Yehuda Sadeh wrote:
>>
>> The log is trimmed, but I guess it's complaining about missing
>> libxml2. In any case, you shouldn't be compiling libs3 (unless you
>> compile rest-bench) so cherry-picking commit
>> 4e3807bc587c232318b0a2023ac7e9d39fef67a3 should solve this issue.
>>
>> On Tue, May 22, 2012 at 7:32 AM, Matt Weil<mweil@genome.wustl.edu> =A0=
wrote:
>>>>
>>>> make[3]: *** [build/obj/simplexml.do] Error 1
>>>> make[3]: *** Waiting for unfinished jobs....
>>>> make[3]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src/lib=
s3'
>>>> make[2]: *** [all-recursive] Error 1
>>>> make[2]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
>>>> make[1]: *** [all] Error 2
>>>> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
>>>> make: *** [all-recursive] Error 1
>>>> error: Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
>>>>
>>>>
>>>> RPM build errors:
>>>> =A0 =A0Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>
>

Yeah, as I said, it's missing libxml2 so it fails to compile libs3.
However, it shouldn't even try to compile that, so commit
4e3807bc587c232318b0a2023ac7e9d39fef67a3 should fix that for you.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
