From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: some thoughts about scrub
Date: Mon, 31 Jan 2011 14:14:19 -0800
Message-ID: <AANLkTinJ7q5tFzQfoJaSvopaJpHrqxoBbKoxNMgKD70n@mail.gmail.com>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
	<20110131215819.f0537c57.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59617 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab1AaWOW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 17:14:22 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A2814C067
	for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 14:14:21 -0800 (PST)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 501DFC063
	for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 14:14:21 -0800 (PST)
Received: by eye27 with SMTP id 27so2853651eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 14:14:20 -0800 (PST)
In-Reply-To: <20110131215819.f0537c57.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, brchrisman@gmail.com, ceph-devel@vger.kernel.org

2011/1/31 Cl=E1udio Martins <ctpm@ist.utl.pt>:
> =A0So, I do agree that, as Brian Chrisman pointed out, background scr=
ub
> is always important as it helps to prevent your data redundancy going
> bad without you knowing about it. I also agree with that sys. admin.
> notification is important in either case.
>
> =A0But I also think that Ceph should try to correct the errors it fin=
ds
> through scrub, because some of today's drives may throw uncorrected
> errors even if they are still useful - I'd rather have more copies of
> my data, even if they're slightly unrealiable, since I should always =
be
> able to tell the bad ones by BTRFS checksums. Besides, I think this
> model of always trying to correct errors fits well with Ceph's
> goal of working with unrealiable, comodity hardware, so it makes no
> sense to just bail out and force the operator to swap every flaky dri=
ve.

I don't think scrub is ever going to go away. It can't do much to fix
errors right now, and it can't be certain about correctness, but all
these things can be added to it. It shouldn't be considered much more
than a stub right now; that was certainly what we said when we wrote
the code that exists right now. We will eventually add checksumming
(so we can make sure that files of the same size have the same data,
etc) and other features to make it more useful than it is right now.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
