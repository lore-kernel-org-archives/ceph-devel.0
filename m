From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: vstart.sh failed
Date: Mon, 14 Aug 2017 14:24:10 +0800
Message-ID: <CACKY0b9zMiSpanrctLjUxebAPDogfWHG6PEbPaMcHa_Gsercrg@mail.gmail.com>
References: <CAMwhyqW=1ghYXwBYX+P+prqL-1e=w1YJQneeRg6_=arMC+ePvQ@mail.gmail.com>
 <CACKY0b86jnkgY=nC20fYY_MDwxPADsWYNj0euPGfsS5DQOjLsQ@mail.gmail.com> <CAN1NP8joj8nh-mZr_Bimn7fdFnyQjhufw3dV3S6jA0T1=6HL4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:38512 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdHNGYM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Aug 2017 02:24:12 -0400
Received: by mail-lf0-f47.google.com with SMTP id y15so35568797lfd.5
        for <ceph-devel@vger.kernel.org>; Sun, 13 Aug 2017 23:24:12 -0700 (PDT)
In-Reply-To: <CAN1NP8joj8nh-mZr_Bimn7fdFnyQjhufw3dV3S6jA0T1=6HL4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Forumulator V <forumulator@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

yeah, try this command:  sudo pip install pyOpenSSL

2017-08-12 5:13 GMT+08:00 Forumulator V <forumulator@gmail.com>:
> Hey Liu,
>
> I'm getting the same error: So you're saying that installing python OpenS=
SL
> will fix this?
>
> Also, you can add "--mgr_num 0" to vstart make it go away
>
> Pranjal
>
> On Fri, Aug 11, 2017 at 4:55 PM, liuchang0812 <liuchang0812@gmail.com>
> wrote:
>>
>> ceph-mgr probably loads RESTful plugin failed. ceph-mgr's restful
>> plugin depends on OpenSSL library. you need to resolve this
>> dependency.  you could check out/mgr.x.log, ceph-mgr prints error
>> message.
>>
>> actually you could ignore this error if you don't use ceph-mgr's restful
>> plugin.
>>
>>
>> error logging:
>>
>> 2017-08-11 17:14:59.032574 7f37665b6700 -1 mgr load Module not found:
>> 'restful'
>> 2017-08-11 17:14:59.032617 7f37665b6700 -1 mgr load Traceback (most
>> recent call last):
>>   File "/home/liuchang/WorkSpace/ceph/src/pybind/mgr/restful/__init__.py=
",
>> line 1, in <module>
>>     from module import *  # NOQA
>>   File "/home/liuchang/WorkSpace/ceph/src/pybind/mgr/restful/module.py",
>> line 18, in <module>
>>     from OpenSSL import crypto
>> ImportError: No module named OpenSSL
>>
>>
>> 2017-08-11 17:46 GMT+08:00 =E6=94=80=E5=88=98 <liupan1111@gmail.com>:
>> > Hi All,
>> >
>> > I am trying to use vstart.sh to create a local cluster, and got the
>> > problem below, could anybody give me some help? Thanks!
>> >
>> > .....
>> > set mgr/restful/x/server_port
>> > Starting mgr.x
>> > /mnt/aliceph/liupan1/ceph/build/bin/ceph-mgr -i x -c
>> > /mnt/aliceph/liupan1/ceph/build/ceph.conf
>> > /mnt/aliceph/liupan1/ceph/build/bin/ceph -c
>> > /mnt/aliceph/liupan1/ceph/build/ceph.conf -k
>> > /mnt/aliceph/liupan1/ceph/build/keyring restful
>> > create-self-signed-cert
>> > no valid command found; 10 closest matches:
>> > osd setcrushmap {<int>}
>> > osd crush set {<int>}
>> > osd crush rule dump {<name>}
>> > osd crush dump
>> > osd crush rule list
>> > osd crush rule ls
>> > osd blacklist ls
>> > osd blacklist clear
>> > osd map <poolname> <objectname> {<nspace>}
>> > osd lspools {<int>}
>> > Error EINVAL: invalid command
>> > MGR Restful is not working, perhaps the package is not installed?
>> > started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for
>> > debug output.
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
