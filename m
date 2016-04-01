From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] ceph-disk: s/prefered/preferred/
Date: Fri, 1 Apr 2016 11:07:10 +0200
Message-ID: <56FE3A3E.3080008@dachary.org>
References: <56FE1B91.2080108@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44256 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcDAJOi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 05:14:38 -0400
In-Reply-To: <56FE1B91.2080108@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

Once again, and with feeling: please PLEASE stop doing these idiotic th=
ings.

You should worry about *your* code. Don't worry about my merge. Don't
worry about other trees. Make sure YOUR code is well-tested and
stable, and make sure there is absolutely nothing questionable there.

This whole idiotic "let's rebase on top of something else because of a
tiny conflict" is a disease.

I'm simply not applying this. If you insist on sending me patches that
have been rebased in the last day, then I will insist on just waiting
for the next merge window.

It really is that simple.

This patch request came in very late in the merge window, and the code
clearly has had almost zero actual testing since it was recently
rebased.

The fact that it avoids a merge conflict is not worth it.

Stop doing this idiotic crazy thing. How many times do I have to tell
people? When  you rebase, you are throwing your old testing away, and
you're also making me get new commits that are different from the
ceph-jewel commits.

I'm not AT ALL interested in getting newly minted untested crap the
last day of the merge window.

Really.

                   Loic

On 01/04/2016 08:56, Nathan Cutler wrote:
> Hi,
>=20
> Please pull the following Ceph updates from this mail.
>=20
> There is not much here, just some overdue proofreading.
>=20
> This patch is based on a recent merge of the jewel tree to avoid conf=
licts with a recent refactor.
>=20
> Sincerely
>=20
> Signed-off-by: Nathan Cutler <ncutler@suse.cz>
> ---
>  src/ceph-disk/ceph_disk/main.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/ceph-disk/ceph_disk/main.py b/src/ceph-disk/ceph_dis=
k/main.py
> index d0ec596..a137967 100755
> --- a/src/ceph-disk/ceph_disk/main.py
> +++ b/src/ceph-disk/ceph_disk/main.py
> @@ -406,7 +406,7 @@ def command(arguments, **kwargs):
>      executable exists and raising a helpful error message
>      if it does not.
>=20
> -    .. note:: This should be the prefered way of calling ``subproces=
s.Popen``
> +    .. note:: This should be the preferred way of calling ``subproce=
ss.Popen``
>      since it provides the caller with the safety net of making sure =
that
>      executables *will* be found and will error nicely otherwise.
>=20
> @@ -429,7 +429,7 @@ def command_check_call(arguments):
>      Safely execute a ``subprocess.check_call`` call making sure that=
 the
>      executable exists and raising a helpful error message if it does=
 not.
>=20
> -    .. note:: This should be the prefered way of calling
> +    .. note:: This should be the preferred way of calling
>      ``subprocess.check_call`` since it provides the caller with the =
safety net
>      of making sure that executables *will* be found and will error n=
icely
>      otherwise.
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
