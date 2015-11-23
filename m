From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 10:03:55 -0600
Message-ID: <CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38081 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbKWQD4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 11:03:56 -0500
Received: by wmec201 with SMTP id c201so111698767wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 08:03:55 -0800 (PST)
In-Reply-To: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 21, 2015 at 1:34 AM, Robert LeBlanc <robert@leblancnet.us> =
wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> We had two interesting issues today. In both cases multiple OSDs
> suicided at the exact same moment. The first incident had four OSDs,
> the second had 12.
>
> First set:
> 145,159,79,176
>
> Second Set:
> osd.177 down at 20:59:48,
> osd.131, osd.136, osd.133, osd.139, osd.175, osd.170, osd.73 down at =
20:00:03,
> osd.178, osd.179 down at 21:00:07,
> osd.159 down at 21:01:22,
> osd.110 down at 21:01:28
>
> Only one OSD failed both times and only a couple of boxes had more
> than one OSD fail. The failures were spread out throughout the
> cluster. There is nothing in dmesg/messages/sar that indicate there
> was any type of hardware problem on the OSD hosts. All the OSDs
> indicate slow I/O and heartbeats missing starting at 20:57:32.
>
> The other odd thing is that most of the VMs across our 16 KVM hosts
> were fine, but several VMs on one host had kernel panics. In the
> messages logs of that host we see a kernel backtrace:
>
> Nov 20 20:58:32 compute8 kernel: WARNING: CPU: 4 PID: 0 at
> net/core/dev.c:2223 skb_warn_bad_offload+0xb6/0xbd()
>
> That host's clock was exactly one minute fast. Everything points to
> this host as having the issue, but I'm having a hard time
> understanding how a client (or several clients) could cause several
> OSDs to suicide. Can a non-responsive client in some way cause the OS=
D
> to fault?

No, it shouldn't be able to just by having clock issues or whatever.
There *are* still some ways a malformed request can cause the OSDs to
crash, though =E2=80=94 it looks like maybe this is a network card issu=
e? That
could have maybe flipped some bits that broke stuff. What's the
backtrace on the OSDs?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
