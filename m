From: Abhishek Dixit <dixitabhi@gmail.com>
Subject: Multipart Upload : Limit on no of parts
Date: Thu, 11 Jun 2015 20:58:14 +0530
Message-ID: <CAGoDY9mQJLW99FvNP-JrM-NGHs3k=Fn9BGJBpXRHFvwP5xg=HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36186 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbFKP2f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jun 2015 11:28:35 -0400
Received: by pablj1 with SMTP id lj1so2139178pab.3
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2015 08:28:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I was looking into limit imposed on no of uploads for multipart upload.
The way it works currently seems as below:
1. RGWCompleteMultipart::get_params does following
______________________________________________
#define COMPLETE_MULTIPART_MAX_LEN (1024 * 1024) /* api defines max
10,000 parts, this should be enough */
   ret = rgw_rest_read_all_input(s, &data, &len, COMPLETE_MULTIPART_MAX_LEN);
___________________________________________________________

2. rgw_rest_read_all_input compares cl with max_len where
cl is Content Length value from POST multipart complete request header and
max_len is COMPLETE_MULTIPART_MAX_LEN as defined above.

3. For chunked input, again the length read is compared with
COMPLETE_MULTIPART_MAX_LEN.

For 10104 parts POST request, we had cl:1039762 and max_len:1048576
which worked.
Limit on no of parts seems to be imposed by this mechanism rather than
an explicit parts check.

Kindly let me know if the understanding is correct.
In case it is, should we not impose a limit via explicit checking for
total no of parts?
Also, can we make this parts limit a configurable option via config_opts?

Thanks
Abhishek Dixit
