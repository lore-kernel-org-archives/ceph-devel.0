From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: About teuthology
Date: Tue, 31 Jul 2012 09:27:54 -0500
Message-ID: <5017EB6A.5040104@inktank.com>
References: <20120731135955.GA23001@mail.sileht.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33918 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab2GaO1z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 10:27:55 -0400
Received: by wgbdr13 with SMTP id dr13so5922700wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 07:27:54 -0700 (PDT)
In-Reply-To: <20120731135955.GA23001@mail.sileht.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mehdi Abaakouk <sileht@sileht.net>
Cc: ceph-devel@vger.kernel.org

On 7/31/12 8:59 AM, Mehdi Abaakouk wrote:
> Hi,
>
> I have taken a look into teuthology, the automation of all this tests
> are good, but are they any way to run it into a already installed
> ceph clusters ?
>
> Thanks in advance.
>
> Cheers,
>

Hi Mehdi,

I think a number of the test related tasks should run fine without 
strictly requiring the ceph task.  You may have to change binary 
locations for things like rados, but those should be pretty minor.

Best way to find out is to give it a try!

Mark
