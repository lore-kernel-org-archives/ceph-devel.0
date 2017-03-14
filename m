From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: Can't compile because of -lpthreads
Date: Tue, 14 Mar 2017 08:54:11 -0400
Message-ID: <162096e6-bddf-7213-fba1-982d7e88c5f6@redhat.com>
References: <CAAXqJ+qjr5WaaR4MmanVLyd_PdWC0=8CYYP0dyTBkrEvXF4ofA@mail.gmail.com>
Reply-To: dang@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35733 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdCNMyF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 08:54:05 -0400
Received: by mail-qt0-f172.google.com with SMTP id x35so54452465qtc.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 05:54:04 -0700 (PDT)
In-Reply-To: <CAAXqJ+qjr5WaaR4MmanVLyd_PdWC0=8CYYP0dyTBkrEvXF4ofA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>, ceph-devel@vger.kernel.org

This appears to be a fallback compatibility check in CMake itself if it 
can't find -lpthread (which is what all the files in Ceph use).  Likely 
you don't have the correct development package installed for pthread. 
I'm not an Ubuntu user, so I'm not sure which package you should 
install.  Google seems to think it's libpthread-stubs0-dev but others on 
the list can correct me if I'm wrong.

Daniel

On 03/14/2017 06:33 AM, Spandan Kumar Sahu wrote:
> Hey everyone,
>
> I am interested in contributing to Ceph and thus I tried to build the
> source code but unfortunately it has some errors. I will list out the
> steps I did:
>
>  * Clone the ceph/ceph.git repo from github on my local machine
>  * `./install_deps.sh`
>  * `./do_cmake.sh`
>
> Now the last command shows some errors. This[1] is the output of
> CMakeError.log file
>  while this[2]. I am using Ubuntu 16.04 LTS.
>
> The particular problem is that my system can't recognise `-lpthreads`
> but it recognises `-pthread` and `-lpthread`. I had tried a lot to
> search this on the internet and also tried out all the stuff described
> in the stackoverflow results but all in vain. I am familiar with
> Makefiles but not so familiar with CMake files and thus couldn't
> really find a solution. I would be really glad if someone could help!
>
> Cc'ing some people who have worked with CMakeLists.txt
>
> [1]: http://paste.ubuntu.com/24175792/
> [2]: http://paste.ubuntu.com/24175794/
>

