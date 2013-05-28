From: Gregory Farnum <greg@inktank.com>
Subject: Re: cuttlefish ceph-fuse writes make for frequent inconsistent pgs
Date: Tue, 28 May 2013 10:15:36 -0700
Message-ID: <CAPYLRzjxc_0obVo5yLDuJXZgtfDrv-Y=RUFK4=qqtLbr-HafWQ@mail.gmail.com>
References: <orzjvgi2m7.fsf@livre.home>
	<CA+4uBUZFR8a3LL5q5pNMv64P8zv4DKOTjhigm0qeMzYUoNYJ+Q@mail.gmail.com>
	<ord2sbigbo.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:45377 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934889Ab3E1RPi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 May 2013 13:15:38 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so7738648lab.34
        for <ceph-devel@vger.kernel.org>; Tue, 28 May 2013 10:15:36 -0700 (PDT)
In-Reply-To: <ord2sbigbo.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 28, 2013 at 2:50 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> On May 27, 2013, Samuel Just <sam.just@inktank.com> wrote:
>
>> Thanks for the detailed information!  Xfs?
>
> btrfs.
>
>> Were there any osd restarts/power cycles?
>
> I can't rule that out, but I'm afraid it was a while ago, and my logs
> don't go that far back.

In general I can't imagine a mechanism by which the client could have
caused the symptoms you're describing =97 it's supposed to be
impossible, and the ceph-fuse client doesn't use any of the access
methods which are more likely to break the safety invariants.

Do you have the bad file data or anything? Solving this sounds like it
would be a forensic journey through the OSD encoding and transmission
infrastructure. :/
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
