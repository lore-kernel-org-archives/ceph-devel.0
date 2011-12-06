From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rbd device would disappear after re-boot
Date: Tue, 6 Dec 2011 11:10:39 -0800
Message-ID: <CAORUGqDjAW-PpqtfL_hzDKZEk3HbgozBBjip-nBYhG6yYgduTg@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D943112@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63187 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab1LFTLy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 14:11:54 -0500
Received: by bkbzv3 with SMTP id zv3so3862420bkb.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 11:11:53 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D943112@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On Tue, Dec 6, 2011 at 01:31,  <Eric_YH_Chen@wistron.com> wrote:
> =C2=A0 Another question about the rbd device. All rbd device would di=
sappear
> after server re-boot.
>
> =C2=A0 Do you have any plan to implement a feature that server would =
re-map
> all the device during initialization?
>
> =C2=A0 If not, do you have any suggestion (about technical part) if w=
e want
> to implement this feature?
>
> =C2=A0 Furthermore, we would like to send a pull request after we fin=
ish it,
> any policy should we take-care?

Yes, all mappings need to be re-established after a reboot.

There is no convention yet on configuring what should be
re-established. Right now, putting an "rbd map" in something like
/etc/rc.local is a decent workaround.

I created http://tracker.newdream.net/issues/1790 to track this feature=
=2E
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
