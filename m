From: Wido den Hollander <wido@widodh.nl>
Subject: Re: mount: 10.0.6.10:/: can't read superblock
Date: Tue, 05 Jun 2012 20:14:48 +0200
Message-ID: <4FCE4C98.8020101@widodh.nl>
References: <bf905afe-88fc-4185-aa06-febe1d08e4f4@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:35888 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651Ab2FESOv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 14:14:51 -0400
In-Reply-To: <bf905afe-88fc-4185-aa06-febe1d08e4f4@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Martin,

On 06/05/2012 08:07 PM, Martin Wilderoth wrote:
> Hello
>
> Is there a way to recover this error.
>
> mount -t ceph 10.0.6.10:/ /mnt -vv -o name=admin,secret=XXXXXXXXXXXXXXXXXXXXXXX
> [  506.640433] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6)
> [  506.650594] ceph: loaded (mds proto 32)
> [  506.652353] libceph: client0 fsid a9d5f9e1-4bb9-4fab-b79b-ba4457631b01
> [  506.670876] Intel AES-NI instructions are not detected.
> [  506.678861] libceph: mon0 10.0.6.10:6789 session established
> mount: 10.0.6.10:/: can't read superblock
>

Could you share some more information? For example the output from: ceph -s

Did you change anything to the cluster since it worked? And what version 
are you running?

> One of my mds logs has 24G of data.

Is it still running?

>
> I have some rbd devices that I would like to keep.

RBD doesn't use the MDS nor the POSIX filesystem, so you will probably 
be fine, but we need the output of "ceph -s" first.

Does this work?
$ rbd ls
$ rados -p rbd ls

Wido

>
> /Regards Martin
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
