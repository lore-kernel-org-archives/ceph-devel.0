From: James Page <james.page@ubuntu.com>
Subject: Re: firefly timing
Date: Tue, 04 Feb 2014 08:14:13 +0200
Message-ID: <52F08535.50100@ubuntu.com>
References: <alpine.DEB.2.00.1402030819030.6345@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47142 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaBDGOR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 01:14:17 -0500
In-Reply-To: <alpine.DEB.2.00.1402030819030.6345@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/02/14 18:21, Sage Weil wrote:
> The only time dependency that I am aware of is the looming 14.04
> freeze date.  I'm hoping that we can (worst case) put an -rc
> release in place and update as the code stabilizes over the next
> several weeks.  James, will this be problematic?

Pushing in an RC is a good approach; what's the likely date for the
firefly release?  I can raise the Freeze Exception now which gives our
release team *lots* of notice :-)  FWIW I don't think this will be a
problem - we have a good track record with ceph in Ubuntu now.

Cheers

James


- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJS8IU1AAoJEL/srsug59jDEQkP/Ak1DvMqDsLwtdWNJCZ6Y4qM
/+GhBuJHCEDhx7+2mM4l9kiFdEVRNY4uarRIaCNYtgMhKWZ0c1MzFD4nVicqmg85
72gfdc97opDU3Mus3GXk6TI51jex6YBaRR4kUDWcT5l2N39yPN9iaxiSftfYnI4C
3sK5W2GdLCaYjWsjgdOum0UDyN9ZSZmK1qBfMHmZZ74OsMPmGK+D9hiTKnH5sEF8
57Nmoa4G4wfmBUf/vxkKnmI51hQrXnp0zqeI5i+xDvDGelNUDtofrcxQrp0yfnff
FAf50KvYeniyjvtgqQMvu9vrb4gvN0lTFUZygLXICq5mX45JitGjQ0NS7T4pVhbE
fdW+2BN4I91CkIVY/qPTRqWv/RIZJM4dj/2w3DBMhoMnIl1laFd+uMd5b2mxrWD9
RHXOOXgE9fq0gBuB5N2w8Q50Bm4+gDqxM7mfQi8lvSjXyUVPdvdnIuYd/L5beIGX
9EbYLLoaXRHIN84DQwHY/6Ni57rPGcG0VNjOBcgNXr/8DXJi4b8ztxIpCT7rhpG0
UeCVEuRsrM5wggvQFODaxQ1BzNvuQbUryj+FK2fsGfwnHESp1J5arKbRJUUHCkT7
tzhHlqx9jWDp6sMyc6jMVotSOgQv/AGq+kt/gBLEz6ymLB4MsZkQQRpMXXID+RkH
tmFj4DUwOn7LRSS1/Ag8
=kovj
-----END PGP SIGNATURE-----
