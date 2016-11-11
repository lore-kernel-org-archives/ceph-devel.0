From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Why does ceph-osd not daemonize in ceph-disk
Date: Fri, 11 Nov 2016 16:30:30 +0100
Message-ID: <d76b7362-8863-0b39-f517-4c8bcd1655b8@digiware.nl>
References: <7dbf8d17-ef39-26c5-73f3-d9eb8e7c58c7@digiware.nl>
 <92f8aaec-2458-c411-0e50-1eae5bd88345@dachary.org>
 <alpine.DEB.2.11.1611111519530.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:30346 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933598AbcKKPae (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Nov 2016 10:30:34 -0500
In-Reply-To: <alpine.DEB.2.11.1611111519530.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 11-11-2016 16:21, Sage Weil wrote:
> On Fri, 11 Nov 2016, Loic Dachary wrote:
>> Hi,
>>
>> FYI when the init system is unknown, it runs ceph-osd directly instead of delegating to the init system.
>>
>> https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L3468
>>
>> The reason why it does not daemonize is unclear to me.
> 
> Does ceph-osd daemonize if you run it manually from the command line?

Yup,

created a small wrapper to see what happened in there, and I actually
see the wrapper exiting. Only this happy event does not make it thru to
the python friends. :( And after 360 sec timeout kills the lot.

--WjW


