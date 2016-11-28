From: Sage Weil <sage@newdream.net>
Subject: Re: Is Ceph-FreeBSD package building information wanted in the Ceph
 tree?
Date: Mon, 28 Nov 2016 14:41:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611281438100.28496@piezo.us.to>
References: <bd20aaaa-93a3-2f7e-482f-b544a4aaf80e@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47724 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbcK1Ol5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2016 09:41:57 -0500
In-Reply-To: <bd20aaaa-93a3-2f7e-482f-b544a4aaf80e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 28 Nov 2016, Willem Jan Withagen wrote:
> Hi,
> 
> The Ceph package build config is almost ready for submission to the
> FreeBSD Ports system.
> Now the question is, is a copy of this also wanted in the Ceph-tree?
> 
> Note that the FreeBSD ports are already publicly available in SVN, and
> completely trackable there.
> 
> Advantage is that all FreeBSD items are in the tree.
> Disadvantage would probably be:
>  -  There ia absolutely no way to test this
>  -  it is not going to be used by users from the tree, but from
> 	/usr/ports
>  -  The version in the Ceph tree will always lagg, if only because
> 	changes will be submitted after acceptance by the Ceph
> 	developers.
> 
> In my personal opinion it does have value, because it will inform
> porters to other systems that there is already infrastructure for BSD.
> 
> But the reason for asking is that I'm bivalent about this.

We do this for debian and rpm distro (keep debian/ and ceph.spec in-tree), 
which is a bit unusual.  In those cases they are the 'upstream' version 
of the build config, and downstream distros typically patch any 
additional changes they need on top.

On another note, as soon as we have a working port, it would be nice to 
have a jenkins job that ensures that we don't break the FreeBSD build 
going forward...

sage
