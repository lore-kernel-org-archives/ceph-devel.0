From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Bucket namespaces pull req. 5872
Date: Mon, 26 Oct 2015 19:29:33 +0100
Message-ID: <CA+H5UW1yK=+s8RTkYSSqA_TqgF7Rft87F+YQ3rOw7NanjL2B0Q@mail.gmail.com>
References: <20151014232542.1f4d6f26@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36812 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbbJZS3g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 14:29:36 -0400
Received: by wicfx6 with SMTP id fx6so127112868wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2015 11:29:34 -0700 (PDT)
In-Reply-To: <20151014232542.1f4d6f26@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Pete Zaitcev <zaitcev@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Another thing worth discussion is the relation between bucket
namespaces and multi-tenancy. I understand MT as a mean to
provide grouping and separation between user IDs while BNS
does the same but in the domain of bucket names. In that sense
both things are perfectly orthogonal.

PR #5872 contains more than plain BNS. It also splits account
owner from identity used to authorize a given operation. Since
now an authentication subsystem (eg. Keystone or the internal,
RADOS-based one) need to set three basic things in req_state:
account owner (req_state::user), authentication identify used by
the verify_permission() methods (req_state::auth_user) and level
of permission (req_state::perm_mask). It also may create new
account (RGWUserInfo) if necessary.

Choice of identifiers in req_state::user and rgw_user::auth_user
is delegated to specific authentication subsystem. One could set
both to the same value while other might decide to differentiate
them and reflect state of some external source-of-truth (Keystone).
However, core of rgw doesn't need to care nor even be aware about
multi-tenancy.

From my understanding wip-5073 implements the tenant concept
at the core layer.

Best regards,
Radoslaw Zarzynski


On Thu, Oct 15, 2015 at 7:25 AM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> I took a decent look at the pull request 5872
>   https://github.com/ceph/ceph/pull/5872
> It implements something called "bucket namespaces": a way to make
> buckets qualified with a prefix that permits different users use
> buckets with the same name.
>
> I think I like the idea overall, but the implementation raises
> some questions. The most important in my mind is: why use rgw_user?
>
> In the wip-5073, rgw_user is needed because tenant there adds
> a namespace both to users and buckets. But here, users are not
> in a namespace, only buckets are. Or at least that's what I see
> in the code, please set me straight if I'm wrong.
>
> Conceptually, the user name is just a label, and this patch keeps
> those labels compatible. I think, the information about a user
> should contain the user's bucket namespace, but the user's label
> does not need to have it. So, RGWUserInfo should have the bucket
> namespace name (and possibly has_own_bns), and rgw_user is superfluous.
>
> If we could get rid of rgw_user, I would be onboard with this.
>
> Less importantly, I do not like the generosity with knobs.
> The rgw_swift_create_account_with_bns shold go away with rgw_user.
> The rgw_swift_account_in_url should be possible to incorporate
> in a compatible fashion (it does not add an extra next_tok()).
> The rgw_keystone_accepted_admin_roles... okay, that one might
> be needed. Swift has an equivalent of it.
>
> Finally, there are some miniscule technical issues.
>  - Is it just me, or do encoding and decoding of RGWUserInfo do
>    not match?  Decoding appears to make provision for wip-5073,
>    which we may not even need.
>  - The --own-bucket-namespace should not be a boolean, but the
>    namespace's name.
>  - There's some junk imported from wip-5073; I'll work on cleaning
>    that up.
>
> -- Pete
