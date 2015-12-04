From: =?windows-1252?Q?Javier_Mu=F1oz?= <jmunhoz@igalia.com>
Subject: Re: RGW S3 Website hosting, non-clean code for early review
Date: Fri, 04 Dec 2015 13:10:47 +0100
Message-ID: <566182C7.6010008@igalia.com>
References: <20150623093325.GH10754@orbis-terrarum.net> <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com> <robbat2-20150623T230410-006258787Z@orbis-terrarum.net> <854662566.18884035.1435100864177.JavaMail.zimbra@redhat.com> <1563403567.1093721.1438280774967.JavaMail.zimbra@redhat.com> <robbat2-20150731T080643-628065411Z@orbis-terrarum.net> <565EF9E4.2020501@igalia.com> <robbat2-20151203T214017-551971919Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp3.mundo-r.com ([212.51.32.191]:35503 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752121AbbLDMLC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Dec 2015 07:11:02 -0500
In-Reply-To: <robbat2-20151203T214017-551971919Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel@vger.kernel.org, Jonathan LaCour <jonathan.lacour@dreamhost.com>

On 12/03/2015 10:47 PM, Robin H. Johnson wrote:
> On Wed, Dec 02, 2015 at 03:02:12PM +0100, Javier Mu=F1oz wrote:
>> I would appreciate to know the current status of the implementation =
if
>> possible. Any progress? Any 'deadline' to go upstream? :)
>=20
> When:
> As soon as it works 100% and passes my testsuite, which I hope is ver=
y
> soon. I would very much like to have this in Jewel.
>=20
> My work was being done in this branch
> https://github.com/dreamhost/ceph/tree/wip-static-website-robbat2-mas=
ter
> However, due to master moving forward, I can't use the latest parts o=
f
> the gitbuilder and automatic testing successfully (they've moved on,
> while this has stayed behind).
>=20
> Yehuda wanted me to try and NOT rebase it, for ease of his review, bu=
t
> that was no longer possible :-(.
> (tagged as wip-static-website-robbat2-master_yehuda-review-20151012 i=
n
> the dreamhost fork).
>=20
> The above, but squashed and updated to master as of 2015/12/02
> https://github.com/dreamhost/ceph/tree/wip-static-website-robbat2-mas=
ter-20151202
> It's presently running against my testsuite, and if it passes the pie=
ces
> that I know it should [1], I'll be splitting it up to submit.
>=20
> [1] I'm seeing some failures of places where I didn't touch the code,=
 so
> having to separate those out.

Thanks for the update!

Javier

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
