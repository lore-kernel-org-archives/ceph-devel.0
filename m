From: Stratos Psomadakis <psomas@grnet.gr>
Subject: Re: [PATCH v2] rbd: Support plain/json/xml output formatting
Date: Mon, 14 Jan 2013 15:19:20 +0200
Message-ID: <50F405D8.4000200@grnet.gr>
References: <50CF559E.9040504@inktank.com> <1355919440-24357-1-git-send-email-psomas@grnet.gr> <50E76AAD.1040808@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DJTBQWLBANWGXVQGAJKD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:48269 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755903Ab3ANNTa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jan 2013 08:19:30 -0500
In-Reply-To: <50E76AAD.1040808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DJTBQWLBANWGXVQGAJKD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/05/2013 01:50 AM, Josh Durgin wrote:
> On 12/19/2012 04:17 AM, Stratos Psomadakis wrote:
>> This patch renames the --format option to --image-format, for
>> specyfing the RBD
>> image format, and uses --format to specify the output formating (to be=

>> consistent with the other ceph tools). To avoid breaking backwards
>> compatibility
>> with existing scripts, rbd will still accept --format [1|2] for the
>> image
>> format, but will print a warning message, noting its use is deprecated=
=2E
>>
>> The rbd subcommands that support the new --format option are : ls,
>> info, snap
>> list, children, showmapped, lock list.
>>
>> Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
>> ---
>> Hi,
>>
>> this is the updated version of the patch. I renamed --format option to=

>>   --image-format, and used --format to specify the output formatting,
>> as you
>> suggested.
>>
>> I also implemented some basic error checking on the --format input,
>> and modified
>> the rbd subcommands you mentioned, to support plain/json/xml output
>> formatting.
>> Although, I'm not sure if the json and xml output of those commands
>> is what
>> you'd want.
>>
>> The style issues should also be resolved now.
>>
>> Let me know what you think.
>
> There were still some style issues (missing braces, long lines, and
> spaces instead of tabs), but I squashed fixes to those into the
> wip-rbd-formatted-output branch.
>
> I changed the output a bit to uses ints, arrays, etc. where it
> seemed appropriate. The tests aren't quite done yet, but does
> this new json output look good to you?
>
> Josh

Hi,

Sorry for the delay. Thanks for resolving the style issues and cleaning
this up.

Wrt the json output, I think it's fine as it is now.

Just a minor comment. The --pretty-format option doesn't seem to be
documented (in either rbd --help or rbd man page). Other than that, I
don't see any other issues.

Thanks,
Stratos

--=20
Stratos Psomadakis
<psomas@grnet.gr>



------enig2DJTBQWLBANWGXVQGAJKD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD0Bd4ACgkQid1lVeNDMmCUAwCdHUXfS2ejrjACDfJjDm9rkqaf
66MAmwe8XB0AvmPRNLyC08Nr02IWJTpC
=Uuhu
-----END PGP SIGNATURE-----

------enig2DJTBQWLBANWGXVQGAJKD--
