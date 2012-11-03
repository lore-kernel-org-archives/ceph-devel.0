From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Unable to Start Ceph service
Date: Fri, 2 Nov 2012 23:45:45 -0700
Message-ID: <E588DBC9-36FE-4DDC-98A5-C7627380CD98@inktank.com>
References: <CAGfy=6m7yJwVzVuFCZrHqe8tvcnYvkU7w7rieZuo4s7duQV5gw@mail.gmail.com> <5091A7BE.2050106@inktank.com> <CAGfy=6ni5fybh_zXK1L4HFBeNiYrr-sir_NVJuUk9SgURt=YBw@mail.gmail.com> <CAGfy=6n7vM6KTdJQNjtqV0QUyiWrKf5Mai6HC_4-4vWfYEiVpQ@mail.gmail.com> <CAMzNCsB848NEhQEmcOb9Vob29MUkxdupcGGo8sYA58jZbWuPZw@mail.gmail.com> <CAGfy=6=pW1VuhTvM0p70aXjN-m0Lu3JsDPRFTb1n7bfYxSwHKQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46704 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2KCGpu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 02:45:50 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2894473pad.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 23:45:49 -0700 (PDT)
In-Reply-To: <CAGfy=6=pW1VuhTvM0p70aXjN-m0Lu3JsDPRFTb1n7bfYxSwHKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: Tyler Brekke <tyler.brekke@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Hemant -

You don't need to build and install from the deb packages.  The "make install" does put things under /usr/local by default, which is different from the packages.  That can be overridden when running configure.  configure --help will give you the options.

Someone who has done this recently can perhaps comment if there are any modifications to the standard documentation for a local build and install.  

Cheers,
Gary

On Nov 2, 2012, at 9:15 PM, hemant surale wrote:

> The G++ internal compilation error was observed due to insufficient
> RAM. So I increased it then everything is running fine.
> 
> One more doubt regarding GIt Cloned Dir and Tarball setup.
> 
> While building ceph from source code (tarball file) . I extract them
> into some folder and perform
> "./autogen.sh
> ./configure
> make
> sudo make install " .
> What more should I do in order to have ceph service running on that machine?
> Does It necessary to clone the git dir & then build .deb packages ,
> even after I installed ceph from tarball ?
> 
> 
> -
> Hemant Surale.
> 
> 
> On Sat, Nov 3, 2012 at 12:10 AM, Tyler Brekke <tyler.brekke@inktank.com> wrote:
>> Can you check dmesg? It looks like you ran out of memory on your VM
>> while building.
>> 
>> On Thu, Nov 1, 2012 at 11:59 PM, hemant surale <hemant.surale@gmail.com> wrote:
>>> ---------- Forwarded message ----------
>>> From: hemant surale <hemant.surale@gmail.com>
>>> Date: Fri, Nov 2, 2012 at 12:10 PM
>>> Subject: Re: Unable to Start Ceph service
>>> To: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org"
>>> <ceph-devel@vger.kernel.org>
>>> 
>>> 
>>> 
>>> Initially I installed ceph directly by following 5minute guide from
>>> official site , So before building ceph from source code I installed
>>> ceph as well as removed it using "sudo apt-get remove ceph" ,But It
>>> seems that some directories left undeleted.
>>> 
>>> Now I tried to Build ceph again on fresh VM and again I have some
>>> issues to resolve .
>>> 
>>> As proceeding to building step when I came across "make" cmd following
>>> error is observed
>>> ---------------------------------------------------------//Error---------------------------------------------------------------------
>>>  CXX    MDS.o
>>> g++: internal compiler error: Killed (program cc1plus)
>>> Please submit a full bug report,
>>> with preprocessed source if appropriate.
>>> See <file:///usr/share/doc/gcc-4.6/README.Bugs> for instructions.
>>> make[3]: *** [MDS.o] Error 4
>>> make[3]: Leaving directory `/home/hemant/ceph/ceph/src'
>>> make[2]: *** [all-recursive] Error 1
>>> make[2]: Leaving directory `/home/hemant/ceph/ceph/src'
>>> make[1]: *** [all] Error 2
>>> make[1]: Leaving directory `/home/hemant/ceph/ceph/src'
>>> make: *** [all-recursive] Error 1
>>> ---------------------------_---------------------------_---------------------------_---------------------------
>>> 
>>> 
>>> - Hemant Surale
>>> 
>>> 
>>> On Thu, Nov 1, 2012 at 4:05 AM, Dan Mick <dan.mick@inktank.com> wrote:
>>>> 
>>>> I've had a long private thread with Hemant, and I believe he's past this problem (in case anyone scans archives looking for open questions).
>>>> Hemant, it would be best to keep the thread on ceph-devel; you get more people looking and answering.
>>>> 
>>>> It's a mystery, still, how /usr/bin/ceph-osd ended up being a directory.
>>>> 
>>>> 
>>>> On 10/30/2012 05:59 AM, hemant surale wrote:
>>>>> 
>>>>> Hi All,
>>>>>    I am building ceph from sourcecode availavle from site. I executeed
>>>>> all steps for building it , executed "mkcephfs" as well the only
>>>>> problem is as shown below.
>>>>> 
>>>>> 
>>>>> ------------------------------------------------------------------------------------------------------------
>>>>> root@atish-virtual-machine:~/ceph# service ceph start
>>>>> === mon.alpha ===
>>>>> Starting Ceph mon.alpha on atish-virtual-machine...
>>>>> bash: /usr/bin/ceph-mon: Is a directory
>>>>> failed: ' /usr/bin/ceph-mon -i alpha --pid-file
>>>>> /var/run/ceph/mon.alpha.pid -c /etc/ceph/ceph.conf '
>>>>> -----------------------------------------------------------------------------------------------------------------------
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

