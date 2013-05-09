From: Leen Besselink <leen@consolejunkie.net>
Subject: On Developer Summit topic Ceph stats and monitoring tools
Date: Fri, 10 May 2013 00:35:43 +0200
Message-ID: <20130509223528.GD8377@apia.perrit.net>
Reply-To: leen@consolejunkie.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta2.perrit.net ([194.213.15.114]:40603 "EHLO mta2.perrit.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165Ab3EIWpE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 May 2013 18:45:04 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Kyle Bader <kyle.bader@dreamhost.com>

Hi Folks,

Today I looked at the blueprint and video on Ceph stats and monitoring tools.

And I'm thinking if you want to push data into Ganglia did you consider using sFlow instead ?

I've been looking at using sFlow and Ganglia for many different uses, just like they are blogging about:

http://blog.sflow.com/

The advantage of sFlow is that many applications/programs, including network switches and parts that I would use to build OpenStack already support it.

And sFlow doesn't just sent statistics, but also samples in real time. So you actually get much more information.

Supposedly it is easy to add sFlow to an application/daemon/programs with very little overhead, but haven't looked into it.

Have a nice day,
	Leen.

PS Kyle: I added you to the CC, I thought you might not be on ceph-devel and you seem to be sort
of a lead of this project.
