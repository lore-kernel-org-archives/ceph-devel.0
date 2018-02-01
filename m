From: Sage Weil <sage@newdream.net>
Subject: Re: master / mimic-dev1 deb build broken on ceph/ceph-ci
Date: Thu, 1 Feb 2018 13:10:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802011310071.22550@piezo.novalocal>
References: <CAJE9aOPsGdqDEZFFxwYJ2SRgqOPSkYmC5px5yKyMkvYw0GsP3Q@mail.gmail.com> <alpine.DEB.2.11.1801041429290.8186@piezo.novalocal> <60b00451-33c1-51a9-d091-40c00f7e4988@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:54022 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeBANKf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Feb 2018 08:10:35 -0500
In-Reply-To: <60b00451-33c1-51a9-d091-40c00f7e4988@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: kefu chai <tchaikov@gmail.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Thu, 1 Feb 2018, Nathan Cutler wrote:
> > By the way, v13.0.1 is tagged and mimic-dev1 branch is merged into master
> > and removed.
> 
> Hi Sage:
> 
> Are you sure v13.0.1 is tagged? I can not find the tag.
> 
> $ git describe ceph/master
> v13.0.0-5254-g9401bba7a8

Sigh.. I had it tagged but didn't use -a (so it wasn't used by git 
describe) and apparently didn't push it either. It's there now!

sage
