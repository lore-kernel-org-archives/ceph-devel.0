From: hemant surale <hemant.surale@gmail.com>
Subject: Fwd: Unable to Start Ceph service
Date: Fri, 2 Nov 2012 12:29:51 +0530
Message-ID: <CAGfy=6n7vM6KTdJQNjtqV0QUyiWrKf5Mai6HC_4-4vWfYEiVpQ@mail.gmail.com>
References: <CAGfy=6m7yJwVzVuFCZrHqe8tvcnYvkU7w7rieZuo4s7duQV5gw@mail.gmail.com>
	<5091A7BE.2050106@inktank.com>
	<CAGfy=6ni5fybh_zXK1L4HFBeNiYrr-sir_NVJuUk9SgURt=YBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36223 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab2KBG7w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 02:59:52 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3514430vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 23:59:51 -0700 (PDT)
In-Reply-To: <CAGfy=6ni5fybh_zXK1L4HFBeNiYrr-sir_NVJuUk9SgURt=YBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Dan Mick <dan.mick@inktank.com>

---------- Forwarded message ----------
From: hemant surale <hemant.surale@gmail.com>
Date: Fri, Nov 2, 2012 at 12:10 PM
Subject: Re: Unable to Start Ceph service
To: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org"
<ceph-devel@vger.kernel.org>



 Initially I installed ceph directly by following 5minute guide from
official site , So before building ceph from source code I installed
ceph as well as removed it using "sudo apt-get remove ceph" ,But It
seems that some directories left undeleted.

Now I tried to Build ceph again on fresh VM and again I have some
issues to resolve .

As proceeding to building step when I came across "make" cmd following
error is observed
---------------------------------------------------------//Error---------------------------------------------------------------------
  CXX    MDS.o
g++: internal compiler error: Killed (program cc1plus)
Please submit a full bug report,
with preprocessed source if appropriate.
See <file:///usr/share/doc/gcc-4.6/README.Bugs> for instructions.
make[3]: *** [MDS.o] Error 4
make[3]: Leaving directory `/home/hemant/ceph/ceph/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/hemant/ceph/ceph/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/hemant/ceph/ceph/src'
make: *** [all-recursive] Error 1
---------------------------_---------------------------_---------------------------_---------------------------


- Hemant Surale


On Thu, Nov 1, 2012 at 4:05 AM, Dan Mick <dan.mick@inktank.com> wrote:
>
> I've had a long private thread with Hemant, and I believe he's past this problem (in case anyone scans archives looking for open questions).
> Hemant, it would be best to keep the thread on ceph-devel; you get more people looking and answering.
>
> It's a mystery, still, how /usr/bin/ceph-osd ended up being a directory.
>
>
> On 10/30/2012 05:59 AM, hemant surale wrote:
>>
>> Hi All,
>>     I am building ceph from sourcecode availavle from site. I executeed
>> all steps for building it , executed "mkcephfs" as well the only
>> problem is as shown below.
>>
>>
>> ------------------------------------------------------------------------------------------------------------
>> root@atish-virtual-machine:~/ceph# service ceph start
>> === mon.alpha ===
>> Starting Ceph mon.alpha on atish-virtual-machine...
>> bash: /usr/bin/ceph-mon: Is a directory
>> failed: ' /usr/bin/ceph-mon -i alpha --pid-file
>> /var/run/ceph/mon.alpha.pid -c /etc/ceph/ceph.conf '
>> -----------------------------------------------------------------------------------------------------------------------
