From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: vstart.sh failed
Date: Fri, 11 Aug 2017 19:25:22 +0800
Message-ID: <CACKY0b86jnkgY=nC20fYY_MDwxPADsWYNj0euPGfsS5DQOjLsQ@mail.gmail.com>
References: <CAMwhyqW=1ghYXwBYX+P+prqL-1e=w1YJQneeRg6_=arMC+ePvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33674 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdHKLZX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Aug 2017 07:25:23 -0400
Received: by mail-vk0-f48.google.com with SMTP id j189so12237311vka.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Aug 2017 04:25:23 -0700 (PDT)
In-Reply-To: <CAMwhyqW=1ghYXwBYX+P+prqL-1e=w1YJQneeRg6_=arMC+ePvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

ceph-mgr probably loads RESTful plugin failed. ceph-mgr's restful
plugin depends on OpenSSL library. you need to resolve this
dependency.  you could check out/mgr.x.log, ceph-mgr prints error
message.

actually you could ignore this error if you don't use ceph-mgr's restful pl=
ugin.


error logging:

2017-08-11 17:14:59.032574 7f37665b6700 -1 mgr load Module not found:
'restful'
2017-08-11 17:14:59.032617 7f37665b6700 -1 mgr load Traceback (most
recent call last):
  File "/home/liuchang/WorkSpace/ceph/src/pybind/mgr/restful/__init__.py",
line 1, in <module>
    from module import *  # NOQA
  File "/home/liuchang/WorkSpace/ceph/src/pybind/mgr/restful/module.py",
line 18, in <module>
    from OpenSSL import crypto
ImportError: No module named OpenSSL


2017-08-11 17:46 GMT+08:00 =E6=94=80=E5=88=98 <liupan1111@gmail.com>:
> Hi All,
>
> I am trying to use vstart.sh to create a local cluster, and got the
> problem below, could anybody give me some help? Thanks!
>
> .....
> set mgr/restful/x/server_port
> Starting mgr.x
> /mnt/aliceph/liupan1/ceph/build/bin/ceph-mgr -i x -c
> /mnt/aliceph/liupan1/ceph/build/ceph.conf
> /mnt/aliceph/liupan1/ceph/build/bin/ceph -c
> /mnt/aliceph/liupan1/ceph/build/ceph.conf -k
> /mnt/aliceph/liupan1/ceph/build/keyring restful
> create-self-signed-cert
> no valid command found; 10 closest matches:
> osd setcrushmap {<int>}
> osd crush set {<int>}
> osd crush rule dump {<name>}
> osd crush dump
> osd crush rule list
> osd crush rule ls
> osd blacklist ls
> osd blacklist clear
> osd map <poolname> <objectname> {<nspace>}
> osd lspools {<int>}
> Error EINVAL: invalid command
> MGR Restful is not working, perhaps the package is not installed?
> started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for
> debug output.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
