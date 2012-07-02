From: Gregory Farnum <greg@inktank.com>
Subject: Re: Bug with ceph_mount and non-existent directory
Date: Mon, 2 Jul 2012 10:04:16 -0700
Message-ID: <CAPYLRzi_2Bvn=fcC_hWBzNTRj4fLPzx1NMfj_X=6ZVsM9n+Mcw@mail.gmail.com>
References: <071130CA-B2AB-4C9D-80A7-23BE3DEF12C9@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37679 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab2GBRES convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 13:04:18 -0400
Received: by lbbgm6 with SMTP id gm6so7903770lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 10:04:16 -0700 (PDT)
In-Reply-To: <071130CA-B2AB-4C9D-80A7-23BE3DEF12C9@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 26, 2012 at 8:20 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wro=
te:
> I get the following assert failure during cleanup if ceph_mount() is =
passed a non-existent directory, while ceph_mount() returns success. No=
thing critical, but it got triggered with Java unit test framework.
>
> =A0 =A0 [junit] ./include/xlist.h: In function 'xlist<T>::item::~item=
() [with T =3D Inode*]' thread 7fafb175f700 time 2012-06-24 11:11:03.03=
8030
> =A0 =A0 [junit] ./include/xlist.h: 28: FAILED assert(!is_on_list())
> =A0 =A0 [junit] =A0ceph version 0.47.2-414-gc4bf133 (commit:c4bf133b8=
7403016cff0355cbebd54f95d3f753b)
> =A0 =A0 [junit] =A01: (()+0x1073c8) [0x7fafa862d3c8]
> =A0 =A0 [junit] =A02: (Inode::~Inode()+0x249) [0x7fafa867f8f9]
> =A0 =A0 [junit] =A03: (Client::tear_down_cache()+0x2c3) [0x7fafa86673=
93]
> =A0 =A0 [junit] =A04: (Client::~Client()+0x2f) [0x7fafa866747f]
> =A0 =A0 [junit] =A05: (Client::~Client()+0x9) [0x7fafa8667b49]
> =A0 =A0 [junit] =A06: (ceph_mount()+0x136) [0x7fafa862f8d6]

Sorry to leave this so long. Just to make sure I understand: if you
pass ceph_mount a directory (to be the root of the local mount) which
doesn't exist, it mounts successfully (at root?), but then asserts on
cleanup?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
