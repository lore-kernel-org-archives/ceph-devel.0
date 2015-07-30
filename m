From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: hammer/firefly backports upgrade suite
Date: Thu, 30 Jul 2015 09:23:03 +0200
Message-ID: <55B9D0D7.607@suse.cz>
References: <55B946D0.3070308@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34195 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbbG3HXF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jul 2015 03:23:05 -0400
In-Reply-To: <55B946D0.3070308@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> It turns out the mistake was to use upgrade/firefly-x and upgrade/hammer-x instead of upgrade/firelfy and upgrade/hammer. When -c hammer-backports or -c firefly-backports is given to teuthology-suite, it will upgrade to this version, from older versions of the same stable branch.
>
> I've updated:
>
> http://tracker.ceph.com/issues/11644#upgrade
> http://tracker.ceph.com/issues/11990#upgrade
>
> whith the fix and they are running (using the OpenStack cluster though, there may be issues with the firefly upgrade suite but the hammer upgrade suite must run fine, it has run at http://ceph.aevoo.fr:8081/ enough times to suggest there are no OpenStack specific issues).

Hi Loic:

As you predicted, the firefly upgrade suite finished with quite a few 
failures. I looked at the first one and the log said:

ERROR:teuthology.misc:. teuthology/test/integration/openrc.sh && 
openstack network show -f json unknown error ERROR: openstack No 
networks with a name or ID of 'unknown' found

Nathan
