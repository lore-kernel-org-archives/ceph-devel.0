From: Maxim Mikheev <mikhmv@gmail.com>
Subject: Re: Ceph copy-on-write
Date: Fri, 04 Nov 2011 16:39:53 -0400
Message-ID: <4EB44D99.2070803@gmail.com>
References: <4EB35754.1040506@gmail.com> <CAORUGqAUW4Z-+KmfBwxXTpdsF+T52HrPuQuQzcSuA9Z=UA7DyQ@mail.gmail.com> <4EB43E4A.5050001@gmail.com> <CAORUGqA-mc399rQPwx0DyEMikMRszWGJijpgBw-7dPeMJEi0gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38645 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab1KDUj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 16:39:58 -0400
Received: by vcbf1 with SMTP id f1so746922vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 13:39:58 -0700 (PDT)
In-Reply-To: <CAORUGqA-mc399rQPwx0DyEMikMRszWGJijpgBw-7dPeMJEi0gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thanks, 

Upgrade from 0.34 to 0.37 was not smooth. I was have to clean all 
disks. But new version is working well

On Fri 04 Nov 2011 03:54:42 PM EDT, Tommi Virtanen wrote:
> On Fri, Nov 4, 2011 at 12:34, Maxim Mikheev<mikhmv@gmail.com>  wrote:
>> I have another question. Looks like repository version 0.37 for ubuntu
>> oneric has brocken dependencies
>> for ceph-client-tools.
>> Can you advice how can I install it?
>
> v0.37 renamed ceph-client-tools to ceph-common. Unfortunately, we
> didn't test the upgrade path, and the new ceph-common package doesn't
> replace ceph-client-tools automatically (this was fixed in
> ee34e09c6129297b3c4e9405138a4e3807d47118). You can remove
> ceph-client-tools manually, to get the upgrade to complete.
