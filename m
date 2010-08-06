From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: rbd create command fails to create image
Date: Fri, 6 Aug 2010 15:35:37 +0800
Message-ID: <AANLkTikyKWEObcbRJ1pTjMuEHOAXrRxiKO5ts+9m9cx0@mail.gmail.com>
References: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
	<AANLkTiksxkHQ-bJuKuE=sxGUpeBUcB16sjqmVRB4GkCU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43925 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933911Ab0HFHfn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Aug 2010 03:35:43 -0400
Received: by vws3 with SMTP id 3so5878477vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Aug 2010 00:35:42 -0700 (PDT)
In-Reply-To: <AANLkTiksxkHQ-bJuKuE=sxGUpeBUcB16sjqmVRB4GkCU@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

you are right. I don't have any classes installed. but cclass -a
fails. what could be the causes?

[root@ceph-1 x86_64]# cclass -a
nm: /usr/lib64/rados-classes/libcls_rbd.so.1.0.0: no symbols
Loading class: /usr/lib64/rados-classes/libcls_rbd.so.1.0.0: Error:
Could not detect class name
nm: /usr/lib64/rados-classes/libcls_rbd.so.1.0.0: no symbols
read 37096 bytes from /usr/lib64/rados-classes/libcls_rbd.so.1.0.0
10.08.06_15:32:25.472987 mon <-
[class,add,Error:,Could,not,detect,class,name,changed]
10.08.06_15:32:25.473399 mon0 -> 'invalid option: detect' (-22)

[root@ceph-1 x86_64]# ceph class list
10.08.06_15:32:55.087874 mon <- [class,list]
10.08.06_15:32:55.088179 mon0 -> 'no installed classes!' (0)




On Fri, Aug 6, 2010 at 3:10 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Thu, Aug 5, 2010 at 11:50 PM, Xiaoguang Liu <syslxg@gmail.com> wro=
te:
>> unstable branch, =A0build on Fedora 13.
>>
>>
>> [root@ceph-1 mnt]# rbd create foo --size 1024
>> failed to assign a block name for image
>> create error: Operation not supported
>
> This happens because the osd doesn't have the rbd class loaded in, or
> have an older version loaded in. The rbd class is a loadable library
> that handles some of the rbd header manipulation, as well as assignin=
g
> a unique block names for the specific rbd image. The list of classes
> in the system can be obtained by running:
>
> $ ./ceph class list
> 10.08.06_00:35:17.213413 mon <- [class,list]
> 10.08.06_00:35:17.214044 mon1 -> 'installed classes:
> rbd (v1.2 [x86-64]) [active]
> ' (0)
>
> Currently we'd expect rbd class version 1.2 to be loaded in and activ=
ated.
>
> Loading a class can be done by the cclass utility, e.g.:
> $ cclass -a
>
> This will try to load all the classes that were installed with they
> system, usually at /usr/lib/rados-classes. This is only needed to be
> run once (per architecture) as long as there's no need to update the
> class.
>
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
