From: John Spray <jspray@redhat.com>
Subject: Re: not able to run src/ceph any longer
Date: Mon, 23 May 2016 10:15:42 +0100
Message-ID: <CALe9h7d1Yt0qKZa4KtQg6c5A+wTpQf5o2YmKcG=TZ1OeDk1n0Q@mail.gmail.com>
References: <c6296508-10eb-f78a-f0e1-6bac2d1be6ea@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35556 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbcEWJQE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2016 05:16:04 -0400
Received: by mail-oi0-f54.google.com with SMTP id x19so268005202oix.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2016 02:16:03 -0700 (PDT)
In-Reply-To: <c6296508-10eb-f78a-f0e1-6bac2d1be6ea@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 23, 2016 at 12:10 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> When the testscripts try to run src/ceph I get:
>
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> Traceback (most recent call last):
>   File "src/ceph", line 118, in <module>
>     import rados
> ImportError: /usr/srcs/Ceph/work/ceph/src/.libs/librados.so.2: Undefined
> symbol "g_ceph_context"
>
> which is in libglobal, but if I try to link that to librados I'm just
> getting nothing but dubble definitions and errors.
>
> Where have things gone wrong for me?
> How should "import rados" get the g_ceph_context?

Usually that's a symptom of a bug where something is touching global
state somewhere it shouldn't (such as using dout instead of ldout in
client code), and pulling in the g_ceph_context symbol where it
shouldn't.  The symptom is that daemons build correctly but client
libraries become un-importable.

Do you have local changes?  If not, try updating to latest master, it
seems to be OK right now.

John

> Thanx
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
