From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Ceph Development with Eclipse
Date: Sat, 2 Feb 2013 15:44:49 -0800
Message-ID: <CAC-hyiF6DcEDrBBXMrpBWxb_Ki-r=uDTZ4vFdkZeBaLkpUwfAQ@mail.gmail.com>
References: <DUB116-W12467CE5C3C0CAECA94D647E0030@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:47560 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3BBXou (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Feb 2013 18:44:50 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so6822308iac.21
        for <ceph-devel@vger.kernel.org>; Sat, 02 Feb 2013 15:44:49 -0800 (PST)
In-Reply-To: <DUB116-W12467CE5C3C0CAECA94D647E0030@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: charles L <charlesboy009@hotmail.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

On Sat, Feb 2, 2013 at 9:40 AM, charles L <charlesboy009@hotmail.com> wrote:
>
>
> Hi
>
> I am a beginner at c++ and eclipse. I need some startup help to develop ceph with eclipse. If you could provide your config file on eclipse, it will be a great starting point and very appreciated.
>

Well, I'm not sure there are many ceph developers that use eclipse.
However, ceph builds using generic autotools, so you should probably
just use a compatible generic C/C++ plugin that leverages that.

Yehuda
