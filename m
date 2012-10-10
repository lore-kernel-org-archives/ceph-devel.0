From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Unable to build CEPH packages
Date: Wed, 10 Oct 2012 10:03:08 -0700
Message-ID: <3D0CC9E5-2798-4C0A-9134-1C6BDDDF6A63@inktank.com>
References: <CAGfy=6kaMcemE_8qdG9dhrwUWNyh+fEzQvvfgPWiMEPrYf9_Og@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60719 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615Ab2JJRDL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 13:03:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so813646pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 10:03:11 -0700 (PDT)
In-Reply-To: <CAGfy=6kaMcemE_8qdG9dhrwUWNyh+fEzQvvfgPWiMEPrYf9_Og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Hemant -

I'll be happy to help you with the problem.   The first things that would be helpful for me to know is what version of ceph you are trying to build, what distribution you are building on, and what your yum repositories are.  You can get the last piece of information with the "yum repolist" comand.

Thanks,
Gary


On Oct 10, 2012, at 2:34 AM, hemant surale wrote:

> Hi Folks ,
> 
> I was trying to build ceph from source code , To have stable setup for VMs .
> 
> While I was executing "yum install rpm-build rpmdevtools"  Error
> observed is "No package rpm-build is available  No package rpmdevtools
> is available "
> 
> All previous steps are working fine ,but error is observed while
> building ceph packages .
> http://ceph.com/docs/master/source/build-packages/
> 
> Please help me out .
> 
> Thanks & Regards,
> Hemant Surale.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

