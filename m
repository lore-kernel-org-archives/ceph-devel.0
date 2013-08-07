From: Sage Weil <sage@inktank.com>
Subject: Re: /etc/init.d/ceph script will restart stop start the daemon
 twice
Date: Wed, 7 Aug 2013 09:24:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308070923260.5427@cobra.newdream.net>
References: <52026465.2020905@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44526 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab3HGQYf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 12:24:35 -0400
In-Reply-To: <52026465.2020905@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huangjun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 7 Aug 2013, huangjun wrote:
> hi,
> we use the ceph 0.613, write all the and when
> operate(restart|start|stop) the cluster daemon(osd|mds|mon), it will
> excecute the operation twice.
> from the code init-ceph.in:
> get_localname_list
> get_name_list "$@"
> for name in $what; do
> .....
> done
> so the result $what will include twice the local daemons, shall we only
> use the get_name_list? what's get_localname_list do here?

It sounds like you have the osds listed in ceph.conf (with a host = ... 
line) *and* have touched /var/lib/ceph/osd/*/sysvinit ?  You should only 
do one or the other.. preferably touching the sysvinit file so that 
ceph.conf is simple (this is what ceph-deploy does).

sage
