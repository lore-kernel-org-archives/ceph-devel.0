From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: build errors centos 6.2
Date: Tue, 22 May 2012 09:06:46 -0700
Message-ID: <CAC-hyiH05vJSA6d-NxfoM88uAwAFvhE3GKrD8KRCVcag6yW6Kw@mail.gmail.com>
References: <4FBBA38B.2070203@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49546 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab2EVQGr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 12:06:47 -0400
Received: by bkcji2 with SMTP id ji2so5140218bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 09:06:46 -0700 (PDT)
In-Reply-To: <4FBBA38B.2070203@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The log is trimmed, but I guess it's complaining about missing
libxml2. In any case, you shouldn't be compiling libs3 (unless you
compile rest-bench) so cherry-picking commit
4e3807bc587c232318b0a2023ac7e9d39fef67a3 should solve this issue.

On Tue, May 22, 2012 at 7:32 AM, Matt Weil <mweil@genome.wustl.edu> wro=
te:
>> make[3]: *** [build/obj/simplexml.do] Error 1
>> make[3]: *** Waiting for unfinished jobs....
>> make[3]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src/libs3=
'
>> make[2]: *** [all-recursive] Error 1
>> make[2]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47/src'
>> make: *** [all-recursive] Error 1
>> error: Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
>>
>>
>> RPM build errors:
>> =A0 =A0Bad exit status from /var/tmp/rpm-tmp.9tq56B (%build)
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
