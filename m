From: Alex Elder <elder@inktank.com>
Subject: Re: CEPH RBD client kernel panic when OSD connection is lost on kernel
 3.2, 3.5, 3.5.4
Date: Mon, 24 Sep 2012 17:59:01 -0500
Message-ID: <5060E5B5.8040807@inktank.com>
References: <CAP5wSLcy90qhsTnNxM=t+_SB1kpfNvchrSqdAG91P6tCe0RPRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50263 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab2IXW7E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 18:59:04 -0400
Received: by ieak13 with SMTP id k13so12393950iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 15:59:04 -0700 (PDT)
In-Reply-To: <CAP5wSLcy90qhsTnNxM=t+_SB1kpfNvchrSqdAG91P6tCe0RPRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Huang <ythuang@gmail.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On 09/24/2012 05:23 AM, Christian Huang wrote:
> Hi,
>     we met the following issue while testing ceph cluster HA.
>     Appreciate if anyone can shed some light.
>     could this be related to the configuration ? (ie, 2 OSD nodes only)

It appears to me the kernel that was in use for the crash logs
you provided was built from source.  If that is the case, are you
able to provide me with the precise commit id so I am sure to
be working with the right code?

Here is a line that leads me to that conclusion:

[  203.172114] Pid: 1901, comm: kworker/0:2 Not tainted 3.2.0-29-generic
#46-Ubuntu Wistron Cloud Computing/P92TB2

If you wish I would be happy to work with one of the other versions
of the code, but would prefer to also have crash information that
matches the source code I'm looking at.  Thank you.

					-Alex


>     Issue description:
>     ceph rbd client will kernel panic if an OSD server loses it's
> network connectivity.
>     so far, we can reproduce it with certainty.
>     we have tried with the following kernels
>     a. Stock kernel from 12.04 (3.2 series)
>         3.5 series, as suggested in a previous mail by Sage
>     b. 3.5.0-15 from quantal repo,
> git://kernel.ubuntu.com/ubuntu/ubuntu-quantal.git, Ubuntu-3.5.0-15.22
> tag
>     c. v3.5.4-quantal,
> http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.5.4-quantal/
> 
>     Environment:
>     OS: Ubuntu 12.04 precise pangolin
>     Ceph configuration:
>         OSD nodes: 2 x 12 drives , 1 os drive, 11 are mapped to OSD
> 0-10, 10GbE link
>         Monitor nodes: 3 x KVM virtual machines on ubuntu host.
>         test client: fresh install of Ubuntu 12.04.1
>         Ceph version used: 0.48, 0.48.1, 0.48.2, 0.51
>         all nodes have the same kernel version.
> 
>     steps to reproduce:
>     on the test client,
>     1. load rbd modules
>     2. create rbd device
>     3. map rbd device
>     4. use fio tool to create work load on the device, 8 threads is
> used for workload
>         we have also tried with iometer, 8 workers, 32k 50/50, same results.
> 
>     on one of the OSD nodes,
>     1. sudo ifconfig eth0 down #where eth0 is the primary interface
> configured for ceph.
>     2. within 30 seconds, the test client will panic.
> 
>     this happens when there is IO activity on the RBD device, and one
> of the OSD nodes loses connectivity.
> 
>     The netconsole output is available available from the following
> dropbox link,
>     zip: goo.gl/LHytr
> 
> Best Regards
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

