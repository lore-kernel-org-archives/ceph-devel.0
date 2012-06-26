From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: Remove unrelated log output from command line utils?
Date: Tue, 26 Jun 2012 16:17:55 -0700
Message-ID: <CAPud5_7oG_rHP7VqpgJL6pwCM12S34KJ01J8vYXNnrBCuwMd-g@mail.gmail.com>
References: <CAPud5_5iOr9sCXYQU9Nr5f-+NDBy-sPkGuc5x-wTETyP_MDtfg@mail.gmail.com>
	<4FEA1945.4050208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49725 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab2FZXR4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 19:17:56 -0400
Received: by pbbrp8 with SMTP id rp8so716556pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 16:17:55 -0700 (PDT)
In-Reply-To: <4FEA1945.4050208@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks!

On Tue, Jun 26, 2012 at 1:19 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 06/26/2012 11:53 AM, Nick Bartos wrote:
>>
>> I think the stderr output should only be going to the logs, not to an
>> arbitrary command line utility.
>>
>> Is there any way to change this behaviour?
>
>
> Yes, set 'log to stderr = false' in your ceph.conf, or add
> --no-log-to-stderr to your commands. You can do the same for errors
> with 'err to stderr = false' and --no-err-to-stderr.
