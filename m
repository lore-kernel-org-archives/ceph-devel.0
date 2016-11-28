From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Jenkins builder for FreeBSD
Date: Mon, 28 Nov 2016 17:10:59 +0100
Message-ID: <64553f6d-6cde-db4f-3f03-2ac2e2fcbaa8@digiware.nl>
References: <bd20aaaa-93a3-2f7e-482f-b544a4aaf80e@digiware.nl>
 <alpine.DEB.2.11.1611281438100.28496@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:54856 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbcK1QLD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 28 Nov 2016 11:11:03 -0500
In-Reply-To: <alpine.DEB.2.11.1611281438100.28496@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 28-11-2016 15:41, Sage Weil wrote:
> On another note, as soon as we have a working port, it would be nice to 
> have a jenkins job that ensures that we don't break the FreeBSD build 
> going forward...

Hi Sage,

I had a jenkins builder running for a while, but the hardware got
confiscated to be used in a project. 8-)

So I'll have to "redo" the setup of the base system in a VM on the
cluster, but that should not be much more than a bit time to get things
running. It also depends on how deep you want to test it? I did not
fully destroy the complete VM, but just deleted the jobs directory and
then have Jenkins fetch, build and test my WIP.

So yes, there will be a builder on this end.

Is there any particular way you would like to "integrate" this?
Or would you prefer to run it within the jenkins cluster that you
already have?

--WjW

