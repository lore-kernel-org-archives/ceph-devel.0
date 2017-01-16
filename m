From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Request for advice on ceph compile time.
Date: Mon, 16 Jan 2017 23:05:46 +0100
Message-ID: <1e7dee33-5d6d-4610-0a7e-dcb1d626b014@digiware.nl>
References: <CA+hcxJR65Ux2J+nUyFAXz08aZkrWVBKrSKeH-kH-Rqd-FLXNqg@mail.gmail.com>
 <85210ecc-191d-ac31-7d0b-ee9be562c83c@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17697 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbdAPWFw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 16 Jan 2017 17:05:52 -0500
In-Reply-To: <85210ecc-191d-ac31-7d0b-ee9be562c83c@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Victor Denisov <vdenisov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 16-1-2017 20:51, Igor Fedotov wrote:
> My best choices are:
> 
> 1) Use  -j switch for make
> 
> 2) Make specific target(s) only, e.g. some UT for the code I'm working
> on and proceed with the full build when most of the patch is ready.

Right,

My most favourite command by now is:
	( cd build; gmake -j8 VERBOSE=1 )
or dedicated makes:
	( cd build ; gmake -j8 bin/ceph-osd )
Running with  8 cores.
ccache with about 5Gb of cache on a fast disk (ssd)

Only trash the whole build if you have very large and invasive changes,
by doing rm -rf build...

When running tests, these are the favourites:
	(cd build; ctest -j8 --output-on-failure )
	(cd build; ctest -j8  --rerun-failed --output-on-failure )
	(cd build; ctest -V -R <regex matching tests> )

or testing for faults cases:
	(cd build; ctest -j8  --repeat-until-fail <n> )

--WjW




