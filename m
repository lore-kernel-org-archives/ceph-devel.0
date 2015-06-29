From: Harshal Gupta <harshal.gupta001@gmail.com>
Subject: Re: Error Messages in S3 API calls
Date: Mon, 29 Jun 2015 22:35:12 +0530
Message-ID: <CAPRac-awN3mfwVmjgRCge0zS95Ff0bqMSyfwGA+49JzdF9Kjrw@mail.gmail.com>
References: <CAPRac-aU_W7uV-L_HQrz_uy1Je4t65AeGf+VO6avbnwnuwzKoQ@mail.gmail.com>
 <CAPRac-ZXhhWhMAs93VgjJfDpC_C8boAZ2+SwfYN9TiF0bwU44w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33344 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbF2RFb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 13:05:31 -0400
Received: by igcur8 with SMTP id ur8so42210992igc.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 10:05:31 -0700 (PDT)
In-Reply-To: <CAPRac-ZXhhWhMAs93VgjJfDpC_C8boAZ2+SwfYN9TiF0bwU44w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have raised a pull request as there is not a major code change. You
can check the code here :

https://github.com/ceph/ceph/pull/5101

On Mon, Jun 29, 2015 at 10:23 PM, Harshal Gupta
<harshal.gupta001@gmail.com> wrote:
> Hi,
> AWS S3 provides descriptive error messages in xml body whenever
> there is an error wile making a REST API call. (e.g. in case of
> BucketNotFound; there is message "The bucket you tried to delete is
> not empty.") which helps the end user who are non technical to
> understand what went wrong.
> Such Error messages are not there in RGW.
>
> Also S3 provides a request id in XML body for each error response.
> This id can be used for debugging purposes.This is already implemented
> as "Trans_id" in master branch.
>
> Since many applications parse XML body for information, It will be
> beneficial to add both of these in xml error response.
>
> I am going to add those in error response. Please share your thoughts about it.
>
> Thanks
> --
> HARSHAL GUPTA
> Software Engineer
> Rilance JioCloud



-- 
HARSHAL GUPTA
Software Engineer
Rilance JioCloud
