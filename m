From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: ceph on nilfs2?
Date: Mon, 17 Dec 2012 09:37:23 -0800
Message-ID: <CAC-hyiFws6ZBL9L2AmZ8bYCBS0qCZX0smUOsyQGEL-EMWn_1Lw@mail.gmail.com>
References: <alpine.DEB.2.00.1212131643480.2817@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42839 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab2LQRhY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 12:37:24 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5780063iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 09:37:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212131643480.2817@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Dec 13, 2012 at 4:47 PM, Sage Weil <sage@inktank.com> wrote:
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

That reminds me of the filestore abstraction project we should start.
Yehuda
