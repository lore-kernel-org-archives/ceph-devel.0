From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Remove unrelated log output from command line utils?
Date: Tue, 26 Jun 2012 13:19:17 -0700
Message-ID: <4FEA1945.4050208@inktank.com>
References: <CAPud5_5iOr9sCXYQU9Nr5f-+NDBy-sPkGuc5x-wTETyP_MDtfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51641 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2FZUTV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 16:19:21 -0400
Received: by dady13 with SMTP id y13so370833dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 13:19:21 -0700 (PDT)
In-Reply-To: <CAPud5_5iOr9sCXYQU9Nr5f-+NDBy-sPkGuc5x-wTETyP_MDtfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 06/26/2012 11:53 AM, Nick Bartos wrote:
> I think the stderr output should only be going to the logs, not to an
> arbitrary command line utility.
>
> Is there any way to change this behaviour?

Yes, set 'log to stderr = false' in your ceph.conf, or add
--no-log-to-stderr to your commands. You can do the same for errors
with 'err to stderr = false' and --no-err-to-stderr.
