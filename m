From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: teuthology SELinux failures
Date: Fri, 2 Jun 2017 04:44:28 +0200
Message-ID: <bce6778c-42a2-b4ca-6ae3-2ce9e771d180@suse.cz>
References: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
 <1496331233.10067.1.camel@redhat.com>
 <CAKPXa=Ydy_KAoFaUrnMPWA51S_D3snjPPfAtGW5oE=omi41ENg@mail.gmail.com>
 <CALe9h7ch+6NHLEhC=YDAaY77ki-Xo-L0Eh5m9XsaGWRAsPETfw@mail.gmail.com>
 <CAMMFjmE8vy_h8uNtJW4bHVDa=MGMsX0C+ecTSXsFoFs=kSH1NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58383 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751120AbdFBCob (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Jun 2017 22:44:31 -0400
In-Reply-To: <CAMMFjmE8vy_h8uNtJW4bHVDa=MGMsX0C+ecTSXsFoFs=kSH1NQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, John Spray <jspray@redhat.com>
Cc: Vasu Kulkarni <vakulkar@redhat.com>, Boris Ranto <branto@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> all k* suites run with -k testing in nightlies

What I hear John saying is you should add an explicit "-k distro" to all 
the other suites in the nightlies.

We had the same issue in backports testing, and fixed it by specifying 
"-k distro" on all teuthology-suite commands we use, except for the k* 
suites of course.

Not specifying "-k" is the equivalent of saying "I don't care, just use 
whatever kernel happens to be on each test node".

Nathan
