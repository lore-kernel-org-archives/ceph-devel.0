From: Cesar Mello <cmello@gmail.com>
Subject: Re: ListBuckets works but PutObject does not
Date: Fri, 18 Jan 2013 11:01:04 -0200
Message-ID: <CAJVE5RX+MWwjp3FFJn4jr99s87MW-cvzPRsxNBuF89==PyoOaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:48320 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab3ARNBH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 08:01:07 -0500
Received: by mail-la0-f48.google.com with SMTP id ej20so3771110lab.7
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 05:01:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've noticed the ListBuckets sample sends an http request to the URL
ubuntu1, which works. (ubuntu1 is the host name of the apache
machine). But the PutBucket sample sends an http request to
'my-new-mucket.ubuntu1', and this does not get resolved. So I'm
currently investigating the apache config.

(I'm a Windows guy not very used to apache and Linux, sorry).

Any suggestions are appreciated, but I'm sure I can work out this
before my vacation ends. :-)

Best regards
Cesar

On Fri, Jan 18, 2013 at 10:05 AM, Cesar Mello <cmello@gmail.com> wrote:
> Hi,
>
> Just in case someone sees some obvious mistake of mine...
>
> I have setup an S3 gateway and it seems to be running fine. I'm trying
> the samples from the API documentation for C# [1]. The connection and
> authentication is working successfully. The ListBuckets sample works
> and the response is OK. But when I try the PutBucket sample, the SDK
> times out after 3 retries.
>
> I'll keep investigating, but any suggestion is welcome.
>
> Thank you a lot for the attention.
>
> Best regards
> Cesar
>
> [1] http://ceph.com/docs/master/radosgw/s3/csharp/
