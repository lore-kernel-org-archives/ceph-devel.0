From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bucket namespaces pull req. 5872
Date: Sun, 29 Nov 2015 23:39:17 -0700
Message-ID: <20151129233917.7003967b@lembas.zaitcev.lan>
References: <20151014232542.1f4d6f26@guren.zaitcev.lan>
	<CA+H5UW2HhPGkPA9P+=9j2aFRCYEgdLFg=5uvg6Xkcd7sXMeYig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbbK3GjS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Nov 2015 01:39:18 -0500
In-Reply-To: <CA+H5UW2HhPGkPA9P+=9j2aFRCYEgdLFg=5uvg6Xkcd7sXMeYig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

On Mon, 26 Oct 2015 16:09:41 +0100
Radoslaw Zarzynski <rzarzynski@mirantis.com> wrote:

> > The rgw_swift_account_in_url should be possible to incorporate
> > in a compatible fashion (it does not add an extra next_tok()).
>=20
> According to "rgw_swift_account_in_url": I don=E2=80=99t see viable m=
ethod for
> deducing whether two tokens in URL refer to 1) account and bucket or
> 2) bucket and object. Of course, we may apply some kind of heuristic
> like scanning the first token for auth prefix (eg. =E2=80=9CAUTH_=E2=80=
=9D, =E2=80=9CKEY_=E2=80=9D) but
> this would introduce limitations on bucket naming.

I thought a bit more about this and I want to backtrack on my agreement=
=2E
Your reasoning would be sound if we did not know the format of the
incoming URL ahead of time. Indeed there's no telling if it's
/account/bucket or /bucket/object. But actually we do have that knowled=
ge,
because it's the URL that we gave to the client when it authenticated!

There may be an exception, namely if a client gets a token across a clu=
ster
upgrade. For a while we should recognize old tokens and thus old Storag=
eURL
formats. This makes me think that the kind of path parsing could be a
parameter hidden in the token somewhere.

Anyhow, rather than speculate about it, I'm going to put together a pat=
ch
to go on top of current WIP 5073 and then you'll see what I mean.

-- Pete
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
