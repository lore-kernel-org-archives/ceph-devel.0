From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD Fwd: Build failed in Jenkins: ceph-master #491
Date: Mon, 3 Apr 2017 22:48:39 +0100
Message-ID: <d6856db4-bbdf-426a-67be-9590d15831ce@digiware.nl>
References: <1496578540.11.1491070646102.JavaMail.jenkins@cephdev.digiware.nl>
 <28d0fff1-89d1-e6fb-dd25-c45e67b5a8fa@digiware.nl>
 <OFEBB086A9.04CBF66E-ON002580F7.00549C80-862580F7.0057E911@notes.na.collabserv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:36932 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbdDCUsw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 3 Apr 2017 16:48:52 -0400
In-Reply-To: <OFEBB086A9.04CBF66E-ON002580F7.00549C80-862580F7.0057E911@notes.na.collabserv.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew N Solomon <asolomon@us.ibm.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 3-4-2017 17:00, Andrew N Solomon wrote:
> Willem-
> 
> I think I see the problem and have a fix in mind for this. I will put it
> up asap.
> Sorry for the trouble. Since you seemingly have available access to FreeBSD
> more easily than I do perhaps you could help with testing my fix once it
> is up?
> 
> We should be able to just move the #include <sys/auxv.h> line (ie line
> 16 of src/arch/ppc.c)
> under the #if __linux__ && __powerpc64__ (on line 18).
> 
> The call to getauxval is already under that same #if __linux__ &&
> __powerpc64__ directive. The
> reason auxv.h is included is to provide the declaration for the
> getauxval function, which is seemingly
> present in linux but not FreeBSD.
> 
> Thanks,
> Andy Solomon
> 
> 
> Inactive hide details for Willem Jan Withagen ---04/01/2017 04:11:24
> PM---From: Willem Jan Withagen <wjw@digiware.nl> To: AndreWillem Jan
> Withagen ---04/01/2017 04:11:24 PM---From: Willem Jan Withagen
> <wjw@digiware.nl> To: Andrew N Solomon/Austin/IBM@IBMUS, Ceph
> Development <ceph-devel@vger.kernel.org
> 
> From: Willem Jan Withagen <wjw@digiware.nl>
> To: Andrew N Solomon/Austin/IBM@IBMUS, Ceph Development
> <ceph-devel@vger.kernel.org>
> Date: 04/01/2017 04:11 PM
> Subject: FreeBSD Fwd: Build failed in Jenkins: ceph-master #491
> 
> ------------------------------------------------------------------------
> 
> 
> 
> Currently my FreeBSD build fails due to inclusion of a file
> that does not exist on FreeBSD.
> Next to the fact that I'm not really certain that everything will build
> and run on PPC with FreeBSD. :)
> 
> Perhaps we can conditionalise PPC code just as we did with ARM code?
> Or perhaps even exclude pp.cc in CMakeLists.txt without upsetting the
> balance of order.

Hi Andrew,

Currently there is PR (#14289) of Kefu in the works that tries to fix
this in a rather structural way.
You might want to take a look at it.

--WjW


