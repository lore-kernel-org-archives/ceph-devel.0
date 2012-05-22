From: Matt Weil <mweil@genome.wustl.edu>
Subject: Re: build errors centos 6.2
Date: Tue, 22 May 2012 14:42:42 -0500
Message-ID: <4FBBEC32.60206@genome.wustl.edu>
References: <4FBBA38B.2070203@genome.wustl.edu> <CAC-hyiH05vJSA6d-NxfoM88uAwAFvhE3GKrD8KRCVcag6yW6Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:39795 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755481Ab2EVTmn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:42:43 -0400
In-Reply-To: <CAC-hyiH05vJSA6d-NxfoM88uAwAFvhE3GKrD8KRCVcag6yW6Kw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> build/obj/util.do: Compiling dynamic object
> src/simplexml.c:27:27: error: libxml/parser.h: No such file or directory
> src/simplexml.c:48: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'saxGetEntity'
> cc1: warnings being treated as errors
> src/simplexml.c:56: error: type defaults to 'int' in declaration of 'xmlChar'
> src/simplexml.c:56: error: expected ';', ',' or ')' before '*' token
> src/simplexml.c:88: error: type defaults to 'int' in declaration of 'xmlChar'
> src/simplexml.c:88: error: expected ';', ',' or ')' before '*' token
> src/simplexml.c:111: error: type defaults to 'int' in declaration of 'xmlChar'
> src/simplexml.c:111: error: expected ';', ',' or ')' before '*' token
> src/simplexml.c:138: error: variable 'saxHandlerG' has initializer but incomplete type

sorry I did trim it.

On 5/22/12 11:06 AM, Yehuda Sadeh wrote:
> The log is trimmed, but I guess it's complaining about missing
> libxml2. In any case, you shouldn't be compiling libs3 (unless you
> compile rest-bench) so cherry-picking commit
> 4e3807bc587c232318b0a2023ac7e9d39fef67a3 should solve this issue.
>
> On Tue, May 22, 2012 at 7:32 AM, Matt Weil<mweil@genome.wustl.edu>  wrote:
>>> make[3]: *** [build/obj/simplexml.do] Error 1
>>> make[3]: *** Waiting for unfinished jobs....
>>> make[3]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src/libs3'
>>> make[2]: *** [all-recursive] Error 1
>>> make[2]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
>>> make[1]: *** [all] Error 2
>>> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
>>> make: *** [all-recursive] Error 1
>>> error: Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
>>>
>>>
>>> RPM build errors:
>>>     Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

