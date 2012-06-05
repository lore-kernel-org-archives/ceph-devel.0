From: Udo Seidel <udoseidel@gmx.de>
Subject: Re: [PATCH] ceph.spec.in: Fix license to GPL-2.0 and use SPDX
 format
Date: Tue, 5 Jun 2012 15:13:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206051511250.16970@tron.seidelnet.de>
References: <4FCE0309.90104@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:40477 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934140Ab2FENNl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 09:13:41 -0400
In-Reply-To: <4FCE0309.90104@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi Holger,

On Tue, 5 Jun 2012, Holger Macht wrote:

> Minor spec file fix. LGPLv2 in spec file is not correct, because some of
> the included packages/binaries are GPLv2. For example:

cool.


> src/os/btrfs_ioctl.h -> package ceph, binary ceph-osd

<snip-snap>

> +License:	GPL-2.0
> Group:		System Environment/Base
> URL:		http://ceph.newdream.net/
> Source0:	http://ceph.newdream.net/download/%{name}-%{version}.tar.bz2

Since you are on it anyway ... it might be worth to change the URL too ... 
;-)

Cheers,
Udo
