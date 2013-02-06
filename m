From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/3] ceph-test.install: updated filelist
Date: Wed, 06 Feb 2013 01:17:06 -0800
Message-ID: <51121F92.3070001@inktank.com>
References: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de> <1359998564-27004-4-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:40628 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab3BFJRO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 04:17:14 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so676625pad.35
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 01:17:14 -0800 (PST)
In-Reply-To: <1359998564-27004-4-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

This one looks good independent of the renaming.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/04/2013 09:22 AM, Danny Al-Gaaf wrote:
> Don't install rest-bench twice, it's already part of the rest-bench package.
>
> Add some files which are part of the ceph-test package on RPM based
> distributions already: ceph_test_mon_workloadgen, ceph_rgw_jsonparser,
> ceph_test_objectcacher_stress.
>
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>   debian/ceph-test.install | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/debian/ceph-test.install b/debian/ceph-test.install
> index bc5137b..a3648c3 100644
> --- a/debian/ceph-test.install
> +++ b/debian/ceph-test.install
> @@ -5,8 +5,8 @@ usr/bin/ceph_multi_stress_watch
>   usr/bin/ceph_omapbench
>   usr/bin/ceph_psim
>   usr/bin/ceph_radosacl
> -usr/bin/ceph_rest-bench
>   usr/bin/ceph_rgw_multiparser
> +usr/bin/ceph_rgw_jsonparser
>   usr/bin/ceph_scratchtool
>   usr/bin/ceph_scratchtoolpp
>   usr/bin/ceph_smalliobench
> @@ -31,8 +31,10 @@ usr/bin/ceph_test_keyvaluedb_iterators
>   usr/bin/ceph_test_libcephfs
>   usr/bin/ceph_test_librbd
>   usr/bin/ceph_test_librbd_fsx
> +usr/bin/ceph_test_mon_workloadgen
>   usr/bin/ceph_test_mutate
>   usr/bin/ceph_test_object_map
> +usr/bin/ceph_test_objectcacher_stress
>   usr/bin/ceph_test_rados_api_aio
>   usr/bin/ceph_test_rados_api_cls
>   usr/bin/ceph_test_rados_api_io
>

