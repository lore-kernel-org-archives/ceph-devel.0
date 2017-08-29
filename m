From: kefu chai <tchaikov@gmail.com>
Subject: Re: Building Ceph in Docker
Date: Tue, 29 Aug 2017 21:53:02 +0800
Message-ID: <CAJE9aOPNxoui-f5ScSNX3W9YrfGiEmBna3La1zdRVr7WheLdGA@mail.gmail.com>
References: <CAM+oqtHyc-1RSB1StOt2fUpJCS8b-5gwEHfLP9eDhgC2uq-mNw@mail.gmail.com>
 <a27efb29-bfc3-305a-5517-eb9b58612484@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35728 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdH2NxD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 09:53:03 -0400
Received: by mail-oi0-f52.google.com with SMTP id k77so27776540oib.2
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 06:53:03 -0700 (PDT)
In-Reply-To: <a27efb29-bfc3-305a-5517-eb9b58612484@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Mingliang LIU <mingliang.liu@salesforce.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 29, 2017 at 6:27 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> I know we're building Ceph in Linux distributions and many of you use
>> vstart.sh as I do. Steps to install dependencies are easy so we don't
>> have to worry about prerequisites in a dev machine.
>>
>> I'm thinking if it's useful to build Ceph in Docker. There are reasons
>> to do this, for example 1) not be able/willing to install quite a few
>> dependency software/library on a shared Linux, 2) to have a standard
>> build image for isolated and automatic testing, and 3) to build on
>> Mac/Windows. I know for this we can create Linux virtual machines on
>> Mac/ Windows, but I think container is lightweight and better.
>>
>> So I attach a small script that creates a Docker image to build the
>> Ceph from source, and then starts a test cluster with vstart.sh in a
>> container. Do you think it's something useful and/or worth to have in
>> source tree?
>>
>> When I was building Hadoop, I found its start-build-env.sh helpful,
>> which is basically the same idea I borrowed here.
>
>
> Have you looked at docker-test.sh ?
>
> https://github.com/ceph/ceph/blob/master/src/test/docker-test.sh
>
> I have not tried it in awhile, but it used to be able to not only build Ceph
> but also run "make check", in a Docker container. It support(ed) several
> different operating systems.
>
> It would be nice if someone got it working again.

it still worked the last time i tried to build luminous on
debian/stretch. (i hacked src/test/debian-jessie a little bit).

>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
