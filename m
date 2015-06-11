From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Multipart Upload : Limit on no of parts
Date: Thu, 11 Jun 2015 12:15:12 -0400 (EDT)
Message-ID: <1525576271.13174633.1434039312262.JavaMail.zimbra@redhat.com>
References: <CAGoDY9mQJLW99FvNP-JrM-NGHs3k=Fn9BGJBpXRHFvwP5xg=HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:49927 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbFKQPO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jun 2015 12:15:14 -0400
In-Reply-To: <CAGoDY9mQJLW99FvNP-JrM-NGHs3k=Fn9BGJBpXRHFvwP5xg=HQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Dixit <dixitabhi@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Abhishek Dixit" <dixitabhi@gmail.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, June 11, 2015 8:28:14 AM
> Subject: Multipart Upload : Limit on no of parts
> 
> Hi,
> 
> I was looking into limit imposed on no of uploads for multipart upload.
> The way it works currently seems as below:
> 1. RGWCompleteMultipart::get_params does following
> ______________________________________________
> #define COMPLETE_MULTIPART_MAX_LEN (1024 * 1024) /* api defines max
> 10,000 parts, this should be enough */
>    ret = rgw_rest_read_all_input(s, &data, &len, COMPLETE_MULTIPART_MAX_LEN);
> ___________________________________________________________
> 
> 2. rgw_rest_read_all_input compares cl with max_len where
> cl is Content Length value from POST multipart complete request header and
> max_len is COMPLETE_MULTIPART_MAX_LEN as defined above.
> 
> 3. For chunked input, again the length read is compared with
> COMPLETE_MULTIPART_MAX_LEN.
> 
> For 10104 parts POST request, we had cl:1039762 and max_len:1048576
> which worked.
> Limit on no of parts seems to be imposed by this mechanism rather than
> an explicit parts check.
> 
> Kindly let me know if the understanding is correct.
> In case it is, should we not impose a limit via explicit checking for
> total no of parts?
> Also, can we make this parts limit a configurable option via config_opts?
> 

I thought we had an explicit check for that, but I can't really find it, so I might have gotten it wrong. We should enforce some limit on that number. First, the way we index the parts in the omap assumes a certain max so it pads the keys with a specific amount of zeros. Second, in the case where users are uploading parts with different sizes, the created manifest will be too large. Is there a real need to have more than 10k parts?

Yehuda
