From: Loic Dachary <loic@dachary.org>
Subject: Re: Why does ceph-osd not daemonize in ceph-disk
Date: Fri, 11 Nov 2016 16:44:48 +0100
Message-ID: <896aebe2-3048-a6b6-97a9-b7dbf740d39b@dachary.org>
References: <7dbf8d17-ef39-26c5-73f3-d9eb8e7c58c7@digiware.nl>
 <92f8aaec-2458-c411-0e50-1eae5bd88345@dachary.org>
 <alpine.DEB.2.11.1611111519530.29579@piezo.us.to>
 <d76b7362-8863-0b39-f517-4c8bcd1655b8@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59368 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754181AbcKKPov (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 10:44:51 -0500
In-Reply-To: <d76b7362-8863-0b39-f517-4c8bcd1655b8@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 11/11/2016 16:30, Willem Jan Withagen wrote:
> On 11-11-2016 16:21, Sage Weil wrote:
>> On Fri, 11 Nov 2016, Loic Dachary wrote:
>>> Hi,
>>>
>>> FYI when the init system is unknown, it runs ceph-osd directly instead of delegating to the init system.
>>>
>>> https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L3468
>>>
>>> The reason why it does not daemonize is unclear to me.
>>
>> Does ceph-osd daemonize if you run it manually from the command line?
> 
> Yup,
> 
> created a small wrapper to see what happened in there, and I actually
> see the wrapper exiting. Only this happy event does not make it thru to
> the python friends. :( And after 360 sec timeout kills the lot.

Couldy you show the command line you're using to manually run the OSD ? I suspect the arguments are not the same: the python script populates the CEPH_ARGS environment variable.

Just a thought ;-)

-- 
Loïc Dachary, Artisan Logiciel Libre
