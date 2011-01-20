From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: sparse file support
Date: Thu, 20 Jan 2011 14:03:01 -0800
Message-ID: <AANLkTinymVyHX32VMtxS7vYb3kM1sTdNLUOP8g5aKxdO@mail.gmail.com>
References: <AANLkTik231Dz019ztWhJsMX0tnVKL-EdmkY8ROCSWLnV@mail.gmail.com>
	<Pine.LNX.4.64.1101201325570.25905@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37515 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1ATWDD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jan 2011 17:03:03 -0500
Received: by qyk12 with SMTP id 12so1175282qyk.19
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jan 2011 14:03:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1101201325570.25905@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 20, 2011 at 1:28 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 20 Jan 2011, Brian Chrisman wrote:
>> I've performed some simple testing of sparse files on ceph. =A0Summa=
ry,
>> ceph reports full file size to 'du' and 'ls', where it should return
>> actual storage usage to 'du'. =A0Creating a sparse file on ceph does=
 not
>> actually use the full file size in storage (which is correct
>> behavior). =A0Is this a known issue, or should I submit a bug?
>
> This is a design choice. =A0The MDS doesn't know how many blocks are
> allocated because, with the exception of reporting st_blocks to du, i=
t
> doesn't need to. =A0This makes metadata smaller and the protocols sim=
pler.
>
> sage

Ahh ok, understood.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
