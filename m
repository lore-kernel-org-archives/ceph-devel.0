From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Strange message in logs: fault with nothing to send, going
 to standby
Date: Fri, 13 Apr 2012 10:52:08 -0700
Message-ID: <717FA37186A64819A42CDFEC89341636@dreamhost.com>
References: <CAMvP8PAU61-wM_hVKy56U4d6s3W6p+X76J4Drkrkz00C2oSyDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57749 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab2DMRwM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 13:52:12 -0400
Received: by yenl12 with SMTP id l12so1788617yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Apr 2012 10:52:11 -0700 (PDT)
In-Reply-To: <CAMvP8PAU61-wM_hVKy56U4d6s3W6p+X76J4Drkrkz00C2oSyDQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Friday, April 13, 2012 at 9:38 AM, Tomasz Paszkowski wrote:
> Hi,
> =20
> Can anyone explain we why this message ( fault with nothing to send,
> going to standby) appears in osd log file ?
> =20
> osd log: http://paste.openstack.org/show/12786/
> mon log: http://paste.openstack.org/show/12787/
> =20

The "fault with nothing to send, going to standby" message indicates th=
at one of the Messenger's sockets hasn't seen any activity for the spec=
ified timeout period (default 15 minutes), and so it's going to close t=
he socket. It's normal and doesn't indicate any problems =E2=80=94 if e=
ither endpoint needs to send a Message it will re-establish the session=
 cleanly.
-Greg


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
