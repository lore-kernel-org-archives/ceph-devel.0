From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Status of Fencing
Date: Fri, 14 Sep 2012 17:28:50 -0700
Message-ID: <5053CBC2.1050406@inktank.com>
References: <CA+jddaNnQAaQ0cT5-0OarOdrRqsuTrbm8naZnsfUCUdXWT0z9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39847 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2IOA3E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 20:29:04 -0400
Received: by pbbrr13 with SMTP id rr13so6383363pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 17:29:04 -0700 (PDT)
In-Reply-To: <CA+jddaNnQAaQ0cT5-0OarOdrRqsuTrbm8naZnsfUCUdXWT0z9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 09/14/2012 05:14 PM, Mandell Degerness wrote:
> I was wondering if there was an update on the RBD fencing question.
> Either knowing when an RBD is mounted elsewhere or being able to
> enforce a fence on an RBD would be really helpful.
>
> -Mandell Degerness

Advisory locking of rbd images is ready for review in the 
wip-librbd-locking branch. This lets you lock/unlock images with the rbd 
cli tool,
so you could detect when it's being used, but fencing is not
implemented yet.

Josh
