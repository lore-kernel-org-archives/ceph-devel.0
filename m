From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Missing prettytable during ceph-disk runs
Date: Fri, 2 Jun 2017 16:49:54 +0200
Message-ID: <fee031e9-0310-ab38-1527-8e8d665714a0@digiware.nl>
References: <92db6d6a-420d-3f89-9631-8376b5d7d6a2@digiware.nl>
 <CAC-Np1y1hBFVnor9OhMxmj+xXZO5cnHvcQz6wAbjJ-7xhLhPBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:59879 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdFBOt6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Jun 2017 10:49:58 -0400
In-Reply-To: <CAC-Np1y1hBFVnor9OhMxmj+xXZO5cnHvcQz6wAbjJ-7xhLhPBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 2-6-2017 16:36, Alfredo Deza wrote:
> On Fri, Jun 2, 2017 at 6:42 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> During run-tox tests, ceph-disk complains that it is missing prettytable.
>> It is however installed on my system, and I can load it. So that part
>> works. But one way or another it is not loaded into the tox environment.
>>
>> How or what are all other dependancies loaded?
>> Is there a config file where I need to add that this test needs prettytable?
> 
> I am not sure what tox file you are running, but tox will create a
> virtual environment where it installs dependencies
> for the project you are testing. These dependencies should be defined
> by the project, the tox file, or by configuring tox to
> use dependencies installed system-wide.
> 
> For example, in ceph-installer, we tell tox to install a dependency
> that is only needed for tests like this:
> 
> https://github.com/ceph/ceph-installer/blob/master/tox.ini#L5-L6
> 
> I think that prettytable is a Python dependency so you can go ahead
> and add it there and it should work.
> 
> This also sounds like a bug :)

tox.ini contains:
[testenv]
setenv =
       VIRTUAL_ENV={envdir}
       CEPH_DISK={envbindir}/coverage run --append --source=ceph_disk --
{envbindir}/ceph-disk
usedevelop = true
deps =
  {env:NO_INDEX:}
  --use-wheel
  --find-links=file://{toxinidir}/wheelhouse
  -r{toxinidir}/requirements.txt
  -r{toxinidir}/test-requirements.txt
  ../ceph-detect-init

So I added it to requirements.txt, and ran make tests.

After that every thing is A-oke.

Thanx,
--WjW

