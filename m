From: James Page <james.page@ubuntu.com>
Subject: Re: 0.55 init script Issue?
Date: Mon, 10 Dec 2012 09:13:49 +0000
Message-ID: <50C5A7CD.9010303@ubuntu.com>
References: <50BF7314.2020809@gammacode.com> <50BFA354.7040308@inktank.com> <50BFABE5.1020904@ubuntu.com> <CAPYLRzjme=UxScsKDXdKPAWJyfxB1hNQGRJWT7QyJk+ET3dFHQ@mail.gmail.com> <alpine.DEB.2.00.1212051610560.16078@cobra.newdream.net> <alpine.DEB.2.00.1212060534110.13653@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51489 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab2LJJNz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 04:13:55 -0500
In-Reply-To: <alpine.DEB.2.00.1212060534110.13653@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Dan Mick <dan.mick@inktank.com>, Mike Dawson <mdawson@gammacode.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 06/12/12 13:35, Sage Weil wrote:
>>> Yeah, this or something very similar is definitely the correct
>>>>> solution. Sage recently added the "ceph" upstart job, and
>>>>> we didn't put it through sufficient verification prior to
>>>>> release in order to notice this issue. Users who aren't
>>>>> using upstart (I expect that's all of them) should just
>>>>> delete the job after running the package install. We'll
>>>>> certainly sort this out prior to the next release; I'm not
>>>>> sure if we want to roll a v0.55.1 right away or not.
>>> 
>>> Let's push it to the testing branch, but make sure any other
>>> fixes are there before rolling a .1.. maybe tomorrow?
> I've pushed this to the testing branch.  If someone wants to verify
> the packages built at
> 
> http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/testing/
>
>  are fixed, that would be fabulous!

I think the radosgw init script and upstart configuration are going to
conflict in a similar way to the ceph one.

I've been working on integrating the upstart configurations into the
Ubuntu distro packaging of ceph; it is possible to install multiple
upstart configurations into single binary packages using dh_installinit:

    dh_installinit --no-start
    # Install upstart configurations using dh_installinit
    for conf in `ls -1 src/upstart/ceph-*.conf | grep -v mds`; do \
        name=`basename $$conf | cut -d . -f 1`; \
        cp $$conf debian/ceph.$$name.upstart; \
        dh_installinit -pceph --upstart-only --no-start --name=$$name; \
    done
    for conf in `ls -1 src/upstart/ceph-mds*.conf`; do \
        name=`basename $$conf | cut -d . -f 1`; \
        cp $$conf debian/ceph-mds.$$name.upstart; \
        dh_installinit -pceph-mds --upstart-only --no-start
- --name=$$name; \
    done
    for conf in `ls -1 src/upstart/radosgw*.conf`; do \
        name=`basename $$conf | cut -d . -f 1`; \
        cp $$conf debian/radosgw.$$name.upstart; \
        dh_installinit -pradosgw --upstart-only --no-start
- --name=$$name; \
    done


- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQxafNAAoJEL/srsug59jDGloP/0NK8RAFLLGcwHBOGqPSiOSr
e61NAus6zM0gRHdY0GxPLLzh8XfcoJtpiOdJE2PeC0YbNX7SRLnlHBc3uh3nRv0+
LF5RfzN0MASpk5miCVIpZCNhRVbg+tte1k3tEbZEgwsFavmhXdXzL7bwaKDKVuRp
Y8/XENu6qF2tSt1A1P5ABOqetjrZi78Z6bNSBS20N2PIZHAXwdb2MdFPKO600n2w
jVPjXh/nfCuPpmehE+ZVP/1y/7jLvtgYTIppg8bHNG0X4TI6aarHh3fiypti+UNu
y/fQvx48ktkCtaF7nfoIx+Kr1qWO9xcuHYZy/35a9woJIyBWGTHS4yT/UYG202gM
JjelhXu0BM4WrmTf9bdFo2iK55MNtKOEPOAjmy4FZbVtBc1iUNtyBOJGDSv5Ls+0
uwDImZbg1W8VqtnioQRrhNUelgV3SLYoWfzOjAsHMoS25/WsLwvnRm8XExD2223l
SQOfcwXjTDldRRc04wohr2Rc1/vuTEFGt94cLVf67UutEDgN4T8LK2Za+RV/D6/e
GmrofhClKQUIeHm3WaD3P2oJJZIG+MOeNG0+Y1JB4aOgL+ZUtuLTQo3xa8fhvhDA
mRcYrCvUwS+k70OcSh2GTpt9y+1mnk+qAB4JR3SclTVOUUh4i9KtYa+1F5+8NWwU
DsfC6VS1vdgPnBEcKw0d
=5jkr
-----END PGP SIGNATURE-----
