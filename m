From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rbd and Metaserver
Date: Fri, 6 May 2011 10:08:28 -0700
Message-ID: <20110506170828.GA22119@dreamer>
References: <4DC2DB6E.9010500@ufm.su>
 <2000619B57A3492DBDFCA82B0843792D@gmail.com>
 <BANLkTim-7Y5DKQ+O3o4_cUbvjZ9kYghAQA@mail.gmail.com>
 <Pine.LNX.4.64.1105052054060.14021@cobra.newdream.net>
 <BANLkTi=rZ6L_V0NqBe6Vi7JuJh6P2CZBkA@mail.gmail.com>
 <BANLkTimuVAJS197twGV8=FT1_7+DxwgWcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43551 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab1EFRI2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 13:08:28 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimuVAJS197twGV8=FT1_7+DxwgWcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: tsk <aixt2006@gmail.com>, Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Thu, May 05, 2011 at 11:02:17PM -0700, Brian Chrisman wrote:
> Sage can verify but as I understand it, all rados clients need is the
> osd map from the mon server.
> In other systems, that might be considered 'metadata', but in ceph,
> the 'metadata' server (MDS) tracks filesystem metadata.

Let me just confirm that. It goes something like this:

mon manages things related to cluster membership, health and internal
coordination.

osds store objects, in a flat hierarchy, only providing simple
operations (not a real filesystem). This service is also called RADOS.

mds builds a POSIX filesystem from the object storage. MDS is the only
component that really knows about filenames in the Ceph FS, chmod,
etc.

-- 
:(){ :|:&};:
