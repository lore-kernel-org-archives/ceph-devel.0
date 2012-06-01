From: Greg Farnum <greg@inktank.com>
Subject: Re: iozone test crashed on ceph
Date: Fri, 1 Jun 2012 09:32:52 -0700
Message-ID: <0F43C46A9543420FBEB081A55ACD1FB0@inktank.com>
References: <loom.20120601T025228-787@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62839 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965419Ab2FAQc4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 12:32:56 -0400
Received: by pbbrp8 with SMTP id rp8so3166567pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 09:32:56 -0700 (PDT)
In-Reply-To: <loom.20120601T025228-787@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thursday, May 31, 2012 at 5:58 PM, udit agarwal wrote:
> Hi,
> I have set up ceph system with a client, mon and mds on one system which is
> connected to 2 osds. I ran iozone test with a 10G file and it ran fine. But when
> I ran iozone test with a 5G file, the process got killed and our ceph system
> hanged. Can anyone please help me with this.

What do you mean, "the process got killed"? It hung and some task watcher killed it? Or it got OOMed?
How did you determine that the "ceph system" hung? The cluster stopped responding to requests, or just the local mount point?
-Greg

