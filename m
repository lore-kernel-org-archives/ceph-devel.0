From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd lock list command failure
Date: Mon, 14 Sep 2015 15:35:49 -0700
Message-ID: <55F74BC5.1070002@inktank.com>
References: <1133197671.21438012.1441816007901.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34669 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbINWf5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 18:35:57 -0400
Received: by qkfq186 with SMTP id q186so64764068qkf.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2015 15:35:57 -0700 (PDT)
In-Reply-To: <1133197671.21438012.1441816007901.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huamin Chen <hchen@redhat.com>, ceph-devel@vger.kernel.org

On 09/09/2015 09:26 AM, Huamin Chen wrote:
> Hi
>
> Running "rbd lock list" inside a Docker container yields mixed results. Sometimes I can get the right results but most times I just get errors.
>
> A good run is like this:
> [root@host server]# docker run --privileged --net=host -v /dev:/dev -v /sys:/sys ceph/base rbd lock list foo --pool kube --id kube -m host:6789 --key=AQAMgXhVwBCeDhAA9nlPaFyfUSatGD4drFWDvQ==
> 2015-09-09 16:11:16.812858 7f3337ff5840 -1 did not load config file, using default settings.
> There is 1 exclusive lock on this image.
> Locker      ID                                                     Address
> client.4333 kubelet_lock_magic_host 10.16.154.78:0/1000001
>
> Same commands but with error:
> [root@host server]# docker run --privileged --net=host -v /dev:/dev -v /sys:/sys ceph/base rbd lock list foo --pool kube --id kube -m host:6789 --key=AQAMgXhVwBCeDhAA9nlPaFyfUSatGD4drFWDvQ==
> 2015-09-09 16:11:30.430345 7f4159766840 -1 did not load config file, using default settings.
> 2015-09-09 16:11:30.464193 7f4159766840 -1 librbd::ImageCtx: error finding header: (108) Cannot send after transport endpoint shutdown
> rbd: error opening image foo: (108) Cannot send after transport endpoint shutdown

Are you using blacklisting? That is the error that a blacklisted client
gets from rados.
