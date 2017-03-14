From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Untested PRs merged to jewel before 10.2.6 release?
Date: Tue, 14 Mar 2017 01:30:35 +0100
Message-ID: <58362c5b-727a-3cc7-f52e-a01b136617e2@suse.cz>
References: <713de223-60a8-7def-5e59-c6c09b52dc06@suse.cz>
 <robbat2-20170308T014947-232855039Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36345 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdCNAai (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Mar 2017 20:30:38 -0400
In-Reply-To: <robbat2-20170308T014947-232855039Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> Am I seeing that right? If so, that appears to potentially defeat the
>> purpose of the integration testing we do. Maybe I'm overstating the
>> danger here -- the commits look innocuous enough -- but it seems to set
>> a rather dangerous precedent.
> There's a merge error in them too:
> qa/suites/rgw/singleton/all/radosgw-admin.yaml
>>>>>>>> 8af4c35f95... qa/suites/rgw: Add openstack volume configuration

Thanks, Robin. Opened https://github.com/ceph/ceph/pull/13952 with fix.

Nathan
