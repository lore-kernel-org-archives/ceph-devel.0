From: Samuel Just <sam.just@inktank.com>
Subject: Re: [PATCH]ECBackend: Using ROUND_UP_TO to refactor get_recovery_chunk_size()
Date: Thu, 31 Jul 2014 14:48:31 -0700
Message-ID: <CA+4uBUZcjh8NU9wKEcbuzm5pNhjJkea42+5N8acbb5sZ=dVJgQ@mail.gmail.com>
References: <6AA21C22F0A5DA478922644AD2EC308C897ED0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:54232 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaGaVsc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 17:48:32 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so2998635qaj.21
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 14:48:31 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C897ED0@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "sage@redhat.com" <sage@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Any chance you can submit this as a pull request?

On Tue, Jul 29, 2014 at 11:12 PM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
> ---
>  src/osd/ECBackend.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/src/osd/ECBackend.h b/src/osd/ECBackend.h
> index 28bcf8a..0e96407 100644
> --- a/src/osd/ECBackend.h
> +++ b/src/osd/ECBackend.h
> @@ -149,10 +149,8 @@ public:
>  private:
>    friend struct ECRecoveryHandle;
>    uint64_t get_recovery_chunk_size() const {
> -    uint64_t max = cct->_conf->osd_recovery_max_chunk;
> -    max -= max % sinfo.get_stripe_width();
> -    max += sinfo.get_stripe_width();
> -    return max;
> +    return ROUND_UP_TO(cct->_conf->osd_recovery_max_chunk,
> +                       sinfo.get_stripe_width());
>    }
>
>    /**
> --
> 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
