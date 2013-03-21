From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 26/39] mds: issue caps when lock state in replica become SYNC
Date: Wed, 20 Mar 2013 17:52:13 -0700
Message-ID: <CAPYLRzgo=M79LVVRO5+aasvNtjaNxnyKQbs0Guumpo1PjTkLKw@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-27-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:44723 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab3CUAwO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 20:52:14 -0400
Received: by mail-we0-f181.google.com with SMTP id p43so1889983wea.12
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 17:52:13 -0700 (PDT)
In-Reply-To: <1363531902-24909-27-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> because client can request READ caps from non-auth MDS.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Locker.cc | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
> index 4d45f99..28920d4 100644
> --- a/src/mds/Locker.cc
> +++ b/src/mds/Locker.cc
> @@ -4403,6 +4403,8 @@ void Locker::handle_file_lock(ScatterLock *lock, MLock *m)
>      lock->set_state(LOCK_SYNC);
>
>      lock->get_rdlock();
> +    if (caps)
> +      issue_caps(in);
>      lock->finish_waiters(SimpleLock::WAIT_RD|SimpleLock::WAIT_STABLE);
>      lock->put_rdlock();
>      break;
> --
> 1.7.11.7
>
