From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Re: Redundancy with Ceph
Date: Mon, 5 Jul 2010 09:55:30 +0200
Message-ID: <201007050955.30279.cray@unix-ag.uni-kl.de>
References: <201007042234.46732.cray@unix-ag.uni-kl.de> <201007050033.50739.cray@unix-ag.uni-kl.de> <i0rpno$ao1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:47496 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab0GEHzk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jul 2010 03:55:40 -0400
In-Reply-To: <i0rpno$ao1$1@dough.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

Thanks a lot for the link and your help!
Now, the issue are clear.

The output of "ceph osd dump -o -" said that there shall be replication because max_osd is 3 and the size of all pools is 2. But osd2 was "out down".

# ceph osd dump -o -
...
max_osd 3
osd0 out down (up_from 0 up_thru 0 down_at 0 last_clean 0-0)
osd1 in weight 1 up   (up_from 2 up_thru 2 down_at 0 last_clean 0-0) 10.243.150.209:6801/20989 10.243.150.209:6802/20989
osd2 out down (up_from 0 up_thru 0 down_at 0 last_clean 0-0)

The reason: I forgot to start the ceph server at osd2.
Now, it looks better.

# ceph osd dump -o -
...
max_osd 3
osd0 out down (up_from 0 up_thru 0 down_at 0 last_clean 0-0)
osd1 in weight 1 up   (up_from 2 up_thru 6 down_at 0 last_clean 0-0) 10.243.150.209:6801/20989 10.243.150.209:6802/20989
osd2 in weight 1 up   (up_from 5 up_thru 5 down_at 0 last_clean 0-0) 10.212.118.67:6800/20983 10.212.118.67:6801/20983

Best Regards and thanks again,
   Christian


Am Montag, 5. Juli 2010 schrieb Thomas Mueller:
> Am Mon, 05 Jul 2010 00:33:50 +0200 schrieb Christian Baun:
> 
> > Hi,
> > 
> > I created 2 servers and one client
> > 
> > Server 1 => mon, mds, osd
> > Server 2 => osd
> > 
> > I tried some tests with iozone and I don't think Server 2 is used.
> 
> 
> did you read:
> 
> http://ceph.newdream.net/wiki/Adjusting_replication_level
> 
> 
> 
> - Thomas

