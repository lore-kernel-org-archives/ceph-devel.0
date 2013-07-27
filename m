From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: blueprint: ceph platform portability
Date: Sat, 27 Jul 2013 23:25:14 +0800
Message-ID: <51F3E65A.7030508@ubuntukylin.com>
References: <CA+Hcz5-WA8uKo9HjN48Z3tnT0RJBE2z8gKKtkEEFndKUb2iCTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:45543 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab3G0PZ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Jul 2013 11:25:27 -0400
In-Reply-To: <CA+Hcz5-WA8uKo9HjN48Z3tnT0RJBE2z8gKKtkEEFndKUb2iCTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We did some work on Sparc machine, fixed some little endian/big endian 
as well as non-align access issues. We are using CentOS 6 recompiled 
version. We have managed to compile Ceph, however, it still could not 
work properly due to some aotmic function bug from some libs. We did not 
track it further recently.

Any experiences on running Ceph on big endian machine to share?

On 07/27/2013 07:07 AM, Noah Watkins wrote:
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Increasing_Ceph_portability
>
> Recently I've managed to get Ceph built and running on OSX. There was
> a past effort to get Ceph working on non-Linux platforms, most notably
> FreeBSD, but that approach introduced a lot of ad-hoc macros that has
> made it difficult to manage changes needed to support additional
> platforms.
>
> This session would address the areas within Ceph that are currently
> non-portable, discuss the state of OSX support, and touch on what is
> needed to factor out platform specific functionality. Changes are
> roughly grouped into (1) internal critical (e.g. locking) (2) internal
> non-critical (some optimizations), and (2) exported headers. A
> significant amount of the OSX changes have been introduced as feature
> tests with generic alternatives, and as such the tree may already be
> near building on additional platforms, so it would be great to find
> people that would be willing to test on additional platforms.
>
> If you are interested please add yourself as an interested party or
> owner of this blueprint :)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
