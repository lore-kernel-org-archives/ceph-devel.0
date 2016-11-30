From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Is Ceph-FreeBSD package building information wanted in the Ceph
 tree?
Date: Wed, 30 Nov 2016 12:51:20 +0100
Message-ID: <2e66e146-2102-04a6-9694-97e62229ef5c@digiware.nl>
References: <bd20aaaa-93a3-2f7e-482f-b544a4aaf80e@digiware.nl>
 <alpine.DEB.2.11.1611281438100.28496@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:45596 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbcK3Lvk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 06:51:40 -0500
In-Reply-To: <alpine.DEB.2.11.1611281438100.28496@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 28-11-2016 15:41, Sage Weil wrote:
> On another note, as soon as we have a working port, it would be nice to 
> have a jenkins job that ensures that we don't break the FreeBSD build 
> going forward...

I have Jenkins for FreeBSD back on line:

http://cephdev.digiware.nl:8180/jenkins/

It builds:
	wip.FreeBSD: all of my recent work I commit to my fork
	ceph-master: HEAD of the current official git Ceph tree
		BUT augmented with a (the few) essential patches that I
		have commited in PRs.

Both builds are atm. run in the CET night at resp 6:00 and 1:00.
Build Failures are reported and mailed to me.

If you would like to have any other integration, let me know and I'll
see if I/we can accomodate that in our openstack cluster.

--WjW


