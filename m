From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 1/2] mds: pass proper mask to CInode::get_caps_issued
Date: Wed, 17 Apr 2013 14:58:35 -0700
Message-ID: <CAPYLRzihT+vX=fO2rfMCRFpptunrXiHq-PcqFUsgTH2xf+9kTw@mail.gmail.com>
References: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
	<1365754273-14088-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:55365 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966803Ab3DQV6g convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 17:58:36 -0400
Received: by mail-qa0-f50.google.com with SMTP id dx4so1163980qab.16
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 14:58:35 -0700 (PDT)
In-Reply-To: <1365754273-14088-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Elder <elder@inktank.com>

This looks good to me, and I got Sage to review the second patch as
well. These are both merged into the next branch =97 thanks!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Apr 12, 2013 at 1:11 AM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> There is a total of 22 cap bits and file lock uses 8 cap bits.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CInode.h  | 4 ++--
>  src/mds/Locker.cc | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/src/mds/CInode.h b/src/mds/CInode.h
> index 43af9c4..a3fe3cf 100644
> --- a/src/mds/CInode.h
> +++ b/src/mds/CInode.h
> @@ -736,9 +736,9 @@ public:
>
>    // caps issued, wanted
>    int get_caps_issued(int *ploner =3D 0, int *pother =3D 0, int *pxl=
ocker =3D 0,
> -                     int shift =3D 0, int mask =3D 0xffff);
> +                     int shift =3D 0, int mask =3D -1);
>    bool is_any_caps_wanted();
> -  int get_caps_wanted(int *ploner =3D 0, int *pother =3D 0, int shif=
t =3D 0, int mask =3D 0xffff);
> +  int get_caps_wanted(int *ploner =3D 0, int *pother =3D 0, int shif=
t =3D 0, int mask =3D -1);
>    bool issued_caps_need_gather(SimpleLock *lock);
>    void replicate_relax_locks();
>
> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
> index 7ba9f44..f86ba88 100644
> --- a/src/mds/Locker.cc
> +++ b/src/mds/Locker.cc
> @@ -616,7 +616,8 @@ void Locker::eval_gather(SimpleLock *lock, bool f=
irst, bool *pneed_issue, list<C
>
>    int loner_issued =3D 0, other_issued =3D 0, xlocker_issued =3D 0;
>    if (caps && in->is_head()) {
> -    in->get_caps_issued(&loner_issued, &other_issued, &xlocker_issue=
d, lock->get_cap_shift(), 3);
> +    in->get_caps_issued(&loner_issued, &other_issued, &xlocker_issue=
d,
> +                       lock->get_cap_shift(), lock->get_cap_mask());
>      dout(10) << " next state is " << lock->get_state_name(next)
>              << " issued/allows loner " << gcap_string(loner_issued)
>              << "/" << gcap_string(lock->gcaps_allowed(CAP_LONER, nex=
t))
> --
> 1.7.11.7
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
