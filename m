From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: preparing v0.80.11
Date: Tue, 26 May 2015 22:28:34 +0200
Message-ID: <5564D772.9080909@suse.cz>
References: <5562DEEC.5060602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45174 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbEZU2h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 May 2015 16:28:37 -0400
In-Reply-To: <5562DEEC.5060602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic:

The first round of 0.80.11 backports, including all trivial backports 
(where "trivial" is defined as those I was able to do by myself without 
help), is now ready for integration testing in the "firefly-backports" 
branch of the SUSE fork:

https://github.com/SUSE/ceph/commits/firefly-backports

The non-trivial backports (on which I hereby solicit help) are:

http://tracker.ceph.com/issues/11699 Objecter: resend linger ops on split
http://tracker.ceph.com/issues/11700 make the all osd/filestore thread 
pool suicide timeouts separately configurable
http://tracker.ceph.com/issues/11704 erasure-code: misalignment
http://tracker.ceph.com/issues/11720 rgw deleting S3 objects leaves 
__shadow_ objects behind

Nathan
