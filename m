From: Gregory Farnum <greg@inktank.com>
Subject: Re: Simpler LRC configuration
Date: Tue, 19 Aug 2014 15:02:47 -0700
Message-ID: <CAPYLRzhLH1kSgBGG1X3m8OQz+1=zjmyBeTnEiDJNeDhb-is8+w@mail.gmail.com>
References: <53EE3902.1080009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:45591 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbaHSWCs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 18:02:48 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so8234557vcb.32
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 15:02:47 -0700 (PDT)
In-Reply-To: <53EE3902.1080009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Aug 15, 2014 at 9:44 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Based on Andreas suggestions for Xorbas configuration (in a previous thread) and the last G/H discussions ( https://wiki.ceph.com/Planning/CDS/CDS_Giant_and_Hammer_%28Jun_2014%29 ), here is a simpler configuration for the LRC plugin. Instead of replacing the generic description, it generates it from a user friendly set of parameters:
>
>    https://github.com/dachary/ceph/commit/a2cfda81b8f51bb77f2c2708597f7ad7e1882b3c
>
> The more flexible configuration syntax can be retained but the system administrator is not required to understand it.
>
> What do people think ?

This syntax is much simpler, nice!
As with all of the EC plugin work, that's about the level I'm working at. ;)
-Greg
