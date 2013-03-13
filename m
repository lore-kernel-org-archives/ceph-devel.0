From: Wido den Hollander <wido@42on.com>
Subject: Re: Release Cadence
Date: Wed, 13 Mar 2013 12:08:20 +0100
Message-ID: <51405E24.9030702@42on.com>
References: <CAP8Oy=LhkgGeUe8KLHJtbKwmsJe3-0idApOzx9kTsBm67fgEFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:56324 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab3CMLIW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Mar 2013 07:08:22 -0400
In-Reply-To: <CAP8Oy=LhkgGeUe8KLHJtbKwmsJe3-0idApOzx9kTsBm67fgEFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <patrick@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On 03/12/2013 09:12 PM, Patrick McGarry wrote:
> Hey all,
>
> Just wanted to link to a few words on the new Ceph release cadence.
>
> http://ceph.com/community/ceph-settles-in-to-aggressive-release-cadence/
>
> Feel free to hit us with any questions.  Thanks.
>
>

One note in the LTS releases. While LTS releases would be great, I agree 
that at this point in time Ceph isn't ready for it.

Point being that the API changes and such are becoming less frequent, 
but think about the burden of having to facilitate an upgrade path from 
code which was written one year ago to the current point in time.

Think about the new monitor proposal and such.

Just to conclude, I think it's wise for now to not call anything "LTS" 
yet. I however fully agree that in the longer run it would be desirable 
for production deployments.

>
> Best Regards,
>
> --
> Patrick McGarry
> Director, Community
> Inktank
>
> http://ceph.com  ||  http://inktank.com
> @scuttlemonkey || @ceph || @inktank
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
