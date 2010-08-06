From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: rbd create command fails to create image
Date: Fri, 6 Aug 2010 00:10:39 -0700
Message-ID: <AANLkTiksxkHQ-bJuKuE=sxGUpeBUcB16sjqmVRB4GkCU@mail.gmail.com>
References: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57930 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760524Ab0HFHKr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Aug 2010 03:10:47 -0400
Received: by wwj40 with SMTP id 40so8708665wwj.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 Aug 2010 00:10:46 -0700 (PDT)
In-Reply-To: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 5, 2010 at 11:50 PM, Xiaoguang Liu <syslxg@gmail.com> wrote=
:
> unstable branch, =A0build on Fedora 13.
>
>
> [root@ceph-1 mnt]# rbd create foo --size 1024
> failed to assign a block name for image
> create error: Operation not supported

This happens because the osd doesn't have the rbd class loaded in, or
have an older version loaded in. The rbd class is a loadable library
that handles some of the rbd header manipulation, as well as assigning
a unique block names for the specific rbd image. The list of classes
in the system can be obtained by running:

$ ./ceph class list
10.08.06_00:35:17.213413 mon <- [class,list]
10.08.06_00:35:17.214044 mon1 -> 'installed classes:
rbd (v1.2 [x86-64]) [active]
' (0)

Currently we'd expect rbd class version 1.2 to be loaded in and activat=
ed.

Loading a class can be done by the cclass utility, e.g.:
$ cclass -a

This will try to load all the classes that were installed with they
system, usually at /usr/lib/rados-classes. This is only needed to be
run once (per architecture) as long as there's no need to update the
class.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
