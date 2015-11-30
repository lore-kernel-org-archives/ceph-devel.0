From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 16:13:21 +0200
Message-ID: <20151130141320.GB20205@gmail.com>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <565C38D2.4080403@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35786 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271AbbK3ONY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Nov 2015 09:13:24 -0500
Received: by lfdl133 with SMTP id l133so197342835lfd.2
        for <ceph-devel@vger.kernel.org>; Mon, 30 Nov 2015 06:13:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <565C38D2.4080403@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 30, 2015 at 12:53:54PM +0100, Willem Jan Withagen wrote:

> > git clone --recursive -b wip-freebsd https://github.com/trociny/ceph.git
> > cd ceph
> > ./install-deps.sh
> > ./do_autogen.sh
> > gmake
> > cd src
> > ./vstart.sh # start dev cluster
> > ./ceph -s # check it works
> > 
> 
> So what backend for the OSDs are you using here?

The default one, which is FileStore. I have not done much testing
though...

-- 
Mykola Golub
