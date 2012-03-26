From: Alex Elder <elder@dreamhost.com>
Subject: Oneiric Builds
Date: Mon, 26 Mar 2012 07:54:46 -0500
Message-ID: <4F706716.2020806@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48947 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab2CZMyt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 08:54:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@dreamhost.com>, tommi.virtanen@dreamhost.com
Cc: ceph-devel@vger.kernel.org

I'm unable to load an up-to-date ceph-common package on my plana
(oneiric) system.  One of you mentioned something about how this file:

     /etc/apt/sources.list.d/ceph.list

is referring to natty, when it should be referring to oneiric.
Dan found that the reason was we aren't building packages for
oneric.  He found, *somewhere*, this code snippet:

     case distro
     when "maverick"
       # we don't actually build for maverick, but natty seems to work
       # fine; old sepia is still maverick
       distro = "natty"
     when "oneiric"
       # TODO we don't yet build debs for oneiric, so kludge it back to
       # natty; FIX ME
       distro = "natty"
     end

In the mean time I think I can find a way to build the package
on my machine, but is there a fix for this pending?

					-Alex
