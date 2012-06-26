From: Dan Mick <dan.mick@inktank.com>
Subject: Re: How to delete a mds?
Date: Mon, 25 Jun 2012 17:13:09 -0700
Message-ID: <4FE8FE95.1030008@inktank.com>
References: <CAPud5_4V=7U+OsVy7cyTwW3_dU8cEBhjw1bpEtM75WczyYvCqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42886 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757958Ab2FZANM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 20:13:12 -0400
Received: by dady13 with SMTP id y13so6019962dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 17:13:12 -0700 (PDT)
In-Reply-To: <CAPud5_4V=7U+OsVy7cyTwW3_dU8cEBhjw1bpEtM75WczyYvCqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

This is a stupid question, but, did you stop and restart the cluster 
after editing ceph.conf?

On 06/25/2012 05:09 PM, Nick Bartos wrote:
> We decided to stop using the posix filesystem, and as such have
> stopped running ceph-mds (and removed the mds things from ceph.conf).
> However we get warnings about the missing mds when running 'ceph
> health'.
>
> How do I delete all the mdses?  I tried 'ceph mds rm<mdsname>' but
> that doesn't seem to do any good.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
