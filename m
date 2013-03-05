From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: teuthology and code coverage revisited
Date: Tue, 05 Mar 2013 09:30:52 -0800
Message-ID: <51362BCC.6030307@inktank.com>
References: <513530E6.4000705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:53005 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362Ab3CERaV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 12:30:21 -0500
Received: by mail-da0-f52.google.com with SMTP id x33so34501dad.11
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 09:30:20 -0800 (PST)
In-Reply-To: <513530E6.4000705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 03/04/2013 03:40 PM, Loic Dachary wrote:
> CommandFailedError: Command failed on 10.20.0.7 with status 1: 'rmdir -- /tmp/cephtest/ubuntu@teuthology-2013-03-04_21-03-19'
> DEBUG:teuthology.run_tasks:Exception was not quenched, exiting: Exception: failed to fetch package version from http://gitbuilder.ceph.com/ceph-deb-quantal-x86_64-gcov/ref/master/version
> INFO:teuthology.run:Summary data:

There's only one gitbuilder that is configured --enable-coverage, and
that one is for precise, hence the error fetching a gcov package for
quantal. You can see them all at: http://ceph.com/gitbuilder.cgi

Josh
