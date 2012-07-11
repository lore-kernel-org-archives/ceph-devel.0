From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Pg stuck stale...why?
Date: Tue, 10 Jul 2012 18:22:07 -0700
Message-ID: <4FFCD53F.108@inktank.com>
References: <4FFCD2AC.3040809@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54719 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab2GKBWK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 21:22:10 -0400
Received: by pbbrp8 with SMTP id rp8so1135981pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 18:22:10 -0700 (PDT)
In-Reply-To: <4FFCD2AC.3040809@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: ceph-devel@vger.kernel.org

On 07/10/2012 06:11 PM, Mark Kirkwood wrote:
> I am seeing this:
>
> # ceph -s
> health HEALTH_WARN 256 pgs stale; 256 pgs stuck stale
> monmap e1: 3 mons at
> {ved1=192.168.122.11:6789/0,ved2=192.168.122.12:6789/0,ved3=192.168.122.13:6789/0},
> election epoch 18, quorum 0,1,2 ved1,ved2,ved3
> osdmap e62: 4 osds: 4 up, 4 in
> pgmap v47148: 768 pgs: 512 active+clean, 256 stale+active+clean; 2224 MB
> data, 15442 MB used, 86907 MB / 102350 MB avail
> mdsmap e1: 0/0/1
>
> In particular 256 pgs stuck stale - I've tried a) waiting a while
> (overnight), b) a rolling restart of all 4 osd's, c) restarting all ceph
> services on all 4 nodes. All without changing this.
>
> As far as I understand what stuck state means, I can't see why they need
> to stay that way, given all osd's and mon's are up. (I have no mds
> configured)....any ideas? Or is this just expected?
>
> Regards
>
> Mark

What does 'ceph pg dump_stuck stale' show? Stale means that the
monitors haven't gotten updates about those pgs from the osds within
the a certain period of time (default is 300 seconds), so something may
be wrong with your crushmap or those pgs themselves.

Josh
