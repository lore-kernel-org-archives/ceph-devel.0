From: Sage Weil <sage@newdream.net>
Subject: Re: cleanup: add override where possible when implementing an
 interface
Date: Tue, 14 Feb 2017 14:11:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702141410190.7782@piezo.novalocal>
References: <CACKY0b8Xy5JNC-5Y8BcQEW8QDrHq85Qa7=nC9DjB3H+VmbarNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58503 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbdBNOMB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 09:12:01 -0500
In-Reply-To: <CACKY0b8Xy5JNC-5Y8BcQEW8QDrHq85Qa7=nC9DjB3H+VmbarNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 14 Feb 2017, liuchang0812 wrote:
> Hi, Sage and Cephers:
> 
> I saw a issue "add override where possible when implementing an
> interface". So I used a LLVM tool called clang-tidy to do it
> automatically. .
> 
> I have made a big changes:
> 
>       246 files changed, 1305 insertions(+), 1305 deletions(-)
> 
> I could build it successfully, should I make a Pull-Request?

Yeah sure!  If you could break it up by subsystem (rgw, osd, rbd, mds, 
everything else) that would help.  Thanks!
 
> BTW, I am pleasure to write a simple documentation about this tool if
> we need this.

Sure!  Something in doc/dev, or even just an email to the list?

sage
