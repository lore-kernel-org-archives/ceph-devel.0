From: Sage Weil <sage@newdream.net>
Subject: Re: How to open clog debug
Date: Mon, 30 Nov 2015 05:24:57 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511300524320.19170@cobra.newdream.net>
References: <47D132BF400BE64BAE6D71033F7D3D7519AC30@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42611 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbbK3NY6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Nov 2015 08:24:58 -0500
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D7519AC30@H3CMLB14-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wukongming <wu.kongming@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 30 Nov 2015, Wukongming wrote:
> Hi, All
> 
>         Does anyone know how to open clog debug?

It's usually something like

 	monc->clog.debug() << "hi there\n";

sage
