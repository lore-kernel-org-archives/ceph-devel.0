From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] shared images
Date: Mon, 13 May 2013 09:55:24 -0700
Message-ID: <CAPYLRzjU6f0HqmKOpX=Ct2WQNCT-ukxYUEVr7VNXSYOpKPW7rA@mail.gmail.com>
References: <1368461414.21953.4.camel@lde-hro-01>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:57892 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3EMQzZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 12:55:25 -0400
Received: by mail-lb0-f178.google.com with SMTP id p10so2946168lbv.37
        for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 09:55:24 -0700 (PDT)
In-Reply-To: <1368461414.21953.4.camel@lde-hro-01>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Harald_R=F6=DFler?= <Harald.Roessler@btd.de>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 13, 2013 at 9:10 AM, Harald R=F6=DFler <Harald.Roessler@btd=
=2Ede> wrote:
>
> Hi Together
>
> is there a description of how a shared image works in detail? Can suc=
h
> an image can be used for a shared file system on two virtual machine
> (KVM) to mount. In my case, write on one machine and read only on the
> other KVM.Are the changes are visible on the read only KVM?

The image is just striped across RADOS objects. In general you can
think of it behaving exactly like a hard drive connected to your
computer over iSCSI =97 a proper shared FS (eg, OCFS2) will work on top
of it, but there's no magic that makes running an ext4 mount on two
machines work...
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
