From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Bug with ceph_mount and non-existent directory
Date: Thu, 12 Jul 2012 08:26:23 -0700
Message-ID: <CAPrxi59OzF9YhWkmuKF_v2guO5bofJoufHVj5FLws88bPCJy7A@mail.gmail.com>
References: <071130CA-B2AB-4C9D-80A7-23BE3DEF12C9@cs.ucsc.edu>
	<CAPYLRzi_2Bvn=fcC_hWBzNTRj4fLPzx1NMfj_X=6ZVsM9n+Mcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42836 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528Ab2GLP0Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 11:26:24 -0400
Received: by yenl2 with SMTP id l2so2521032yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 08:26:23 -0700 (PDT)
In-Reply-To: <CAPYLRzi_2Bvn=fcC_hWBzNTRj4fLPzx1NMfj_X=6ZVsM9n+Mcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 2, 2012 at 10:04 AM, Gregory Farnum <greg@inktank.com> wrote:
> On Tue, Jun 26, 2012 at 8:20 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> I get the following assert failure during cleanup if ceph_mount() is passed a non-existent directory, while ceph_mount() returns success. Nothing critical, but it got triggered with Java unit test framework.

Hey Greg, I didn't test if the mount is functional, but it doesn't
return an error.

- Noah

>>
>>     [junit] ./include/xlist.h: In function 'xlist<T>::item::~item() [with T = Inode*]' thread 7fafb175f700 time 2012-06-24 11:11:03.038030
>>     [junit] ./include/xlist.h: 28: FAILED assert(!is_on_list())
>>     [junit]  ceph version 0.47.2-414-gc4bf133 (commit:c4bf133b87403016cff0355cbebd54f95d3f753b)
>>     [junit]  1: (()+0x1073c8) [0x7fafa862d3c8]
>>     [junit]  2: (Inode::~Inode()+0x249) [0x7fafa867f8f9]
>>     [junit]  3: (Client::tear_down_cache()+0x2c3) [0x7fafa8667393]
>>     [junit]  4: (Client::~Client()+0x2f) [0x7fafa866747f]
>>     [junit]  5: (Client::~Client()+0x9) [0x7fafa8667b49]
>>     [junit]  6: (ceph_mount()+0x136) [0x7fafa862f8d6]
>
> Sorry to leave this so long. Just to make sure I understand: if you
> pass ceph_mount a directory (to be the root of the local mount) which
> doesn't exist, it mounts successfully (at root?), but then asserts on
> cleanup?
