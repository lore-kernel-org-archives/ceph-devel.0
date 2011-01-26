From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: master branch in git
Date: Wed, 26 Jan 2011 15:22:52 -0700
Message-ID: <1296080572.23762.81.camel@sale659.sandia.gov>
References: <1296076567.1802.16.camel@dogen>
 <AANLkTimjgPj2wQhtw1zg8NK-jsLPk1RUHiRcjA0XH8RV@mail.gmail.com>
 <1296078697.1802.37.camel@dogen>
 <Pine.LNX.4.64.1101261357390.27034@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:57106 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab1AZWXE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 17:23:04 -0500
In-Reply-To: <Pine.LNX.4.64.1101261357390.27034@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Leach <john@brightbox.co.uk>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Wed, 2011-01-26 at 15:01 -0700, Sage Weil wrote:
> Yeah.  Currently:
> 
>  master - last release (but I forgot to update it)
>  unstable - unstable
>  testing - bug fixes to last release, will become next stable release
>  rc - will become next major release
> 
> I agree that's not optimal.  I think moving unstable to work to master 
> makes sense.
> 
> How about something like:
> 
>  master - unstable (and get rid of 'unstable' branch)
>  testing or stable - bug fixes to last release.
>  rc or next - what will be the next major release
> 

FWIW, master/stable/next makes sense to me.

> Does anyone see value in having a branch that has the last release?  They 
> can see that with the git tags.

Also FWIW, I think tags should be enough for releases.

-- Jim

> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


