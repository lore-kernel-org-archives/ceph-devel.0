From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: mds fails to start on SL6
Date: Sat, 7 Jul 2012 09:43:52 +0100
Message-ID: <CAD0JqPGFmN+72KGcg1qHh_w5fK8vr_XZTzpysGNHEcF_6mcE0w@mail.gmail.com>
References: <sfid-H20120706-173805-+057.69-1@marduk.tchpc.tcd.ie>
	<DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
	<4ff7146f.c6abd80a.2746.3555SMTPIN_ADDED@mx.google.com>
Reply-To: jtang@tchpc.tcd.ie
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65149 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab2GGInx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jul 2012 04:43:53 -0400
Received: by lbbgm6 with SMTP id gm6so16709482lbb.19
        for <ceph-devel@vger.kernel.org>; Sat, 07 Jul 2012 01:43:52 -0700 (PDT)
In-Reply-To: <4ff7146f.c6abd80a.2746.3555SMTPIN_ADDED@mx.google.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Greg

On Fri, Jul 6, 2012 at 5:38 PM, Gregory Farnum <greg@inktank.com> wrote:
> Do you have more in the log? It looks like it's being instructed to
> shut down before it's fully come up (thus the error in the Objecter
> http://tracker.newdream.net/issues/2740, but is not the root cause),
> but I can't see why.
> -Greg
That's all that appeared in the log, if you need additional information I
was following a wiki page from <
http://ceph.com/wiki/Installing_on_RedHat_or_CentOS> to do the installation
and also made some updated notes of what I did to install it which I can
provide if you need it (they are updated installation notes for the
mentioned wiki page which others will find useful anyway). I also had
followed the 5min quick guide to testing out ceph on a single machine.

Unfortunately I'm going to be away for the next week or two so I won't be
able to do much for a few weeks on this.

Jimmy
-- 
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/
