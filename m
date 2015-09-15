From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: rbd lock list command failure
Date: Tue, 15 Sep 2015 08:59:00 -0700
Message-ID: <55F84044.1060605@redhat.com>
References: <1133197671.21438012.1441816007901.JavaMail.zimbra@redhat.com> <55F74BC5.1070002@inktank.com> <1409465566.23543060.1442322647959.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbbIOP7A (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Sep 2015 11:59:00 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 182A1C0AA263
	for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 15:59:00 +0000 (UTC)
In-Reply-To: <1409465566.23543060.1442322647959.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huamin Chen <hchen@redhat.com>
Cc: ceph-devel@vger.kernel.org

On 09/15/2015 06:10 AM, Huamin Chen wrote:
> Hey Josh,
>
> Indeed, from "ceph -w", I found my client got blacklisted the moment the "rbd lock" command was executed.
>
> I think this might be caused by my configuration that both Ceph OSD and rbd command are running inside the containers on the same host.

Yeah, that's probably due to this bug: http://tracker.ceph.com/issues/13032

A previously blacklisted client might end up with the same client
address as a future process due to running in containers, and librados
using the pid as part of that address.

Josh

>
> ----- Original Message -----
> From: "Josh Durgin" <josh.durgin@inktank.com>
> To: "Huamin Chen" <hchen@redhat.com>, ceph-devel@vger.kernel.org
> Sent: Monday, September 14, 2015 6:35:49 PM
> Subject: Re: rbd lock list command failure
>
> On 09/09/2015 09:26 AM, Huamin Chen wrote:
>> Hi
>>
>> Running "rbd lock list" inside a Docker container yields mixed results. Sometimes I can get the right results but most times I just get errors.
>>
>> A good run is like this:
>> [root@host server]# docker run --privileged --net=host -v /dev:/dev -v /sys:/sys ceph/base rbd lock list foo --pool kube --id kube -m host:6789 --key=AQAMgXhVwBCeDhAA9nlPaFyfUSatGD4drFWDvQ==
>> 2015-09-09 16:11:16.812858 7f3337ff5840 -1 did not load config file, using default settings.
>> There is 1 exclusive lock on this image.
>> Locker      ID                                                     Address
>> client.4333 kubelet_lock_magic_host 10.16.154.78:0/1000001
>>
>> Same commands but with error:
>> [root@host server]# docker run --privileged --net=host -v /dev:/dev -v /sys:/sys ceph/base rbd lock list foo --pool kube --id kube -m host:6789 --key=AQAMgXhVwBCeDhAA9nlPaFyfUSatGD4drFWDvQ==
>> 2015-09-09 16:11:30.430345 7f4159766840 -1 did not load config file, using default settings.
>> 2015-09-09 16:11:30.464193 7f4159766840 -1 librbd::ImageCtx: error finding header: (108) Cannot send after transport endpoint shutdown
>> rbd: error opening image foo: (108) Cannot send after transport endpoint shutdown
>
> Are you using blacklisting? That is the error that a blacklisted client
> gets from rados.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

