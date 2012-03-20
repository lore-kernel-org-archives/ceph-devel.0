From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Ceph mon crash
Date: Tue, 20 Mar 2012 09:49:25 -0700
Message-ID: <1479058075F34FB781EA8541B5C0EA78@dreamhost.com>
References: <CAHULbCnEs7o6E5mvUtMjN7NxJ3-fn8M-nriUdCqqceiBOvXKKA@mail.gmail.com>
 <CAHULbCk9RkaDUKYncp4-cYB3H9uhU8rjP+z0PW7YRD+goTORcg@mail.gmail.com>
 <CAHULbCk1Lqp7fe6+0hSZkJp57Aht57zzoF8bXLpuBa+TCfcX4w@mail.gmail.com>
 <66BEE4F342554A54BA21F31CB051E2C4@dreamhost.com>
 <CAHULbCkQ-vzDgHHZtSLNGgZFLAODphUTjFJfmK5y+SnveJqfYg@mail.gmail.com>
 <A542F36937A84D5D9450188A02E47FC7@dreamhost.com>
 <CAHULbCmyc+OtJd72JJDCKE_gH=2v+SLDMjYTpZQmtRqzYCw9vA@mail.gmail.com>
 <CAHULbCk3nktgUEWuQURc2mBs7cOOKWPir8msVcQpF4wM_TTYtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60162 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144Ab2CTQt2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 12:49:28 -0400
Received: by gghe5 with SMTP id e5so256140ggh.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Mar 2012 09:49:27 -0700 (PDT)
In-Reply-To: <CAHULbCk3nktgUEWuQURc2mBs7cOOKWPir8msVcQpF4wM_TTYtA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, March 20, 2012 at 1:02 AM, ruslan usifov wrote:
> I found it in source. I want to liquidate of war messages which appear
> when i monitor cluster with follow:
> 
> ceph -w
> 
> There was messages that i have one down mds (actually i doesn't have any)
Ah. I'm not sure we actually support removal of all the MDSes once you start one up. Given the prevalence of RBD users we probably should, though! Bug filed: http://tracker.newdream.net/issues/2195


I *think* that if you don't ever create an MDS that line won't show up; somebody who runs an RBD cluster could tell you for sure. :)
> 
> > If necessary I can figure out how to create a good MDSMap and inject it into your monitors, but I'd rather not if you don't have any data in there. (In which case, reformat the cluster.)
> 
> This is a test environment, so i reformat cluster map manually. Also i
> must say that mons die not immediately when i run (ceph mds rm 1), but
> after some time

Yes, when you ran the mds rm command you corrupted your MDSMap, but the system doesn't notice right away since the map is not being accessed by clients or your servers. But eventually you (or a monitoring service, more likely) ran the ceph health command, which made the mon look at the MDSMap, which caused an assert. Then the ceph tool tried again on a different monitor, etc.



-Greg 

