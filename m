From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: How to mount all cluster data to one particular Dir in single
 Host.
Date: Thu, 30 Aug 2012 07:45:49 -0700
Message-ID: <20120830144549.GD19573@splice>
References: <CAGfy=6nT2w7wqH30QscDREydNg2CS7uGURdx0E-2_qOGqaScoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55707 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2H3Op4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 10:45:56 -0400
Received: by pbbrr13 with SMTP id rr13so3248173pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 07:45:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGfy=6nT2w7wqH30QscDREydNg2CS7uGURdx0E-2_qOGqaScoQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 30, 2012 at 04:36:13PM +0530, hemant surale wrote:
> Is it possible to mount all cluster data on directory present at
> single node?

Are you trying to see the raw data, how files are stored by the OSD? You
can't mount them remotely, but you can log into your VMs and look in the
OSDs' data directories.

> v0.31 & ubuntu 11.10

These are both very old, and we don't support them anymore. For ceph you
should look into argonaut v0.48.1 or a more recent tag v0.51. For
Ubuntu, we recommend Precise 12.04.
