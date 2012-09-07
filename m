From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph-fuse mount options
Date: Fri, 7 Sep 2012 09:22:34 -0700
Message-ID: <CAPYLRzgc_-9nTE+-Y6rm9aiBBVeEMZTfBs-ycRw3cFV8tL2AHg@mail.gmail.com>
References: <C601985E-3865-4582-99DA-BC0168893968@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46896 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab2IGQWf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 12:22:35 -0400
Received: by ieje11 with SMTP id e11so5333879iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 09:22:35 -0700 (PDT)
In-Reply-To: <C601985E-3865-4582-99DA-BC0168893968@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: ceph-devel@vger.kernel.org

On Fri, Sep 7, 2012 at 9:03 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> Hi All,
>
> I know that cephfs has the option picking which pools to use, will ce=
ph-fuse be gaining this feature at any point in the future? Or is this =
feature available but isn't documented?

It's not available =97=A0making it work would require implementing FUSE=
's
ioctl system, which we will probably do at some point, but is yet to
be prioritized or placed anywhere.

However, ceph-fuse does of course respect settings put in place by the
kernel client, so if you just want to do a one-time configuration then
you can do it via the kernel on one machine and use ceph-fuse
elsewhere...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
