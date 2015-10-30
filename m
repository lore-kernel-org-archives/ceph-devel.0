From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bucket namespaces pull req. 5872
Date: Thu, 29 Oct 2015 23:30:22 -0600
Message-ID: <20151029233022.1c8ee38a@lembas.zaitcev.lan>
References: <20151014232542.1f4d6f26@guren.zaitcev.lan>
	<CA+H5UW2HhPGkPA9P+=9j2aFRCYEgdLFg=5uvg6Xkcd7sXMeYig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33051 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758295AbbJ3FaZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Oct 2015 01:30:25 -0400
In-Reply-To: <CA+H5UW2HhPGkPA9P+=9j2aFRCYEgdLFg=5uvg6Xkcd7sXMeYig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, zaitcev@redhat.com

On Mon, 26 Oct 2015 16:09:41 +0100
Radoslaw Zarzynski <rzarzynski@mirantis.com> wrote:

> Those are the reasons I=E2=80=99m behind keeping rgw_user even if the
> entire information it carries would be solely an ID string.

Okay. It felt a little obfuscatory but perhaps it's my kernel backgroun=
d talking.

> Yeah, bucket namespace is a part of account/RGWUserInfo*. Property
> =E2=80=9Chas_own_bns=E2=80=9D even now is serialized together with RG=
WUserInfo.

Very well, we're good.

> > The rgw_swift_create_account_with_bns shold go away with rgw_user.
>=20
> Option "rgw_swift_create_account_with_bns" is needed mostly due to
> integration with OpenStack (Keystone) when accounts* are automaticall=
y
> created at first access. Without the parameter you would lose ability=
 to
> tell radosgw what is more important for you: compliance with Swift AP=
I
> or previous behavior that still may be useful in some cases. Creating
> massive amount of accounts by hand might not be an option here.

I'm buying the logic here: at the time of auto-creation, we do not
possess the information about the account being auto-created wanting BN=
S
or not. Still, it feels unsatisfactory. I'd rather look into some sort
of user attributes in Keystone or whatnot. I'll investigate and report.

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

That makes sense, but it's not how I read the actual code. I'll look ag=
ain.

-- Pete
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
