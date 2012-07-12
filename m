From: James Page <james.page@ubuntu.com>
Subject: Re: Ceph Upstream Tarball + Re: Ceph status for Wheezy
Date: Thu, 12 Jul 2012 11:38:47 +0100
Message-ID: <4FFEA937.405@ubuntu.com>
References: <4FFC44BE.6090505@ubuntu.com> <1341966632.12180.22.camel@julia> <4FFD40DA.7020408@ubuntu.com> <1342042993.12180.98.camel@julia> <alpine.DEB.2.00.1207111553050.693@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000302010408030402040706"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:32995 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933641Ab2GLKis (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 06:38:48 -0400
In-Reply-To: <alpine.DEB.2.00.1207111553050.693@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, Ceph Development <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000302010408030402040706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/07/12 00:32, Sage Weil wrote:
>> On Wed, 2012-07-11 at 10:01 +0100, James Page wrote:
>>>>> On 11/07/12 01:30, Laszlo Boszormenyi (GCS) wrote:
>>>>>>> You are right, the watch file is outdated.
>>> An updated watch file is attached. Please commit it Sage. It
>>> goes for numbers only, so 0.48argonaut will be 0.48 .
> Why leave off the argonaut?  The intent was to be able to tell from
> e.g. dpkg -l ceph that this was the argonaut stable release,
> without having to figure out through some other channel that 0.48
> is special.
> 

Laszlo - I've updated your watch file and my orig-tar.sh to produce
something that I think works well and automatically - see attached.

Sage - although this technically works with the versioning algorithm in
Debian/Ubuntu I'm uncomfortable using the stable release code name in
the version string.

I would suggest that we document something in debian/NEWS for the 0.48
release version that details that this is the argonaut stable release.


- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJP/qk2AAoJEL/srsug59jDMjcQAIifMFlc8TUMIFPYgMmjYVAb
6mx0cx5pLsmUqGyGSmV+L97+XNDkjABKiudNBFQRsDawbwsYNHNGqH2vNxE6jkEq
e+i3J/RJaJZnigqvVeTAnqQlCxbz6nOulZsVHtPVB2pp6NUN5nN3FXSVpXNMJW3K
NtEsRJvDcK9l7l1MH4gKVefOCKbm8b92d/JWV+HV0rIJBCPx8N/MfQejhCmGNOsy
ykjhdsXodcEXiPWfwIOE+3foS54AXV5mWodY2Fg6P0n6c23NnyN/E9rMMVanInju
VZgEDRC5vbfA5Lnpw9a77X77ppUKuzYUGB6LNMfwfXtXkkCXIkCh9BvngkC/7VHO
FsLf4QKE2y2/VsR36mFt6cQIUW22STtY/tR611Dlv3KjG79Le5Q+AbeX9MP7otcv
WHm50b+HjCxGSnIw8J9Vs1BO5ldjmxyvmdiuxBms+Nud46Ad8ZXT6RGtQEPOkDSj
IYH9bO+2nnchc8Wnv+DKp33eMzB+iwEKsNuuFCClR0lMRAWUnnf6EGLHtAGqRXym
zKfOeon17qsLpS7rWv8b53mKqvuyh1rPC4K2QjEQtTqArj9143B/mbrIpL/QKMjU
JS1IsFlztzJGXRFviMS6ImWZTLY6YQYFtuaZ4obKCQ+NLWqsqtV22GakyQgkE+DY
DCvcoLzC7q5f8wkyn1L5
=LhJK
-----END PGP SIGNATURE-----

--------------000302010408030402040706
Content-Type: text/plain; charset=UTF-8;
 name="watch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="watch"

dmVyc2lvbj0zCmh0dHBzOi8vZ2l0aHViLmNvbS9jZXBoL2NlcGgvdGFncyAuKi90YXJiYWxs
L3YoXGRbXGRcLl0rKS4qIGRlYmlhbiBkZWJpYW4vb3JpZy10YXIuc2gKCg==
--------------000302010408030402040706
Content-Type: application/x-shellscript;
 name="orig-tar.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="orig-tar.sh"

Iy9iaW4vc2ggLWUKClZFUlNJT049JDIKU1JDPSQzClRBUj0uLi9jZXBoXyRWRVJTSU9OLm9y
aWcudGFyLmJ6MgpESVI9Y2VwaC0kVkVSU0lPTgpta2RpciAtcCAkRElSCgojIFVucGFjayBy
ZWFkeSBmbyByZS1wYWNraW5nCnRhciAteHpmICRTUkMgLUMgJERJUiAtLXN0cmlwLWNvbXBv
bmVudHM9MQoKIyBSZXBhY2sgZXhjbHVkaW5nIHN0dWZmIHdlIGRvbid0IG5lZWQKQlpJUDI9
LS1iZXN0IHRhciAtY2pmICRUQVIgLS1leGNsdWRlICJjZXBoLSRWRVJTSU9OL2RlYmlhbiIg
JERJUgoKcm0gLXJmICRESVIgJFNSQwoK
--------------000302010408030402040706--
