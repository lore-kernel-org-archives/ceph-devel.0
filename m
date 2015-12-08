From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Compiling for FreeBSD
Date: Tue, 8 Dec 2015 14:36:58 +0200
Message-ID: <20151208123656.GA22774@gmail.com>
References: <CAOtMX2j5xJBnYoNdxTGGQFz-fTVX2xQka2NuyUZuOPpsft6HuA@mail.gmail.com>
 <alpine.DEB.2.00.1512011034550.19170@cobra.newdream.net>
 <565DEA60.7010608@digiware.nl>
 <CAAM7YAmzq3a_kqXE2ZgK_fp4i6QduY49aXqiWVNK3F59iZUFRA@mail.gmail.com>
 <565F5A03.7020401@digiware.nl>
 <CAAM7YA=Q6gbBbN92a9KigAXw4e_SrshQ6Q8mC1Xff+vxQQkrKw@mail.gmail.com>
 <5661DBB8.1040505@digiware.nl>
 <CAJ4mKGZ+wjum+R3=pBS8urko4D1B_D+eKjytWE_uDdFcGW6sSA@mail.gmail.com>
 <5661F358.2060401@digiware.nl>
 <5666AB1D.5010101@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33421 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbbLHMhC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 07:37:02 -0500
Received: by lbbkw15 with SMTP id kw15so10276757lbb.0
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 04:37:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5666AB1D.5010101@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>, Sage Weil <sage@newdream.net>, Alan Somers <asomers@freebsd.org>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 08, 2015 at 11:04:13AM +0100, Willem Jan Withagen wrote:
> On 4-12-2015 21:11, Willem Jan Withagen wrote:
> 
> One larger problem with libraries I have is the stuff with dlopen.
> 
> In ./configure it seems that most of the code is short-circuited, and -ldl
> gets appended in the Makefile.am's by default. The code there is rather hard
> to parse.
> 
> FreeBSD has this in libc, so no specific includes needed.
> 
> Now the question is how do I cleanly fix this without breaking just
> about every other platform?

Could you provide particular examples? Because what I see in the
master is usually like below:

if LINUX
xio_server_LDADD += -ldl
endif

If you see somewhere -ldl is added unconditionally it is likely to
have to be fixed the same way.

-- 
Mykola Golub
