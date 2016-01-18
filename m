From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Compiling for FreeBSD, Bluestore requires AIO
Date: Mon, 18 Jan 2016 11:54:55 +0200
Message-ID: <20160118095454.GA30351@gmail.com>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <5698CF58.7020206@digiware.nl>
 <alpine.DEB.2.11.1601151229030.17315@cpach.fuggernut.com>
 <56993BB5.7070302@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35726 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbcARJzA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jan 2016 04:55:00 -0500
Received: by mail-lf0-f45.google.com with SMTP id c192so316080411lfe.2
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jan 2016 01:54:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56993BB5.7070302@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jan 15, 2016 at 07:34:29PM +0100, Willem Jan Withagen wrote:

> ATM I've excluded the building of Bluestore, not really knowing how hard
> that is going to bite me in run the tests.

It looks like you have figured out how to exclude building Bluestore,
but just in case, I have the following PR open, that do the same:

https://github.com/ceph/ceph/pull/7169

-- 
Mykola Golub
