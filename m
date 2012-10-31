From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Unable to Start Ceph service
Date: Wed, 31 Oct 2012 15:35:42 -0700
Message-ID: <5091A7BE.2050106@inktank.com>
References: <CAGfy=6m7yJwVzVuFCZrHqe8tvcnYvkU7w7rieZuo4s7duQV5gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55878 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab2JaWfp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 18:35:45 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1278327pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 15:35:45 -0700 (PDT)
In-Reply-To: <CAGfy=6m7yJwVzVuFCZrHqe8tvcnYvkU7w7rieZuo4s7duQV5gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

I've had a long private thread with Hemant, and I believe he's past this 
problem (in case anyone scans archives looking for open questions).
Hemant, it would be best to keep the thread on ceph-devel; you get more 
people looking and answering.

It's a mystery, still, how /usr/bin/ceph-osd ended up being a directory.

On 10/30/2012 05:59 AM, hemant surale wrote:
> Hi All,
>     I am building ceph from sourcecode availavle from site. I executeed
> all steps for building it , executed "mkcephfs" as well the only
> problem is as shown below.
>
>
> ------------------------------------------------------------------------------------------------------------
> root@atish-virtual-machine:~/ceph# service ceph start
> === mon.alpha ===
> Starting Ceph mon.alpha on atish-virtual-machine...
> bash: /usr/bin/ceph-mon: Is a directory
> failed: ' /usr/bin/ceph-mon -i alpha --pid-file
> /var/run/ceph/mon.alpha.pid -c /etc/ceph/ceph.conf '
> -----------------------------------------------------------------------------------------------------------------------
