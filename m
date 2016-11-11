From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Why does ceph-osd not daemonize in ceph-disk
Date: Fri, 11 Nov 2016 16:52:12 +0100
Message-ID: <39b916f6-5a61-3708-14ca-456fdf1d3f39@digiware.nl>
References: <7dbf8d17-ef39-26c5-73f3-d9eb8e7c58c7@digiware.nl>
 <92f8aaec-2458-c411-0e50-1eae5bd88345@dachary.org>
 <alpine.DEB.2.11.1611111519530.29579@piezo.us.to>
 <d76b7362-8863-0b39-f517-4c8bcd1655b8@digiware.nl>
 <896aebe2-3048-a6b6-97a9-b7dbf740d39b@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:63160 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756493AbcKKPwS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Nov 2016 10:52:18 -0500
In-Reply-To: <896aebe2-3048-a6b6-97a9-b7dbf740d39b@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 11-11-2016 16:44, Loic Dachary wrote:
> 
> 
> On 11/11/2016 16:30, Willem Jan Withagen wrote:
>> On 11-11-2016 16:21, Sage Weil wrote:
>>> On Fri, 11 Nov 2016, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> FYI when the init system is unknown, it runs ceph-osd directly instead of delegating to the init system.
>>>>
>>>> https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L3468
>>>>
>>>> The reason why it does not daemonize is unclear to me.
>>>
>>> Does ceph-osd daemonize if you run it manually from the command line?
>>
>> Yup,
>>
>> created a small wrapper to see what happened in there, and I actually
>> see the wrapper exiting. Only this happy event does not make it thru to
>> the python friends. :( And after 360 sec timeout kills the lot.
> 
> Couldy you show the command line you're using to manually run the OSD ? I suspect the arguments are not the same: the python script populates the CEPH_ARGS environment variable.
> 
> Just a thought ;-)

Hi Loic,

Yup, there is a lot of coverage stuff in between....
I have not really manually run the ceph-osd command, but wrapped it in:
#!/bin/bash

shopt -s -o pipefail

echo "$@" > /tmp/ceph-osd.$$.out
/usr/srcs/Ceph/work/ceph/build/bin/ceph-osd.bin "$@" | \
	tee -a /tmp/ceph-osd.$$.out
status=$?

echo ceph-osd done >> /tmp/ceph-osd.$$.out

exit $status
====

And this actually logs 'done' in the logfile. So the ceph-osd actually
returns, and so does the wrapper.
As options is logs:
	--cluster=ceph --id=0 --osd-data=testdir/test-ceph-disk/dir
--osd-journal=testdir/test-ceph-disk/dir/journal

I could also log:
	ENV
and rerun.
	
--WjW




