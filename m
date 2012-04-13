From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Problem after upgrade to 0.45
Date: Fri, 13 Apr 2012 14:09:13 +0200
Message-ID: <CAMwB3ThsOt=fLHn54GpD4h7DmnMskAFJxm58Kp40ANKfLOFV9Q@mail.gmail.com>
References: <CAMwB3TidM-Jebn0Hjr0sM8a-F0jpaByRAH0tLha27CAhV7pPqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61790 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab2DMMJO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 08:09:14 -0400
Received: by wibhj6 with SMTP id hj6so6449193wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 13 Apr 2012 05:09:13 -0700 (PDT)
In-Reply-To: <CAMwB3TidM-Jebn0Hjr0sM8a-F0jpaByRAH0tLha27CAhV7pPqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

More info, that after i use filestore_xattr_use_omap =3D 1 in conf, and
ceph -w is like that in attachment in mail before.

I have downgrade to 0.44, and everything is ok now, but why this happen=
 ??

2012/4/13 S=B3awomir Skowron <szibis@gmail.com>:
> 2012-04-13 11:03:20.017166 7f63d62b47a0 -- 0.0.0.0:6848/9291
> accepter.bind my_inst.addr is 0.0.0.0:6848/9291 need_addr=3D1
> 2012-04-13 11:03:20.018576 7f63d62b47a0 filestore(/vol0/data/osd.1)
> basedir /vol0/data/osd.1 journal /vol0/data/osd.1/journal
> 2012-04-13 11:03:20.027918 7f63d62b47a0 filestore(/vol0/data/osd.1)
> limited size xattrs -- enable filestore_xattr_use_omap
> 2012-04-13 11:03:20.028014 7f63d62b47a0 =A0** ERROR: error converting
> store /vol0/data/osd.1: (95) Operation not supported
> 2012-04-13 11:07:08.904974 7f35299ed7a0 ceph version 0.45
> (commit:0aea1cb1df5c3e5ab783ca6f2ed7649823b613c5), process ceph-osd,
> pid 20052
> 2012-04-13 11:07:08.905164 7f35299ed7a0 -- 0.0.0.0:6800/20052
> accepter.bind my_inst.addr is 0.0.0.0:6800/20052 need_addr=3D1
> 2012-04-13 11:07:08.905182 7f35299ed7a0 -- 0.0.0.0:6801/20052
> accepter.bind my_inst.addr is 0.0.0.0:6801/20052 need_addr=3D1
> 2012-04-13 11:07:08.905197 7f35299ed7a0 -- 0.0.0.0:6802/20052
> accepter.bind my_inst.addr is 0.0.0.0:6802/20052 need_addr=3D1
> 2012-04-13 11:07:08.906418 7f35299ed7a0 filestore(/vol0/data/osd.1)
> basedir /vol0/data/osd.1 journal /vol0/data/osd.1/journal
> 2012-04-13 11:07:08.906565 7f35299ed7a0 filestore(/vol0/data/osd.1)
> limited size xattrs -- enable filestore_xattr_use_omap
> 2012-04-13 11:07:08.906644 7f35299ed7a0 =A0** ERROR: error converting
> store /vol0/data/osd.1: (95) Operation not supported
> 2012-04-13 11:09:18.894624 7fd2a60157a0 ceph version 0.45
> (commit:0aea1cb1df5c3e5ab783ca6f2ed7649823b613c5), process ceph-osd,
> pid 31803
> 2012-04-13 11:09:18.894859 7fd2a60157a0 -- 0.0.0.0:6800/31803
> accepter.bind my_inst.addr is 0.0.0.0:6800/31803 need_addr=3D1
> 2012-04-13 11:09:18.894884 7fd2a60157a0 -- 0.0.0.0:6801/31803
> accepter.bind my_inst.addr is 0.0.0.0:6801/31803 need_addr=3D1
> 2012-04-13 11:09:18.894905 7fd2a60157a0 -- 0.0.0.0:6802/31803
> accepter.bind my_inst.addr is 0.0.0.0:6802/31803 need_addr=3D1
> 2012-04-13 11:09:18.896173 7fd2a60157a0 filestore(/vol0/data/osd.1)
> basedir /vol0/data/osd.1 journal /vol0/data/osd.1/journal
> 2012-04-13 11:09:18.896326 7fd2a60157a0 filestore(/vol0/data/osd.1)
> limited size xattrs -- enable filestore_xattr_use_omap
>
> and my ceph -w in attachment. Many failed osd, and more.
>
> --
> -----
> Pozdrawiam
>
> S=B3awek "sZiBis" Skowron



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
