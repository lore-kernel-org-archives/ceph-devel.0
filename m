From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: ceph on nilfs2?
Date: Mon, 17 Dec 2012 18:23:25 +0100
Message-ID: <CAN04cT6knMbdk=87VqmyEeyg409J5K_7VThxd2ibP5NyK3tNNg@mail.gmail.com>
References: <alpine.DEB.2.00.1212131643480.2817@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58715 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab2LQRX0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 12:23:26 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so7479136vcd.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 09:23:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212131643480.2817@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Would be nice indeed, but IIRC, nilfs does not support xattrs, yet...


On Fri, Dec 14, 2012 at 1:47 AM, Sage Weil <sage@inktank.com> wrote:
> nilfs2 has a 'continuous snapshotting' architecture that the ceph-osd can
> take advantage of for making fully-consistent checkpoints of state for
> recovering from a crash.  If these checkpoints are efficient enough, in
> fact, you may even get away with not having a journal file/device at all.
> Provided ceph can trigger snapshot creation when it wants to, can roll
> back to a previous snapshot on startup, and gets the basic features it
> needs out of the fs (mainly xattrs), this might be something worth looking
> at, if someone is looking for a project!
>
> http://www.nilfs.org
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
