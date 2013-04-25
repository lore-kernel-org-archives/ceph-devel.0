From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH v4] radosgw: receiving unexpected error code while
 accessing an non-existing object by authorized not-owner user
Date: Thu, 25 Apr 2013 13:16:11 -0700
Message-ID: <CABBk=J_u1QbNAQgA14MWF8rYLLNxc0jg0Qmyu-PBOz-vEW5pZA@mail.gmail.com>
References: <1366904216-7097-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:53354 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab3DYUQN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 16:16:13 -0400
Received: by mail-vc0-f169.google.com with SMTP id gd11so3258061vcb.28
        for <ceph-devel@vger.kernel.org>; Thu, 25 Apr 2013 13:16:12 -0700 (PDT)
In-Reply-To: <1366904216-7097-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

On Thu, Apr 25, 2013 at 8:36 AM, Li Wang <liwang@ubuntukylin.com> wrote:
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
>
> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>
> ---
>  src/rgw/rgw_acl.cc    |    4 ++--
>  src/rgw/rgw_common.cc |    8 --------
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/src/rgw/rgw_acl.cc b/src/rgw/rgw_acl.cc
> index 1a90649..6357d4b 100644
> --- a/src/rgw/rgw_acl.cc
> +++ b/src/rgw/rgw_acl.cc
> @@ -92,7 +92,7 @@ int RGWAccessControlPolicy::get_perm(string& id, int perm_mask) {
>
>  bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask, int perm)
>  {
> -  int test_perm = perm;
> +  int test_perm = perm | RGW_PERM_READ_OBJS | RGW_PERM_WRITE_OBJS;
>
>    int policy_perm = get_perm(uid, test_perm);
>
> @@ -107,7 +107,7 @@ bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask,
>      policy_perm |= (RGW_PERM_READ | RGW_PERM_READ_ACP);
>    }
>
> -  int acl_perm = policy_perm & user_perm_mask;
> +  int acl_perm = policy_perm & perm & user_perm_mask;
>
>    ldout(cct, 10) << " uid=" << uid << " requested perm (type)=" << perm << ", policy perm=" << policy_perm << ", user_perm_mask=" << user_perm_mask << ", acl perm=" << acl_perm << dendl;
>
> diff --git a/src/rgw/rgw_common.cc b/src/rgw/rgw_common.cc
> index d9c0a80..2cd4e6f 100644
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

Looks good, merged into next.

Thanks,
Yehuda
