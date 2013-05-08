From: Wido den Hollander <wido@42on.com>
Subject: Re: Cuttlefish installation on debian 6.0 squeeze depends on cryptsetup-bin
Date: Wed, 08 May 2013 10:34:02 +0200
Message-ID: <518A0DFA.7030100@42on.com>
References: <CAOVDbHa2qS7-O1AyyQSPRcnb8DSrGxf_iKzBWUDkJLVf+uAuSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:53418 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454Ab3EHIeE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 May 2013 04:34:04 -0400
In-Reply-To: <CAOVDbHa2qS7-O1AyyQSPRcnb8DSrGxf_iKzBWUDkJLVf+uAuSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henning Verbeek <hankipanky@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/08/2013 10:09 AM, Henning Verbeek wrote:
> Dear ceph developers,
>
> I just tried to upgrade my ceph installation from bobtail to
> cuttlefish on a debian 6.0 squeeze installation. The installation of
> package 'ceph' failed due to missing package 'cryptsetup-bin':
>
>    $ sudo apt-get -y install ceph
>    Reading package lists... Done
>    Building dependency tree
>    Reading state information... Done
>    Some packages could not be installed. This may mean that you have
>    requested an impossible situation or if you are using the unstable
>    distribution that some required packages have not yet been created
>    or been moved out of Incoming.
>    The following information may help to resolve the situation:
>
>    The following packages have unmet dependencies:
>     ceph : Depends: cryptsetup-bin but it is not installable
>            Recommends: ceph-mds but it is not going to be installed
>    E: Broken packages
>
> Package 'cryptsetup-bin' is available only from wheezy onwards:
> http://packages.debian.org/search?keywords=cryptsetup-bin
>
> On squeeze, the package is called 'cryptsetup'.
>
> Can I suggest that the dependency be changed for the squeeze packages?

I think that is reasonable? Just out of curiosity, why Debian Squeeze 
and not Wheezy? The newer kernels also give you some XFS performance 
benefits.

Depends: binutils,
          ceph-common,
          cryptsetup-bin | cryptsetup,

That should already fix your problem.

Wido

> Thank you.
>
> Cheers,
> Henning
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
