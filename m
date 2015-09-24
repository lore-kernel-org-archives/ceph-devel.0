From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 19:25:01 +0300
Message-ID: <560423DD.3080701@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
 <5602C48C.4010009@mirantis.com>
 <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
 <5604131E.2030408@mirantis.com>
 <alpine.DEB.2.00.1509240829540.13265@cobra.newdream.net>
 <56041D16.6060805@mirantis.com>
 <alpine.DEB.2.00.1509240900540.13265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32889 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbbIXQZH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 12:25:07 -0400
Received: by lahh2 with SMTP id h2so68679852lah.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 09:25:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509240900540.13265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 24.09.2015 19:03, Sage Weil wrote:
> On Thu, 24 Sep 2015, Igor Fedotov wrote:
>
> Dynamic stripe sizes are possible but it's a significant change from 
> the way the EC pool currently works. I would make that a separate 
> project (as its useful in its own right) and not complicate the 
> compression situation. Or, if it simplifies the compression approach, 
> then I'd make that change first. sage 
Just to clarify a bit. What I saw when played with Ceph. Please correct 
me if I'm wrong..

For low-level RADOS access client data written to EC pool has to be 
aligned with stripe size . The last block can be unaligned though but no 
more appends are permitted in this case.
Data copied from cache goes in blocks up to 8Mb size. In general case  
the last block seems to have unaligned size too.

EC pool additionally performs alignment of the incoming blocks to stripe 
bound internally. This way blocks going to EC lib are always aligned.
We should probably perform compression prior to this alignment.
Thus some dependency on stripe size is present in EC pools but it's not 
that strict.

Thanks,
Igor
