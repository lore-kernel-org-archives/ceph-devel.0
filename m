From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Wed, 2 Dec 2015 22:10:00 +0100
Message-ID: <565F5E28.8020706@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl> <565DEC36.10102@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:60290 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbbLBVKd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Dec 2015 16:10:33 -0500
In-Reply-To: <565DEC36.10102@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mykola Golub <mgolub@mirantis.com>, "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 1-12-2015 19:51, Willem Jan Withagen wrote:
> On 1-12-2015 17:24, Willem Jan Withagen wrote:
>> I think in the short run it will not be the code that is going to be a
>> major porting pain. But getting the run-time environment ironed out is
>> just plain (hard) work. Things where /bin/sh expects certain bash-isms.
>> Where paths have not been setup to the fullest all the way back into
>> ./configure: like ${initrddir} => /etc/init.d versus /usr/local/etc/rc.d.
>> Probably plenty more like these.
> 
> To answer myself:
>     grep != grep
> 
> freetest# grep -P test *
> grep: The -P option is not supported
> 
> :(
> 
> And only to match things like:
>     ceph-authtool kring --list|grep -P '^\tcaps '
> 
> Start looking for a mode that works could work on both....

Looks like that will be something along the lines of

	grep -E '^\Wtcaps'

And that gets a lot of tests accepted.

--WjW


