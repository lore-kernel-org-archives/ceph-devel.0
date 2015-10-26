From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Bucket namespaces pull req. 5872
Date: Mon, 26 Oct 2015 16:09:41 +0100
Message-ID: <CA+H5UW2HhPGkPA9P+=9j2aFRCYEgdLFg=5uvg6Xkcd7sXMeYig@mail.gmail.com>
References: <20151014232542.1f4d6f26@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36105 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbbJZPJn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 11:09:43 -0400
Received: by wicfx6 with SMTP id fx6so118658235wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2015 08:09:42 -0700 (PDT)
In-Reply-To: <20151014232542.1f4d6f26@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

Hello Pete,

Thank you for your review and sorry for very late response.

> The most important in my mind is: why use rgw_user?

You are completely right, rgw_user isn=E2=80=99t necessary for BNS. I p=
reserved
it because of type-correctness. Having separate language type for basic
entities makes code easier to understand and extend in future. This tra=
it
could be particularly important if Yehuda decide to implement multi-
tenancy. Those are the reasons I=E2=80=99m behind keeping rgw_user even=
 if the
entire information it carries would be solely an ID string.

> I think, the information about a user should contain the user's bucke=
t namespace,
> but the user's label does not need to have it. So, RGWUserInfo should=
 have the
> bucket namespace name (and possibly has_own_bns)

Yeah, bucket namespace is a part of account/RGWUserInfo*. Property
=E2=80=9Chas_own_bns=E2=80=9D even now is serialized together with RGWU=
serInfo.
It=E2=80=99s passed as a part of rgw_user in order to skip reworking si=
gnatures
of many functions and methods. However, I would say that in the end
it=E2=80=99s worth to perform such refactoring and thus have rgw_user c=
leaned.
I will work on that.

> Less importantly, I do not like the generosity with knobs.

Me too, but sometimes introduction of configuration parameter is
necessary to not enforce new behavior that may break backward
compatibility.

> The rgw_swift_create_account_with_bns shold go away with rgw_user.

Option "rgw_swift_create_account_with_bns" is needed mostly due to
integration with OpenStack (Keystone) when accounts* are automatically
created at first access. Without the parameter you would lose ability t=
o
tell radosgw what is more important for you: compliance with Swift API
or previous behavior that still may be useful in some cases. Creating
massive amount of accounts by hand might not be an option here.

> The rgw_swift_account_in_url should be possible to incorporate
> in a compatible fashion (it does not add an extra next_tok()).

According to "rgw_swift_account_in_url": I don=E2=80=99t see viable met=
hod for
deducing whether two tokens in URL refer to 1) account and bucket or
2) bucket and object. Of course, we may apply some kind of heuristic
like scanning the first token for auth prefix (eg. =E2=80=9CAUTH_=E2=80=
=9D, =E2=80=9CKEY_=E2=80=9D) but
this would introduce limitations on bucket naming.

> - Is it just me, or do encoding and decoding of RGWUserInfo do
>   not match?  Decoding appears to make provision for wip-5073,
>   which we may not even need.

I'm not sure whether I understood you correctly. Serialization of buffe=
rlist
is versioned and we provide code to support previous versions. However,
in the case of removing "tenant" (if we decide it's desired at the mome=
nt),
touching original commits of wip-5073 in order to simply avoid adding i=
t
might be better.

> - The --own-bucket-namespace should not be a boolean, but the
>   namespace's name.

We may switch to this behavior if we think there are some use cases
which could be covered with such transition. From technical point of
view this is not a problem.

Best regards,
Radoslaw Zarzynski

* in the context of radosgw under term "account" I understand some part=
s
of RGWUserInfo and bucket index.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
