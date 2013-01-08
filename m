From: Gregory Farnum <greg@inktank.com>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Tue, 8 Jan 2013 15:36:59 -0800
Message-ID: <CAPYLRziWs+mpHCB=FXin2UYA-wwrqiqPe1B--_kVN_+ex0apkQ@mail.gmail.com>
References: <50E81A3D.5070100@ledeuns.net>
	<50EB0518.9050304@ledeuns.net>
	<E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com>
	<50EBDC5E.3090207@ledeuns.net>
	<CAPYLRzhUWYu8vp-Lk6WgyjxLH-GJ08QakTgWqZEKjVSXCbEZ2A@mail.gmail.com>
	<50EC7720.1040604@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43658 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301Ab3AHXhA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 18:37:00 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so221495qaq.5
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 15:36:59 -0800 (PST)
In-Reply-To: <50EC7720.1040604@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 8, 2013 at 11:44 AM, Denis Fondras <ceph@ledeuns.net> wrote=
:
> Hello,
>
>
>> What error message do you get when you try and turn it on? If the
>> daemon is crashing, what is the backtrace?
>
>
> The daemon is crashing. Here is the full log if you want to take a lo=
ok :
> http://vps.ledeuns.net/ceph-osd.0.log.gz
>
> The RBD rebuild script helped to get the data back. I will now try to
> rebuild a Ceph cluster and do some more tests.
>
> Denis

It looks like it's taking approximately forever for writes to complete
to disk; it's shutting down because threads are going off to write and
not coming back. If you set "osd op thread timeout =3D 60" (or 120) it
might manage to churn through, but I'd look into why the writes are
taking so long =97 bad disk, fragmented btrfs filesystem, or something
else.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
