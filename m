From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: GSOC about ceph-mgr:POOL PG_NUM AUTO-TUNING
Date: Mon, 8 May 2017 10:25:58 +0530
Message-ID: <CAAXqJ+oj_LD=gEWed3p_9sqHSZnR59BA9SQe-UGwanTJEBz84Q@mail.gmail.com>
References: <CALKDg+3dUcUqamE8D9XPUu2pzOCBuWCuF9yCyBvPa4emxS0q7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35327 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdEHEz7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 May 2017 00:55:59 -0400
Received: by mail-oi0-f44.google.com with SMTP id l18so38284382oig.2
        for <ceph-devel@vger.kernel.org>; Sun, 07 May 2017 21:55:59 -0700 (PDT)
In-Reply-To: <CALKDg+3dUcUqamE8D9XPUu2pzOCBuWCuF9yCyBvPa4emxS0q7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hequan <hequanzh@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, kchai@redhat.com

Hey Hequan

I am Spandan Kumar Sahu, a second year undergraduate student selected
for "Smarter Reweight by Utilisation" project.

The mailing list only accepts plain text emails, so your proposal sent
as an attachment, isn't there in the mail I received. It would be
great, if you can upload it on Github and share the link. I am running
into some errors when I use vstart, so I would like to see how you go
about it.

As an initial observation, the various API calls, that could be made,
are present in PyModules.cc under the definition of
get_python(const std::string &what) function.

Hope this helps.

On Mon, May 8, 2017 at 9:19 AM, Hequan <hequanzh@gmail.com> wrote:
> Hi, everyone
>
> Nice to join you! My name is Hequan Zhang. I am a postgraduate student
> in Wuhan National Laboratory for Optoelectronics of Huazhong
> University of Science and Technology, majoring in Computer Science.
>
> It is my great pleasure that my proposal (see the attachment) had been accepted.
>
> Now I have completed the following setps about my project:
>
>     setup up a ceph cluster with ceph-mgr for testing with vstart.sh.
>
> [root@ceph2 build]# ./bin/ceph -s
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> 2017-05-08 11:32:06.634767 7f5e14ea5700 -1 WARNING: all dangerous and
> experimental features are enabled.
> 2017-05-08 11:32:06.668537 7f5e14ea5700 -1 WARNING: all dangerous and
> experimental features are enabled.
>     cluster e471b2c9-181f-4bc7-9d07-e36e187dd5ca
>      health HEALTH_OK
>      monmap e2: 1 mons at {a=192.168.10.2:40914/0}
>             election epoch 4, quorum 0 a
>         mgr active: x
>      osdmap e24: 4 osds: 4 up, 4 in
>       pgmap v499: 72 pgs, 2 pools, 0 bytes data, 0 objects
>             4368 MB used, 36847 MB / 41215 MB avail
>                   72 active+clean
>
>       Understand how Ceph uses PG for data placement and migration.
>
>       Understand the tradeoffs.
>
> For the last two steps, please refer to my proposal.
>
> Now I have some questions regarding ceph-mgr, and hope to have your suggestions.
>
> First, except for http://docs.ceph.com/docs/master/mgr/, is there any
> other docs about how ceph-mgr works?
>
> Second, I would like to know the working mechanisms of python module.
> Would you please recommend some related materials?
>
> At last, is there a dashboard working for ceph-mgr now, if so, what is it?
>
> Any comments and feedback would be appreciated.
>
> Thanks.
> Hequan
> -----------------------------------------------------
> Hequan Zhang
> Phone: +86 158-0279-2436
> Room 408, Building B
> Wuhan National Laboratory for Optoelectronics
> Huazhong University of Science and Technology
> Wuhan, Hubei 430074
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Spandan Kumar Sahu
IIT Kharagpur
