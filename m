From: Haomai Wang <haomai@xsky.com>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 02:08:48 +0800
Message-ID: <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
References: <565B3999.3050302@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0124.outbound.protection.outlook.com ([104.47.126.124]:63774
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751849AbbK2SJL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 Nov 2015 13:09:11 -0500
Received: by igvg19 with SMTP id g19so56940520igv.1
        for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 10:08:48 -0800 (PST)
In-Reply-To: <565B3999.3050302@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 30, 2015 at 1:44 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> Not unlike many others running FreeBSD I'd like to see if I/we can get
> Ceph to build and run on FreeBSD. If not all components than at least
> certain components.
>
> With compilation I do get quite some way, even with the CLANG compiler.
> But I run into obvious part where Linux goes a different direction from
> what is available on FreeBSD.
>
> If I google one of the reports I ran into, I get at:
> http://lists.ceph.com/pipermail/ceph-commit-ceph.com/2013-November/005812.html
>
> Which sort of suggests that some of the code for FreeBSD has again been
> purged from the tree...
>
> Is that to remove FreeBSD completely from the tree?
> Or just because that code did not work?

I guess we still expect FreeBSD support, which version do you test to
compile? I'd like to help to make bsd work :-)

>
> Thanx,
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
