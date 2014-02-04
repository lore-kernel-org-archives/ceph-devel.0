From: James Page <james.page@ubuntu.com>
Subject: Re: firefly timing
Date: Tue, 04 Feb 2014 08:33:02 +0200
Message-ID: <52F0899E.40902@ubuntu.com>
References: <alpine.DEB.2.00.1402030819030.6345@cobra.newdream.net> <52F08535.50100@ubuntu.com> <alpine.DEB.2.00.1402032216080.17892@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47223 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaBDGdF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 01:33:05 -0500
In-Reply-To: <alpine.DEB.2.00.1402032216080.17892@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/02/14 08:20, Sage Weil wrote:
> On Tue, 4 Feb 2014, James Page wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA256
>> 
>> On 03/02/14 18:21, Sage Weil wrote:
>>> The only time dependency that I am aware of is the looming
>>> 14.04 freeze date.  I'm hoping that we can (worst case) put an
>>> -rc release in place and update as the code stabilizes over the
>>> next several weeks.  James, will this be problematic?
>> 
>> Pushing in an RC is a good approach; what's the likely date for
>> the firefly release?  I can raise the Freeze Exception now which
>> gives our release team *lots* of notice :-)  FWIW I don't think
>> this will be a problem - we have a good track record with ceph in
>> Ubuntu now.
> 
> If we take the usual 4 weeks, it will be the second week of March,
> and an -rc will come out in the last week of February.  The freeze
> will come before the trusty freeze, but an early -rc at that point
> will be relatively raw.  I assume it will be worth building,
> though, to minimize the number of hoops to jump through.  There are
> also several users who have expressed interest in an early build
> with EC support to star their testing.

That should be OK - I'll tee things up with the release team now

Thanks

- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJS8ImdAAoJEL/srsug59jD02UP+wUSz9xt2z2hyDVmkW9h2pBg
jDYAe+prKehdm1t1yulCBWABRxPwE2aV52LXn4X/8QivHQcqQzYP3wUfwCbsT/4F
qewImdizrXU1vDVUaRJ1/eQ3V3zkH51DzgmhGzk7OdXa3HWXBrCG0U1IPnbRSzpq
qo19uWdHNInzzv8a1w83YI1Gse+PrLNcotdmuKy8zk+o0/0N+naMKHgs+jx5fvfY
doWwtbyB/h9ef4C7s57eOcyoxW69/DxUO8xXV9aL2JMHmvTdiCejKFxSlwo8Tkke
5HKWHRU166ZJgCOkuA6qHsI/Nhli/FPd3TQCdfCmK78ClfCYvZrsyPCStIvYyPCF
NAtlkNGmzU7DCNgIsylCeVVBwUZ2BnHUFyOdrUzkSL7a1KJbG/BihzgbYaOD6fMD
7IlIvm6x6ltzk634TEy/bHwGJkVy8zkB+w2zPOVeYubNTXxofkPJJ+0YRXdodEHF
/ATovYrhQbxYHTGlQUDbLJp9yoaLdTfL1clfBtaIqknpRBsSBRHH7ikobSN7hqn4
wLlj7hoFm35nOpAf/3fmMbIHF0ntRKlL9LMEwGeZjLMWVx1/6K8jsxHY1qzUzmOD
OkWDR4bWQNcpwTmfeBo6FsXOW7+sO5r4LwhvOOvkhYEwWI41Nsb0MLYXv7Q+SFZG
2TPFLdOxR2R4LqHg+Nse
=p3Oi
-----END PGP SIGNATURE-----
