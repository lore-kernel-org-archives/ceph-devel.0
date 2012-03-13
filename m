From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Trying to build "ceph-client-standalone" under kernel 2.6.32
Date: Tue, 13 Mar 2012 11:29:53 -0700
Message-ID: <CAORUGqBgiLggF4epHUX9+eNS3M8aYx=O6RLG-F92ud9Vcvb_Hw@mail.gmail.com>
References: <loom.20120313T154901-294@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:60680 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab2CMSaO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Mar 2012 14:30:14 -0400
Received: by dadp12 with SMTP id p12so1365431dad.11
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 11:30:13 -0700 (PDT)
In-Reply-To: <loom.20120313T154901-294@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bryan Wright <bkw1a@ayesha.phys.virginia.edu>
Cc: ceph-devel@vger.kernel.org

On Tue, Mar 13, 2012 at 07:55, Bryan Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
> I'm doing this under 32-bit CentOS 5.7 with a 2.6.32 kernel. =C2=A0(U=
ltimately, I'll
=2E..
> =C2=A0 =C2=A0 The problem is that when I try "make -C libceph", I get=
 errors of the form:
>
> /usr/src/ceph-client-standalone/libceph/ceph_common.c:9:28: error:
> keys/ceph-type.h: No such file or directory

I'm afraid the standalone tree is not really kept up to date, and
adjusting for the changes in the mainline kernel is making it ever
harder to do so.

Perhaps you could use a newer kernel on your CentOS install?

Or just run 64-bit and use FUSE. It's been a long time since I saw a
server that couldn't do 64-bit, or had less than 4GB of RAM.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
