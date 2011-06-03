From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: fs again
Date: Fri, 3 Jun 2011 16:49:18 -0700
Message-ID: <BANLkTikWGimkB49ah8i01ZTcy8Y19PgyXA@mail.gmail.com>
References: <4DE97258.2040206@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38372 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab1FCXtU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2011 19:49:20 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D30E2CE89
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jun 2011 16:49:19 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 85C31CE83
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jun 2011 16:49:19 -0700 (PDT)
Received: by ewy4 with SMTP id 4so831322ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2011 16:49:18 -0700 (PDT)
In-Reply-To: <4DE97258.2040206@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

I run ext4 and btrfs on different partitions, that I use for Ceph, and
I think everybody else does too.

I don't remember if you're killing new or old versions of these FSes, t=
hough.
-Greg

On Fri, Jun 3, 2011 at 4:46 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi.
>
> I have question to developers.
>
> ext3 and btrfs - unusable.
>
> Guys, what kind of fs do you use at your stand?
>
> WBR,
> =A0 =A0Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
