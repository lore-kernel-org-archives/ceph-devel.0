From: Samuel Just <sam.just@inktank.com>
Subject: Re: Very bad behavior when
Date: Fri, 23 Nov 2012 18:11:25 -0800
Message-ID: <CA+4uBUbXY2dBc=w-5an9cZ+26SHcQLHgXXpF55R6R_xX+2LHXg@mail.gmail.com>
References: <CAF6-1L5WSukXaDfy64wxUuuHDdhZ3G3AW_=fkjiVLzbm_g-rng@mail.gmail.com>
	<CA+4uBUbm36k0vF-+gvcBkCXCaUYOwggE1e=Vdd+3GigSgYk=AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64249 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788Ab2KXCL0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 21:11:26 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4137308vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 18:11:25 -0800 (PST)
In-Reply-To: <CA+4uBUbm36k0vF-+gvcBkCXCaUYOwggE1e=Vdd+3GigSgYk=AQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sylvain Munaut <s.munaut@whatever-company.com>

That is indeed poor behavior.  What version are you running?
-Sam

On Nov 23, 2012 6:06 PM, "Samuel Just" <sam.just@inktank.com> wrote:
>
> That is indeed bad behavior.  What version are you running?
> -Sam
>
> On Nov 22, 2012 1:18 PM, "Sylvain Munaut" <s.munaut@whatever-company.com> wrote:
>>
>> Hi,
>>
>> I know that ceph has time synced servers has a requirements, but I
>> think a sane failure mode like a message in the logs instead of
>> incontrollably growing memory usage would be a good idea.
>>
>> I had the NTP process die on me tonight on an OSD (for unknown reason
>> so far ...) and the clock went 3000s out of sync and the OSD memory
>> just kept growing, and also the master mon memory.
>> (which has the nice effect of having the master mon being OOM killed,
>> then one of the backup takes the master role and grows as well and
>> gets killed and so on and so forth until there is no quorum anymore).
>>
>> Cheers,
>>
>>      Sylvain
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
