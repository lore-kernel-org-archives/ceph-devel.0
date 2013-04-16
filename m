From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] radosgw: receiving unexpected error code while accessing
 an non-existing object by authorized not-owner user
Date: Tue, 16 Apr 2013 08:11:35 -0700
Message-ID: <CABBk=J9XPt6no=rF5fMf7HvixrUEzZbB6qNuJiEnV2-A=QcyCQ@mail.gmail.com>
References: <1366102515-10136-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:59545 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab3DPPLg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 11:11:36 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so516850veb.12
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 08:11:35 -0700 (PDT)
In-Reply-To: <1366102515-10136-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

On Tue, Apr 16, 2013 at 1:55 AM, Li Wang <liwang@ubuntukylin.com> wrote:
> This patch fixes a bug in radosgw swift compatibility code,
> that is, if a not-owner but authorized user access a non-existing
> object in a container, he wiil receive unexpected error code,
> to repeat this bug, do the following steps,
>
> 1 User1 creates a container, and grants the read/write permission to user2
>
> curl -X PUT -i -k -H "X-Auth-Token: $user1_token" $url/$container
> curl -X POST -i -k -H "X-Auth-Token: $user1_token" -H "X-Container-Read:
> $user2" -H "X-Container-Write: $user2" $url/$container
>
> 2 User2 queries the object 'obj' in the newly created container
> by using HEAD instruction, note the container currently is empty
>
> curl -X HEAD -i -k -H "X-Auth-Token: $user2_token" $url/$container/obj
>
> 3 The response received by user2 is '401 Authorization Required',
> rather than the expected '404 Not Found', the details are as follows,
>
> HTTP/1.1 401 Authorization Required
> Date: Tue, 16 Apr 2013 01:52:49 GMT
> Server: Apache/2.2.22 (Ubuntu)
> Accept-Ranges: bytes
> Content-Length: 12
> Vary: Accept-Encoding
> Content-Type: text/plain; charset=utf-8
>
> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> ---
>  src/rgw/rgw_acl.cc    |   11 +++++++++--
>  src/rgw/rgw_common.cc |   22 ++--------------------
>  2 files changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/src/rgw/rgw_acl.cc b/src/rgw/rgw_acl.cc
> index 1a90649..a27feec 100644
> --- a/src/rgw/rgw_acl.cc
> +++ b/src/rgw/rgw_acl.cc
> @@ -93,6 +93,13 @@ int RGWAccessControlPolicy::get_perm(string& id, int perm_mask) {
>  bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask, int perm)
>  {
>    int test_perm = perm;
> +
> +  if (test_perm & (RGW_PERM_READ | RGW_PERM_READ_ACP)) {
> +    test_perm |= RGW_PERM_READ_OBJS;
> +  }
> +  if (test_perm & (RGW_PERM_WRITE | RGW_PERM_WRITE_ACP)) {
> +    test_perm |= RGW_PERM_WRITE_OBJS;
> +  }
>
>    int policy_perm = get_perm(uid, test_perm);
>
> @@ -101,10 +108,10 @@ bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask,
>       buckets, so the swift READ permission on bucket will allow listing
>       the bucket content */
>    if (policy_perm & RGW_PERM_WRITE_OBJS) {
> -    policy_perm |= (RGW_PERM_WRITE | RGW_PERM_WRITE_ACP);
> +    policy_perm |= (RGW_PERM_WRITE | RGW_PERM_WRITE_ACP) & perm;
>    }
>    if (policy_perm & RGW_PERM_READ_OBJS) {
> -    policy_perm |= (RGW_PERM_READ | RGW_PERM_READ_ACP);
> +    policy_perm |= (RGW_PERM_READ | RGW_PERM_READ_ACP) & perm;
>    }
>
>    int acl_perm = policy_perm & user_perm_mask;
> diff --git a/src/rgw/rgw_common.cc b/src/rgw/rgw_common.cc
> index d9c0a80..7b5b6c0 100644
> --- a/src/rgw/rgw_common.cc
> +++ b/src/rgw/rgw_common.cc
> @@ -515,14 +515,6 @@ bool verify_bucket_permission(struct req_state *s, int perm)
>    if ((perm & (int)s->perm_mask) != perm)
>      return false;
>
> -  if (s->bucket_acl->verify_permission(s->user.user_id, perm, perm))
> -    return true;
> -
> -  if (perm & (RGW_PERM_READ | RGW_PERM_READ_ACP))
> -    perm |= RGW_PERM_READ_OBJS;
> -  if (perm & RGW_PERM_WRITE)
> -    perm |= RGW_PERM_WRITE_OBJS;
> -
>    return s->bucket_acl->verify_permission(s->user.user_id, perm, perm);
>  }
>
> @@ -540,18 +532,8 @@ bool verify_object_permission(struct req_state *s, RGWAccessControlPolicy *bucke
>
>    if ((perm & (int)s->perm_mask) != perm)
>      return false;
> -
> -  int swift_perm = 0;
> -  if (perm & (RGW_PERM_READ | RGW_PERM_READ_ACP))
> -    swift_perm |= RGW_PERM_READ_OBJS;
> -  if (perm & RGW_PERM_WRITE)
> -    swift_perm |= RGW_PERM_WRITE_OBJS;
> -
> -  if (!swift_perm)
> -    return false;
> -  /* we already verified the user mask above, so we pass swift_perm as the mask here,
> -     otherwise the mask might not cover the swift permissions bits */
> -  return bucket_acl->verify_permission(s->user.user_id, swift_perm, swift_perm);
> +
> +  return bucket_acl->verify_permission(s->user.user_id, s->perm_mask, perm);

At this point we're interested at the READ_OBJS/WRITE_OBJS bits, but
you're passing here the raw perm mask. So basically if a user have a
bucket READ permission it'll be able to read all the objects in the
bucket. We don't want that, this should only be possible if a user has
READ_OBJS bit set on the bucket.

>  }
>
>  bool verify_object_permission(struct req_state *s, int perm)
> --

The actual problem is in read_policy() where we forget about the swift
ACLs, and only check for the bucket's READ bit. Maybe fix the problem
there?

Yehuda
