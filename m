From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Why does ceph-osd not daemonize in ceph-disk
Date: Wed, 16 Nov 2016 13:00:34 +0100
Message-ID: <af1d8434-c101-af8b-c31f-6113ad8e2bc3@digiware.nl>
References: <7dbf8d17-ef39-26c5-73f3-d9eb8e7c58c7@digiware.nl>
 <8200d853-33c0-df48-a447-61d872129e81@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25101 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752809AbcKPMAk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 07:00:40 -0500
In-Reply-To: <8200d853-33c0-df48-a447-61d872129e81@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>

On 11-11-2016 16:23, Willem Jan Withagen wrote:
> On 11-11-2016 13:50, Willem Jan Withagen wrote:
>> Hi,
>>
>> As one of the last steps to complete my first run op porting I need to
>> get ceph-disk working...
>> But I'm getting a stall in test_activate for the OSD. why doesn't the
>> activation of the OSD background and the script continues.
> 
> Right,
> 
> I was wrong.... After lots of prints and echos I have learned that
> ceph-osd does daemonize and return to the shell right after that with
> exit code 0 .
> So there now everything is well.
> 
> Question is now back my favourite problem: figuring python out. :(
> Where between bin/ceph-osd and the command_check_call() things get hang up.

Well, the plot thinkens.... and it gets weirder and weirder.

Both ceph-osd, ceph-disk and coverage return. Just filled the python up
with prints till I was sure....

Removing the timeout 360 from the commandline in test.sh actually gets
the job done. So one way or another /usr/bin/timeout thinks that the
process did not finish. And that is something I have not seen before.

Looking at the pstree ceph-osd is a direct child of timeout. No more
processes in between. So all intermediate work seems te be done.
And I'm not sure why timeout thinks its children are not finished.
Note that this is the only case where timeout starts acting up.

I guess that I'm going to if-fi it for the time being...

--WjW

