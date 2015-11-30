From: Sage Weil <sage@newdream.net>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 05:21:39 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
References: <565B3999.3050302@digiware.nl> <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com> <565B4A7F.60301@digiware.nl> <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com> <20151130065812.GA20205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42598 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbbK3NVk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Nov 2015 08:21:40 -0500
In-Reply-To: <20151130065812.GA20205@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

The problem with all of the porting code in general is that it is doomed 
to break later on if we don't have (at least) ongoing build tests.  In 
order for a FreeBSD or OSX port to continue working we need VMs that run 
either gitbuilder or a jenkins job or similar so that we can tell when it 
breaks.

If someone is willing to run a VM somewhere to do this we can pretty 
easily stick it on the gitbuilder page at

	http://ceph.com/gitbuilder.cgi

sage
