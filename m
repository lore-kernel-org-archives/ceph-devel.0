From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Missing prettytable during ceph-disk runs
Date: Fri, 2 Jun 2017 18:01:39 +0200
Message-ID: <5f1c8ae2-f112-4ae4-60c1-ed3f57274d44@digiware.nl>
References: <92db6d6a-420d-3f89-9631-8376b5d7d6a2@digiware.nl>
 <CAC-Np1y1hBFVnor9OhMxmj+xXZO5cnHvcQz6wAbjJ-7xhLhPBw@mail.gmail.com>
 <alpine.DEB.2.11.1706021539070.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:46868 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdFBQBo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Jun 2017 12:01:44 -0400
In-Reply-To: <alpine.DEB.2.11.1706021539070.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 2-6-2017 17:39, Sage Weil wrote:
> On Fri, 2 Jun 2017, Alfredo Deza wrote:
>> On Fri, Jun 2, 2017 at 6:42 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> During run-tox tests, ceph-disk complains that it is missing prettytable.
>>> It is however installed on my system, and I can load it. So that part
>>> works. But one way or another it is not loaded into the tox environment.
>>>
>>> How or what are all other dependancies loaded?
>>> Is there a config file where I need to add that this test needs prettytable?
>>
>> I am not sure what tox file you are running, but tox will create a
>> virtual environment where it installs dependencies
>> for the project you are testing. These dependencies should be defined
>> by the project, the tox file, or by configuring tox to
>> use dependencies installed system-wide.
>>
>> For example, in ceph-installer, we tell tox to install a dependency
>> that is only needed for tests like this:
>>
>> https://github.com/ceph/ceph-installer/blob/master/tox.ini#L5-L6
>>
>> I think that prettytable is a Python dependency so you can go ahead
>> and add it there and it should work.
>>
>> This also sounds like a bug :)
> 
> I've been having the ceph-disk tox test fail on my local machine for a 
> week or two. I haven't been able to figure out why (prettytable is also 
> installed here).  I've tried blowing away my build/ directory but that 
> doesn't seem to help..

I have a soluution that works for me.

ceph-disk: add required py-module for tox-testing #15433

It that is the way to follow, I do not know, because there are a zillion
place to add a requirement. And I just think this is the one.
Asuming that it also tells tox that prettytable is required durign
regular running.
But that is open for any better suggestions.

Once you add this, you atleast need to run "make tests" to rebuild the
tox env.

--WjW

