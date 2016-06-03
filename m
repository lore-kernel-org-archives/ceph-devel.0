From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Fresh deploy Ceph (Jewel) failed because the ceph OSD deamon is
 not activated
Date: Fri, 3 Jun 2016 08:49:40 -0400
Message-ID: <CAC-Np1w-TZJXfwGdi81wVK7xTdJdJwRJ1zrhfVh1Bc+JkuktUw@mail.gmail.com>
References: <CAOCf4A=8WiBpmYV9NBFyQ639TpHxN74h3O6sT1UqMPiopaY5zQ@mail.gmail.com>
	<alpine.DEB.2.11.1606030825210.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35487 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcFCMtl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 08:49:41 -0400
Received: by mail-oi0-f50.google.com with SMTP id w184so124821048oiw.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2016 05:49:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606030825210.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tone Zhang <tone.zhang@linaro.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 3, 2016 at 8:25 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 3 Jun 2016, Tone Zhang wrote:
>> Hello all,
>>
>> I fresh deployed Ceph within 3 ceph nodes according to the manual
>> http://docs.ceph.com/docs/master/start/quick-ceph-deploy/.
>> Ceph version is Jewel (ceph version 10.2.1
>> (3a66dd4f30852819c1bdaa8ec23c795d4ad77269)).
>> Ubuntu 16.04 is used in each node.
>> After run the command "ceph-deploy osd activate", there is warning
>> reported, following an ERROR, ENAMETOOLONG. After check in each ceph
>> OSD node, the ceph osd daemon is not start up.
>
> This probably happened because you deployed the OSD on ext4.  We should
> probably remove that option (or add a warning) to ceph-deploy.

Since ceph-deploy is meant to be opinionated about these things, I
think the option should be removed:

PR: https://github.com/ceph/ceph-deploy/pull/399
Tracker issue: http://tracker.ceph.com/issues/16140

>
> sage
>
>
>>
>> According to the installation manual, the below options are not mandatory:
>> filestore_max_xattr_value_size_XXX
>> osd_max_object_name_len
>>
>> In the source code, the value of filestore_max_xattr_value_size_XXX
>> should be over the value of osd_max_object_name_len, otherwise the
>> error, ENAMETOOLONG, will be reported.
>>
>> logical if the options are not mandatory, I think the OSD daemon
>> should NOT be blocked.
>> So it should be one bug. Right?
>> I can reproduce the problem in Jewel and in the source code building
>> from the latest master branch (version is
>> 9661bbbbd7d0f03095039184f8ed9fb92855d576).
>> Now the question is that is it one bug? Is there any history behind?
>> If it is a bug, I'd like to fix it.
>> What's you opinion? Any suggestion?
>> I have created one bug to track the issue http://tracker.ceph.com/issues/16070.
>> Thanks.
>>
>> Br,
>> Tone ZHANG
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
