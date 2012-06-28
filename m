From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: ceph was didn't stop.
Date: Wed, 27 Jun 2012 17:20:15 -0700
Message-ID: <4FEBA33F.8020700@inktank.com>
References: <loom.20120627T061404-977@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56732 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab2F1AUV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 20:20:21 -0400
Received: by dady13 with SMTP id y13so2105041dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jun 2012 17:20:20 -0700 (PDT)
In-Reply-To: <loom.20120627T061404-977@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 06/26/2012 09:19 PM, ramu wrote:
> Hi all,
>
>           I started ceph through /etc/init.d/ -a start,but it was not stop.I tried
> with /etc/init.d/ceph -a stop and /etc/init.d/ceph -v -a stop and
> service ceph -a stop also,there is no error logs showing.I tried with
> /etc/init.d/ceph -a killall it's working but I want stop single osd or mon
>   it was not working.Please help me.

What command are you running to kill a single osd or mon?
'/etc/init.d/ceph -a stop osd.0' should work.

If it's still failing, you could change "#!/bin/sh" to "#!/bin/sh -x"
at the top of /etc/init.d/ceph to see which command isn't working.

Josh
